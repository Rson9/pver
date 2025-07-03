package cmd

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/spf13/cobra"
)

var installCmd = &cobra.Command{
	Use:   "install",
	Short: "Install dependencies from requirements.txt",
	Run: func(c *cobra.Command, args []string) {
		if _, err := os.Stat("requirements.txt"); os.IsNotExist(err) {
			fmt.Println("❌ requirements.txt not found")
			return
		}

		pip := "./venv/bin/pip"
		if _, err := os.Stat(pip); os.IsNotExist(err) {
			fmt.Println("❌ pip not found at", pip)
			return
		}

		cmd := exec.Command(pip, "install", "-r", "requirements.txt")
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			fmt.Println("❌ Failed to install dependencies:", err)
			os.Exit(1)
		}

		fmt.Println("✅ Dependencies installed")
	},
}

func init() {
	rootCmd.AddCommand(installCmd)
}