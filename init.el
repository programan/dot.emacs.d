;; 共通ロードパスの追加
(load "~/.emacs.d/init-load-path")

;; Emacs24から標準搭載されたパッケージマネージャの設定
(load "~/.emacs.d/init-package")

;; 全体的な環境設定
;; Unicodeをメインにする場合の設定
;使用する言語環境
(set-language-environment 'Japanese)
;開く場合に優先する文字コード
(prefer-coding-system       'utf-8)
;デフォルトで使用する文字コード
(set-default-coding-systems 'utf-8)
;新しいファイルを作成するときの文字コード
(setq default-buffer-file-coding-system 'utf-8)

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


;; DDSKK
(load "~/.emacs.d/init-skk")

;; undo-tree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; window-sysytemが有効の時のみ初期化
(when (window-system)
  ;; 編集行のハイライト設定の読み込み
  (load "~/.emacs.d/init-hilight-line")

  ;; color-theme
  ;;(load-theme 'deeper-blue t)
  ;;(load-theme 'manoj-dark t)
  ;;(load-theme 'misterioso t)
  (load-theme 'tango-dark t)
  ;;(load-theme 'wheatgrass t)
  ;;(load-theme 'wombat t)
)

(require 'all-ext)

;; anything
;;(load "~/.emacs.d/init-anything")

;; helm
(load "~/.emacs.d/init-helm")

;; オートコンプリート設定の読み込み
(load "~/.emacs.d/init-auto-complete")

;; snippet設定の読み込み
(load "~/.emacs.d/init-snippet")

;; モード設定の読み込み
(load "~/.emacs.d/init-modes")

;; flymake設定の読み込み
(load "~/.emacs.d/init-flymake")

;; 全角空白、タブ、改行表示モード設定の読み込み
(load "~/.emacs.d/init-jaspace")

;; バッファ2分割時の縦横トグル設定の読み込み
(load "~/.emacs.d/init-window-toggle-division")

;; アウトラインモード設定の読み込み
;;(load "~/.emacs.d/init-outline-tree")

;; 行の折り返しON/OFF設定の読み込み
(load "~/.emacs.d/init-truncate-lines")

;; tailの読み込み
(load "~/.emacs.d/init-tail")

;; main-lineの読み込み
;; (load "~/.emacs.d/init-mainline")

;; ediff
;; コントロール用のバッファを同一フレーム内に表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのバッファを上下ではなく左右に並べる
(setq ediff-split-window-function 'split-window-horizontally)

;; 同名ファイルのバッファ名の識別文字列を変更
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; ウィンドウフレームの設定
;; ウィンドウ設定
(when window-system
  (progn
    (set-frame-size
     (selected-frame)
     (- (/ (round (* (/ (x-display-pixel-width) 2) 1.4)) (frame-char-width)) 1)
     (- (/ (- (x-display-pixel-height) 180) (frame-char-height)) 1))
    )
  (set-frame-position
   (selected-frame)
   20
   30
   )
  )
(setq initial-frame-alist default-frame-alist)
(set-background-color "Black")
(set-foreground-color "White")
(set-cursor-color "Gray")

;; メニューバーを消す
(menu-bar-mode -1)
;; スタートアップメッセージを非表示
(setq inhibit-startup-message t)

;; モードライン設定
;; モードラインに時間を表示する
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)

;; モードラインに行数とカラムを表示
(line-number-mode 1)
(column-number-mode 1)

;; モードラインの色
(set-face-foreground 'mode-line "light blue")
(set-face-background 'mode-line "grey19")
;;(set-face-background 'modeline "black")

;; モードラインにバッテリ残量表示
;(display-battery-mode t)

;; タイトルバー設定
;; タイトルバーにファイル名を表示
;(setq frame-title-format "%b")
;; ウィンドウタイトルをファイルパスに
(setq frame-title-format (format "%%f - Emacs @%s" (system-name)))

;; ショートカットキー設定
;; M-g で指定行へ移動
(global-set-key "\M-g" 'goto-line)

;; 複数行コメントブロック
(global-set-key "\C-c>" 'comment-region)
(global-set-key "\C-c<" 'uncomment-region)

;; ファイル編集回り設定
;; 前回編集していた場所を記憶
(load "saveplace")
(setq-default save-place t)

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

;; *.~ とかのバックアップファイルを作らない
;;(setq make-backup-files nil)
;; .#* とかのバックアップファイルを作らない
;(setq auto-save-default nil)

;; バックアップとオートセーブファイルを~/.emacs.d/backups/へ集める
(add-to-list 'backup-directory-alist
	     (cons "." "~/.emacs.d/backups/"))
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))


;; ファイルを訪問時のフックからvc-find-file-hookを削除
;; こいつが有効だと、gitとかcvsとかのディレクトリがある場合に
;; 再帰的にいろいろ調査しようとして、動きがすごく重たい
;; ネットワークディレクトリ上のファイルを開くと顕著
;; gitとかcvsとかの便利機能をemacsで使わないならオフ
;; ちなみにgitはmagitというlispがある。でもWindowsでは動かないかも
(remove-hook 'find-file-hooks 'vc-find-file-hook)
;;(eval-after-load "vc" '(remove-hook 'find-file-hooks 'vc-find-file-hook))

;; proofreading
(require 'yspel)

;; M-x dirtree
(require 'dirtree)

;; M-x ep-dirtree
(require 'eproject)
(defun ep-dirtree ()
  (interactive)
  (dirtree eproject-root t))

;; eww(emacs web wowser)
;;デフォルトの検索エンジンはduckduckgoのままだが地域を日本として検索するように設定
;;(setq eww-search-prefix "https://duckduckgo.com/html/?kl=jp-jp&q=")
;;広告なし
(setq eww-search-prefix "https://duckduckgo.com/html/?kl=jp-jp&k1=-1&q=")


;; 環境変数を見えるようにする
;; pyenvでインストールしたpythonとかがちゃんと見える
;; (when (memq window-system '(mac ns))
;;   (exec-path-from-shell-initialize))

;; recentf
(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))
;;(setq recentf-save-file "~/.emacs.d/.recentf")
;;(setq recentf-max-saved-items 100)            ;; recentf に保存するファイルの数
;;(setq recentf-exclude '(".recentf"))           ;; .recentf自体は含まない
;;(setq recentf-auto-cleanup 10)                 ;; 保存する内容を整理
;;(run-with-idle-timer 30 t 'recentf-save-list)  ;; 30秒ごとに .recentf を保存
