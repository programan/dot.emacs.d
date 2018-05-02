;; yasnippet
;; snippet(部品)を内部に持っていてコード補完をしてくれる
;; Emacsのメニューを表示している場合項目が追加されている
(when (require 'yasnippet nil t) ;; not yasnippet-bundle

  (setq yas/snippet-dirs 
;;      '("~/.emacs.d/site-lisp/yasnippets" "~/.emacs.d/site-lisp/myyasnippets")
        '("~/.emacs.d/site-lisp/yasnippets")
        )

  (yas-global-mode 1)
  ;; (yas-reload-all)

  ;; (yas/initialize)
  ;; (yas/load-directory "~/.emacs.d/site-lisp/yasnippet/snippets")

  ;; rails-snippets
  ;; rails用のコード補完
  (yas/load-directory "~/.emacs.d/site-lisp/yasnippets-rails/rails-snippets")

  ;; 既存スニペットを挿入する
  (define-key yas-minor-mode-map (kbd "C-x i i") 'yas-insert-snippet)
  ;; 新規スニペットを作成するバッファを用意する
  (define-key yas-minor-mode-map (kbd "C-x i n") 'yas-new-snippet)
  ;; 既存スニペットを閲覧・編集する
  (define-key yas-minor-mode-map (kbd "C-x i v") 'yas-visit-snippet-file)
  )
(require 'angular-snippets)
