;キーボードから入力される文字コード
(set-keyboard-coding-system 'sjis)

;ターミナルの文字コード
(set-terminal-coding-system 'utf-8)

;ファイル名の文字コード
;;(setq default-file-name-coding-system 'japanese-cp932-dos)
;(set-file-name-coding-system 'utf-8)
;(require 'utf-8m)
;(set-file-name-coding-system 'utf-8m)

;クリップボードの文字コード
;; MS Windows clipboard
;;(set-clipboard-coding-system 'utf-16le-dos)
;;(set-clipboard-coding-system 'utf-8)
;;(unless (<= 23 emacs-major-version) 
;;  (set-selection-coding-system 'compound-text-unix))

;; コピーした内容を PRIMARY,CLIPBOARD セクションにもコピーする
;;(set-clipboard-coding-system 'compound-text)
(set-clipboard-coding-system 'utf-8)
(cond (window-system (setq x-select-enable-clipboard t) ))

;; C-y で CLIPBOARD の内容をペースト(ヤンク)する
;; クリップボードの内容を kill-ring に追加してからヤンクします
;; kill-ringに新しい内容を追加するとそちらが優先されます
(cond (window-system (global-set-key "\C-y" 'x-clipboard-yank)))


;; MS-Windows shell-mode
;(add-hook
; 'shell-mode-hook
; '(lambda ()
;   (set-buffer-process-coding-system 'sjis 'sjis)))


;; シフト + 矢印で範囲選択
(setq pc-select-selection-keys-only t)
(when (< emacs-major-version 24)
  (pc-selection-mode 1)
)

;; NTEmacs (emacs 22.x) =>
;;  日本語文字: モトヤシーダまたはモトヤアポロを用意してください.
;;  英文字: consolas を用意してください.(Vista はデフォルトで入ってます. XP は microsoft からダウンロードしてください.)
;; NTEmacs (emacs 23.x) =>
;;  日本語文字: MS ゴシック
;;  英文字: consolas
;; GNU Emacs 23.x on unix =>
;;  ~/.Xresources にて日本語フォントを設定してください.
;(set-default-font "Consolas 10")
;(set-fontset-font (frame-parameter nil 'font)
;                                 'japanese-jisx0208
;                                 '("ＭＳ ゴシック" . "unicode-bmp")
;                                 )
;(set-fontset-font (frame-parameter nil 'font)
;           'katakana-jisx0201
;           '("ＭＳ ゴシック" . "unicode-bmp")
;           )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; フォントの設定
;;01234567890123456789
;;あいうえおかきくけこ
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(cond (window-system
;       (set-face-attribute 'default nil
;                           :family "さざなみゴシック"
;                           :height 80)
;       (set-fontset-font (frame-parameter nil 'font)
;                         'japanese-jisx0208
;                         '("Takaoゴシック" . "unicode-bmp")
;                         )
;       (set-fontset-font (frame-parameter nil 'font)
;                         'katakana-jisx0201
;                         '("Takaoゴシック" . "unicode-bmp")
;                         )
;       (setq face-font-rescale-alist
;             '(
;               (".*さざなみゴシック.*" . 1.0)
;               (".*Takaoゴシック.*"    . 1.1)
;               ))
;       ))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


;(set-face-attribute 'default nil
;                   :family "Ricty"
;                   :height 160)
;(set-fontset-font
; nil 'japanese-jisx0208
; (font-spec :family "Ricty"))
;;(add-to-list 'default-frame-alist '(font . "ricty-13.5"))
;(add-to-list 'default-frame-alist '(font . "ricty-11"))

(let* ((size 13)
       (asciifont "Ricty") ; ASCII fonts
       (jpfont "Ricty") ; Japanese fonts
       (h (* size 8))
       (fontspec (font-spec :family asciifont))
       (jp-fontspec (font-spec :family jpfont)))
  (set-face-attribute 'default nil :family asciifont :height h)
  (set-fontset-font nil 'japanese-jisx0213.2004-1 jp-fontspec)
  (set-fontset-font nil 'japanese-jisx0213-2 jp-fontspec)
  (set-fontset-font nil 'katakana-jisx0201 jp-fontspec)
  (set-fontset-font nil '(#x0080 . #x024F) fontspec) 
  (set-fontset-font nil '(#x0370 . #x03FF) fontspec))


; 機種依存文字
;(require 'cp5022x)
;; charset と coding-system の優先度設定
;(set-charset-priority 'ascii
;                      'japanese-jisx0208
;                      'latin-jisx0201
;                      'katakana-jisx0201
;                      'iso-8859-1
;                      'cp1252
;                      'unicode)
;(set-coding-system-priority 'utf-8
;                            'euc-jp
;                            'iso-2022-jp
;                            'cp932)



;; ツールバーの非表示
(if window-system (progn
                    (tool-bar-mode 0)))


;; 半透明化
;; 透明度の設定
;(add-to-list 'default-frame-alist '(alpha . 80))

(if window-system (progn
                    (set-background-color "Black")
                    (set-foreground-color "LightGray")
                    (set-cursor-color "Gray")
                    (set-frame-parameter nil 'alpha 85)
                    ))
;; auto-install
;; wgetが必要
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/site-lisp/auto-install/") ;Emacs Lispをインストールするディレクトリの指定
  ;; EmacsWikiに登録されているelispの名前を取得する
  (auto-install-update-emacswiki-package-name t)
  ;(setq auto-install-use-wget t)
  ;; install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))

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
(require 'migemo)
(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a")) (setq migemo-user-dictionary nil) (setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)

