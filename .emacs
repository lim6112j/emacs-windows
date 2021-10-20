(menu-bar-mode 0)
(tool-bar-mode 0)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("78e9a3e1c519656654044aeb25acb8bec02579508c145b6db158d2cfad87c44e" "583148e87f779040b5349db48b6fcad6fe9a873c6ada20487e9a1ec40d845505" default))
 '(global-display-line-numbers-mode t)
 '(haskell-mode-hook '(interactive-haskell-mode) t)
 '(initial-frame-alist '((fullscreen . maximized)))
 '(lsp-dart-dap-flutter-hot-reload-on-save t)
 '(org-roam-directory "~/org/roam/")
 '(package-selected-packages
   '(lsp-origami folding lua-mode magit counsel projectile-ripgrep wgrep ivy org-evil yasnippet-snippets evil-surround php-mode evil-terminal-cursor-changer web-mode lsp-haskell evil-org org org-roam dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company lsp-ui company hover))
 '(tool-bar-mode nil))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;;'(default ((t (:inherit nil :extend nil :stipple nil :background "#2e3436" :foreground "#eeeeec" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 180 :width normal :foundry "nil" :family "Menlo")))))
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
;;(require 'smex) ; Not needed if you use package.el
;;(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                    ; when Smex is auto-initialized on its first run.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;;(global-set-key (kbd "M-x") 'smex)
;;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "C-.") #'next-window-any-frame)
(global-set-key (kbd "C-,") #'prev-window)

(defun prev-window ()
  (interactive)
  (other-window -1))
(add-to-list 'load-path "~/.emacs.d/lisp")
;;(load "ghcid.el")
;;(require 'ghcid)
(cd "~")
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq ivy-count-format "(%d/%d) ")
(global-display-line-numbers-mode)
;;(require 'multiple-cursors)
;;(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;;(global-set-key (kbd "C->") 'mc/mark-next-like-this)
;;(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;;(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
(put 'upcase-region 'disabled nil)
(global-set-key (kbd "M-o") (lambda () (interactive)(end-of-line)(newline)))
(add-to-list 'load-path "~/.emacs.d/elpa/evil-1.14.0")
(require 'evil)
(require 'evil-leader)
(global-evil-leader-mode)
(evil-mode 1)
(ido-mode 1)
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)
;;(add-to-list 'exec-path "~/.ghcup/bin/")
;;(add-to-list 'exec-path "~/.local/bin/")
(projectile-mode +1)
;; for mac
;;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(set-face-attribute 'comint-highlight-prompt nil
                    :inherit nil)
(require 'key-chord)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "d" 'dired
  "e" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "g" 'magit-status
  "s" 'save-buffer
  "t" 'treemacs
  "c" 'lsp-execute-code-action
  "f" 'lsp-format-buffer
  "S" 'shell)

(setq package-selected-packages 
  '(dart-mode lsp-mode lsp-dart lsp-treemacs flycheck company
    ;; Optional packages
    lsp-ui company hover))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

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
 '(default ((t (:family "D2Coding" :foundry "outline" :slant normal :weight normal :height 98 :width normal)))))
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
(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
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
(company-mode 1)
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
