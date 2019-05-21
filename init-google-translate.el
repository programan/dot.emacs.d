;; (require 'popwin)

;; (setq display-buffer-function 'popwin:display-buffer)
;; (setq popwin:popup-window-position 'bottom)


;; 英語か日本語かは自動判定してくれる
;; region指定してC-M-tすると、そのregionの翻訳をしてくれる
;; region指定せずにC-M-tすると、現在位置のwordを翻訳してくれる
;; C-u C-M-tすると、自分で調べたいものを入力できる
(when (require 'google-translate nil t)
  (require 'google-translate-default-ui)

  (defvar google-translate-english-chars "[:ascii:]"
    "これらの文字が含まれているときは英語とみなす")
  (defun google-translate-enja-or-jaen (&optional string)
    "regionか現在位置の単語を翻訳する。C-u付きでquery指定も可能"
    (interactive)
    (setq string
	  (cond ((stringp string) string)
		(current-prefix-arg
		 (read-string "Google Translate: "))
		((use-region-p)
		 (buffer-substring (region-beginning) (region-end)))
		(t
		 (thing-at-point 'word))))
    (let* ((asciip (string-match
		    (format "\\`[%s]+\\'" google-translate-english-chars)
		    string)))
      (run-at-time 0.1 nil 'deactivate-mark)
      (google-translate-translate
       (if asciip "en" "ja")
       (if asciip "ja" "en")
       string)))

  ;; (push '("\*Google Translate\*" :height 0.5 :stick t) popwin:special-display-config)

  (global-set-key (kbd "C-M-t") 'google-translate-enja-or-jaen)
  )

;; 2019-05-21
;; Fix error of "Failed to search TKK"
(defun google-translate--get-b-d1 ()
  ;; TKK='427110.1469889687'
  (list 427110 1469889687))
