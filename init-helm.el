;; helm
(when (require 'helm-config nil t)
  (helm-mode 1)

  ;; ファイル関係(履歴やバッファなどのファイルリスト)
  (global-set-key (kbd "C-;") 'helm-for-files)
  ;; ctagsによる関数ジャンプ
  (global-set-key (kbd "M-.") 'helm-c-etags-select)
  ;; 過去にコピーした履歴から選んで貼り付け
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  ;; バッファ内の関数を絞り込む
  (global-set-key (kbd "C-c i") 'helm-imenu)
  ;; grep
  ;; C-x c M-g s がデフォルトコマンド
  ;; ディレクトリも再起的に検索するには、C-uを最初に打つ
  (global-set-key (kbd "C-c g") 'helm-do-grep)
  
  
  (setq helm-idle-delay             0.3
	helm-input-idle-delay       0.3
	helm-candidate-number-limit 200)
  )

;; helm-descbinds
;; describe-bindingsを置き換えてキーバインドを表示
;; C-h b
(when (require 'helm-descbinds nil t)
  (helm-descbinds-mode)

  ;; describe-bindings
  ;; (global-set-key (kbd "C-c b") 'helm-descbinds)
  (global-set-key (kbd "C-c b") 'helm-descbinds)
  )
