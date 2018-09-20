;;; packages.el --- vue layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: lawr <lawrance.rsp@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst vue-packages
  '(
    add-node-modules-path
    company-lsp 
    flycheck
    smartparens
    vue-mode
    (lsp-vue :requires lsp-mode lsp-ui company-lsp)
  ))

(defun vue/post-init-add-node-modules-path ()
  (spacemacs/add-to-hooks #'add-node-modules-path '(css-mode-hook
                                                    vue-html-mode-hook
                                                    js-mode-hook)))

(defun vue/init-vue-mode ()
  "Initialize vue package"
  (use-package vue-mode
    :mode
    (("\\.vue\\'"        . vue-mode))
    :config
    (setq mmm-submode-decoration-level 0)
    :commands lsp-vue-enable))

(defun vue/post-init-smartparens()
  (add-to-list 'vue-mode-hook #'smartparens-mode))

(defun vue/post-init-flycheck ()
  (spacemacs/enable-flycheck 'vue-mode))

;; lsp-ui-doc-enable	t
;; lsp-ui-flycheck-enable t
;; lsp-ui-sideline-enable t
;; lsp-ui-flycheck-enable t

(defun vue/init-lsp-vue ()
  (use-package lsp-vue
    :init
    (add-hook 'vue-mode-hook #'lsp-vue-mmm-enable)
    :config
    (when vue-format-before-save
      (add-hook 'before-save-hook 'spacemacs/vue-format-before-save))))

(defun vue/post-init-company-lsp ()
  (spacemacs|add-company-backends
    :backends company-lsp
    :modes vue-mode))
