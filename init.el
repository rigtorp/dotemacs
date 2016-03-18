;;; init.el-- - init
;;; Commentary:
;;; Code:

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(defun my-compile ()
  (interactive)
  (setq-local compilation-read-command nil)
  (call-interactively 'compile))

(use-package cc-mode
  :bind (:map c++-mode-map
	      ("C-c f" . clang-format-buffer)
	      ("M-p" . company-complete-common)
	      ("<f5>" . my-compile)))

(use-package clang-format
  :ensure t
  :commands clang-format clang-format-buffer clang-format-region)

(use-package cmake-mode
  :ensure t
  :mode "CMakeLists.txt")

(use-package company
  :ensure t
  :config
  (global-company-mode t))

(use-package company-go
  :ensure t
  :commands company-go)    

(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :init
  (add-hook 'c++-mode-hook 'flycheck-mode)
  (add-hook 'c-mode-hook 'flycheck-mode))

(use-package flycheck-irony
  :ensure t
  :commands flycheck-irony-setup
  :init
  (add-hook 'c++-mode-hook 'flycheck-irony-setup)
  (add-hook 'c-mode-hook 'flycheck-irony-setup))

(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :init
  (defun my-go-company-hook ()
    (setq company-backends 'company-go))
  (add-hook 'go-mode-hook 'my-go-company-hook))

(use-package helm
  :ensure t
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  :init
  (helm-mode t))

(use-package irony
  :ensure t
  :commands irony-mode
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (defun my-irony-mode-hook ()
    (setq company-backends '(company-irony-c-headers company-irony))
    (setq irony-additional-clang-options '("-std=c++14")))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package projectile
  :ensure t
  :config
  (projectile-global-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
    (helm-projectile helm company-c-headers yasnippet use-package solarized-theme projectile markdown-mode go-mode flycheck-irony company-irony-c-headers company-irony cmake-mode clang-format)))
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
