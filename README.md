# itib's dotfiles

## Windows intial setting

### WSL

1. `wsl --install`
2. reboot
3. setup Username & password

## Ubuntu setting

### install git

```
$ sudo apt update
$ sudo apt install git
$ git clone https://github.com/itiB/dotfiles.git
```

```
$ sudo apt install smbclient
$ sudo mount -t cifs -o guest,uid=1000,gid=1000,nounix,rw,dir_mode=0755,file_mode=0644 //192.168.10.117/share1 ~/nas
```

```
$ sudo apt update
$ sudo apt install software-properties-common
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt install ansible
```