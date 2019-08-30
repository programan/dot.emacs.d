;;; init-tail.el --- init-tail.el
;;; Commentary:
;; Settings for tail command.a
;;; Code:

;; tail command
(when (require 'tail nil t)
  (setq tail-hide-delay 20)
  (setq tail-max-size 20)
  )

;;; init-tail.el ends here
