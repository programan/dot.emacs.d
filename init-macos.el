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
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/site-lisp/auto-install/") ;Emacs Lispをインストールするディレクトリの指定
  ;; EmacsWikiに登録されているelispの名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;(setq auto-install-use-wget t)
  ;; install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))

;; anything
;(require 'anything-startup)
;(global-set-key (kbd "C-;") 'anything-filelist+)
;Be sure Anything does not fight with ido-mode.
;(anything-read-string-mode 0)
;(setq anything-c-filelist-file-name "/tmp/all.filelist")

;(setq anything-sources
;      '(anything-c-source-buffers
;	anything-c-source-imenu
;	anything-c-source-etags-select
;	anything-c-source-gtags-select
;	)) 
;;(global-set-key "\M-." 'anything-c-source-etags-select)

;; ctags.elの設定
(setq ctags-update-command (expand-file-name  "/usr/local/bin/ctags"))
;(require 'ctags-update nil t)
;(setq tags-revert-without-query t)
;(setq ctags-command "ctags -R -e --fields=\"+afikKlmnsSzt\" ")
;(setq ctags-command "ctags -R -e")
(global-set-key (kbd "<f5>") 'ctags-update)


;; DDSKK
;(let ((default-directory (expand-file-name "~/DDSKK/lisp")))
;  (add-to-list 'load-path default-directory)
;  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
;      (normal-top-level-add-subdirs-to-load-path)))
(add-to-list 'load-path "~/DDSKK/lisp/skk")
;(require 'skk)
;(require 'info)
;(add-to-list 'Info-additional-directory-list "~/DDSKK/info")
;(setq skk-user-directory "~/DDSKK/")
(when (require 'skk-autoloads nil t)
  (define-key global-map (kbd "\C-xj") 'skk-mode)
  (setq skk-byte-compile-init-file t))
;; dired-x with skk
;(add-hook 'dired-load-hook
;          (lambda ()
;            (load "dired-x")
;            (global-set-key "\C-x\C-j" 'skk-mode)
;            ))
(global-set-key "\C-xj" 'skk-mode)

(setq SKK_SET_JISYO t)
;; skk用のstickyキー設定
(setq skk-sticky-key ";")
;; インライン候補縦表示
(setq skk-show-inline 'vertical)


;; EGG(git)
(when (executable-find "git")
  (require 'egg nil t))

