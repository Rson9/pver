all: build

build:
	go build -o pver main.go

install: build
	@echo "🔧 Running install script..."
	@test -f install.sh || (echo "❌ install.sh not found! Are you in the project root?" && exit 1)
	@chmod +x install.sh
	@./install.sh


uninstall:
	bash uninstall.sh

clean:
	rm -f pver