;;; init-helm.el --- init-helm.el
;;; Commentary:
;; Settings for helm.
;;; Code:


;; helm
(when (require 'helm-config nil t)
  (helm-mode 1)

  ;; ファイル関係(履歴やバッファなどのファイルリスト)
  (global-set-key (kbd "C-;") 'helm-for-files)
  ;; ctagsによる関数ジャンプ
  ;; (global-set-key (kbd "M-.") 'helm-c-etags-select)
  (global-set-key (kbd "M-.") 'helm-etags-select)
  ;; 過去にコピーした履歴から選んで貼り付け
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  ;; バッファ内の関数を絞り込む
  (global-set-key (kbd "C-c i") 'helm-imenu)
  ;; grep
  ;; C-x c M-g s がデフォルトコマンド
  ;; ディレクトリも再起的に検索するには、C-uを最初に打つ
  ;; (global-set-key (kbd "C-c g") 'helm-do-grep)
  ;; (global-set-key (kbd "C-c g") 'helm-do-grep-ag)
  ;; (global-set-key (kbd "C-c g") 'helm-ag)
  (global-set-key (kbd "C-c g") 'helm-do-ag)

  ;; M-x
  (define-key global-map (kbd "M-x") 'helm-M-x)
  (setq helm-M-x-fuzzy-match t)

  ;; C-x C-f
  (define-key global-map (kbd "C-x C-f") 'helm-find-files)

  ;; ;; helm-occurの起動
  ;; (global-set-key (kbd "C-M-o") 'helm-occur)
  ;; ;; isearchからhelm-occurを起動
  ;; (define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
  ;; ;; helm-occurからall-extに受け渡し
  ;; (define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur)


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

; (setq helm-projectile-fuzzy-match nil)
 (when (require 'helm-projectile nil t)
   (setq projectile-completion-system 'helm)
   (helm-projectile-on)
;;   (global-set-key (kbd "s-x p f") 'helm-projectile-find-file)
   )


 (when (require 'helm-swoop nil t)
   ;; Change the keybinds to whatever you like :)
   (global-set-key (kbd "M-i") 'helm-swoop)
   (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
   (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
   (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

   ;; When doing isearch, hand the word over to helm-swoop
   (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
   ;; From helm-swoop to helm-multi-swoop-all
   (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
   ;; When doing evil-search, hand the word over to helm-swoop
   ;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

   ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
   (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

   ;; Move up and down like isearch
   (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
   (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
   (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
   (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

   ;; Save buffer when helm-multi-swoop-edit complete
   (setq helm-multi-swoop-edit-save t)

   ;; ;; Go to the opposite side of line from the end or beginning of line
   (setq helm-swoop-move-to-line-cycle t)

   ;; If you prefer fuzzy matching
   ;; (setq helm-swoop-use-fuzzy-match t)
   )

(when (require 'migemo nil t)
  (helm-migemo-mode 1))

;;; init-helm.el ends here
