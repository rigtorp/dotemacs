;; basic settings
(set-default-font "Monospace-10")
(menu-bar-mode nil)
(scroll-bar-mode nil)
(tool-bar-mode nil)
(setq inhibit-startup-screen t)

(add-to-list 'load-path "/home/erkki/.emacs.d/")

;; save history
(savehist-mode t)
(recentf-mode t)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; show paren
(show-paren-mode t)

;; flyspell
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

;; yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")

;; auto complete
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories 
             "~/.emacs.d/auto-complete/ac-dict")
(ac-config-default)

;; gccsense
(require 'gccsense)
(add-hook 'c-mode-common-hook
          (lambda ()
            (local-set-key (kbd "C-c .") 'ac-complete-gccsense)))

;; gtags
;(add-hook 'c-mode-common-hook
;          (lambda ()
;            (gtags-mode)))

;; c-mode
(c-set-offset 'innamespace 0)

;; custom
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(indent-tabs-mode nil)
 '(standard-indent 2))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
