;;; private/my-cc/config.el -*- lexical-binding: t; -*-

;; ccls implies use of lsp
(after! ccls
  (setq lsp-prefer-flymake nil)
  (setq company-lsp-enable-recompletion t)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  ;; TODO: below line is reverted by doom until lsp-enable-semantic-highlighting set to 't
  ;; see https://github.com/hlissner/doom-emacs/commit/d85c7b857bc536e2371d7dfe72f05d6d3b095f0a
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
