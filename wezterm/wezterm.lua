-- ~/.config/wezterm/wezterm.lua
local wezterm = require("wezterm")
local config = wezterm.config_builder()
config.automatically_reload_config = true
config.audible_bell = "Disabled"

-- =====================
-- フォント
-- =====================
config.font = wezterm.font("Cica")
config.font_size = 14.0

-- =====================
-- カラーテーマ
-- =====================
config.color_scheme = "Catppuccin Mocha"

-- =====================
-- 外観
-- =====================
config.window_background_opacity = 0.95 -- 少し透過（好みで 1.0 に）
config.macos_window_background_blur = 20

config.window_padding = {
	left = 12,
	right = 12,
	top = 8,
	bottom = 8,
}

-- タブバーをオシャレに
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- =====================
-- 動作
-- =====================
config.scrollback_lines = 10000
config.enable_scroll_bar = false

-- Optionキーをメタキーとして使う（Mac）
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false

-- =====================
-- キーバインド（tmux導入までの暫定 + 最小限）
-- =====================-- キーバインドをtmuxライクに統一
-- プレフィックスは Ctrl+Space
local act = wezterm.action

-- プレフィックスキーの状態管理
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1500 }

config.keys = {
	-- 新規タブ
	{ key = "t", mods = "CMD", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	-- タブを閉じる
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
	-- タブ移動
	{ key = "[", mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "]", mods = "CMD", action = wezterm.action.ActivateTabRelative(1) },
	-- フォントサイズ調整
	{ key = "=", mods = "CMD", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = wezterm.action.DecreaseFontSize },
	{ key = "0", mods = "CMD", action = wezterm.action.ResetFontSize },

	-- プレフィックス + | で水平分割
	{ key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	-- プレフィックス + - で垂直分割
	{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

	-- プレフィックス + hjkl でペイン移動
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },

	-- プレフィックス + x でペインを閉じる
	{ key = "x", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },

	-- プレフィックス + z でペインをズーム（tmuxのzoom相当）
	{ key = "z", mods = "LEADER", action = act.TogglePaneZoomState },

	-- プレフィックス + 数字でタブ移動
	{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
	{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
	{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
	{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
	{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
}

-- =====================
-- OS判定（Windows併用時の準備）
-- =====================
local os_info = wezterm.target_triple
if os_info:find("windows") then
	config.default_prog = { "pwsh", "-NoLogo" }
	config.font_size = 12.0 -- Windowsはちょっと小さめが見やすいことが多い
end

return config
