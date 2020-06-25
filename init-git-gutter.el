;;; init-git-gutter.el --- init-git-gutter.el
;;; Commentary:
;; Settings for git-gutter.
;;; Code:


(when (require 'git-gutter nil t)
  (custom-set-variables
   '(git-gutter:modified-sign "  ") ;; two space
   '(git-gutter:added-sign "++")    ;; multiple character is OK
   '(git-gutter:deleted-sign "--"))

  (set-face-background 'git-gutter:modified "purple") ;; background color
  (set-face-foreground 'git-gutter:added "green")
  (set-face-foreground 'git-gutter:deleted "red")

  ;; first character should be a space
  (custom-set-variables
   '(git-gutter:lighter " GG"))

  ;; (custom-set-variables
  ;;  '(git-gutter:update-interval 2))
  
  (global-git-gutter-mode +1))


;;; init-git-gutter.el ends here

