;;; init-frame.el --- init-frame.el
;;; Commentary:
;; Settings for frame of Emacs.
;;; Code:

;; フレームの設定
;; ある程度の大きさと位置を最初から指定しておく
;; (when window-system
;;   (progn
;;     (set-frame-size
;;      (selected-frame)
;;      (- (/ (round (* (/ (x-display-pixel-width) 2) 1.4)) (frame-char-width)) 1)
;;      (- (/ (- (x-display-pixel-height) 180) (frame-char-height)) 1)))
;;   (set-frame-position
;;    (selected-frame)
;;    20
;;    30))



(when window-system
  ;; タイトルバー設定
  ;; タイトルバーにファイル名を表示
  ;; (setq frame-title-format "%b")
  ;; ウィンドウタイトルをファイルパスに
  (setq frame-title-format (format "%%f - Emacs @%s" (system-name)))
  (setq frame-resize-pixelwise t)
  ;; サイズ
  ;; (add-to-list 'default-frame-alist '(height . 50))
  ;; (add-to-list 'default-frame-alist '(width . (text-pixels . 1200)))
  ;; (add-to-list 'default-frame-alist '(height . (text-pixels . 1200)))
  ;; (add-to-list 'default-frame-alist `(width . (text-pixels . ,(x-display-pixel-width))))
  ;; (add-to-list 'default-frame-alist `(width . (text-pixels . ,(round (* (/ (x-display-pixel-width) 3) 1.3)))))
  (add-to-list 'default-frame-alist `(width . (text-pixels . ,(- (/ (x-display-pixel-width) 2) 150))))
  (add-to-list 'default-frame-alist `(height . (text-pixels . ,(- (x-display-pixel-height) 200))))
  ;; (add-to-list 'default-frame-alist '(fullscreen . fullheight))
  ;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
  ;; 位置
  (add-to-list 'default-frame-alist '(left . 100))
  (add-to-list 'default-frame-alist '(top . 80)))


(setq initial-frame-alist default-frame-alist)

;;; init-frame.el ends here
