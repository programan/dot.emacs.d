;; Anything
(require 'anything-startup)
(global-set-key (kbd "C-;") 'anything-filelist+)
;Be sure Anything does not fight with ido-mode.
(anything-read-string-mode 0)
;; ctagsによる関数ジャンプ
(global-set-key (kbd "M-.") 'anything-c-etags-select)

;; 候補の最大表示数
(setq anything-candidate-number-limit 100)

;; root権限でアクションを実行する時のコマンド(su)
(require 'anything-config nil t)
(when (not (eq window-system 'w32))
  (setq anything-su-or-sudo "sudo"))

;; describe-bindingsをAnythingに置き換える
(when (require 'descbinds-anything nil t)
  (descbinds-anything-install))

;; Anythingのマッチング強化
(require 'anything-match-plugin nil t)

;; Lispシンボルの補完候補の再検索時間
(when (require 'anything-complete nil t)
  (anything-lisp-complete-symbol-set-timer 150))

;; 補完インタフェースの拡張
(require 'anything-show-completion nil t)

;; auto-installのAnythingインタフェース
(when (require 'auto-install nil t)
  (require 'anything-auto-install nil t))

