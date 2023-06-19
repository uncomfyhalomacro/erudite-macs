(straight-use-package 'prescient)
(straight-use-package 'corfu-prescient)
(straight-use-package 'company-prescient)
(straight-use-package 'ivy-prescient)
(straight-use-package 'selectrum-prescient)
(straight-use-package 'vertico-prescient)


;; Themes

(defun dark-theme-load-mocha ()
  "Change theme to mocha flavor"
  (interactive)
  (setq catppuccin-flavor 'mocha)
  (catppuccin-reload))
(defun light-theme-load-latte ()
  "Change theme to frappe flavor"
  (interactive)
  (setq catppuccin-flavor 'latte)
  (catppuccin-reload))
(defun system-check-theme-p ()
  "Check theme based on preferred mode"
  (if (string= (getenv "CONTAINER_ID") "")
      (if (string= (shell-command-to-string "gsettings get org.gnome.desktop.interface color-scheme") "\'prefer-dark\'\n") t)
      (if (string= (shell-command-to-string "distrobox-host-exec gsettings get org.gnome.desktop.interface color-scheme") "\'prefer-dark\'\n") t)))
(defun catppuccin/load-theme ()
  "Load dark/light variant depending on the system theme"
  ;; Load themes
  (interactive)
  (if (system-check-theme-p)
      (dark-theme-load-mocha)
      (light-theme-load-latte)))

(use-package catppuccin-theme
  :custom (catppuccin/load-theme)
  :config
  (defun check-current-theme-mode-p ()
    "Checks between dark and light mode"
    (if (string= (symbol-name catppuccin-flavor) 'mocha) t))
  (defun theme-switcheroo-mode ()
    "Switches between light and dark mode"
    (interactive)
    (if (check-current-theme-mode-p)
	(light-theme-load-latte)
      (dark-theme-load-mocha)))
  (global-set-key (kbd "C-x C-\\") 'theme-switcheroo-mode)
  :init
  (load-theme 'catppuccin t)
  (catppuccin/load-theme)
  :straight `(catppuccin-theme :type git
			       :host github
			       :repo "catppuccin/emacs"
			       :branch "main"))
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
  :straight t)
(use-package neotree
  :straight t
  :after all-the-icons
  :init    (setq neo-theme (if (display-graphic-p) 'icons 'classic))
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




;; Misc functions
(defun indent-org-block ()
  (when (org-in-src-block-p)
    (org-edit-special)
    (indent-region (point-min) (point))
    (org-edit-src-exit)))
