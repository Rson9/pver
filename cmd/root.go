package cmd

import (
	"fmt"
	"github.com/spf13/cobra"
	"os"
)

var rootCmd = &cobra.Command{
	Use:   "pver",
	Short: "轻量级 Python 虚拟环境初始化工具",
	Long:  "pver 是一个用 Go 编写的 CLI 工具，帮助你快速初始化和管理 Python 虚拟环境。",
	// 我们用自定义 Help 替换默认 help 输出
}

func customHelp(cmd *cobra.Command, args []string) {
	helpText := `
pver 是一个用 Go 编写的轻量级 CLI 工具，用于快速初始化 Python 虚拟环境。

可用命令：
  init        初始化虚拟环境（默认目录为 venv）
  install     安装 requirements.txt 中的依赖
  remove      删除虚拟环境目录
  info        显示 Python 和 pip 的版本

Shell 扩展命令（需运行 install.sh 安装）：
  pver cd     激活虚拟环境（source venv/bin/activate）
  pver exit   退出虚拟环境（调用 deactivate）

安装路径：
  ~/.local/bin/pver

文档与卸载：
  运行 uninstall.sh 可彻底移除本工具及 shell 配置。

示例：
  pver init
  pver install
  pver cd
  pver exit

更多帮助：
  pver [command] --help  查看指定命令的详细说明
`
	fmt.Print(helpText)
}


func Execute() {
	rootCmd.SetHelpFunc(customHelp)
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
