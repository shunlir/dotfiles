;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

(when (package! lsp-mode)
  (package! dap-mode))

(when (package! term)
  (package! eterm-256color))

(package! modern-cpp-font-lock)
