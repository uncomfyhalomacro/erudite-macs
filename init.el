;;;; erudite --- Summary
;;;; Commentary:
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
(use-package magit)

;; Shell
(use-package lsp-sh
  :init
  (setq lsp-sh-enable t)
  :hook
  (sh-mode . lsp-sh-enable))
;; Julia
(use-package julia-snail
    :hook (julia-mode . julia-snail-mode))
(use-package lsp-julia
  :init
  (setq lsp-julia-package-dir nil)
  (setq lsp-julia-flags `("-J/home/uncomfy/.julia/environments/emacs-lspconfig/languageserver.so"))
  :config
  (setq lsp-julia-default-environment "~/.julia/environments/emacs-lspconfig"))

;; Rust
(use-package rust-mode
  :straight t)
(use-package rustic
  :straight t
  :config (setq rustic-analyzer-command '("/usr/local/bin/rust-analyzer")))

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
  (setq lsp-ui-sideline-enable nil
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

;; File Explorer

;; Treesitter support
(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)
(require 'tree-sitter)
(require 'tree-sitter-hl)
(require 'tree-sitter-langs)
(require 'tree-sitter-debug)
(require 'tree-sitter-query)


;; Themes
(load-theme 'gruvbox-light-hard t)

;; User defined keymaps
;;;; Org-Mode

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;; Window Layout


;; (defvar parameters
;;   '(window-parameters . ((no-other-window . t)
;;                          (no-delete-other-windows . t))))

;; (setq fit-window-to-buffer-horizontally t)
;; (setq window-resize-pixelwise t)

;; (setq
;;  display-buffer-alist
;;  `(("\\*Buffer List\\*" display-buffer-in-side-window
;;     (side . top) (slot . 0) (window-height . fit-window-to-buffer)
;;     (preserve-size . (nil . t)) ,parameters)
;;    ("\\*Tags List\\*" display-buffer-in-side-window
;;     (side . right) (slot . 0) (window-width . fit-window-to-buffer)
;;     (preserve-size . (t . nil)) ,parameters)
;;    ("\\*\\(?:help\\|grep\\|Completions\\)\\*"
;;     display-buffer-in-side-window
;;     (side . bottom) (slot . -1) (preserve-size . (nil . t))
;;     ,parameters)
;;    ("\\*\\(?:shell\\|compilation\\)\\*" display-buffer-in-side-window
;;     (side . bottom) (slot . 1) (preserve-size . (nil . t))
;;     ,parameters)))
;; (defun dired-default-directory-on-left ()
;;   "Display `default-directory' in side window on left, hiding details."
;;   (interactive)
;;   (let ((buffer (dired-noselect default-directory)))
;;     (with-current-buffer buffer (dired-hide-details-mode t))
;;     (display-buffer-in-side-window
;;      buffer `((side . left) (slot . 0)
;;               (window-width . fit-window-to-buffer)
;;               (preserve-size . (t . nil)) ,parameters))))
