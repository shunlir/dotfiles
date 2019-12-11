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
  (setq ccls-args '("--init={\"cache\": {\"directory\": \"/tmp/ccls-cache\"}}"))
  (ccls-use-default-rainbow-sem-highlight)
  (map!
   :map (c-mode-map c++-mode-map)
   :n "C-h" (λ! (ccls-navigate "U"))
   :n "C-j" (λ! (ccls-navigate "R"))
   :n "C-k" (λ! (ccls-navigate "L"))
   :n "C-l" (λ! (ccls-navigate "D"))
   (:localleader
     :n "a"  #'ccls/references-address
     :n "f"  #'ccls/references-not-call
     :n "lp" #'ccls-preprocess-file
     :n "lf" #'ccls-reload
     :n "m"  #'ccls/references-macro
     :n "r"  #'ccls/references-read
     :n "w"  #'ccls/references-write))
  )

(use-package! modern-cpp-font-lock
  :hook '(c++-mode . modern-c++-font-lock-mode))

(use-package! eterm-256color
  :after term
  :config
  (add-hook 'term-mode-hook #'eterm-256color-mode))
