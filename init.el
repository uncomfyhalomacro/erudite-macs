(setq inhibit-startup-message t)
    (set-face-attribute 'default nil :font "JuliaMono 14")
    (set-fontset-font t nil "Symbols Nerd Font" nil 'append)
    (set-fontset-font t nil "Noto Sans Symbols" nil 'append)
    (set-fontset-font t nil "Noto Sans Symbols2" nil 'append)
    (set-fontset-font t nil "Noto Sans CJK SC" nil 'append)
    (set-fontset-font t nil "Noto Sans CJK TC" nil 'append)

    (set-fontset-font t nil "Noto Sans CJK KR" nil 'append)
    (set-fontset-font t nil "Noto Sans CJK JP" nil 'append)
    (set-fontset-font t nil "Noto Sans CJK HK" nil 'append)
    (set-fontset-font t nil "Noto Color Emoji" nil 'append)
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

(straight-use-package 'ayu-theme)
(straight-use-package 'catppuccin-theme)
(use-package page-break-lines
  :config
  (page-break-lines-mode))
(use-package projectile
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))
(use-package dashboard
  :straight t
  :config
  (dashboard-setup-startup-hook))
(use-package evil
  :straight t
  :config
  (evil-mode 0))
(straight-use-package 'julia-mode)
(straight-use-package 'elcord)
(use-package vterm
  :straight t)
(use-package all-the-icons
  :straight t
 )
(use-package neotree
  :straight t
  :after all-the-icons
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'classic))
  :config 
  (global-set-key [f8] 'neotree-toggle))
(use-package toc-org
  :straight t)
(use-package org-auto-tangle
  :after toc-org
  :defer t
  :straight t
  :config
  :hook (org-mode . org-auto-tangle-mode))
(straight-use-package 'gruvbox-theme)
(straight-use-package 'lsp-mode)
(straight-use-package 'company)

;; Load packages
(require 'ayu-theme)
(require 'elcord)
(use-package flycheck
  :straight t
  :init (global-flycheck-mode))
(elcord-mode 1)
(company-mode)
(add-hook 'after-init-hook 'global-company-mode)
(use-package magit
  :defer t
  )

;; Shell
(use-package lsp-sh
  :init
  (setq lsp-sh-enable t)
  :hook
  (sh-mode . lsp-sh-enable))

;; Julia
(use-package julia-repl
  :straight t
  :hook (
	 (julia-mode . julia-repl-mode))
  :config
  (julia-repl-set-terminal-backend 'vterm)
  )
(use-package lsp-julia
  :config
  (setq
	lsp-julia-command "julia"
	lsp-julia-package-dir "@emacs-lspconfig"
	lsp-julia-flags `(,(concat "--project=" lsp-julia-package-dir)
			  "--startup-file=no"
			  "--history-file=no"
			  ,(concat "-J" (shell-command-to-string "julia --startup-file=no --history-file=no -e 'print(homedir())'") "/.julia/environments/emacs-lspconfig/languageserver.so"))
	lsp-julia-default-environment (string-trim(shell-command-to-string "julia --startup-file=no --history-file=no -e 'print(dirname(Base.active_project()))'"))))

;; Rust
(use-package rust-mode
  :straight t)
(use-package rustic
  :straight t
  :config
  (setq rustic-analyzer-command '("rust-analyzer")))

(use-package treemacs
  :straight t
  :config
  (treemacs-follow-mode 1)
  (treemacs-project-follow-mode 1)
  )


(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)

	 (julia-mode . lsp)
	 (rust-mode . lsp)
	 (sh-mode . lsp)

	 ;; if you want which-key integration
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
;; optionally

(use-package lsp-ui
  :init
  (setq lsp-ui-sideline-enable t
	lsp-ui-doc-border "#BDAE93"
	lsp-ui-sideline-show-code-actions t
	lsp-ui-sideline-show-diagnostics t
	lsp-signature-auto-activate nil
	lsp-signature-render-documentation nil
	lsp-ui-doc-show-with-cursor t
	lsp-eldoc-enable-hover nil
	lsp-completion-show-detail t
	lsp-completion-show-kind t
	lsp-ui-doc-position 'at-point
	lsp-ui-doc-enable t)
  :commands lsp-ui-mode)
;; if you are ivy user
(use-package all-the-icons-ivy
  :straight t
  :init (add-hook 'after-init-hook 'all-the-icons-ivy-setup))
(use-package all-the-icons-dired
  :straight t
  :init
  (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
 )
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;; optionally if you want to use debugger
(use-package dap-mode)
;; dap-julia has not yet been implemented


;; optional if you want which-key integration
(use-package which-key
  :config
  (which-key-mode))

;; File Explorer

;; Treesitter support
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(require 'tree-sitter)
(require 'tree-sitter-hl)
(require 'tree-sitter-langs)
(require 'tree-sitter-debug)
(require 'tree-sitter-query)
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

;; Themes
(load-theme 'catppuccin t)

;; User defined keymaps
		    ;;;; Org-Mode

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c ;") #'comment-line)
(global-set-key (kbd "C-c C-;") #'comment-region)
