;; yasnippet
;; snippet(部品)を内部に持っていてコード補完をしてくれる
;; Emacsのメニューを表示している場合項目が追加されている
(when (require 'yasnippet nil t) ;; not yasnippet-bundle
  (yas-global-mode 1)
  ;; (yas-reload-all)

  (setq yas/snippet-dirs 
	'("~/.emacs.d/site-lisp/yasnippet/snippets" "~/.emacs.d/site-lisp/yasnippet/extras/imported")
	)

  ;; (yas/initialize)
  (yas/load-directory "~/.emacs.d/site-lisp/yasnippet/snippets")

  ;; rails-snippets
  ;; rails用のコード補完
  (yas/load-directory "~/.emacs.d/site-lisp/yasnippets-rails/rails-snippets")


  )
(require 'angular-snippets)
