;;; toolset/init-magit.el -*- lexical-binding: t -*-

(defgroup irkalla-magit '()
  "Magical git client for Emacs."
  :tag "Irkalla Magit"
  :group 'irkalla)

;; TODO: expand this later... + add open in new buffer instead of mini-buf.
(use-package magit
  :if (executable-find "git")
  :bind (("C-x g" . magit))
  :custom
  (magit-auto-revert-mode nil)
  (magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))

(provide 'init-magit)