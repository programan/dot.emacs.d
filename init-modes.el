;; モード設定

;; Emacs24から標準になったelectric系の機能を有効にする
(when (>= emacs-major-version 24)
  ;; 自動で閉じカッコを入れる
  ;;(electric-pair-mode t)
  ;; 改行時にインデント
  (electric-indent-mode t)
  ;; 自動で改行
;  (electric-layout-mode t)
  )

;; electricをemacs全体で有効にしたくない場合は
;; add-hookで個別に設定する
(defun electric-pair ()
  "If at end of line, insert character pair without surrounding spaces.
    Otherwise, just insert the typed character."
  (interactive)
  (if (eolp) (let (parens-require-spaces) (insert-pair)) (self-insert-command 1)))

;; コメント内または文字列内の場合はelectricを無効
(defadvice electric-pair-post-self-insert-function
  (around electric-pair-post-self-insert-function-around activate)
  "Don't insert the closing pair in comments or strings"
  (unless (nth 8 (save-excursion (syntax-ppss (1- (point)))))
    ad-do-it))

;; 他のエディタなどがファイルを書き換えたらすぐにそれを反映する
;; auto-revert-modeを有効にする
;;(auto-revert-mode t)
(global-auto-revert-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C/C++
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c-mode, c++-mode
(add-hook 'c-mode-common-hook
          '(lambda ()
             ;;; K&R のスタイルを使う
             ;(c-set-style "k&r")
             (c-set-style "stroustrup")
             ;;; インデントには tab を使う
             (setq indent-tabs-mode t)
             ;;; インデント幅
             (setq c-basic-offset 4)
	     (setq tab-width 4)
             ))

;; C++ style
;(add-hook 'c++-mode-hook
;          '(lambda()
;             (c-set-style "stroustrup")
;             ;(setq indent-tabs-mode nil)     ; インデントは空白文字で行う（TABコードを空白に変換）
;             ;(c-set-offset 'innamespace 0)   ; namespace {}の中はインデントしない
;             ;;; K&R のスタイルを使う
;             ;(c-set-style "k&r")
;             ;;; インデントには tab を使う
;             (setq indent-tabs-mode t)
;             ;;; インデント幅
;             (setq c-basic-offset 4)
;             (c-set-offset 'arglist-close 0) ; 関数の引数リストの閉じ括弧はインデントしない
;             ))

(add-to-list 'auto-mode-alist '("\\.c$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.cpp$" . c++-mode))

;(setq auto-mode-alist
      ;;; 拡張子とモードの対応
;      (append
;       '(("\\.c$" . c-mode))
;       '(("\\.h$" . c-mode))
;       '(("\\.cpp$" . c++-mode))
;       auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; php
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;php-mode
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.ctp$" . php-mode))
;; php-modeの補完を強化する
;; (defun php-completion-hook ()
;;   (when (require 'php-completion nil t)
;;     (php-completion t)
;;     (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
;;     (when (require 'auto-complete nil t)
;;       (make-variable-buffer-local 'ac-sources)
;;       (add-to-list 'ac-sources 'ac-sources-php-completion)
;;       (auto-complete-mode t))))

(add-hook 'php-mode-hook
	  '(lambda ()
	     ;; 他のエディタなどがファイルを書き換えたらすぐにそれを反映する
	     ;; auto-revert-modeを有効にする
	     (auto-revert-mode t)
	     ;; 補完
	     ;; php-cliとcscopeが必要
	     (when (require 'company-php nil t)
	       (company-mode t)
	       (add-to-list 'company-backends 'company-ac-php-backend )
	       (yas-global-mode 1)
	       (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
	       (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back
	       )
	     ;; 配列の整形
	     (defun ywb-php-lineup-arglist-intro (langelem)
	       (save-excursion
		 (goto-char (cdr langelem))
		 (vector (+ (current-column) c-basic-offset))))
	     (defun ywb-php-lineup-arglist-close (langelem)
	       (save-excursion
		 (goto-char (cdr langelem))
		 (vector (current-column))))
	     (c-set-style "stroustrup")
	     (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
	     (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)
	     (c-set-offset 'arglist-cont-nonempty' 4)
	     (setq tab-width 4)
	     (setq c-basic-offset 4)
	     (c-set-offset 'case-label' 4)
;;	     (setq indent-tabs-mode nil)
	     (setq indent-tabs-mode t)
	     ;;C-cC-fで関数helpにジャンプ
	     (setq php-search-url "http://www.php.net/ja/")
	     (setq php-manual-url "http://www.php.net/manual/ja/")
             ;;複数行コメント
	     (setq comment-start "// ")
	     (setq comment-end "")
	     ;; RET キーで自動改行+インデント
	     (define-key c-mode-base-map "\C-m" 'newline-and-indent)
	     ;; カッコ強調表示
	     (show-paren-mode t)
	     ;; auto-complete
	     ;; ('php-completion-hook)
	     ;; 勝手に改行モード (必要なければコメントアウトする)
	     (c-toggle-auto-hungry-state t)
	     (setq c-hanging-braces-alist
		   '(
;		     (class-open nil)
;		     (class-close nil)
		     (defun-open after)
		     (defun-close before)
;		     (inline-open nil)
;		     (inline-close nil)
;		     (brace-list-open nil)
;		     (brace-list-close nil)
;		     (block-open nil)
;		     (block-close nil)
;		     (substatement-open before after)
		     (substatement-open after)
		     (substatement-close before)
;		     (statement-case-open before after)
;		     (extern-lang-open nil)
;		     (extern-lang-close nil)
		     ))
	     ;; (setq php-mode-force-pear t)
	     (electric-pair-mode t)
	     ))
(add-hook 'php-mode-hook #'rainbow-delimiters-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'python-mode "python-mode" "Major mode for editing python code." t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(defun my-python-mode-hook ()
  ;; (setq py-indent-offset 4)
  ;; (setq python-indent 4)
  (setq indent-level 4)
  (setq python-indent 4)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq interpreter-mode-alist (cons '("python" . python-mode)
				     interpreter-mode-alist))

  ;; jedi
  (when (require 'jedi-core nil t)
    ;; 初回実行時のみ、M-x jedi:install-server RET を実行
    ;; jediサーバがインストールされる場所はjedi:environment-rootで指定できる
    (setq jedi:complete-on-dot t)
    (setq jedi:use-shortcuts t)
    (add-hook 'python-mode-hook 'jedi:setup)
    (add-to-list 'company-backends 'company-jedi)
    )

  ;; (setq jedi:environment-root "jedi")  ; or any other name you like
  ;; (setq jedi:environment-virtualenv
  ;; 	(append python-environment-virtualenv
  ;; 		'("--python" "~/.pyenv/python")))
  
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
(add-hook 'python-mode-hook
	  '(lambda()
	     (electric-pair-mode t)
	     ))

;(add-hook 'python-mode-hook
;          '(lambda()
;             (setq tab-width 4)
;             (setq indent-level 4)
;             (setq python-indent 4)
;             (setq py-indent-offset 4)
;             (setq indent-tabs-mode nil)
;;;           (setq indent-tabs-mode t)
;;        複数行コメント
;             (setq comment-start "# ")
;             (setq comment-end "")
;             )
;          )
;; (require 'jedi)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)                 ; optional


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C# support
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'flymake)
;(add-hook 'csharp-mode-hook
;	  '(lambda ()
;	     (flymake-mode t)))

(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist (cons '("\\.cs$" . csharp-mode) auto-mode-alist))
;; Patterns for finding Microsoft C# compiler error messages:
(require 'compile)
(push '("^\\(.*\\)(\\([0-9]+\\),\\([0-9]+\\)): error" 1 2 3 2) compilation-error-regexp-alist)
(push '("^\\(.*\\)(\\([0-9]+\\),\\([0-9]+\\)): warning" 1 2 3 1) compilation-error-regexp-alist)

;; Patterns for defining blocks to hide/show:
(push '(csharp-mode
        "\\(^\\s *#\\s *region\\b\\)\\|{"
        "\\(^\\s *#\\s *endregion\\b\\)\\|}"
        "/[*/]"
        nil
        hs-c-like-adjust-block-beginning)
      hs-special-modes-alist)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; javascript
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
	     ;; 他のエディタなどがファイルを書き換えたらすぐにそれを反映する
	     ;; auto-revert-modeを有効にする
	     (auto-revert-mode t)
             (setq indent-tabs-mode nil)
             (setq js2-basic-offset 2)
             (setq js2-enter-indents-newline t)
             (setq comment-start "// ")
             (setq comment-end "")
	     (define-key js2-mode-map (kbd "M-.") 'helm-etags-select)
	     (electric-pair-mode t)
	     ;; (electric-pair-mode t)
	     ;; (electric-indent-mode t)
	     ;; (electric-layout-mode t)
	     ;; (define-key js2-mode-map "\"" 'electric-pair)
	     ;; (define-key js2-mode-map "\'" 'electric-pair)
	     ;; (define-key js2-mode-map "(" 'electric-pair)
	     ;; (define-key js2-mode-map "[" 'electric-pair)
	     ;; (define-key js2-mode-map "{" 'electric-pair)
	     ;; (set (make-local-variable 'indent-line-function) 'js2-indent-line)
             ))

; js2mode(fork)でadd-hook時にパラメータを変えても反映されないものをここで変更
;; (when (load "js2-mode" t)
;;   (setq js2-cleanup-whitespace nil
;;         js2-mirror-mode t)
;;   )

;(add-hook 'js2-mode-hook
;          #'(lambda ()
;              (require 'js)
;              (setq js-indent-level 2
;                    js-expr-indent-offset 2
;                    indent-tabs-mode nil
;                    )
;              (setq comment-start "// ")
;              (setq comment-end "")
;              (set (make-local-variable 'indent-line-function) 'js-indent-line)))

;(add-hook 'js2-mode-hook
;          #'(lambda ()
;              (require 'espresso)
;              (setq espresso-indent-level 2
;                    espresso-expr-indent-offset 2
;                    indent-tabs-mode nil)
;              (setq comment-start "// ")
;              (setq comment-end "")
;              (set (make-local-variable 'indent-line-function) 'espresso-indent-line)))


;(add-hook 'js2-mode-hook
;	  '(lambda()
;	     (setq tab-width 4)
;	     (setq indent-level 4)
;	     (setq js2-basic-offset 4)
;	     (setq indent-tabs-mode nil)
;;	     (setq indent-tabs-mode t)
;        複数行コメント
;	     (setq comment-start "// ")
;	     (setq comment-end "")
;	     )
;	  )
(add-hook 'js2-mode-hook #'rainbow-delimiters-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; json
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
;(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby-mode
(autoload 'ruby-mode "ruby-mode" "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
;; #!/usr/bin/env ruby といった行で始まる、拡張子のないコマンドファイルを適切なモードで開く
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
;; irb
;(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")
;(autoload 'inf-ruby-keys "inf-ruby" "Set local key defs for inf-ruby in ruby-mode")
;(add-hook 'ruby-mode-hook '(lambda () (inf-ruby-keys)))

(add-hook 'ruby-mode-hook
	  '(lambda ()
	     (when (require 'rspec-mode nil t)
	       ;; C-c , v RSpec実行
	       ;; C-c , s カ-ソルが当たっているサンプルを実行
	       ;; C-c , t Specとソースを切り替える 
	       (eval-after-load 'rspec-mode
		 '(rspec-install-snippets))
	       ;; Railsプロジェクト以外でrspec-modeを使うとエラーが出るので対処
	       ;; http://d.hatena.ne.jp/nbahide/20100721/1279676604
	       (custom-set-variables '(rspec-use-rake-flag nil))
	       (custom-set-faces )
	       )
	     (when (require 'ruby-electric nil t)
	       ;; ruby-electric.el --- electric editing commands for ruby files
	       ;; if に対するendとか入れてくれる
	       ;; emacs24標準のelectricとバッティングするので、ruby-mode時は
	       ;; electric系はオフにする
	       (let ((rel (assq 'ruby-electric-mode minor-mode-map-alist)))
		 (setq minor-mode-map-alist (append (delete rel minor-mode-map-alist) (list rel))))
	       (setq ruby-electric-expand-delimiters-list nil)
	       )
	     (when (require 'ruby-block nil t)
	       ;; end に対応する行をハイライト
	       (defun ruby-mode-hook-ruby-block()
		 (ruby-block-mode t))
	       (add-hook 'ruby-mode-hook 'ruby-mode-hook-ruby-block)
	       ;; ミニバッファに表示し, かつ, オーバレイする.
	       (setq ruby-block-highlight-toggle t)
	       ;; 何もしない
	       ;;(setq ruby-block-highlight-toggle 'noghing)
	       ;; ミニバッファに表示
	       ;;(setq ruby-block-highlight-toggle 'minibuffer)
	       ;; オーバレイする
	       ;;(setq ruby-block-highlight-toggle 'overlay)
	       )
	     (when (require 'rhtml-mode nil t)
	       (add-hook 'rhtml-mode-hook
			 (lambda ()
			   ;; 他のエディタなどがファイルを書き換えたらすぐにそれを反映する
			   ;; auto-revert-modeを有効にする
			   (auto-revert-mode t)))
	       )
	     ;; (when (require 'projectile-rails nil t)
	     ;;   (add-hook 'projectile-mode-hook 'projectile-rails-on)
	     ;;   (add-hook 'ruby-mode-hook 'projectile-mode)
	     ;;   (add-hook 'rhtml-mode-hook 'projectile-mode)
	     ;;   (add-hook 'haml-mode-hook 'projectile-mode)
	     ;;   (add-hook 'slim-mode-hook 'projectile-mode)
	     ;;   (add-hook 'sass-mode-hook 'projectile-mode)
	     ;;   )
	     ;; (when (require 'robe-mode nil t)
	     ;;   (robe-mode 1)
	     ;;   )
	     ;; ruby-modeのインデント
	     (setq ruby-indent-level 2)
	     (setq ruby-indent-tabs-mode nil)
	     ;; 他のエディタなどがファイルを書き換えたらすぐにそれを反映する
	     ;; auto-revert-modeを有効にする
	     (auto-revert-mode t)
	     (ruby-electric-mode t)
	     ;; RET キーで自動改行+インデント
	     (define-key ruby-mode-map [return] 'reindent-then-newline-and-indent)
	     (when (>= emacs-major-version 24)
	       (set (make-local-variable 'electric-pair-mode) nil)
	       (set (make-local-variable 'electric-indent-mode) nil)
	       (set (make-local-variable 'electric-layout-mode) nil)))
	  )



;; projectile-rails
;; C-c r m                 : app/models 配下のファイルを選択して開く
;; C-c r M                 : 対応する model を開く
;; C-c r c                 : app/controllers 配下のファイルを選択して開く
;; C-c r C                 : 対応する controller を開く
;; C-c r v                 : app/views 配下のファイルを選択して開く
;; C-c r V                 : 対応する view を開く
;; C-c r h                 : app/helpers 配下のファイルを選択して開く
;; C-c r H                 : 対応する helper を開く
;; C-c r l                 : lib 配下のファイルを選択して開く
;; C-c r f                 : features 配下のファイルを選択して開く
;; C-c r p                 : spec 配下のファイルを選択して開く
;; C-c r P                 : 対応する spec を開く
;; C-c r t                 : tests 配下のファイルを選択して開く
;; C-c r T                 : 対応する test を開く
;; C-c r n                 : db/migrate 配下のファイルを選択して開く
;; C-c r N                 : 対応する migrate ファイルを開く
;; C-c r u                 : spec/fixture ファイルを選択して開く
;; C-c r U                 : 対応する fixture ファイルを開く
;; C-c r j                 : app/assets/javascripts 配下のファイルを選択して開く
;; C-c r s                 : app/assets/styles 配下のファイルを選択して開く
;; C-c r o                 : log 配下のファイルを選択して開き、 auto-revert-tail-mode を起動する
;; C-c r i                 : config/initializers 配下のファイルを選択して開く
;; C-c r e                 : config/environments 配下のファイルを選択して開く
;; C-c r a                 : config/locales 配下のファイルを選択して開く
;; C-c r @                 : app/mailers 配下のファイルを選択して開く
;; C-c r !                 : validator ファイルを選択して開く
;; C-c r y                 : app/views/layouts 配下のファイルを選択して開く
;; C-c r k                 : lib/tasks 配下のファイルを選択して開く
;; C-c r b                 : app/jobs 配下のファイルを選択して開く
;; C-c r ! c, C-c r r      : inf-ruby buffer の中で `rails console' を実行する
;; C-c r ! s, C-c r R      : rails server を実行する
;; C-c r ! r               : rake task を選択して実行する
;; C-c r ! g               : rails generate を実行する
;; C-c r x                 : 選択した範囲を partial として切り出す
;; C-c r RET, C-c r g f    : カーソル位置の対応する constant、template、partial、 gem ファイルに移動する
;; C-c r g g               : Gemfile を開く
;; C-c r g r               : config/routes.rb を開く
;; C-c r g d               : db/schema.rb を開く
;; C-c r g s               : db/seeds.rb を開く
;; C-c r g h               : spec/spec_helper.rb を開く
(add-hook 'ruby-mode-hook 'projectile-mode)
(add-hook 'rhtml-mode-hook 'projectile-mode)
(add-hook 'haml-mode-hook 'projectile-mode)
(add-hook 'slim-mode-hook 'projectile-mode)
(add-hook 'sass-mode-hook 'projectile-mode)
(when (require 'projectile-rails nil t)
  (add-hook 'projectile-mode-hook 'projectile-rails-on)
  )

;; --------------------------------------------------
;; robe
;; http://codeout.hatenablog.com/entry/2014/02/04/210237
;; --------------------------------------------------
;; robeを有効にする
;; project directoryにGemfileがあり、pryとpry-docが入っていること
;; M-x robe-startで開始
;; Gemfileが無い場合はM-x inf-rubyの後にM-x robe-start
;; companyでrobeの補完を表示するようにしてある
;; C-c C-dでリファレンスを表示
(add-hook 'ruby-mode-hook 'robe-mode)
(autoload 'robe-mode "robe" "Code navigation, documentation lookup and completion for Ruby" t nil)
;; rvmを利用してrubyのバージョンを管理している場合はこの設定で.rvmrcなどで選択されているrubyを使う
(defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
  (rvm-activate-corresponding-ruby))
;; helm-robe
(custom-set-variables
 '(robe-completing-read-func 'helm-robe-completing-read))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; slim-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'slim-mode "slim-mode" "slim-mode" t nil)
;;(require 'slim-mode)
(add-to-list 'auto-mode-alist '("\\.slim$" . slim-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;sass-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'sass-mode "sass-mode" "sass-mode" t nil)
;;(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;haml-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'haml-mode "haml-mode" "haml-mode" t nil)
;;(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-hook 'haml-mode-hook
	  (lambda ()
	    ;; 他のエディタなどがファイルを書き換えたらすぐにそれを反映する
	    ;; auto-revert-modeを有効にする
	    (auto-revert-mode t)
	    (setq indent-tabs-mode nil)
	    (define-key haml-mode-map "\C-m" 'newline-and-indent)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MarkDown
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
;(setq auto-mode-alist
;      (cons '("\\.md" . markdown-mode) auto-mode-alist))
;; (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.mkd$" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.mdwn$" . gfm-mode))

;; C-c C-c m でカレントバッファを HTML に変換し新しいバッファに表示
;; C-c C-c p でカレントバッファを変換しブラウザで開く
;; C-c C-c e で変換して保存。basename.mdwn だったら basename.html として保存
;; Windowsの場合Markdown.plを実行できるように以下の設定を追記
(if (eq window-system 'w32) (progn
;			      (setq markdown-command "c:/cygwin/bin/perl.exe ~/.emacs.d/site-lisp/Markdown.pl")
			      (setq markdown-command "perl.exe ~/.emacs.d/site-lisp/Markdown.pl")
			      )
  (progn
    ;; (setq markdown-command "perl ~/.emacs.d/site-lisp/Markdown.pl"))
    ;; nodeのpackageでgithub flavoredに対応したパーザであるmarkedをインストールしてある前提
    (setq markdown-command "marked"))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; jade-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; coffeescript-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'coffee-mode "coffee-mode" "Major mode for editing CoffeeScript." t)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(defun coffee-custom ()
  "coffee-mode-hook"
  (and (set (make-local-variable 'tab-width) 4)
       (set (make-local-variable 'coffee-tab-width) 4))
  )

(add-hook 'coffee-mode-hook
	  '(lambda() (coffee-custom)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yaml-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(add-to-list 'load-path "~/.emacs.d/elisp/yaml-mode")
(when (require 'yaml-mode nil t)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; web-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.shtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ctp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ejs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tag\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tag\\.js\\'" . web-mode))
;(setq auto-mode-alist
;      (append '(
;                ("\\.\\(html\\|xhtml\\|shtml\\|tpl\\|ctp\\|ejs\\)\\'" . web-mode)
;                ("\\.php\\'" . php-mode)
;                )
;              auto-mode-alist))
;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(defun web-mode-hook ()
  "Hooks for Web mode."
  ;; 変更日時の自動修正
  (setq time-stamp-line-limit -200)
  (if (not (memq 'time-stamp write-file-hooks))
      (setq write-file-hooks
            (cons 'time-stamp write-file-hooks)))
  (setq time-stamp-format " %3a %3b %02d %02H:%02M:%02S %:y %Z")
  (setq time-stamp-start "Last modified:")
  (setq time-stamp-end "$")
  ;; web-modeの設定
  (setq web-mode-markup-indent-offset 4) ;; html indent
  (setq web-mode-css-indent-offset 4)    ;; css indent
  (setq web-mode-code-indent-offset 4)   ;; script indent(js,php,etc..)
  ;; htmlの内容をインデント
  ;; TEXTAREA等の中身をインデントすると副作用が起こったりするので
  ;; デフォルトではインデントしない
  ;;(setq web-mode-indent-style 2)
  ;; コメントのスタイル
  ;;   1:htmlのコメントスタイル(default)
  ;;   2:テンプレートエンジンのコメントスタイル
  ;;      (Ex. {# django comment #},{* smarty comment *},{{-- blade comment --}})
  (setq web-mode-comment-style 2)
  ;; 終了タグの自動補完をしない
  ;;(setq web-mode-disable-auto-pairing t)
  ;; color:#ff0000;等とした場合に指定した色をbgに表示しない
  ;;(setq web-mode-disable-css-colorization t)
  ;;css,js,php,etc..の範囲をbg色で表示
  ;; (setq web-mode-enable-block-faces t)
  ;; (custom-set-faces
  ;;  '(web-mode-server-face
  ;;    ((t (:background "grey"))))                  ; template Blockの背景色
  ;;  '(web-mode-css-face
  ;;    ((t (:background "grey18"))))                ; CSS Blockの背景色
  ;;  '(web-mode-javascript-face
  ;;    ((t (:background "grey36"))))                ; javascript Blockの背景色
  ;;  )
  ;;(setq web-mode-enable-heredoc-fontification t)
  )
(define-key web-mode-map  (kbd "C-;") nil)
(define-key web-mode-map  (kbd "C-c C-;") 'web-mode-comment-or-uncomment)
(add-hook 'web-mode-hook  'web-mode-hook)
;; 色の設定
;; (custom-set-faces
;;  '(web-mode-doctype-face
;;    ((t (:foreground "#82AE46"))))                          ; doctype
;;  '(web-mode-html-tag-face
;;    ((t (:foreground "#E6B422" :weight bold))))             ; 要素名
;;  '(web-mode-html-attr-name-face
;;    ((t (:foreground "#C97586"))))                          ; 属性名など
;;  '(web-mode-html-attr-value-face
;;    ((t (:foreground "#82AE46"))))                          ; 属性値
;;  '(web-mode-comment-face
;;    ((t (:foreground "#D9333F"))))                          ; コメント
;;  '(web-mode-server-comment-face
;;    ((t (:foreground "#D9333F"))))                          ; コメント
;;  '(web-mode-css-rule-face
;;    ((t (:foreground "#A0D8EF"))))                          ; cssのタグ
;;  '(web-mode-css-pseudo-class-face
;;    ((t (:foreground "#FF7F00"))))                          ; css 疑似クラス
;;  '(web-mode-css-at-rule-face
;;    ((t (:foreground "#FF7F00"))))                          ; cssのタグ
;;  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rainbow-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'scss-mode-hook 'rainbow-mode)
(add-hook 'php-mode-hook 'rainbow-mode)
(add-hook 'sass-mode-hook 'rainbow-mode)
;; (add-hook 'html-mode-hook 'rainbow-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; go-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'go-mode)
(add-hook 'go-mode-hook
          '(lambda()
             ;;; インデントには tab を使う
             (setq indent-tabs-mode t)
             ;;; インデント幅
             (setq c-basic-offset 4)
	     (setq tab-width 4)
            ;; (local-set-key (kbd "M-.") 'godef-jump)
            ;; (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)
            ;; (local-set-key (kbd "C-c i") 'go-goto-imports)
            ;; (local-set-key (kbd "C-c d") 'godoc)
	    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; lua-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'lua-mode)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
(add-hook 'lua-mode-hook
	  '(lambda()
	     (setq lua-indent-level 2)
	     ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; swift-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'swift-mode)
(add-to-list 'auto-mode-alist '("\\.swift" . swift-mode))
(add-hook 'swift-mode-hook
	  '(lambda()
	     (setq swift-indent-offset 4)
	     (setq swift-indent-switch-case-offset 0)
	     (setq swift-indent-multiline-statement-offset 2)
	     (local-set-key "\C-c\C-c" 'quickrun)
	     (local-set-key "\C-c\C-a" 'quickrun-with-arg)
	     ))
