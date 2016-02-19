;; キーボードから入力される文字コード
(set-keyboard-coding-system 'sjis-mac)

;; ターミナルの文字コード
(set-terminal-coding-system 'utf-8)

;; ファイル名の文字コード
(when (>= emacs-major-version 23)
  (set-file-name-coding-system 'utf-8)
)
(when (<= emacs-major-version 22)
  (require 'utf-8m)
  (set-file-name-coding-system 'utf-8m)
)

;; クリップボードの文字コード
(set-clipboard-coding-system 'utf-8)

;;;キーバインド設定
;; Macのキーバインドを使う。optionをメタキーにする。
(when (<= emacs-major-version 22)
  (mac-key-mode 1)
)
(setq mac-option-modifier 'meta)


(when (>= emacs-major-version 23)
  (define-key global-map [ns-drag-file] 'ns-find-file)
  (setq ns-pop-up-frames nil)
  )

;; シフト + 矢印で範囲選択
(setq pc-select-selection-keys-only t)
(when (< emacs-major-version 24)
  (pc-selection-mode 1)
  )


;; フォント設定
;(if (eq window-system 'mac) (require 'carbon-font))
;(fixed-width-set-fontset "hirakaku_w3" 12)
;(setq fixed-width-rescale nil)

;(if (eq window-system 'mac) (progn 
;							  (require 'carbon-font)
;							  (fixed-width-set-fontset "hirakaku_w3" 12)
;							  (setq fixed-width-rescale nil)
;;							  (set-default-font "fontset-hiraginomaru12")
;;							  (setq default-frame-alist (append '((font . "fontset-hiraginomaru12"))))
;))

;(set-face-attribute 'default nil
;		    :family "Ricty"
;		    :height 140)
;(set-fontset-font
; nil 'japanese-jisx0208
; (font-spec :family "Ricty"))
;(add-to-list 'default-frame-alist '(font . "ricty-13"))
;;(add-to-list 'default-frame-alist '(font . "ricty-11"))

(let* ((size 13)
       (asciifont "Ricty") ; ASCII fonts
       (jpfont "Ricty") ; Japanese fonts
       (h (* size 10))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec) 
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))

;; growl messages at file saved
;(defun growlnotify-after-save-hook ()
;  (shell-command
;   (format "growlnotify -t \"Emacs\" -m \"saved : %s \""
;                  (buffer-name (current-buffer)))))
;(add-hook 'after-save-hook 'growlnotify-after-save-hook)

;; 半透明化
;; 透明度の設定
(add-to-list 'default-frame-alist '(alpha . 85))

;; ツールバーの非表示
(if window-system (progn
		    (tool-bar-mode 0)))

; Macでは¥とバックスラッシュが違う文字列として扱われるため制御する 
(define-key global-map [?¥] [?\\])  ;; ¥の代わりにバックスラッシュを入力する

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
;; (setq sql-mysql-program "d:/mysoft/mysql5/bin/mysql")
(setq sql-mysql-program "/Applications/MAMP/Library/bin/mysql")
;;(setq sql-mysql-options '("-C" "-t" "-f" "-n"))
(setq sql-mysql-options '("-C" "-t" "-f" "-n" "-P 8889"))
