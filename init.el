(setq inhibit-startup-message t)

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
(straight-use-package 'elcord)
(straight-use-package 'evil)
(straight-use-package 'julia-repl)
(straight-use-package 'julia-mode)
(straight-use-package 'slime)
(straight-use-package 'gruvbox-theme)
(straight-use-package 'lsp-mode)

;; Load packages
(require 'ayu-theme)
(require 'elcord)
(elcord-mode)
(require 'evil)
(evil-mode)
(require 'lsp-mode)
(lsp-mode)
(require 'julia-repl)
(require 'julia-mode)


(use-package lsp-julia
	     :config
	       (setq lsp-julia-default-environment "~/.julia/environments/v1.7"))


;; Themes
(load-theme 'gruvbox-light-hard)
