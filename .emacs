;; (set-language-environment "Korean")
;; (prefer-coding-system 'utf-8)
(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode -1)
;;(toggle-frame-fullscreen)
(global-display-line-numbers-mode)
(global-auto-revert-mode)
(windmove-default-keybindings)
(global-set-key (kbd"s-n") 'windmove-down)
(global-set-key (kbd"s-b") 'windmove-left)
(global-set-key (kbd"s-p") 'windmove-up)
(global-set-key (kbd"s-f") 'windmove-right)
(package-initialize)
(setq package-install-upgrade-built-in t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(use-package zenburn-theme
  :ensure zenburn-theme)
(load-theme 'zenburn t)
;;(load-theme 'catppuccin t)
;;(load-theme 'anti-zenburn t)
;; multiple cursors
(use-package multiple-cursors
  :ensure multiple-cursors
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )
;; find matching paren
(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(use-package smartparens-mode
  :ensure smartparens ;;install the package
  :hook (prog-mode text-mode markdown-mode) ;; add `smartparens-mode` to these hooks
  :config
  ;; load default config
  (require 'smartparens-config))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 '("f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" default))
 '(fit-frame-to-buffer t)
 '(global-display-line-numbers-mode t)
 '(ns-alternate-modifier 'meta)
 '(ns-command-modifier 'super)
 '(org-agenda-files '("~/org/roam/"))
 '(org-confirm-babel-evaluate nil)
 '(org-cycle-inline-images-display t)
 '(org-display-remote-inline-images 'download)
 '(org-startup-with-inline-images t)
 '(org-todo-keywords '((sequence "TODO" "DONE" "PENDING" "DELETE")))
 '(package-selected-packages
	 '(dart-mode anti-zenburn-theme catppuccin-theme diff-hl editorconfig ob-haskell restclient org-bullets eglot-java kotlin-mode ob-rust ob-kotlin elm-mode python-mode ob-mermaid clojure-ts-clojurescript-mode clojure-ts-mode psci kotlin-ts-mode nix-mode elixir-mode eglot typescript-mode prettier-js jsonrpc general treesit-auto tree-sitter-langs tree-sitter eldoc-box all haskell-mode projectile-ripgrep ripgrep tree-sitter-mode org-roam-ui org-roam org company rust-mode yasnippet lsp savehist vertico projectile helm-lsp lsp-treemacs lsp-ivy help-lsp lsp-ui lsp-mode helm zenburn-theme use-package smartparens multiple-cursors))
 '(projectile-globally-ignored-directories
	 '("^\\.idea$" "^\\.vscode$" "^\\.ensime_cache$" "^\\.eunit$" "^\\.git$" "^\\.hg$" "^\\.fslckout$" "^_FOSSIL_$" "^\\.bzr$" "^_darcs$" "^\\.pijul$" "^\\.tox$" "^\\.svn$" "^\\.stack-work$" "^\\.ccls-cache$" "^\\.cache$" "^\\.clangd$" "^\\.sl$" "^\\.jj$" "^\\.dist$"))
 '(tab-width 2)
 '(tool-bar-mode nil)
 '(warning-suppress-types '((magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "MesloLGM Nerd Font Mono" :foundry "PfEd" :slant normal :weight normal :height 180 :width normal)))))

;; (use-package tree-sitter
;;   :ensure t
;;   :hook (
;; 	 (typescript-mode-hook . tree-sitter-mode)))
;;(use-package lsp-mode
;;  :ensure lsp-mode
;;  :init
;;  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;  (setq lsp-keymap-prefix "C-c l")
;;  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;         (typescript-mode . lsp)
;;	 (rust-mode . lsp)
;;         ;; if you want which-key integration
;;         (lsp-mode . lsp-enable-which-key-integration))
;;  :commands lsp)
;;
;; optionally
;;(use-package lsp-ui :ensure lsp-ui :commands lsp-ui-mode)
;; if you are helm user
;;(use-package helm-lsp :ensure helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
;;(use-package lsp-ivy :ensure lsp-ivy :commands lsp-ivy-workspace-symbol)
;;(use-package lsp-treemacs :ensure lsp-treemacs :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
;;(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
  :ensure which-key
    :config
    (which-key-mode))
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(projectile-mode +1)
;; Recommended keymap prefix on macOS
;; (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;; Recommended keymap prefix on Windows/Linux
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; treemacs
(global-set-key (kbd "C-c t") 'treemacs)
;; Enable vertico
(use-package vertico
  :ensure vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :ensure savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))
;; vertico ends
(require 'rust-mode)
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/org/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

(when (and (eq system-type 'gnu/linux)
           (string-match
            "Linux.*Microsoft.*Linux"
            (shell-command-to-string "uname -a")))
  (setq
   browse-url-generic-program  "/mnt/c/Windows/System32/cmd.exe"
   browse-url-generic-args     '("/c" "start")
   browse-url-browser-function #'browse-url-generic))
(setq org-directory "~/org/")
(defun hs-cycle (&optional level)
  (interactive "p")
  (let (message-log-max
        (inhibit-message t))
    (if (= level 1)
        (pcase last-command
          ('hs-cycle
           (hs-hide-level 1)
           (setq this-command 'hs-cycle-children))
          ('hs-cycle-children
           ;; TODO: Fix this case. `hs-show-block' needs to be
           ;; called twice to open all folds of the parent
           ;; block.
           (save-excursion (hs-show-block))
           (hs-show-block)
           (setq this-command 'hs-cycle-subtree))
          ('hs-cycle-subtree
           (hs-hide-block))
          (_
           (if (not (hs-already-hidden-p))
               (hs-hide-block)
             (hs-hide-level 1)
             (setq this-command 'hs-cycle-children))))
      (hs-hide-level level)
      (setq this-command 'hs-hide-level))))

(defun hs-global-cycle ()
    (interactive)
    (pcase last-command
      ('hs-global-cycle
       (save-excursion (hs-show-all))
       (setq this-command 'hs-global-show))
      (_ (hs-hide-all))))
(global-set-key (kbd "C-<tab>") 'hs-cycle)
(global-set-key (kbd "C-S-<tab>") 'hs-global-cycle)

(add-hook 'typescript-mode-hook 'hs-minor-mode)
;; Move cursor to end of current line
;; Insert new line below current line
;; it will also indent newline
(global-set-key (kbd "<C-return>") (lambda ()
                   (interactive)
                   (end-of-line)
                   (newline-and-indent)))

;; Move cursor to previous line
;; Go to end of the line
;; Insert new line below current line (So it actually insert new line above with indentation)
;; it will also indent newline
(global-set-key (kbd "<C-S-return>") (lambda ()
                       (interactive)
                       (previous-line)
                       (end-of-line)
                       (newline-and-indent)
                       ))

;; setting for typescript and haskell

;; use-package for configuring, even though eglotis
;; built-in in Emacs 29, thus :ensure nil
(use-package nix-mode
	:ensure t)
(use-package kotlin-ts-mode
	:ensure t
	:defer t
	:mode "\\.kt\\'")
(use-package psci
	:ensure t
	:defer t
	:mode "\\.purs\\'")
(use-package clojure-ts-mode
	:ensure t
	:defer t
	:mode
  ("\\.clj\\'" . clojure-ts-mode)
  ("\\.cljs\\'" . clojure-ts-clojurescript-mode))
(use-package ruby-ts-mode
	:ensure t
	:defer t
	:mode "\\.rb\\'")
(use-package python-mode
	:ensure t
	:defer t
	:mode "\\.py\\'")
(use-package elm-mode
	:ensure t
	:defer t
	:mode "\\.elm\\'")
(use-package dart-mode
	:ensure t
	:defer t
	:mode "\\.dart\\'")
(use-package scala-mode
	:ensure t
	:defer t
	:mode "\\.scala\\'")
(use-package eglot-java
	:ensure t)
(use-package eglot :ensure nil :defer t
  :custom-face
  ;; personal preference here; I hate it when packages
  ;; use the `shadow' face for stuff, it's impossible to read
  (eglot-inlay-hint-face
   ((t ( :foreground unspecified
         :inherit font-lock-comment-face))))
  :config
  ;; these two lines help prevent lag with the typescript language server. they
  ;; might actually be mutually exclusive but I haven't investigated further
	(define-key eglot-mode-map (kbd "C-c a") 'eglot-code-actions)
  (with-eval-after-load 'eglot (fset #'jsonrpc--log-event #'ignore))
	(with-eval-after-load 'eglot-java
		(define-key eglot-java-mode-map (kbd "C-c l n") #'eglot-java-file-new)
		(define-key eglot-java-mode-map (kbd "C-c l x") #'eglot-java-run-main)
		(define-key eglot-java-mode-map (kbd "C-c l t") #'eglot-java-run-test)
		(define-key eglot-java-mode-map (kbd "C-c l N") #'eglot-java-project-new)
		(define-key eglot-java-mode-map (kbd "C-c l T") #'eglot-java-project-build-task)
		(define-key eglot-java-mode-map (kbd "C-c l R") #'eglot-java-project-build-refresh))
  (setq eglot-events-buffer-size 0)
  (add-hook 'elixir-mode-hook 'eglot-ensure)

  (add-to-list 'eglot-server-programs '(java-mode "/Users/byeongcheollim/.config/emacs/share/eclipse.jdt.ls/bin/jdtls"))
	(add-to-list 'eglot-server-programs '(elixir-mode "/Users/byeongcheollim/workspace/elixir-ls-v0.22.0/language_server.sh"))
	(add-to-list 'eglot-server-programs '(psci-mode "/Users/byeongcheollim/.nvm/versions/node/v18.19.1/bin/purescript-language-server.sh"))
  (setq-default eglot-workspace-configuration
                '((haskell
                   (plugin
                    (stan
                     (globalOn . :json-false))))))  ;; disable stan
	(add-to-list 'eglot-server-programs '(nix-mode . ("rnix-lsp")))
	(add-to-list 'eglot-server-programs '(kotlin-ts-mode "/usr/local/bin/kotlin-language-server"))
	;; (add-to-list 'eglot-server-programs
  ;;                      '(rust-mode . ("rust-analyzer" :initializationOptions
  ;;                                    ( :procMacro (:enable t)
  ;;                                      :cargo ( :buildScripts (:enable t)
  ;;                                               :features "all"))))))
  ;; just do it, don't prompt me
  (setq eglot-confirm-server-initiated-edits nil)
  (setq eglot-sync-connect 0)
  (setq eglot-autoshutdown t)
  (setq rex/language-servers
        (list '(tsx-ts-mode "typescript-language-server" "--stdio")
              ))
  (dolist (server rex/language-servers)
    (add-to-list 'eglot-server-programs server))
  :hook
	(psci-mode . eglot-ensure)
	(kotlin-ts-mode . eglot-ensure)
	(kotlin-ts-mode . company-mode)
	(kotlin-ts-mode . copilot-mode)
	(nix-mode . eglot-ensure)
	(nix-mode . company-mode)
  (java-mode . eglot-java-mode)
	(java-mode . eglot-ensure)
	(java-mode . company-mode)
  (haskell-mode . eglot-ensure)
	(haskell-mode . company-mode)
	(haskell-mode . copilot-mode)
  (typescript-ts-mode . eglot-ensure)
  (tsx-ts-mode . eglot-ensure)
	(typescript-mode . eglot-ensure)
  (rust-mode . eglot-ensure)
	(clojure-ts-mode . eglot-ensure)
	(clojure-ts-mode . company-mode)
	(clojure-ts-clojurescript-mode . eglot-ensure)
	(clojure-ts-clojurescript-mode . company-mode)
	(ruby-ts-mode . eglot-ensure)
	(ruby-ts-mode . company-mode)
	(python-mode . eglot-ensure)
	(python-mode . company-mode)
	(elm-mode . eglot-ensure)
	(elm-mode . company-mode)
	(c-mode . eglot-ensure)
	(c-mode . company-mode)
	(scala-mode . company-mode)
	(scala-mode . eglot-ensure)
	(dart-mode . eglot-ensure)
	(dart-mode . company-mode)
  (eglot-managed-mode
   . (lambda () (setq eldoc-documentation-function
                      'eldoc-documentation-compose-eagerly))))
;; triggering this manually is imo much nicer than having it pop up
;; automatically and obscure the code once you open it, you can scroll it with
;; C-j and C-k and any other command closes it again, but it can very rarely get
;; stuck on screen, which requires C-g
(use-package eldoc-box
  :defer t
  :config
  (defun rex/eldoc-box-scroll-up ()
    "Scroll up in `eldoc-box--frame'"
    (interactive)
    (with-current-buffer eldoc-box--buffer
      (with-selected-frame eldoc-box--frame
        (scroll-down 3))))
  (defun rex/eldoc-box-scroll-down ()
    "Scroll down in `eldoc-box--frame'"
    (interactive)
    (with-current-buffer eldoc-box--buffer
      (with-selected-frame eldoc-box--frame
        (scroll-up 3))))
  ;; this won't work without installing general; I include it as an example
  ;; see: https://github.com/skyler544/rex/blob/main/config/rex-keybindings.el
;;  :general
;;  (:keymaps 'eglot-mode-map
;;            "C-k" 'rex/eldoc-box-scroll-up
;;            "C-j" 'rex/eldoc-box-scroll-down
;;            "M-h" 'eldoc-box-help-at-point)
)
;; these files are started in fundamental mode
;; by default, but conf-mode handles them well
(use-package emacs :ensure nil
  :mode
  ("\\.env.test$" . conf-mode)
  ("\\.env.local$" . conf-mode)
  ("\\.env.sample$" . conf-mode)
  ("\\.env$" . conf-mode))

(use-package web-mode
  :config
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  :mode
  ("\\.html$" . web-mode)
  ("\\.twig$" . web-mode))
;; this should be replaced by the built-in modes eventually, but it's not always
;; simple to switch and not every language has a builtin `lang'-ts-mode
(use-package tree-sitter
  :demand t
  :diminish tree-sitter-mode
  :config
  (setq treesit-font-lock-level 4))

(use-package tree-sitter-langs
  :after tree-sitter)

;; seems like it will still throw a warning the first time you visit a file with
;; a treesit major mode if you don't have the grammar installed; manually
;; running M-x lang-ts-mode after waiting a few seconds for this package to
;; install and compile the grammar fixes the warning and you shouldn't see it
;; again afterwards
(use-package treesit-auto
  :config
  (setq treesit-auto-install t))

(use-package flymake :ensure nil
  :init
  (setq-default flymake-no-changes-timeout 1)
  :config
  (setq flymake-mode-line-format
        ;; the default mode line lighter takes up an unnecessary amount of
        ;; space, so make it shorter
        '(" " flymake-mode-line-exception flymake-mode-line-counters)))
(use-package add-node-modules-path
  :hook
  (tsx-ts-mode . add-node-modules-path)
  (typescript-ts-mode . add-node-modules-path))

;; you need to have prettier installed for this to work obviously
(use-package prettier-js
  :diminish prettier-js-mode
  :hook
  (tsx-ts-mode . prettier-js-mode)
  (typescript-ts-mode . prettier-js-mode))

;; next error
(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)

;; mac alt-x weird char input
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

;; move line
(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

;; open line below
;; newline-without-break-of-line
(defun newline-without-break-of-line ()
  "1. move to end of the line.
  2. insert newline with index"

  (interactive)
  (let ((oldpos (point)))
    (end-of-line)
    (newline-and-indent)))
(defun newline-above ()
(interactive)
(let ((oldpos (point)))
	(previous-line)
  (end-of-line)
	(newline-and-indent)
))
(global-set-key (kbd "<s-return>") 'newline-without-break-of-line)
(global-set-key (kbd "<s-M-return>") 'newline-above)

(add-hook 'rust-mode-hook 'company-mode)
(add-hook 'typescript-mode-hook 'company-mode)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; for m1 mac
;;(setq load-path (cons  "/opt/homebrew/opt/erlang/lib/erlang/lib/tools-3.6/emacs"
;;      load-path))      (setq erlang-root-dir "/opt/homebrew/opt/erlang/bin")
;;      (setq exec-path (cons "/opt/homebrew/opt/erlang/bin" exec-path))
;;      (require 'erlang-start)
;; for intel mac
(setq load-path (cons  "/usr/local/opt/erlang/lib/erlang/lib/tools-4.1/emacs" load-path))
(setq erlang-root-dir "/usr/local/opt/erlang/bin")
(setq exec-path (cons "/usr/local/opt/erlang/bin" exec-path))
(require 'erlang-start)
;; faster emacs
(fset #'jsonrpc--log-event #'ignore)
(setq eglot-events-buffer-size 0)
(setq eglot-sync-connect nil)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)

;; for autosave annoying vc appearance
(add-to-list 'load-path "/Users/byeongcheollim/emacs-auto-save") ; add auto-save to your load-path
(require 'auto-save)
(auto-save-enable)

(setq auto-save-silent t)   ; quietly save
(setq auto-save-delete-trailing-whitespace t)  ; automatically delete spaces at the end of the line when saving

;;; custom predicates if you don't want auto save.
;;; disable auto save mode when current filetype is an gpg file.
(setq auto-save-disable-predicates
      '((lambda ()
      (string-suffix-p
      "gpg"
      (file-name-extension (buffer-name)) t))))
(use-package ob-mermaid
	:ensure t)
(setq og-mermaid-cli-path "/Users/byeongcheollim/.nvm/versions/node/v18.19.1/bin/mmdc")
;; active Babel languages
(org-babel-do-load-languages
'org-babel-load-languages
'((shell . t)))
;; babel org kotin
(use-package ob-kotlin
	:ensure t)
(use-package ob-rust
	:ensure t)
(use-package kotlin-mode
	:ensure t)
;; set java_home
;;(setenv "JAVA_HOME"
;;				"/usr/local/Cellar/openjdk@17/17.0.13/libexec/openjdk.jdk/Contents/Home/")
(use-package org-bullets
	:ensure t
	:config
	(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
)
(use-package restclient
	:ensure t
)
;; for org haskell
(require 'ob-haskell)
;;(use-package ob-haskell
;;	:ensure t)
;; copilot
;;(setq max-lisp-eval-depth 16000)
(use-package editorconfig
	:ensure t)

(add-to-list 'load-path "/Users/byeongcheollim/workspace/copilot/copilot.el")
(require 'copilot)
(define-key copilot-completion-map (kbd "<tab>") 'copilot-next-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-next-completion)
(define-key copilot-completion-map (kbd "<C-return>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "C-RET") 'copilot-accept-completion)
;; diff show on buffer
(use-package diff-hl
	:ensure t
	:init
	(global-diff-hl-mode))
;; split and focus
(global-set-key "\C-x2" (lambda () (interactive)(split-window-vertically) (other-window 1)))
(global-set-key "\C-x3" (lambda () (interactive)(split-window-horizontally) (other-window 1)))
;; shell on other window
(defun shell-other-window ()
  "Open a `eshell' in a new window."
  (interactive)
  (let ((buf (eshell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))
;; shell window
(global-set-key (kbd "C-;") 'shell-other-window)

;; deepseek
(use-package minuet
  	:ensure t
    :bind
    (;("M-y" . #'minuet-complete-with-minibuffer) ;; use minibuffer for completion
     ("M-i" . #'minuet-show-suggestion) ;; use overlay for completion
     :map minuet-active-mode-map
     ;; These keymaps activate only when a minuet suggestion is displayed in the current buffer
     ("M-p" . #'minuet-previous-suggestion) ;; invoke completion or cycle to next completion
     ("M-n" . #'minuet-next-suggestion) ;; invoke completion or cycle to previous completion
     ("M-A" . #'minuet-accept-suggestion) ;; accept whole completion
     ;; Accept the first line of completion, or N lines with a numeric-prefix:
     ;; e.g. C-u 2 M-a will accepts 2 lines of completion.
     ("M-a" . #'minuet-accept-suggestion-line)
     ("M-e" . #'minuet-dismiss-suggestion))

    :init
    ;; if you want to enable auto suggestion.
    ;; Note that you can manually invoke completions without enable minuet-auto-suggestion-mode
    (add-hook 'prog-mode-hook #'minuet-auto-suggestion-mode)

    :config
    (setq minuet-provider 'openai-fim-compatible)
    (setq minuet-n-completions 1) ; recommended for Local LLM for resource saving
		(setq minuet-request-timeout 8)
    ; I recommend you start with a small context window firstly, and gradually increase it based on your local computing power.
    (setq minuet-context-window 128)
    (plist-put minuet-openai-fim-compatible-options :end-point "http://localhost:11434/v1/completions")
    ;; an arbitrary non-null environment variable as placeholder
    (plist-put minuet-openai-fim-compatible-options :name "Deepseek")
    (plist-put minuet-openai-fim-compatible-options :api-key "TERM")
    (plist-put minuet-openai-fim-compatible-options :model "deepseek-coder-v2")
    ;; Required when defining minuet-ative-mode-map in insert/normal states.
    ;; Not required when defining minuet-active-mode-map without evil state.
    ;; (add-hook 'minuet-active-mode-hook #'evil-normalize-keymaps))
    (minuet-set-optional-options minuet-openai-fim-compatible-options :max_tokens 256))

;; java setting for scala
(setq exec-path (cons "/usr/local/Cellar/openjdk@8/1.8.0-422/libexec/openjdk.jdk/Contents/Home/bin" exec-path))
