package cmd

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/spf13/cobra"
)

var initCmd = &cobra.Command{
	Use:   "init [env_dir]",
	Short: "Initialize a new Python virtual environment",
	Args:  cobra.MaximumNArgs(1),
	Run: func(c *cobra.Command, args []string) {
		dir := "venv"
		if len(args) > 0 {
			dir = args[0]
		}

		pythonPath, err := exec.LookPath("python3")
		if err != nil {
			fmt.Println("❌ python3 not found in PATH")
			os.Exit(1)
		}

		cmd := exec.Command(pythonPath, "-m", "venv", dir)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			fmt.Println("❌ Failed to create virtualenv:", err)
			os.Exit(1)
		}

		fmt.Println("✅ Virtual environment created at:", dir)
	},
}

func init() {
	rootCmd.AddCommand(initCmd)
}