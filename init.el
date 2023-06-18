(setq inhibit-startup-message t)

(when (display-graphic-p)
    (set-face-attribute 'default nil :font "JuliaMono 10")
    (set-fontset-font t nil "Symbols Nerd Font" nil 'append)
    (set-fontset-font t nil "Noto Sans Symbols" nil 'append)
    (set-fontset-font t nil "Noto Sans Symbols2" nil 'append)
    (set-fontset-font t nil "Noto Sans CJK SC" nil 'append)
    (set-fontset-font t nil "Noto Sans CJK TC" nil 'append)
    (set-fontset-font t nil "Noto Sans CJK KR" nil 'append)
    (set-fontset-font t nil "Noto Sans CJK JP" nil 'append)
    (set-fontset-font t nil "Noto Sans CJK HK" nil 'append)
    (set-fontset-font t nil "Noto Color Emoji" nil 'append))

  (global-display-line-numbers-mode 'relative)
  (setq display-line-numbers-type 'relative)

  (setq next-line-add-newlines t)

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
	  (url-retrieve-synchronously "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
				      'silent 'inhibit-cookies)
	(goto-char (point-max))
	(eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))
  ;; Integrate straight with use-package
  (straight-use-package 'use-package)
  (setq straight-use-package-by-default t)
  (load-file "~/.config/emacs/config.el")
  (load-file "~/.config/emacs/keymaps.el")
