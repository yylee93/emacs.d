;;; editor/init-editor.el -*- lexical-binding: t -*-

;; Require custom editor modules:
(require 'init-evil)
;; (require 'init-indentation) ;; FIXME: broken..
(require 'init-orgmode)

;; Indentation: 2 -> 4 + tabs -> spaces
(use-package emacs
  :ensure nil
  :init
  ;; WARN: Smooth scrolling (Emacs >= 29)
  (when (boundp 'pixel-scroll-precision-mode)
    (pixel-scroll-precision-mode 1))
  :custom
  (indent-tabs-mode nil)
  (electric-indent-inhibit t)
  (standard-indent 4)
  (tab-width 4))

;; Built-in configurations
(use-package savehist
  :ensure nil
  :init (savehist-mode 1)
  :custom
  (history-length 1000)
  (history-delete-duplicates t)
  (savehist-autosave-interval 60)
  (savehist-save-minibuffer-history t)
  (savehist-file (expand-file-name "savehist" user-emacs-cache-directory)))

(use-package saveplace
  :ensure nil
  :init (save-place-mode t)
  :custom
  (save-place-file (expand-file-name "saveplace" user-emacs-cache-directory))
  (save-place-forget-unreadable-files t))

;;; External Packages

;; Auto-format code!
(use-package format-all
  :config
  :hook ((prog-mode . format-all-mode)
         (prog-mode . format-all-ensure-formatter))
  :config
  (setq-default format-all-formatters
                '(("Nix" nixfmt)
                  ("Haskell" stylish-haskell)
                  ("Rust" rustfmt))))

;; Code linting
(use-package flycheck
  :hook (after-init . global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; Spelling
(use-package flyspell
  :hook
  ((markdown-mode org-mode text-mode) . flyspell-mode)
  (prog-mode . flyspell-prog-mode)
  :custom
  (flyspell-issue-message-flag nil)
  (flyspell-issue-welcome-flag nil)
  (flyspell-default-dictionary "en_US"))

;; Fold code like paper
(use-package origami
  :hook (nix-mode . origami-mode))

;; Smarter lisp parents
(use-package smartparens
  :hook ((prog-mode text-mode) . smartparens-mode))

;; Perspective.el <-
(use-package perspective
  :bind ("C-x C-b" . persp-list-buffers)
  :custom (persp-mode-prefix-key (kbd "C-c M-p"))
  :init (persp-mode))

;; Tree-based undo system
(use-package undo-tree
  :init (global-undo-tree-mode)
  :custom
  (undo-tree-visualizer-diff t)
  (undo-tree-visualizer-timestamps t))

(provide 'init-editor)
