(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)
(toggle-frame-fullscreen)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-enabled-themes '(wombat))
 '(custom-safe-themes
   '("3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" "78e9a3e1c519656654044aeb25acb8bec02579508c145b6db158d2cfad87c44e" "583148e87f779040b5349db48b6fcad6fe9a873c6ada20487e9a1ec40d845505" default))
 '(fci-rule-color "#383838")
 '(global-display-line-numbers-mode t)
 '(haskell-mode-hook '(interactive-haskell-mode) t)
 '(lsp-dart-dap-flutter-hot-reload-on-save t)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(org-roam-directory "~/org/roam/")
 '(org-superstar-headline-bullets-list '(9673 9675 9673 10047))
 '(org-use-speed-commands nil)
 '(package-selected-packages
   '(pyenv-mode which-key ess multi-term org-superstar org-bullets smex company-lua luarocks flycheck-haskell lsp-origami folding lua-mode magit counsel projectile-ripgrep wgrep ivy org-evil yasnippet-snippets evil-surround php-mode evil-terminal-cursor-changer web-mode lsp-haskell evil-org org org-roam dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company lsp-ui company hover))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(projectile-globally-ignored-directories
   '(".idea" ".vscode" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" ".ccls-cache" ".cache" ".clangd" "Application Data" "AppData" "Cookies" "Documents" "local settings" "NetHood"))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                    ; when Smex is auto-initialized on its first run.
(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(global-set-key (kbd "M-x") 'counsel-M-x)
;;(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "C-.") #'next-window-any-frame)
(global-set-key (kbd "C-,") #'prev-window)

(defun prev-window ()
  (interactive)
  (other-window -1))
(cd "~")
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(global-display-line-numbers-mode)
(put 'upcase-region 'disabled nil)
(global-set-key (kbd "M-o") (lambda () (interactive)(end-of-line)(newline)))
(require 'evil)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-mode 1)
(ido-mode 1)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
(projectile-mode +1)
;; for mac
;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(set-face-attribute 'comint-highlight-prompt nil
                    :inherit nil)
(require 'key-chord)
(setq key-chord-two-keys-delay 0.2)
(key-chord-define evil-visual-state-map "df" 'evil-normal-state)
(key-chord-define evil-insert-state-map "df" 'evil-normal-state)
(key-chord-define evil-visual-state-map "jk" 'evil-normal-state)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  ;;"w h" 'windmove-left
  ;;"w H" 'evil-window-move-far-left
  ;;"w l" 'windmove-right
  ;;"w L" 'evil-window-move-far-right
  ;;"w k" 'windmove-up
  ;;"w K" 'evil-window-move-very-top
  ;;"w j" 'windmove-down
  ;;"w J" 'evil-window-move-very-bottom
  ;;"w d" 'evil-window-delete
  ;;"w s" 'evil-window-new
  ;;"w v" 'evil-window-vnew
  "w" 'evil-window-map
  "p" 'projectile-command-map
  "f f" 'counsel-find-file
  "f s" 'save-buffer
  "f d" 'dired
  "b b" 'counsel-switch-buffer
  "b k" 'kill-buffer
  "g g" 'magit-status
  "g c" 'magit-log-current
  "t t" 'treemacs
  "t f" 'treemacs-create-file
  "t d" 'treemacs-create-dir
  "c c" 'lsp-execute-code-action
  "c f" 'lsp-format-buffer
  "q q" 'save-buffers-kill-emacs
  ":" 'counsel-M-x
  "s" 'shell)

(add-hook 'dart-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      company-minimum-prefix-length 1
      lsp-lens-enable t
      lsp-signature-auto-activate nil)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'zenburn)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "D2Coding" :foundry "outline" :slant normal :weight bold :height 98 :width normal))))
 '(org-document-title ((t (:inherit default :weight bold :foreground "#DCDCCC" :font "Verdana" :height 1.5 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "#DCDCCC" :font "Verdana" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "#DCDCCC" :font "Verdana" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "#DCDCCC" :font "Verdana" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "#DCDCCC" :font "Verdana" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "#DCDCCC" :font "Verdana"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "#DCDCCC" :font "Verdana"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "#DCDCCC" :font "Verdana"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "#DCDCCC" :font "Verdana")))))
(setq org-roam-v2-ack t)
(setq org-return-follows-link  t)
(put 'narrow-to-region 'disabled nil)

(unless (display-graphic-p)
        (require 'evil-terminal-cursor-changer)
        (evil-terminal-cursor-changer-activate) ; or (etcc-on)
        )
(setq org-return-follows-link  t)
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(require 'yasnippet)
;;(yas-global-mode 1)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
;wsl-copy
(defun wsl-copy (start end)
  (interactive "r")
  (shell-command-on-region start end "clip.exe")
  (deactivate-mark)
)
(defun wsl-paste ()
  (interactive)
  (let ((clipboard
	 (shell-command-to-string "powershell.exe -command 'Get-Clipboard' 2> /dev/null")))
    (setq clipboard (replace-regexp-in-string "\r" "" clipboard))
    (setq clipboard (substring clipboard 0 -1))
    (insert clipboard))
)
(if (require 'folding nil 'noerror)
    (folding-mode-add-find-file-hook)
  (message "Library `folding' not found"))
(folding-add-to-marks-list 'dart-mode "#{{{" "#}}}" nil t)
(global-company-mode 1)
;; Add yasnippet support for all company backends
;; https://github.com/syl20bnr/spacemacs/pull/179
(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
(use-package ess
  :ensure t
  :init
  (require 'ess-site))
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(which-key-mode)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)))
