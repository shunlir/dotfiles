;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;;(setq user-full-name "John Doe"
;;      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;
;; `SPC f r' ignore
;; after making change, then run M-x recentf-cleanup to make it work.
(after! recentf
  (add-to-list 'recentf-exclude
             "~/.dotfiles/emacs/.emacs.d-doom-emacs/.local/etc/workspaces/autosave"))

(setq projectile-project-search-path '("~/repo" "/workspaces"))

(setq orderless-matching-styles '(orderless-literal, orderless-regexp, orderless-flex))
(setq orderless-matching-styles
 '(orderless-literal
   orderless-prefixes
   orderless-initialism
   orderless-regexp
   ;; orderless-flex                       ; Basically fuzzy finding
   ;; orderless-strict-leading-initialism
   ;; orderless-strict-initialism
   ;; orderless-strict-full-initialism
   ;; orderless-without-literal          ; Recommended for dispatches instead
   ))

;;
;; org-mode
;;
(setq org-hide-emphasis-markers t)
(add-hook 'org-mode-hook 'org-appear-mode)
(after! org
  (org-babel-do-load-languages
    'org-babel-load-languages
    '((dot . t)
      (plantuml . t)))
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml)))

;;(defun my/org-mode-visual-fill ()
;;  (setq visual-fill-column-width 120
;;        visual-fill-column-center-text t)
;;  (visual-fill-column-mode 1))
;;(after! org
;;  (add-hook 'org-mode-hook #'my/org-mode-visual-fill))

;;
;; plantuml-mode
;;
(after! plantuml-mode
  (setq plantuml-jar-path
      (expand-file-name "~/.local/bin/plantuml.jar"))
  (setq plantuml-default-exec-mode 'jar))


;;
;; terminal
;;
(use-package! eterm-256color
  :after term
  :config
  (add-hook 'term-mode-hook #'eterm-256color-mode))
