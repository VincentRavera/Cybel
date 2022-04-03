;;; cybel-revtramp.el --- A reverse tramp implementation -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Vincent RAVERA
;;
;; Author: Vincent RAVERA <ravera.vincent@gmail.com>
;; Maintainer: Vincent RAVERA <ravera.vincent@gmail.com>
;; Created: April 03, 2022
;; Modified: April 03, 2022
;; Version: 0.0.1
;; Keywords: lisp
;; Homepage: https://github.com/VincentRAVERA/cybel-revtramp
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;; Provide a reverse tramp method
;;
;; inspired from https://www.emacswiki.org/emacs/TrampMode
;;
;; TODO: Tramp starts the process and run one command
;; however it hangs
;; TODO: change histfile
;;
;;; Code:
(require 'tramp)
(setq tramp-debug-buffer t)
(setq tramp-verbose 10)
(add-to-list 'tramp-methods
             (list "rev"
                   '(tramp-login-program "nc")
                   '(tramp-default-port 2222)
                   (cons 'tramp-login-args
                         (list (list
                                '("-l")
                                '("-v")
                                '("-p" "1234"))))
                   '(tramp-remote-shell "sh")
                   '(tramp-remote-shell-args ("-c" "'i"))
                   )
             t)

;; tramp backup path (if not set, save in local backup directory)
(setq tramp-backup-directory-alist nil)
(setq tramp-auto-save-directory nil)

;; /rev:x@x22:
(provide 'cybel-revtramp)
;;; cybel-revtramp.el ends here
