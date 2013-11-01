;; Sublimity
;; https://github.com/zk-phi/sublimity

(require 'sublimity)
(require 'sublimity-scroll)
(require 'sublimity-map)

;;(sublimity-global-mode t)

;; minimapのスクロールする速度
;; n行をweightで割ったステップでスクロール
;; ラストdrift-length行をゆっくりとスクロール
(setq sublimity-scroll-weight 5
      sublimity-scroll-drift-length 10)

;; minimapのサイズ
;; map-sizeが1より小さい場合にfractionが使われる
(setq sublimity-map-size 24)
(setq sublimity-map-fraction 0.3)

;; minimapが作成されたときに呼び出されるhook
(add-hook 'sublimity-map-setup-hook
          (lambda ()
            (setq buffer-face-mode-face '(:family "Monospace"))
            (buffer-face-mode)))

;; スクロールの度にminimapを表示
(setq sublimity-map-on-scroll t)
;;(setq sublimity-map-on-scroll nil)

;; minimapを更新するトリガーとなるコマンド
(setq sublimity-map-on-commands
      '(previous-line next-line backward-paragraph forward-paragraph
                      end-of-defun beginning-of-defun))

;; minimapが更新されるまでの時間(秒または無し)
(sublimity-map-set-delay 2)
;;(sublimity-map-set-delay 'inf)

(defun sublimity-toggle ()
  "Toggle sublimity for current buffer."
  (interactive)
;;  (if sublimity-mode
;;      (message "sublimity on")
;;    (message "sublimity off")))
  (if sublimity-mode
      (setq sublimity-mode nil)
    (setq sublimity-mode t)))
(global-set-key [f7] 'sublimity-toggle)



;; (when (require 'minimap nil t)
;;   (setq minimap-window-location 'right)
;;   (setq minimap-width-fraction 0.15)
;;   (setq minimap-hide-fringes nil)
;;   (setq minimap-dedicated-window t)
;;   (defun minimap-toggle ()
;;     "Toggle minimap for current buffer."
;;     (interactive)
;;     (if (null minimap-bufname)
;; 	(minimap-create)
;;       (minimap-kill)))
;;   (global-set-key [f7] 'minimap-toggle))
