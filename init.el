(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'go-mode-hook 'auto-complete-mode)

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'yas-global-mode)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

(eval-after-load 'company
  '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(setq irony-additional-clang-options '("-std=c++14"))

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(add-hook 'after-init-hook 'projectile-global-mode)

(global-set-key
 (kbd "<f5>") (lambda ()
		(interactive)
		(setq-local compilation-read-command nil)
		(call-interactively 'compile)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(clang-format-executable "clang-format-3.7")
 '(safe-local-variable-values
   (quote
    ((eval add-hook
	   (quote before-save-hook)
	   (function clang-format-buffer)
	   nil t)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
