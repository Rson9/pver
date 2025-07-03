# pver

pver 是一个用 Go 编写的 CLI 工具，帮助你更高效地管理 Python 虚拟环境。


## ✨ 功能

- 快速创建虚拟环境：`pver init`
- 进入虚拟环境：`pver cd`
- 安装依赖：`pver install`
- 查看 Python 版本信息：`pver info`
- 删除虚拟环境：`pver remove`


## 🚀 安装

推荐使用 Makefile 一键构建和安装：

```bash
make install
source ~/.zshrc  # 或你的 shell 配置文件
````

该命令会：

* 编译生成 `pver` 二进制
* 复制到 `~/.local/bin`
* 注入 shell 集成脚本


### 其他安装方式（非推荐）

* **手动构建和安装**

```bash
go build -o pver
bash install.sh
source ~/.zshrc
```

* **Arch Linux（基于 PKGBUILD）**

```bash
makepkg -si
sudo bash /usr/share/pver/install.sh
source ~/.zshrc
```


## 🧹 卸载

使用 Makefile 卸载：

```bash
make uninstall
source ~/.zshrc
```

或者手动：

```bash
bash uninstall.sh
source ~/.zshrc
```


## 📂 文件说明

* `install.sh`：安装并配置 shell 集成
* `uninstall.sh`：卸载并清理配置
* `PKGBUILD`：Arch Linux 安装包描述
* `Makefile`：一键构建/安装/卸载命令集合
* `cmd/`：CLI 各子命令源码

