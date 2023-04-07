;;; completion/init-corfu.el -*- lexical-binding: t -*-

(defgroup irkalla-corfu '()
  "an emacs (at-point) completion pop-up window"
  :tag "Irkalla Corfu"
  :group 'irkalla)

(use-package corfu
  :bind (:map corfu-map
              ("TAB" . corfu-next)
              ([tab] . corfu-next)
              ("S-TAB" . corfu-previous)
              ([backtab] . corfu-previous))
  :init (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preselect t)
  (corfu-auto-prefix 1)
  (corfu-auto-delay 0.05)
  (corfu-count 16)
  (corfu-scroll-margin 5)
  (corfu-separator ?\s)
  (corfu-on-exact-match 'insert)
  (corfu-preview-current 'insert)
  (corfu-quit-no-match 'separator)
  :config
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active)
                (bound-and-true-p vertico--input)
                (eq (current-local-map) read-passwd-map))
      (setq-local corfu-echo-delay nil
                  corfu-popupinfo-delay nil)
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1))

(use-package corfu-popupinfo
  :straight nil
  :hook (corfu-mode . corfu-popupinfo-mode)
  :custom (corfu-popupinfo-delay '(0.5 . 0.2)))

(use-package kind-icon
  :after corfu
  :init (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter)
  :custom (kind-icon-default-face 'corfu-default))

(use-package cape
  :config
  (dolist (fn '(cape-file cape-dabbrev cape-ispell cape-symbol cape-tex cape-keyword))
    (add-to-list 'completion-at-point-functions fn)))

(provide 'init-corfu)
