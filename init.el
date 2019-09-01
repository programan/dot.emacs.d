;;; init.el --- init.el
;;; Commentary:
;; Settings for Emacs.
;;; Code:


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

;; 同名で拡張子がelcとelのファイルがあった場合、新しい方を読む
;; load時に拡張子まで指定されていた場合はこの限りではない
(setq load-prefer-newer t)

;; Emacs24から標準搭載されたパッケージマネージャの設定
(load "~/.emacs.d/init-package")

;; 共通ロードパスの追加
(load "~/.emacs.d/init-load-path")


;; 全体的な環境設定 ;;

;; メニューバーを消す
(menu-bar-mode -1)
;; スタートアップメッセージを非表示
(setq inhibit-startup-message t)

;; Unicodeをメインにする場合の設定
;使用する言語環境
(set-language-environment 'Japanese)
;開く場合に優先する文字コード
(prefer-coding-system       'utf-8)
;デフォルトで使用する文字コード
(set-default-coding-systems 'utf-8)
;新しいファイルを作成するときの文字コード
;; (setq default-buffer-file-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

;; Windows依存とMac依存の設定ファイルを別ファイルからそれぞれ読む
(cond
 ((eq window-system 'w32)
  (load "~/.emacs.d/init-windows"))
 ((eq window-system 'ns)
  (load "~/.emacs.d/init-macos"))
 ((eq window-system 'mac)
  (load "~/.emacs.d/init-macos"))
 ((eq window-system 'x)
  (load "~/.emacs.d/init-xwindow"))
 (t (load "~/.emacs.d/init-console")))


;; (require 'all-ext)


;; frame
(load "~/.emacs.d/init-frame")

;; theme
(load "~/.emacs.d/init-theme")

;; projectile
(load "~/.emacs.d/init-projectile")

;; helm
(load "~/.emacs.d/init-helm")

;; オートコンプリート設定の読み込み
;; 今現在はautoload無効
;; (load "~/.emacs.d/init-auto-complete")
;; auto-completeの変わりにcompanyを使う
(load "~/.emacs.d/init-company")

;; snippet設定の読み込み
(load "~/.emacs.d/init-snippet")

;; symbol overlay
(load "~/.emacs.d/init-symbol-overlay")

;; モード設定の読み込み
(load "~/.emacs.d/init-modes")

;; flymake設定の読み込み
;; (load "~/.emacs.d/init-flymake")

;; flymake設定の読み込み
(load "~/.emacs.d/init-flycheck")

;; 全角空白、タブ、改行表示モード設定の読み込み
;; (load "~/.emacs.d/init-jaspace")

;; whitespace-modeを使用した全角空白、タブ、改行の表示
;; タブ幅4だとして丁度4文字目にタブを挿入すると空白1つではなく4つ分ずれるバグが直るまで使うのは止める
(load "~/.emacs.d/init-whitespace")

;; バッファ2分割時の縦横トグル設定の読み込み
(load "~/.emacs.d/init-window-toggle-division")

;; アウトラインモード設定の読み込み
;;(load "~/.emacs.d/init-outline-tree")

;; 行の折り返しON/OFF設定の読み込み
(load "~/.emacs.d/init-truncate-lines")

;; tailの読み込み
(load "~/.emacs.d/init-tail")

;; slime
(load "~/.emacs.d/init-slime")

;; ediff
(load "~/.emacs.d/init-ediff")

;; DDSKK
(load "~/.emacs.d/init-skk")

;; eww
(load "~/.emacs.d/init-eww")

;; google-translateの読み込み
(load "~/.emacs.d/init-google-translate")

;; recentf
(load "~/.emacs.d/init-recentf")

;; neotree
(load "~/.emacs.d/init-neotree")

;; 編集行のハイライト設定の読み込み
(load "~/.emacs.d/init-hilight-line")

;; backup file
(load "~/.emacs.d/init-backup-file")


;; undo-tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))


(require 'rvm)
(rvm-use-default) ;; use rvm's default ruby for the current Emacs session


;; 同名ファイルのバッファ名の識別文字列を変更
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)


;; anzu
;; anzu-query-replace
;; anzu-query-replace-regexp
(require 'anzu)
(global-anzu-mode +1)
;; (global-set-key (kbd "C-c r") 'anzu-query-replace)
;; (global-set-key (kbd "C-c R") 'anzu-query-replace-regexp)


;; proofreading
(require 'yspel)

;; M-x dirtree
(require 'dirtree)

;; M-x ep-dirtree
(require 'eproject)
(defun ep-dirtree ()
  (interactive)
  (dirtree eproject-root t))


;; vlf
;;Automatically lanches for large file.
(require 'vlf-setup)


;; EditorConfigを有効化する
;; プロジェクトルートに.editorconfigを置く
(editorconfig-mode 1)

;; 環境変数を見えるようにする
;; pyenvでインストールしたpythonとかがちゃんと見える
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))


;; ファイルを訪問時のフックからvc-find-file-hookを削除
;; こいつが有効だと、gitとかcvsとかのディレクトリがある場合に
;; 再帰的にいろいろ調査しようとして、動きがすごく重たい
;; ネットワークディレクトリ上のファイルを開くと顕著
;; gitとかcvsとかの便利機能をemacsで使わないならオフ
;; ちなみにgitはmagitというlispがある。でもWindowsでは動かないかも
(remove-hook 'find-file-hooks 'vc-find-file-hook)
;;(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))


;; mode line
;; (load "~/.emacs.d/init-mode-line")

;; main-line
;; (load "~/.emacs.d/init-mainline")

;; telephone line
(load "~/.emacs.d/init-telephone-line")


;;
;; 上記までで設定したものの上書きやキーバインドなど
;;

;; comment line
;; (set-face-foreground 'font-lock-comment-face "DodgerBlue")
;; (set-face-foreground 'font-lock-comment-delimiter-face "DodgerBlue")
;; (set-face-foreground 'font-lock-comment-face "Yellow")
;; (set-face-foreground 'font-lock-comment-delimiter-face "Red")

;; frame color
;; (set-background-color "Black")
;; (set-foreground-color "White")
;; (set-cursor-color "Gray")


;; モードラインにバッテリ残量表示
;(display-battery-mode t)

;; ファイル編集回り設定
;; 前回編集していた場所を記憶
(load "saveplace")
(when (>= emacs-major-version 25)
  (save-place-mode 1)
)
(when (<= emacs-major-version 24)
  (setq-default save-place t)
)

;; 行番号表示
;; (when (>= emacs-major-version 26)
(when (version<= "26.0.50" emacs-version )
  ;;(display-line-numbers-mode 1)
  (global-display-line-numbers-mode 1)
  ;; 行番号エリアの色
  (set-face-attribute 'line-number nil
                      :foreground "ivory4"
                      :background "gray1")
  (set-face-attribute 'line-number-current-line nil
                      :foreground "turquoise3"))

;; ファイルの終端をフリンジを使い判り易くする
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;; 対応する括弧を光らせる。
(show-paren-mode 1)

;; Beep音を消す(その代わりにBeep音が鳴るタイミングで画面が点滅)
(setq visible-bell t)
;; Beep音を鳴らす(画面の点滅は無い)
;(setq visible-bell nil)
;; Beep音も点滅もしないように無効な関数を設定してみる
(setq ring-bell-function 'ignore)

;; リージョンに色を付ける
(setq transient-mark-mode t)



;; ショートカットキー設定
;; M-g で指定行へ移動
(global-set-key "\M-g" 'goto-line)

;; 複数行コメントブロック
(global-set-key "\C-c>" 'comment-region)
(global-set-key "\C-c<" 'uncomment-region)


;; regionを拡張
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-M-@") 'er/contract-region) ;; リージョンを狭める


;; multiple-cursors
;; C-> で次の行にカーソルを追加していく
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M->") 'mc/skip-to-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; C-h でbackspace
(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))


;; --------
;; 新設された変数 package-selected-packages にインストールしたパッケージ名を保持するようになった影響でinit.elにEmacsが記述するらしい

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(anzu-deactivate-region t)
 '(anzu-mode-lighter "")
 '(anzu-search-threshold 1000)
 '(flymake-python-pyflakes-extra-arguments
   (quote
    ("--max-line-length=99" "--ignore=E124" "--ignore=E126" "--ignore=E128")))
 '(package-selected-packages
   (quote
    (telephone-line symbol-overlay recentf-ext diminish slime-theme challenger-deep-theme indent-guide dockerfile-mode csharp-mode flycheck-pos-tip image-dired+ slime auto-virtualenvwrapper virtualenvwrapper adoc-mode migemo vlf neotree all-the-icons company-tern editorconfig google-translate helm-descbinds undo-tree flycheck-swift swift3-mode company-jedi company-php ac-php ubuntu-theme tronesque-theme paganini-theme metalheart-theme kooten-theme heroku-theme gotham-theme cyberpunk-theme clues-theme bubbleberry-theme bliss-theme badwolf-theme ample-theme material-theme helm-robe robe projectile-rails helm-ag fuzzy company dirtree eproject php-mode anzu yaml-mode web-mode slim-mode ruby-electric ruby-block rspec-mode rhtml-mode rainbow-mode rainbow-delimiters quickrun python-mode multiple-cursors multi-term moccur-edit main-line magit-popup lua-mode less-css-mode js2-mode jade-mode htmlize go-mode git-commit flymake-python-pyflakes flycheck expand-region exec-path-from-shell direx-grep ctags-update csv-mode coffee-mode angular-snippets all-ext)))
 '(robe-completing-read-func (quote helm-robe-completing-read))
 '(rspec-use-rake-when-possible nil))


;;; init.el ends here
