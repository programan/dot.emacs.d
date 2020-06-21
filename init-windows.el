;;; init-windows.el --- init-windows.el
;;; Commentary:
;; Settings for windows.
;;; Code:

;キーボードから入力される文字コード
(set-keyboard-coding-system 'sjis)

;ターミナルの文字コード
(set-terminal-coding-system 'utf-8)

;ファイル名の文字コード
(setq default-file-name-coding-system 'japanese-cp932-dos)

;クリップボードの文字コード
;; MS Windows clipboard
(set-clipboard-coding-system 'utf-16le-dos)

;; MS-Windows shell-mode
(add-hook
 'shell-mode-hook
 '(lambda ()
   (set-buffer-process-coding-system 'sjis 'sjis)))

;; Cygwin入ってる場合に設定しておくとfind grep使える
;; (setq find-dired-find-program "c:\\cygwin\\bin\\find.exe")
;; (setq find-program "c:\\cygwin\\bin\\find.exe")
;; (setenv "PATH" (format "c:\\cygwin\\bin;%s" (getenv "PATH")))

;; (setq find-dired-find-program "c:\\MinGW\\msys\\1.0\\bin\\find.exe")
;; (setq find-program "c:\\MinGW\\msys\\1.0\\bin\\find.exe")
;; (setenv "PATH" (format "c:\\MinGW\\msys\\1.0\\bin;%s" (getenv "PATH")))

;(setq exec-path (append exec-path '(getenv "PATH")))
;(setq exec-path (append exec-path '(format "c:/cygwin/bin;%s" (getenv "PATH"))))

;; シフト + 矢印で範囲選択
(setq pc-select-selection-keys-only t)
(when (<= emacs-major-version 23)
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
;; (set-default-font "Consolas 10")
;; (set-fontset-font (frame-parameter nil 'font)
;;                                   'japanese-jisx0208
;;                                   '("ＭＳ ゴシック" . "unicode-bmp")
;;                                   )
;; (set-fontset-font (frame-parameter nil 'font)
;;             'katakana-jisx0201
;;             '("ＭＳ ゴシック" . "unicode-bmp")
;;             )

(add-to-list 'default-frame-alist '(font . "HackGen-11"))



; 機種依存文字
(require 'cp5022x)
; charset と coding-system の優先度設定
(set-charset-priority 'ascii
                      'japanese-jisx0208
                      'latin-jisx0201
                      'katakana-jisx0201
                      'iso-8859-1
                      'cp1252
                      'unicode)
(set-coding-system-priority 'utf-8
                            'euc-jp
                            'iso-2022-jp
                            'cp932)


;; 半透明化
;; 透明度の設定
(add-to-list 'default-frame-alist '(alpha . 95))


;; ツールバーの非表示
(if window-system (progn
                    (tool-bar-mode 0)))

;; ctags.elの設定
;; (setq ctags-update-command (expand-file-name  "c:/ctags/ctags.exe"))

;(require 'ctags-update nil t)
;(setq tags-revert-without-query t)
;(setq ctags-command "ctags -R -e --fields=\"+afikKlmnsSzt\" ")
;(setq ctags-command "ctags -R -e")
(global-set-key (kbd "<f5>") 'ctags-update)


;; EGG(git)
;(when (executable-find "c:/msysgit/msysgit/bin/git.exe")
;  (require 'egg nil t)
;  (setq egg-git-command "c:/msysgit/msysgit/bin/git.exe")
;  (setq egg-patch-command "c:/msysgit/msysgit/bin/patch.exe"))

;; magit
(global-set-key (kbd "C-x g") 'magit-status)

;; MySQL
;; (setq sql-mysql-program "d:/mysoft/mysql5/bin/mysql")
;; (setq sql-mysql-program "c:/xampp/mysql/bin/mysql.exe")
;; (setq sql-mysql-options '("-C" "-t" "-f" "-n"))

;;(setq sql-mysql-options '("-C" "-t" "-f" "-n" "--port=22222"))
;; truncate lines for long tables
;;(add-hook 'sql-interactive-mode-hook
;;	  (function (lambda ()
;;		      (setq truncate-lines t))))
;; (setq auto-mode-alist
;;       (append
;;        (list
;; 	;; insert entries for other modes here if needed.
;; 	(cons "\.sq$" 'sql-mode))
;;        auto-mode-alist))
;; (add-hook 'sql-mode-hook 'font-lock-mode)


;; migemo


(require 'migemo)
(setq migemo-dictionary "c:/cmigemo/dict/cp932/migemo-dict")
;;;(setq migemo-dictionary "c:/cmigemo/dict/utf-8/migemo-dict")
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a")) (setq migemo-user-dictionary nil) (setq migemo-regex-dictionary nil)
;;;(setq migemo-coding-system 'utf-8-unix)
(setq migemo-coding-system 'cp932-unix)
(load-library "migemo")
(migemo-init)

;;; init-windows.el ends here
