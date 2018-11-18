;; smart mode line
;;
(defvar sml/no-confirm-load-theme t)

;; (defvar sml/theme 'dark)
;; (defvar sml/theme 'powerline)
(defvar sml/theme 'respectful)

;; (defvar sml/shorten-directory t)
(defvar sml/shorten-directory nil)

;; mark of modified buffer
(setq sml/modified-char "*")
;; mark of read only buffer
(setq sml/read-only-char "%%")

;; abbreviate path
;; (add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/" ":DBox:"))

;; はみ出ないように調整する
(setq sml/extra-filler -3)

(sml/setup)


;; diminish
;; Hide or replace minor mode name.
(when (require 'diminish nil t)
  ;; (diminish 'company-mode)
  (diminish 'company-mode "Comp")
  (diminish 'projectile-mode "Ptile")
  (diminish 'undo-tree-mode "UndoT")
  (diminish 'editorconfig-mode "EdCnf"))


;; モードラインに時間を表示する
(setq display-time-interval 1)
(setq display-time-string-forms
  '((format "%s-%s-%s(%s) %s:%s:%s" year month day dayname 24-hours minutes seconds)))
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time-mode t)

;; モードラインに行数とカラムを表示
(line-number-mode 1)
(column-number-mode 1)

;; モードラインの色
(set-face-foreground 'mode-line "light blue")
(set-face-background 'mode-line "grey19")
;; ;;(set-face-background 'modeline "black")

