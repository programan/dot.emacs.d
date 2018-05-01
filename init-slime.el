; initialize slime for common lisp development.

(when (require 'slime nil t)
  ;; (setq inferior-lisp-program "clisp")
  (setq inferior-lisp-program "sbcl")
  (slime-setup '(slime-repl slime-fancy slime-banner)) 
  )

