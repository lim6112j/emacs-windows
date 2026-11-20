;;; writing.el --- iA Writer-style long-form writing environment -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; A distraction-free prose environment built on Org mode:
;;
;;   * centered page with trimmed margins and chrome (writeroom-mode)
;;   * variable-pitch body text with a Korean-capable font (mixed-pitch)
;;   * paragraph focus dimming (focus-mode, from the `focus' package)
;;   * word/character counts and TARGET_WORDS progress in the mode line
;;   * novel / essay capture templates with DRAFT-REVISION-FINAL status
;;   * one-command Markdown export of a scene, chapter, or whole file
;;
;; Enter the whole environment with `C-c w w'.  Single pieces:
;;
;;   C-c w w  toggle the focused writing environment
;;   C-c w f  dim everything but the current paragraph (focus-mode)
;;   C-c w n  narrow to the current subtree (chapter or scene)
;;   C-c w W  widen back
;;   C-c w c  detailed counts in the echo area
;;   C-c w g  set TARGET_WORDS for the current subtree
;;   C-c w e  export the buffer, or the narrowed subtree, to Markdown
;;
;; Capture templates for new projects, novel scenes, and essays:
;; `org-capture' and pick the "Writing" group.
;;
;;; Code:

(defgroup writing nil
  "iA Writer-style long-form writing environment."
  :group 'org)

;;;; Prose typography

(defcustom writing-prose-font "Iowan Old Style"
  "Variable-pitch family used for prose body text."
  :type 'string
  :group 'writing)

(defcustom writing-cjk-font "Apple SD Gothic Neo"
  "Family used for Korean (and other CJK) glyphs in prose faces."
  :type 'string
  :group 'writing)

(defcustom writing-directory
  (expand-file-name "~/writing/")
  "Directory holding writing projects (novel.org, essays.org, ...).
Kept outside ~/org so org-roam does not index manuscripts as notes."
  :type 'directory
  :group 'writing)

(set-face-attribute 'variable-pitch nil
                    :family writing-prose-font
                    :height 1.06)

(dolist (script '(hangul kana cjk-misc bopomofo))
  (set-fontset-font t script (font-spec :family writing-cjk-font)))

;; Korean has no spaces; let lines break at character boundaries too.
(setq-default word-wrap-by-category t)

;;;; Packages

(use-package writeroom-mode
  :ensure t
  :custom
  ;; absolute columns, so the line length stays readable regardless of
  ;; window size (a fraction would be too wide on big monitors)
  (writeroom-width 70)
  (writeroom-mode-line t))

;; provides `focus-mode', which dims everything but the current
;; paragraph (org-mode: current element)
(use-package focus
  :ensure t)

(use-package mixed-pitch
  :ensure t)

;;;; Counting

(defun writing/word-count ()
  "Count whitespace-delimited words in the accessible part of the buffer."
  (length (split-string
           (buffer-substring-no-properties (point-min) (point-max))
           "[ \t\n\r]+" t)))

(defun writing/char-count ()
  "Count non-whitespace characters in the accessible part of the buffer."
  (length (seq-filter
           (lambda (c) (not (memq c '(?\s ?\t ?\n ?\r ?　))))
           (string-to-list
            (buffer-substring-no-properties (point-min) (point-max))))))

(defvar-local writing/counts-cache nil
  "Cached (TICK WORDS . CHARS); invalidated by buffer-modified-tick.")

(defun writing/counts ()
  "Return (WORDS . CHARS), recomputed only after buffer changes."
  (unless (eq (car writing/counts-cache) (buffer-modified-tick))
    (setq writing/counts-cache
          (cons (buffer-modified-tick)
                (cons (writing/word-count) (writing/char-count)))))
  (cdr writing/counts-cache))

(defun writing/korean-p ()
  "Return non-nil when the accessible part of the buffer contains Hangul."
  (save-excursion
    (goto-char (point-min))
    (re-search-forward "[가-힣]" nil t)))

(defun writing/target-words ()
  "Return TARGET_WORDS of the current Org entry as a number, or nil."
  (when (derived-mode-p 'org-mode)
    (ignore-errors
      (let ((raw (org-entry-get nil "TARGET_WORDS")))
        (and raw (string-match-p "[0-9]" raw)
             (string-to-number raw))))))

(defun writing/mode-line-string ()
  (let* ((counts (writing/counts))
         (words (car counts))
         (chars (cdr counts))
         (target (writing/target-words)))
      (if (writing/korean-p)
          (if (and target (> target 0))
              (format " %d/%d자 " chars target)
            (format " %d자 " chars))
        (if (and target (> target 0))
            (format " %d/%dw " words target)
          (format " %dw " words)))))

;;;###autoload
(define-minor-mode writing-count-mode
  "Show word/character count and goal progress in the mode line."
  :init-value nil
  :lighter (" " (:eval (writing/mode-line-string)))
  :group 'writing)

(defun writing/count-message ()
  "Report word and character counts, plus any TARGET_WORDS progress."
  (interactive)
  (let* ((counts (writing/counts))
         (words (car counts))
         (chars (cdr counts))
         (target (writing/target-words)))
    (message "%d words, %d chars%s"
               words chars
               (if (and target (> target 0))
                   (format " — %d/%d (%d%%)" chars target
                           (round (* 100 (/ (float chars) target))))
                 ""))))

;;;; The writing environment

;;;###autoload
(define-minor-mode writing-mode
  "Buffer-local prose defaults for long-form writing.
Soft-wraps text, switches the body to the variable-pitch face, hides
line numbers, allows character-level Korean line breaking, and shows
counts in the mode line."
  :init-value nil
  :lighter " Write"
  :group 'writing
  (if writing-mode
      (progn
        (display-line-numbers-mode -1)
        (visual-line-mode 1)
        (mixed-pitch-mode 1)
        (setq-local word-wrap-by-category t)
        (setq-local line-spacing 0.18)
        (when (derived-mode-p 'org-mode)
          (require 'org-indent)
          (org-indent-mode 1))
        (writing-count-mode 1))
    (visual-line-mode -1)
    (mixed-pitch-mode -1)
    (kill-local-variable 'word-wrap-by-category)
    (kill-local-variable 'line-spacing)
    (when (derived-mode-p 'org-mode)
      (org-indent-mode -1))
    (writing-count-mode -1)
    (when global-display-line-numbers-mode
      (display-line-numbers-mode 1))))

;;;###autoload
(defun writing/toggle-focus ()
  "Toggle the full focused writing environment.
`writeroom-mode' centers the page and trims window chrome;
`writing-mode' applies prose typography and counting."
  (interactive)
  (if writeroom-mode
      (progn
        (writing-mode -1)
        (writeroom-mode -1))
    (writeroom-mode 1)
    (writing-mode 1)))

;;;; Scene / chapter navigation, targets, and export

(defun writing/narrow ()
  "Narrow to the current Org subtree (chapter or scene)."
  (interactive)
  (unless (derived-mode-p 'org-mode)
    (user-error "Not an Org buffer"))
  (org-narrow-to-subtree))

(defun writing/set-target (n)
  "Set TARGET_WORDS for the current Org subtree to N."
  (interactive "nTarget words: ")
  (unless (derived-mode-p 'org-mode)
    (user-error "Not an Org buffer"))
  (org-set-property "TARGET_WORDS" (number-to-string n)))

;;;###autoload
(defun writing/export-markdown ()
  "Export the current Org buffer to Markdown.
When the buffer is narrowed (see \\[writing/narrow]) only the visible
subtree is exported, to NAME-heading.md; otherwise the whole file goes
to NAME.md next to the source."
  (interactive)
  (unless (derived-mode-p 'org-mode)
    (user-error "Not an Org buffer"))
  (unless buffer-file-name
    (user-error "Buffer is not visiting a file"))
  (let* ((base (file-name-sans-extension buffer-file-name))
         (slug (when (buffer-narrowed-p)
                 (downcase
                  (replace-regexp-in-string
                   "[^[:alnum:]]+" "-"
                   (string-trim (org-get-heading t t t))))))
         (out (concat base (when slug (concat "-" slug)) ".md")))
    (org-export-to-file 'md out)
    (message "Exported to %s" out)))

;;;; Keybindings

(defvar writing-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "w") #'writing/toggle-focus)
    (define-key map (kbd "f") #'focus-mode)
    (define-key map (kbd "n") #'writing/narrow)
    (define-key map (kbd "W") #'widen)
    (define-key map (kbd "c") #'writing/count-message)
    (define-key map (kbd "g") #'writing/set-target)
    (define-key map (kbd "e") #'writing/export-markdown)
    map)
  "Prefix map for the writing commands, bound to \\`C-c w'.")

;; Bind the keymap object itself, not the symbol: key lookup only
;; descends into a real keymap, and a symbol is treated as a command.
(global-set-key (kbd "C-c w") writing-map)

;;;; Capture templates

(defun writing/project-file ()
  "Return the file for a new writing project, creating it on demand."
  (let* ((name (replace-regexp-in-string
                "[^[:alnum:]]+" "-"
                (string-trim (read-string "Project file name: "))))
         (file (expand-file-name (concat name ".org") writing-directory)))
    (make-directory (file-name-directory file) t)
    file))

(setq org-capture-templates
      (append
       (when (boundp 'org-capture-templates)
         (assoc-delete-all "w" org-capture-templates))
       `(("w" "Writing")
         ("wN" "New writing project" plain
          (file writing/project-file)
          "#+TITLE: %^{Project title}\n#+SUBTITLE: %^{Subtitle}\n#+AUTHOR: %^{Author}\n#+DATE: %t\n#+TODO: DRAFT REVISION FINAL | PUBLISHED\n#+STARTUP: overview indent\n#+OPTIONS: toc:nil num:nil\n\n* Notes\n:PROPERTIES:\n:STATUS: DRAFT\n:END:\n\n* Draft\n")
         ("wn" "Novel scene" entry
          (file+headline ,(expand-file-name "novel.org" writing-directory) "Scenes")
          "* %^{Scene title}\n:PROPERTIES:\n:STATUS: DRAFT\n:POV: %^{POV character}\n:TARGET_WORDS: %^{Target words}\n:END:\n\n%?")
         ("we" "Essay draft" entry
          (file+headline ,(expand-file-name "essays.org" writing-directory) "Drafts")
          "* %^{Working title}\n:PROPERTIES:\n:STATUS: DRAFT\n:TARGET_WORDS: %^{Target words}\n:END:\n\n%?")
         ("wi" "Writing idea" entry
          (file+headline ,(expand-file-name "inbox.org" writing-directory) "Inbox")
          "* %^{Idea}\n%U\n%?"))))

;;;; Auto-enable in the writing directory

(add-hook 'org-mode-hook
          (lambda ()
            (when (and buffer-file-name
                       (string-prefix-p (expand-file-name writing-directory)
                                        (expand-file-name buffer-file-name)))
              (writing-mode 1))))

(provide 'writing.el)
;;; writing.el ends here
