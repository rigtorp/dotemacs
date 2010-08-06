;;; anything-git.el --- Git sources for `anything.el'

;; Filename: anything-git.el

;; Description: Git sources for `anything.el'
;; Author: Erik Rigtorp <erik@rigtorp.com>
;; Copyright (C) 2010, Erik Rigtorp, all rights reserved.
;; Created: 2010-08-06
;; Keywords: anything, anything-git
;; Compatibility: GNU Emacs 22 ~ 23
;;
;; Features that might be required by this library:
;;
;; `anything'
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Require
(require 'anything)

;;; Code:

;; version check
(let ((version "1.263"))
  (when (and (string= "1." (substring version 0 2))
             (string-match "1\.\\([0-9]+\\)" anything-version)
             (< (string-to-number (match-string 1 anything-version))
                (string-to-number (substring version 2))))
    (error "Please update anything.el!!

http://www.emacswiki.org/cgi-bin/wiki/download/anything.el

or  M-x install-elisp-from-emacswiki anything.el")))


(defun anything-c-git-root ()
  (if anything-default-directory
      (let ((path (locate-dominating-file anything-default-directory ".git")))
        (if path (expand-file-name path)))))

(defun anything-c-git-files-init (path)
  (if path
      (with-current-buffer (anything-candidate-buffer 'global)
        (let ((default-directory path))
          (dolist (file (process-lines "git" "ls-files"))
            (insert default-directory file "\n"))))))

(defvar anything-c-source-git-files
  '((name . "git files")
    (init . (lambda() (anything-c-git-files-init (anything-c-git-root))))
    (candidates-in-buffer)
    (type . file)))

(defun anything-git-find-files ()
  "Preconfigured `anything' for finding files under Git version control."
  (interactive)
  (anything 'anything-c-source-git-files))

(defun anything-c-git-grep (pattern path)
  (with-temp-buffer
    (call-process "git" nil t nil "grep" "-Iin" pattern "--" path)
    (split-string (buffer-string) "\n")))

(defvar anything-c-source-git-grep
  '((name . "git grep")
    (candidates 
     . (lambda () 
         (anything-c-git-grep anything-pattern (anything-c-git-root))))
    (action ("Go to" . anything-c-action-file-line-goto))
    (requires-pattern . 2)
    (volatile)
    (delayed)))

(defun anything-git-grep ()
  "Preconfigured `anything' for anything implementation of `git grep'."
  (interactive)
  (anything 'anything-c-source-git-grep))

(provide 'anything-git)

;;; anything-git.el ends here
