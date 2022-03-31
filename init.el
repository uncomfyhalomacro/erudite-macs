;; Built-in emacs settings
(setq inhibit-startup-message t)
(xterm-mouse-mode t)
(menu-bar-mode -1)

(setq visible-bell t)
;; Use straight.el bootstrap script
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
	(url-retrieve-synchronously
	 "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Integrate straight with use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Install the following packages that I need
(straight-use-package 'ayu-theme)
(use-package evil
      :straight t
      :config
      (evil-mode 0))
(straight-use-package 'julia-mode)
(straight-use-package 'elcord)
(use-package vterm
  :straight t)
(use-package julia-repl
  :hook (julia-mode . julia-repl-mode)
  :straight t
  :config

  (julia-repl-set-terminal-backend 'vterm)
 )

(straight-use-package 'slime)
(straight-use-package 'gruvbox-theme)
(straight-use-package 'lsp-mode)
(straight-use-package 'company)
;; Load packages
(require 'ayu-theme)
(require 'elcord)
(elcord-mode 1)

(company-mode)
(add-hook 'after-init-hook 'global-company-mode)

(use-package julia-snail
    :hook (julia-mode . julia-snail-mode))
(setq lsp-julia-package-dir nil)
(setq lsp-julia-flags `("-J/home/uncomfy/.julia/environments/emacs-lspconfig/languageserver.so"))
(use-package lsp-julia
	     :config
	       (setq lsp-julia-default-environment "~/.julia/environments/emacs-lspconfig"))
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
	 (julia-mode . lsp)
	 ;; if you want which-key integration
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; optionally

(setq lsp-ui-sideline-enable t)
(setq lsp-ui-sideline-show-code-actions t)
(setq lsp-ui-sideline-show-diagnostics t)
(setq lsp-signature-auto-activate nil)
(setq lsp-signature-render-documentation nil)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-eldoc-enable-hover nil)
(setq lsp-completion-show-detail t)
(setq lsp-completion-show-kind t)
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
  :config
      (which-key-mode))


;; Treesitter support
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)

(require 'tree-sitter)
(require 'tree-sitter-hl)
(require 'tree-sitter-langs)
(require 'tree-sitter-debug)
(require 'tree-sitter-query)



;; Themes
(load-theme 'gruvbox-dark-hard t)
