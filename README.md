# reversed-ppa
This is a debian PPA for easier testing on multiple devices.

## Add the PPA to your system

```sh
$ curl -s --compressed "https://hobbeshunter.github.io/reversed-ppa/KEY.gpg" | sudo apt-key add -
$ sudo curl -s --compressed -o /etc/apt/sources.list.d/reversed.list "https://hobbeshunter.github.io/reversed-ppa/reversed.list"
$ sudo apt update
```

## Install reversed companion

```sh
$ sudo apt install reversed-companion
```

## Buil deb packages

Go to reversed-companion/DEBIAN and edit the version in the control file.

```sh
$ MAJOR=0 MINOR=1 REVISION=3 EMAIL=MailOfTheKeyOwner ./build_deb_package.sh ~/path/to/reversed-companion/source
```
