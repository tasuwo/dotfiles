SHELL := zsh

DOTFILES := .gitconfig .gitignore .gitmessage .tmux.conf .vimrc .zshrc

TERMINAL_THEME_URL := https://raw.githubusercontent.com/lysyi3m/macos-terminal-themes/master/themes/DimmedMonokai.terminal
TERMINAL_THEME_FILE := $(HOME)/Library/Application Support/Terminal/DimmedMonokai.terminal
TERMINAL_FONT_SIZE := 18
TERMINAL_FONT_NAME := Cica

FONT_DIR := $(HOME)/Library/Fonts
DL_FONT_URL := https://github.com/miiton/Cica/releases/download/v5.0.3/Cica_v5.0.3_without_emoji.zip
DL_FONT_ZIP_FILE:= $(FONT_DIR)/Cica.zip
DL_FONT_DIR := $(FONT_DIR)/Cica

.PHONY: all
all: install_dotfiles apply_terminal_theme ## Install dotfiles and apply terminal theme

.PHONY: clean
clean: clean_dotfiles clean_fonts clean_terminal_theme ## Clean all installed files and settings

.PHONY: install_dotfiles
install_dotfiles: ## Install dotfiles to home directory
	@for file in $(DOTFILES); do \
		ln -sf $(CURDIR)/$$file $(HOME)/$$file; \
		echo "✅ Installed $$file"; \
	done

.PHONY: clean_dotfiles
clean_dotfiles: ## Remove installed dotfiles from home directory
	@for file in $(DOTFILES); do \
		rm -f $(HOME)/$$file; \
		echo "🗑️ Removed $$file from $(HOME)"; \
	done

.PHONY: download_fonts
download_fonts: ## Download and install fonts
	@if [ -d "$(DL_FONT_DIR)" ]; then \
		echo "✅ Fonts already exist in \"$(DL_FONT_DIR)\""; \
	else \
		echo "🔄 Start downloading fonts..." && \
		mkdir -p "$$(dirname "$(DL_FONT_ZIP_FILE)")" && \
		STATUS_CODE=$$(curl -L -w "%{http_code}" -o "$(DL_FONT_ZIP_FILE)" -s "$(DL_FONT_URL)"); \
		if [ "$$STATUS_CODE" -lt 200 ] || [ "$$STATUS_CODE" -ge 300 ]; then \
			echo "🛑 Failed to download fonts: $$STATUS_CODE"; \
			exit 1; \
		else \
			unzip -qo -d "$(DL_FONT_DIR)" "$(DL_FONT_ZIP_FILE)"; \
			rm "$(DL_FONT_ZIP_FILE)"; \
			echo "✅ Successfully downloaded fonts to \"$(DL_FONT_DIR)\""; \
		fi; \
	fi

.PHONY: clean_fonts
clean_fonts: ## Remove downloaded fonts
	@if [ -d "$(DL_FONT_DIR)" ]; then \
		rm -Rf "$(DL_FONT_DIR)" \
		echo "🗑️ Removed $(DL_FONT_DIR)"; \
	fi

.PHONY: download_terminal_theme
download_terminal_theme: ## Download terminal theme file
	@if [ -f "$(TERMINAL_THEME_FILE)" ]; then \
		echo "✅ Terminal theme file already exists at \"$(TERMINAL_THEME_FILE)\""; \
	else \
		mkdir -p "$$(dirname "$(TERMINAL_THEME_FILE)")" && \
		STATUS_CODE=$$(curl -w "%{http_code}" -o "$(TERMINAL_THEME_FILE)" -s "$(TERMINAL_THEME_URL)"); \
		if [ "$$STATUS_CODE" -lt 200 ] || [ "$$STATUS_CODE" -ge 300 ]; then \
			echo "🛑 Failed to download terminal theme file: $$STATUS_CODE"; \
			exit 1; \
		else \
			echo "✅ Successfully downloaded terminal theme file to \"$(TERMINAL_THEME_FILE)\""; \
		fi; \
	fi

.PHONY: install_terminal_theme
install_terminal_theme: download_terminal_theme ## Install terminal theme
	@if ! osascript -e 'tell application "Terminal" to get the name of every settings set' | grep -q "$$(basename "$(TERMINAL_THEME_FILE)" .terminal)"; then \
		osascript \
			-e "tell application \"Terminal\" to do shell script \"open \\\"${TERMINAL_THEME_FILE}\\\"\"" \
			-e "delay 1"; \
		echo "✅ Successfully installed theme to terminal."; \
	else \
		echo "✅ Theme '$$(basename "$(TERMINAL_THEME_FILE)" .terminal)' is already installed."; \
	fi

.PHONY: apply_terminal_theme
apply_terminal_theme: download_fonts install_terminal_theme ## Apply terminal theme settings
	@osascript \
		-e "tell application \"Terminal\" to set font name of settings set \"$$(basename "$(TERMINAL_THEME_FILE)" .terminal)\" to \"$(TERMINAL_FONT_NAME)\"" \
		-e "tell application \"Terminal\" to set font size of settings set \"$$(basename "$(TERMINAL_THEME_FILE)" .terminal)\" to $(TERMINAL_FONT_SIZE)" \
		-e "tell application \"Terminal\" to set default settings to settings set \"$$(basename "$(TERMINAL_THEME_FILE)" .terminal)\"" \
		-e "tell application \"Terminal\" to set font name of every tab of every window to \"$(TERMINAL_FONT_NAME)\"" \
		-e "tell application \"Terminal\" to set font size of every tab of every window to $(TERMINAL_FONT_SIZE)" \
		-e "tell application \"Terminal\" to set current settings of every tab of every window to settings set \"$$(basename "$(TERMINAL_THEME_FILE)" .terminal)\"" \
	@echo "✅ Successfully apply theme to terminal."

.PHONY: clean_terminal_theme
clean_terminal_theme: ## Remove terminal theme and settings
	@if [ -f "$(TERMINAL_THEME_FILE)" ]; then \
		rm -Rf "$(TERMINAL_THEME_FILE)" \
		echo "🗑️ Removed $(TERMINAL_THEME_FILE)"; \
	fi
	@if osascript -e 'tell application "Terminal" to get the name of every settings set' | grep -q "$$(basename "$(TERMINAL_THEME_FILE)" .terminal)"; then \
		osascript \
			-e "tell application \"Terminal\" to delete settings set \"$$(basename "$(TERMINAL_THEME_FILE)" .terminal)\""; \
		echo "🗑️ Removed terminal theme $$(basename "$(TERMINAL_THEME_FILE)" .terminal) from Terminal settings."; \
	fi

.PHONY: help
help: ## Display Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help