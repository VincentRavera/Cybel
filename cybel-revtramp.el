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
;; also inspired from https://github.com/dougm/vagrant-tramp
;;
;; DONE: Tramp starts the process and run one command
;; DONE: Dired and find-file opens on connections
;; TODO: change histfile for /dev/null
;; TODO: Connection is unstable, async shell command and vterms kills the connections
;;
;;; Code:
(require 'tramp)

(defgroup cybel-revtramp nil
  "Cybel Reverse tramp subgroup."
  :group 'cybel
  :prefix "cybel-revtramp*"
  :link '(url-link :tag "Github" "https://github.com/VincentRavera/Cybel"))

(defconst cybel-revtramp-tramp-method "rev"
  "Method to connect tramp to a reverse shell.")

;; The tramp method
;;;###autoload
(defun cybel-revtramp-tramp-add-method ()
  "Add `cybel-revtramp-tramp-method' to `tramp-methods'."
  (add-to-list 'tramp-methods
               `(,cybel-revtramp-tramp-method
                 (tramp-login-program     "nc")
                 (tramp-login-args        (("-l") ("-p" "%p")))
                 (tramp-remote-shell      "/bin/sh")
                 (tramp-remote-shell-args ("-i" "-c"))
                 (tramp-connection-timeout 5))))

;; Debug commands
;; (setq tramp-debug-buffer t)
;; (setq tramp-verbose 10)

(provide 'cybel-revtramp)
;;; cybel-revtramp.el ends here
