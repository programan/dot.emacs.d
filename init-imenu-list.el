;;; init-imenu-list.el --- init-imenu-list.el
;;; Commentary:
;; Settings for imenu-list.
;;; Code:


(when (require 'imenu-list nil t)
  (global-set-key (kbd "C-'") #'imenu-list-smart-toggle)
  ;; (setq imenu-list-focus-after-activation t)
  ;; (setq imenu-list-auto-resize t)
  (setq imenu-list-idle-update-delay-time 2)
  )

;;; init-imenu-list.el ends here

