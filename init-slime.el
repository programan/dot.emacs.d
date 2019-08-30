;;; init-slime.el --- init-slime.el
;;; Commentary:
;; Settings for Common Lisp development.
;;; Code:


(when (require 'slime nil t)
  ;; (setq inferior-lisp-program "clisp")
  (setq inferior-lisp-program "sbcl")
  (slime-setup '(slime-repl slime-fancy slime-banner)))

;;; init-slime.el ends here
