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

  ;; M-x
  (define-key global-map (kbd "M-x") 'helm-M-x)
  ;; C-x C-f
  (define-key global-map (kbd "C-x C-f") 'helm-find-files)

  
  ;; helm-occurの起動
  (global-set-key (kbd "C-M-o") 'helm-occur)
  ;; isearchからhelm-occurを起動
  (define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
  ;; helm-occurからall-extに受け渡し
  (define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur)

  
  (setq helm-idle-delay             0.3
	helm-input-idle-delay       0.3
	helm-candidate-number-limit 200)


  ;; locateを使わないようにする
  (setq helm-for-files-preferred-list
	'(helm-source-buffers-list
	  helm-source-recentf
	  helm-source-bookmarks
	  helm-source-file-cache
	  helm-source-files-in-current-dir
	  ;; helm-source-locate
	  ))
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
