package cmd

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/spf13/cobra"
)

var removeCmd = &cobra.Command{
	Use:   "remove [env_dir]",
	Short: "Remove virtual environment directory",
	Args:  cobra.MaximumNArgs(1),
	Run: func(c *cobra.Command, args []string) {
		dir := "venv"
		if len(args) > 0 {
			dir = args[0]
		}

		if _, err := os.Stat(dir); os.IsNotExist(err) {
			fmt.Println("❌ Directory does not exist:", dir)
			return
		}

		cmd := exec.Command("rm", "-rf", dir)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		if err := cmd.Run(); err != nil {
			fmt.Println("❌ Failed to delete:", err)
			os.Exit(1)
		}

		fmt.Println("🗑️ Virtual environment deleted:", dir)
	},
}

func init() {
	rootCmd.AddCommand(removeCmd)
}
