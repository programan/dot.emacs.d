;;オートコンプリート

(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
  (ac-config-default)
  ;;  (setq ac-auto-show-menu nil)

  ;; 3文字目からauto-complete開始
  (setq ac-auto-start 3)

  ;;swift
  ;; brew install sourcekitten
  ;; (require 'auto-complete-swift)
  ;; (push 'ac-source-swift-complete ac-sources)

  ;; (require 'ac-python)               ;; python用の補完
  ;; (add-to-list 'ac-modes 'python-2-mode)
  (add-to-list 'ac-modes 'swift-mode)	;; Swift用：swift-modeになったら、auto-completeをスタートさせる
  (add-to-list 'ac-modes 'php-mode)	;; PHP用：php-modeになったら、auto-completeをスタートさせる
  (add-to-list 'ac-modes 'ruby-mode)	;; Ruby用：ruby-modeになったら、auto-completeをスタートさせる
  (add-to-list 'ac-modes 'js2-mode)	;; javascript用：js2-modeになったら、auto-completeをスタートさせる
  (add-to-list 'ac-modes 'jade-mode)	;; jade用：jade-modeになったら、auto-completeをスタートさせる
  (add-to-list 'ac-modes 'coffee-mode)  ;; coffescript用：coffee-modeになったら、auto-completeをスタートさせる
  (add-to-list 'ac-modes 'lua-mode)	;; Lua用：lua-modeになったら、auto-completeをスタートさせる
  (add-to-list 'ac-modes 'web-mode))	;; WEB用：web-modeになったら、auto-completeをスタートさせる
