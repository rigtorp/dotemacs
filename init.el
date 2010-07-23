(set-default-font "Monospace-10")

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
;(dolist (hook '(c++-mode-hook c-mode-hook))
;  (add-hook hook (lambda () (flyspell-mode 1))))


;; font-lock
(require 'font-lock)
(global-font-lock-mode t)


;; yasnippet
(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/yasnippet/snippets")


;; auto-complete
(add-to-list 'load-path "/home/erkki/.emacs.d/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories 
	     "/home/erkki/.emacs.d/auto-complete/ac-dict")
(ac-config-default)


;; gccsense
(require 'gccsense)
(add-hook 'c-mode-common-hook
          (lambda ()
            (local-set-key (kbd "C-c .") 'ac-complete-gccsense)))


;(add-hook 'c-mode-common-hook
;          (lambda ()
;            (gtags-mode)))



;; c-mode
(c-set-offset 'innamespace 0)


(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode nil)
 '(standard-indent 2)
 '(tool-bar-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

