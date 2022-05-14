@echo off
Echo Install Windows Utils
winget install Microsoft.Powertoys
winget install 7zip.7zip
winget install Microsoft.VisualStudioCode
winget install Docker.DockerDesktop
winget install python.python
REM https://zenn.dev/shoji_kai/articles/d26033f252b045
winget install Git.Git
winget install GitHub.cli
winget install Microsoft.GitCredentialManagerCore -s winget
winget install Notion.Notion
winget install LINE.LINE
winget install Discord.Discord
winget install Mozilla.Firefox
winget install google.Chrome
@REM winget install Google.Chrome --location "D:\Program Files\"
winget install Microsoft.Office
winget install Valve.Steam
winget install SlackTechnologies.Slack
winget install -e --id VideoLAN.VLC
winget install -e --id Zoom.Zoom
winget install -e --id AgileBits.1Password
winget install -e --id OBSProject.OBSStudio

wsl --install