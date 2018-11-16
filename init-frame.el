;; フレームの設定
;; ある程度の大きさと位置を最初から指定しておく
(when window-system
  (progn
    (set-frame-size
     (selected-frame)
     (- (/ (round (* (/ (x-display-pixel-width) 2) 1.4)) (frame-char-width)) 1)
     (- (/ (- (x-display-pixel-height) 180) (frame-char-height)) 1)))
  (set-frame-position
   (selected-frame)
   20
   30))

(setq initial-frame-alist default-frame-alist)


;; タイトルバー設定
;; タイトルバーにファイル名を表示
;; (setq frame-title-format "%b")
;; ウィンドウタイトルをファイルパスに
(setq frame-title-format (format "%%f - Emacs @%s" (system-name)))
