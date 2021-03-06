;;; init-xwindow.el --- init-xwindow.el
;;; Commentary:
;; Settings for xwindow.
;;; Code:

;キーボードから入力される文字コード
(set-keyboard-coding-system 'utf-8)

;ターミナルの文字コード
(set-terminal-coding-system 'utf-8)

(when (>= emacs-major-version 23)
  ;; ファイル名の文字コード
  (set-file-name-coding-system 'utf-8))


;クリップボードの文字コード
(set-clipboard-coding-system 'utf-8)
;;(set-clipboard-coding-system 'compound-text)

(when window-system
  ;; コピーした内容を PRIMARY,CLIPBOARD セクションにもコピーする
  (setq select-enable-clipboard t)
  ;; C-yでクリップボードの内容をペースト(ヤンク)する
  (global-set-key "\C-y" 'x-clipboard-yank)
  ;; ツールバーの非表示
  (tool-bar-mode 0))


;; シフト + 矢印で範囲選択
(setq pc-select-selection-keys-only t)


;; フォントの指定
;(set-face-attribute 'default nil
;                   :family "Ricty"
;                   :height 160)
;(set-fontset-font
; nil 'japanese-jisx0208
; (font-spec :family "Ricty"))
;;(add-to-list 'default-frame-alist '(font . "ricty-13.5"))
;(add-to-list 'default-frame-alist '(font . "ricty-11"))
;; (add-to-list 'default-frame-alist '(font . "-*-HackGen-normal-normal-normal-*-*-*-*-*-d-0-*"))
(add-to-list 'default-frame-alist '(font . "HackGen-11"))


;; 半透明化
;; 透明度の設定(active . inactive)
(add-to-list 'default-frame-alist '(alpha . (90 . 80)))

;; ctags.elの設定
(setq ctags-update-command (expand-file-name  "/usr/bin/ctags-exuberant"))

;(require 'ctags-update nil t)
;(setq tags-revert-without-query t)
;(setq ctags-command "ctags -R -e --fields=\"+afikKlmnsSzt\" ")
;(setq ctags-command "ctags -R -e")
(global-set-key (kbd "<f5>") 'ctags-update)

;; multi-termの設定
;(when (require 'multi-term nil t)
;  ;; 使用するシェルの指定
;  (setq multi-term-program "/bin/bash"))

;; 環境変数を見えるようにする
(exec-path-from-shell-initialize)

;; migmo
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq migemo-command "cmigemo")
  (setq migemo-options '("-q" "--emacs"))
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")
  (migemo-init))

;;; init-xwindow.el ends here
