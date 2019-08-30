;;; init-recentf.el --- init-recentf.el
;;; Commentary:
;; Settings for recentf.
;;; Code:

;; recentf
(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-save-file "~/.emacs.d/recentf")
  (setq recentf-exclude '("recentf"))
  (setq recentf-auto-cleanup 30)
  ;; (setq recentf-auto-cleanup 'never)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  ;; (recentf-mode 1)
  (require 'recentf-ext))


;;; init-recentf.el ends here
