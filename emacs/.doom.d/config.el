;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq doom-theme 'doom-vibrant)

(use-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

(use-package! eterm-256color
  :after term
  :config
  (add-hook 'term-mode-hook #'eterm-256color-mode))

(after! lsp-ui
  ;; workaround, see https://github.com/emacs-lsp/lsp-ui/issues/278#issuecomment-590000913
  (setq lsp-ui-peek-fontify 'always))

(setq lsp-keymap-prefix "C-c l")

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration))

;; (which-function-mode)
;; (eval-after-load "which-func"
;;     '(setq which-func-modes '(java-mode c++-mode org-mode)))

;; `SPC f r' ignore
(after! recentf
  (add-to-list 'recentf-exclude
             "~/.dotfiles/emacs/.emacs.d-doom-emacs/.local/etc/workspaces/autosave"))


;;
;; TODO A quick to add supporting for space as delimiters for ivy--regex-fuzzy.
;; ref: https://github.com/abo-abo/swiper/issues/360#issuecomment-253992364
;;

;; darken code block back ground by 5%
;; ref: https://orgmode.org/manual/Editing-Source-Code.html
(after! org
  (require 'color)
  (set-face-attribute 'org-block nil :background
                    (color-darken-name
                     (face-attribute 'default :background) 5)))


;;
;; org-babel
;;

(after! org
  :config
  (org-babel-do-load-languages
    'org-babel-load-languages
    '((dot . t))))
