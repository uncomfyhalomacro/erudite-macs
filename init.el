Content-Type: text/enriched
Text-Width: 70

;; <x-color><param>chocolate1</param>Built-in emacs settings
</x-color>(<x-color><param>Cyan1</param>setq</x-color> inhibit-startup-message t)
(xterm-mouse-mode t)
(menu-bar-mode -1)

(<x-color><param>Cyan1</param>setq</x-color> visible-bell t)
;; <x-color><param>chocolate1</param>Use straight.el bootstrap script
</x-color>(<x-color><param>Cyan1</param>defvar</x-color> <x-color><param>LightGoldenrod</param>bootstrap-version</x-color>)
(<x-color><param>Cyan1</param>let</x-color> ((bootstrap-file
       (expand-file-name <x-color><param>LightSalmon</param>"straight/repos/straight.el/bootstrap.el"</x-color> user-emacs-directory))
      (bootstrap-version 5))
  (<x-color><param>Cyan1</param>unless</x-color> (file-exists-p bootstrap-file)
    (<x-color><param>Cyan1</param>with-current-buffer</x-color>
	(url-retrieve-synchronously
	 <x-color><param>LightSalmon</param>"https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"</x-color>
	 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; <x-color><param>chocolate1</param>Integrate straight with use-package
</x-color>(straight-use-package 'use-package)
(<x-color><param>Cyan1</param>setq</x-color> straight-use-package-by-default t)

;; <x-color><param>chocolate1</param>Install the following packages that I need
</x-color>(straight-use-package 'ayu-theme)
(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>evil</x-color>
  <x-color><param>LightSteelBlue</param>:straight</x-color> t
  <x-color><param>LightSteelBlue</param>:config</x-color>
  (evil-mode 0))
(straight-use-package 'julia-mode)
(straight-use-package 'elcord)
(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>vterm</x-color>
  <x-color><param>LightSteelBlue</param>:straight</x-color> t)
(straight-use-package 'gruvbox-theme)
(straight-use-package 'lsp-mode)
(straight-use-package 'company)
;; <x-color><param>chocolate1</param>Load packages
</x-color>(<x-color><param>Cyan1</param>require</x-color> '<x-color><param>Aquamarine</param>ayu-theme</x-color>)
(<x-color><param>Cyan1</param>require</x-color> '<x-color><param>Aquamarine</param>elcord</x-color>)
(elcord-mode 1)

(company-mode)
(add-hook 'after-init-hook 'global-company-mode)

(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>magit</x-color>)

(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>julia-snail</x-color>
    <x-color><param>LightSteelBlue</param>:hook</x-color> (julia-mode . julia-snail-mode))

(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>lsp-julia</x-color>
  <x-color><param>LightSteelBlue</param>:init</x-color>
  (<x-color><param>Cyan1</param>setq</x-color> lsp-julia-package-dir nil)
  (<x-color><param>Cyan1</param>setq</x-color> lsp-julia-flags `(<x-color><param>LightSalmon</param>"-J/home/uncomfy/.julia/environments/emacs-lspconfig/languageserver.so"</x-color>))
  <x-color><param>LightSteelBlue</param>:config</x-color>
  (<x-color><param>Cyan1</param>setq</x-color> lsp-julia-default-environment <x-color><param>LightSalmon</param>"~/.julia/environments/emacs-lspconfig"</x-color>))
(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>lsp-mode</x-color>
  <x-color><param>LightSteelBlue</param>:init</x-color>
  ;; <x-color><param>chocolate1</param>set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
</x-color>  (<x-color><param>Cyan1</param>setq</x-color> lsp-keymap-prefix <x-color><param>LightSalmon</param>"C-c l"</x-color>)
  <x-color><param>LightSteelBlue</param>:hook</x-color> (;; <x-color><param>chocolate1</param>replace XXX-mode with concrete major-mode(e. g. python-mode)
</x-color>	 (julia-mode . lsp)
	 ;; <x-color><param>chocolate1</param>if you want which-key integration
</x-color>	 (lsp-mode . lsp-enable-which-key-integration))
  <x-color><param>LightSteelBlue</param>:commands</x-color> lsp)

;; <x-color><param>chocolate1</param>optionally
</x-color>

(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>lsp-ui</x-color>
  <x-color><param>LightSteelBlue</param>:init</x-color>
  (<x-color><param>Cyan1</param>setq</x-color> lsp-ui-sideline-enable t)
  (<x-color><param>Cyan1</param>setq</x-color> lsp-ui-sideline-show-code-actions t)
  (<x-color><param>Cyan1</param>setq</x-color> lsp-ui-sideline-show-diagnostics t)
  (<x-color><param>Cyan1</param>setq</x-color> lsp-signature-auto-activate nil)
  (<x-color><param>Cyan1</param>setq</x-color> lsp-signature-render-documentation nil)
  (<x-color><param>Cyan1</param>setq</x-color> lsp-ui-doc-show-with-cursor t)
  (<x-color><param>Cyan1</param>setq</x-color> lsp-eldoc-enable-hover nil)
  (<x-color><param>Cyan1</param>setq</x-color> lsp-completion-show-detail t)
  (<x-color><param>Cyan1</param>setq</x-color> lsp-completion-show-kind t)
  <x-color><param>LightSteelBlue</param>:commands</x-color> lsp-ui-mode)
;; <x-color><param>chocolate1</param>if you are helm user
</x-color>(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>helm-lsp</x-color> <x-color><param>LightSteelBlue</param>:commands</x-color> helm-lsp-workspace-symbol)
;; <x-color><param>chocolate1</param>if you are ivy user
</x-color>(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>lsp-ivy</x-color> <x-color><param>LightSteelBlue</param>:commands</x-color> lsp-ivy-workspace-symbol)
(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>lsp-treemacs</x-color> <x-color><param>LightSteelBlue</param>:commands</x-color> lsp-treemacs-errors-list)

;; <x-color><param>chocolate1</param>optionally if you want to use debugger
</x-color>(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>dap-mode</x-color>)
;; <x-color><param>chocolate1</param>(use-package dap-LANGUAGE) to load the dap adapter for your language
</x-color>
;; <x-color><param>chocolate1</param>optional if you want which-key integration
</x-color>(<x-color><param>Cyan1</param>use-package</x-color> <x-color><param>Aquamarine</param>which-key</x-color>
  <x-color><param>LightSteelBlue</param>:config</x-color>
      (which-key-mode))


;; <x-color><param>chocolate1</param>Treesitter support
</x-color>(straight-use-package 'tree-sitter)
(straight-use-package 'tree-sitter-langs)

(<x-color><param>Cyan1</param>require</x-color> '<x-color><param>Aquamarine</param>tree-sitter</x-color>)
(<x-color><param>Cyan1</param>require</x-color> '<x-color><param>Aquamarine</param>tree-sitter-hl</x-color>)
(<x-color><param>Cyan1</param>require</x-color> '<x-color><param>Aquamarine</param>tree-sitter-langs</x-color>)
(<x-color><param>Cyan1</param>require</x-color> '<x-color><param>Aquamarine</param>tree-sitter-debug</x-color>)
(<x-color><param>Cyan1</param>require</x-color> '<x-color><param>Aquamarine</param>tree-sitter-query</x-color>)



;; <x-color><param>chocolate1</param>Themes
</x-color>(load-theme 'gruvbox-dark-hard t)
