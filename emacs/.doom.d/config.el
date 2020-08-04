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

