# pver

`pver` 是一个用 Go 编写的 CLI 工具，帮助你更高效地管理 Python 虚拟环境。

## ✨ 功能

- 查看 Python 版本信息：`pver info`
- 快速创建虚拟环境：`pver init`
- 进入虚拟环境：`pver cd`
- 退出虚拟环境：`pver exit`
- 安装依赖：`pver install`
- 删除虚拟环境：`pver remove`

## 🚀 安装

方式一（推荐）：

```bash
make install
```

方式二（手动）：

```bash
go build -o pver
bash install.sh
```

方式三（Arch Linux）：

```bash
makepkg -si
sudo bash /usr/share/pver/install.sh
```

## 🧹 卸载

```bash
make uninstall
# 或
bash uninstall.sh
```

## 📂 文件说明
- install.sh: 安装并配置 shell

- uninstall.sh: 卸载并清理配置

- PKGBUILD: Arch 安装包描述

- Makefile: 一键构建/安装

- cmd/: CLI 各子命令源码
