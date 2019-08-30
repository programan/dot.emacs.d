;;; init-projectile.el --- init-projectile.el
;;; Commentary:
;; Settings for projectile.
;;; Code:

(when (require 'projectile nil t)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))


;;; init-projectile.el ends here
