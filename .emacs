;; (set-language-environment "Korean")
;; (prefer-coding-system 'utf-8)
(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode -1)
;; mac alt-x weird char input
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(toggle-frame-fullscreen)
(global-display-line-numbers-mode)
(global-auto-revert-mode)
(package-initialize)
(setq package-install-upgrade-built-in t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(use-package zenburn-theme
  :ensure t)
(load-theme 'zenburn t)
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
 '(package-selected-packages
	 '(treemacs company tree-sitter-langs tree-sitter typescript-mode exec-path-from-shell which-key elixir-mode prettier-js jsonrpc general eldoc-box all haskell-mode projectile-ripgrep ripgrep tree-sitter-mode org-roam-ui org-roam org rust-mode yasnippet lsp savehist vertico projectile helm-lsp lsp-treemacs lsp-ivy help-lsp lsp-ui lsp-mode helm zenburn-theme use-package smartparens multiple-cursors))
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
 '(default ((t (:family "MesloLGM Nerd Font Mono" :foundry "PfEd" :slant normal :weight normal :height 130 :width normal)))))

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
  (use-package exec-path-from-shell
		:ensure t
		:config
		(exec-path-from-shell-initialize)))
(use-package projectile
	:ensure t
	:config
	(projectile-mode +1)
	;; Recommended keymap prefix on macOS
	(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
	;; Recommended keymap prefix on Windows/Linux
	(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
)

;; treemacs
(use-package treemacs
	:ensure t
	:config
	(global-set-key (kbd "C-c t") 'treemacs))

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
(use-package rust-mode
	:ensure t)
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
(use-package typescript-mode
	:ensure t
	:config
	(add-hook 'typescript-mode-hook 'hs-minor-mode))

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
;; use-package for configuring, even though ;; built-in in Emacs 29, thus :ensure nil
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
	(with-eval-after-load 'eglot (fset #'jsonrpc--log-event #'ignore))
	(with-eval-after-load 'eglot-java
	 	(define-key eglot-java-mode-map (kbd "C-c l n") #'eglot-java-file-new)
	 	(define-key eglot-java-mode-map (kbd "C-c l x") #'eglot-java-run-main)
	 	(define-key eglot-java-mode-map (kbd "C-c l t") #'eglot-java-run-test)
	 	(define-key eglot-java-mode-map (kbd "C-c l N") #'eglot-java-project-new)
	 	(define-key eglot-java-mode-map (kbd "C-c l T") #'eglot-java-project-build-task)
	 	(define-key eglot-java-mode-map (kbd "C-c l R") #'eglot-java-project-build-refresh))
	;;(add-to-list 'eglot-server-programs '(java-mode "jdtls"))
	(add-to-list 'eglot-server-programs '(java-mode "/Users/byeongcheollim/.emacs.d/share/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/bin/jdtls"))
  (setq eglot-events-buffer-size 0)
  (add-hook 'elixir-mode-hook 'eglot-ensure)
	(add-to-list 'eglot-server-programs '(elixir-mode "/Users/byeongcheollim/workspace/elixir-ls-v0.22.0/language_server.sh"))
  (setq-default eglot-workspace-configuration
                '((haskell
                   (plugin
                    (stan
                     (globalOn . :json-false))))))  ;; disable stan
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
  (haskell-mode . eglot-ensure)
  (typescript-ts-mode . eglot-ensure)
  (tsx-ts-mode . eglot-ensure)
	(typescript-mode . eglot-ensure)
  (rust-mode . eglot-ensure)
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
	:ensure t
  :demand t
  :diminish tree-sitter-mode
  :config
  (setq treesit-font-lock-level 4))

(use-package tree-sitter-langs
	:ensure t
  :after tree-sitter)

;; seems like it will still throw a warning the first time you visit a file with
;; a treesit major mode if you don't have the grammar installed; manually
;; running M-x lang-ts-mode after waiting a few seconds for this package to
;; install and compile the grammar fixes the warning and you shouldn't see it
;; again afterwards
;;(use-package treesit-auto
;;  :config
;;  (setq treesit-auto-install t))

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
(use-package company
	:ensure t
	:config
	(add-hook 'rust-mode-hook 'company-mode)
	(add-hook 'typescript-mode-hook 'company-mode))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; for m1 mac
(setq load-path (cons  "/opt/homebrew/opt/erlang/lib/erlang/lib/tools-3.6/emacs"
      load-path))      (setq erlang-root-dir "/opt/homebrew/opt/erlang/bin")
      (setq exec-path (cons "/opt/homebrew/opt/erlang/bin" exec-path))
      (require 'erlang-start)
;; for intel mac
;;(Setq Load-path (cons  "/usr/local/opt/erlang/lib/erlang/lib/tools-3.6/emacs"
;;      load-path))      (setq erlang-root-dir "/usr/local/opt/erlang/bin")
;;      (setq exec-path (cons "/usr/local/opt/erlang/bin" exec-path))
;;      (require 'erlang-start)
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
