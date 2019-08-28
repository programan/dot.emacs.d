;;; init-macos.el --- emacs settings for macos.

;; キーボードから入力される文字コード
;; (set-keyboard-coding-system 'sjis-mac)
(set-keyboard-coding-system 'utf-8-mac)

;; ターミナルの文字コード
(set-terminal-coding-system 'utf-8)

;; クリップボードの文字コード
(set-clipboard-coding-system 'utf-8)

(when (<= emacs-major-version 22)
  ;;日本語の濁点、半濁点対応
  (require 'utf-8m)
  (set-file-name-coding-system 'utf-8m)
  ;;キーバインド設定
  ;; Macのキーバインドを使う。optionをメタキーにする。
  (mac-key-mode 1))

(when (>= emacs-major-version 23)
  ;; ファイル名の文字コード
  (set-file-name-coding-system 'utf-8)
  ;; ドラッグされたファイルは新規バッファで開く
  (define-key global-map [ns-drag-file] 'ns-find-file)
  (setq ns-pop-up-frames nil))


;; 左のオプションキーをメタキーにする
(setq mac-option-modifier 'meta)

;; シフト + 矢印で範囲選択
(setq pc-select-selection-keys-only t)
(when (< emacs-major-version 24)
  (pc-selection-mode 1))


;; フォント設定
;; (add-to-list 'default-frame-alist '(font . "ricty-13.5"))
(add-to-list 'default-frame-alist '(font . "HackGen-14"))



;; growl messages at file saved
;(defun growlnotify-after-save-hook ()
;  (shell-command
;   (format "growlnotify -t \"Emacs\" -m \"saved : %s \""
;                  (buffer-name (current-buffer)))))
;(add-hook 'after-save-hook 'growlnotify-after-save-hook)

;; 半透明化
;; 透明度の設定(active . inactive)
(add-to-list 'default-frame-alist '(alpha . (90 . 80)))


(when window-system
  ;; ツールバーの非表示
  (tool-bar-mode 0))


					; Macでは¥とバックスラッシュが違う文字列として扱われるため制御する
;; ¥の代わりにバックスラッシュを入力する
;; (define-key global-map [?¥] [?\\])
;; mini bufferでも
;; (define-key key-translation-map (kbd "¥") (kbd "\\"))
;; C-x C-e 文字コードチェック
;; UTF8で¥は165, \は92
(define-key key-translation-map [165] [92])



;; auto-install
;; wgetが必要
;; (when (require 'auto-install nil t)
;;   (setq auto-install-directory "~/.emacs.d/site-lisp/auto-install/") ;Emacs Lispをインストールするディレクトリの指定
;;   ;; EmacsWikiに登録されているelispの名前を取得する
;;   (auto-install-update-emacswiki-package-name t)
;;   ;(setq auto-install-use-wget t)
;;   ;; install-elispの関数を利用可能にする
;;   (auto-install-compatibility-setup))

;; ctags.elの設定
(setq ctags-update-command (expand-file-name  "/usr/local/bin/ctags"))
;(require 'ctags-update nil t)
;(setq tags-revert-without-query t)
;(setq ctags-command "ctags -R -e --fields=\"+afikKlmnsSzt\" ")
;(setq ctags-command "ctags -R -e")
(global-set-key (kbd "<f5>") 'ctags-update)

;; EGG(git)
;; (when (executable-find "git")
;;   (require 'egg nil t))

;; multi-termの設定
;(when (require 'multi-term nil t)
;  ;; 使用するシェルの指定
;  (setq multi-term-program "/bin/sh"))

;; load environment value
;; (load-file (expand-file-name "~/.emacs.d/shellenv.el"))
;; (dolist (path (reverse (split-string (getenv "PATH") ":")))
;;   (add-to-list 'exec-path path))

;; 環境変数を見えるようにする
(exec-path-from-shell-initialize)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)


;; MySQL
;; (setq sql-mysql-program "/Applications/MAMP/Library/bin/mysql")
;;(setq sql-mysql-options '("-C" "-t" "-f" "-n"))
;; (setq sql-mysql-options '("-C" "-t" "-f" "-n" "-P 8889"))


;; migmo
(when (and (executable-find "cmigemo")
	   (require 'migemo nil t))
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init))
