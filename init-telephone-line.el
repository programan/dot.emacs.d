;;; init-telephone-line.el --- init-telephone-line.el
;;; Commentary:
;; Settings for telephone line.
;;; Code:

;; モードラインに改行コードを表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")
(setq eol-mnemonic-undecided "(??)")

;; モードラインの色
(set-face-foreground 'mode-line "DeepSkyBlue")
(set-face-background 'mode-line "gray19")
(set-face-background 'mode-line-inactive "gray10")

;; モードラインに時間を表示する
;; (setq display-time-interval 1)
;; (setq display-time-string-forms
;;   '((format "%s-%s-%s(%s) %s:%s:%s" year month day dayname 24-hours minutes seconds)))
;; (setq display-time-day-and-date t)
;; (setq display-time-24hr-format t)
;; (display-time-mode t)

;; モードラインに行数とカラムを表示
;; (line-number-mode 1)
(column-number-mode 1)


;; diminish
;; Hide or replace minor mode name.
(when (require 'diminish nil t)
  ;; (diminish 'company-mode)
  (diminish 'company-mode "Comp")
  (diminish 'projectile-mode "Ptile")
  (diminish 'undo-tree-mode "UndoT")
  (diminish 'editorconfig-mode "EdCnf"))



(when (require 'telephone-line nil t)
  ;; 高さ
  (setq telephone-line-height 26)
  ;; セパレータの形を指定
  (setq telephone-line-primary-left-separator 'telephone-line-cubed-left
        telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
        telephone-line-primary-right-separator 'telephone-line-gradient
        telephone-line-secondary-right-separator 'telephone-line-nil)

  ;;色の定義
  (defface my-important-label   '((t (:foreground "cyan" :background "gray1" :inherit mode-line))) "")
  (defface my-information-label '((t (:foreground "RoyalBlue" :background "gray5" :inherit mode-line))) "")
  (defface my-notice-label      '((t (:foreground "PaleGreen" :background "gray5" :inherit mode-line))) "")
  (defface my-warning-label     '((t (:foreground "OrangeRed1" :background "gray1" :inherit mode-line))) "")

  (setq telephone-line-faces
        '((important    .       (my-important-label . my-important-label))
          (information  .       (my-information-label . my-information-label))
          (notice       .       (my-notice-label . my-notice-label))
          (warning      .       (my-warning-label . my-warning-label))
          (evil         .       telephone-line-evil-face)
          (accent       .       (telephone-line-accent-active . telephone-line-accent-inactive))
          (nil          .       (mode-line . mode-line-inactive))))

  ;; 左側で表示するコンテンツの設定
  (setq telephone-line-lhs
        '((nil          . (telephone-line-input-info-segment))
          (important    . (telephone-line-major-mode-segment))
          (information  . (telephone-line-vc-segment))
          (nil          . (telephone-line-projectile-buffer-segment
                           telephone-line-position-segment
                           telephone-line-filesize-segment))))
  ;; 右側で表示するコンテンツの設定
  (setq telephone-line-rhs
        '((warning      .       (telephone-line-flycheck-segment))
          (notice       .       (telephone-line-minor-mode-segment))))

  ;; ;; 左側で表示するコンテンツの設定
  ;; (setq telephone-line-lhs
  ;;       '((nil        . (telephone-line-input-info-segment))
  ;;         (accent     . (telephone-line-major-mode-segment))
  ;;         (accent     . (telephone-line-vc-segment))
  ;;         (nil        . (telephone-line-projectile-buffer-segment
  ;;                        telephone-line-position-segment
  ;;                        telephone-line-filesize-segment))))
  ;; (setq telephone-line-center-rhs
  ;;       '((nil . (telephone-line-nyan-segment))))
  ;; ;; 右側で表示するコンテンツの設定
  ;; (setq telephone-line-rhs
  ;;       '((nil    . (telephone-line-flycheck-segment))
  ;;         (nil    . (telephone-line-minor-mode-segment))))

  (telephone-line-mode 1))


;;; init-telephone-line.el ends here
