;;; init-volatile-highlights.el --- init-volatile-highlights.el
;;; Commentary:
;; Settings for volatile highlights.
;;; Code:

;; yank時に一定時間だけハイライトさせる
(when (require 'volatile-highlights nil t)
  (volatile-highlights-mode t))


;;; init-volatile-highlights.el ends here
