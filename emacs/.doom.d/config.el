;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(use-package! dap-mode
  :after lsp-mode
  :config
  (dap-mode t)
  (dap-ui-mode t))

;; ccls implies use of lsp
(after! ccls
  (setq lsp-prefer-flymake nil)
  (setq company-lsp-enable-recompletion t)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  (setq ccls-sem-highlight-method 'font-lock)
  (ccls-use-default-rainbow-sem-highlight)
  (map!
   :map (c-mode-map c++-mode-map)
   :n "C-h" (λ! (ccls-navigate "U"))
   :n "C-j" (λ! (ccls-navigate "R"))
   :n "C-k" (λ! (ccls-navigate "L")))
  )

(use-package! eterm-256color
  :after term
  :config
  (add-hook 'term-mode-hook #'eterm-256color-mode))

;;(setq ccls-args '("--log-file=/tmp/ccls.log"))
