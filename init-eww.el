;; eww(emacs web wowser)
;;デフォルトの検索エンジンはduckduckgoのままだが地域を日本として検索するように設定
;;(setq eww-search-prefix "https://duckduckgo.com/html/?kl=jp-jp&q=")
;;広告なし
;; (setq eww-search-prefix "https://duckduckgo.com/html/?kl=jp-jp&k1=-1&q=")
;; (setq eww-search-prefix "https://duckduckgo.com/html/?kl=jp-jp&k1=-1&kc=-1&kf=-1&q=")

;; eww for google
(defvar eww-disable-colorize t)
(defun shr-colorize-region--disable (orig start end fg &optional bg &rest _)
  (unless eww-disable-colorize
    (funcall orig start end fg)))
(advice-add 'shr-colorize-region :around 'shr-colorize-region--disable)
(advice-add 'eww-colorize-region :around 'shr-colorize-region--disable)
(defun eww-disable-color ()
  "eww で文字色を反映させない"
  (interactive)
  (setq-local eww-disable-colorize t)
  (eww-reload))
(defun eww-enable-color ()
  "eww で文字色を反映させる"
  (interactive)
  (setq-local eww-disable-colorize nil)
  (eww-reload))
(setq eww-search-prefix "http://www.google.co.jp/search?q=")
