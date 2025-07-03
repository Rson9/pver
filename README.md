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

## ⚠️ 当前已知问题

Shell 命令依赖安装脚本注入：
pver cd、pver init 等命令依赖 install.sh 将函数注入到 .zshrc / .bashrc 中。如果你直接运行 ./pver 或下载二进制文件而未运行安装脚本，将无法正常使用这些 shell 扩展命令。

二进制包未内置集成脚本自动注入：
目前通过 GitHub Releases 提供的二进制包（pver_linux_amd64_x.y.z.tar.gz 等）不包含自动注入 shell 的逻辑，需用户手动运行 install.sh。

仅支持类 Unix 系统测试：
虽然可交叉编译为 Windows 和 macOS，但目前仅在 Linux 和 macOS 上进行了功能验证，Windows 下的 shell 集成尚未支持。

Python 版本选择逻辑尚未完善：
当前默认使用 python3，如有多个 Python 版本（如 pyenv 管理环境），建议先通过外部工具统一 Python 环境。
