package cmd

import (
	"fmt"
	"os/exec"

	"github.com/spf13/cobra"
)

var infoCmd = &cobra.Command{
	Use:   "info",
	Short: "Show Python and pip versions",
	Run: func(c *cobra.Command, args []string) {
		py := exec.Command("python3", "--version")
		pyOut, _ := py.Output()

		pip := exec.Command("python3", "-m", "pip", "--version")
		pipOut, _ := pip.Output()

		fmt.Printf("🐍 Python: %s", pyOut)
		fmt.Printf("📦 Pip: %s", pipOut)
	},
}

func init() {
	rootCmd.AddCommand(infoCmd)
}
