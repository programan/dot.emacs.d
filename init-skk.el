;;; init-skk.el --- init-skk.el
;;; Commentary:
;; Settings for skk.
;;; Code:


;; DDSKK

;; NTEmacs
;;(setq SKK_DATADIR "c:/emacs/etc/skk")
;;(setq SKK_INFODIR "c:/emacs/info")
;;(setq SKK_LISPDIR "c:/emacs/site-lisp/skk")

;;(add-to-list 'load-path "~/DDSKK/lisp/skk")
(add-to-list 'load-path "~/.emacs.d/lisp/skk")
(setq skk-tut-file "~/.emacs.d/share/skk/SKK.tut")
(setq skk-large-jisyo "~/.emacs.d/share/skk/SKK-JISYO.L")

;;(require 'skk)
;;(require 'info)
;;(add-to-list 'Info-additional-directory-list "~/DDSKK/info")
;;(setq skk-user-directory "~/DDSKK/")

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
;; ;キーで変換モード
(setq skk-sticky-key ";")
;; インライン候補縦表示
(setq skk-show-inline 'vertical)

;; lisp-interaction-mode
(add-hook 'lisp-interaction-mode-hook
          '(lambda()
             (eval-expression (skk-mode) nil)
             ))

;; find-file(C-xC-f)
;; バッファを開くとskk-mode
(add-hook 'find-file-hooks
          '(lambda()
             (eval-expression (skk-mode) nil)
             ))

(add-hook 'isearch-mode-hook
          '(lambda ()
             (when (and (boundp 'skk-mode)
                        skk-mode
                        skk-isearch-mode-enable)
               (skk-isearch-mode-setup))))
(add-hook 'isearch-mode-end-hook
          '(lambda ()
             (when (and (featurep 'skk-isearch)
                        skk-isearch-mode-enable)
               (skk-isearch-mode-cleanup))))

;; ミニバッファ上でも skk-mode にする
;; skk-latin-mode でアルファベット入力にしておく
(add-hook 'minibuffer-setup-hook
          '(lambda()
             (progn
               (eval-expression (skk-mode) nil)
               (skk-latin-mode (point))
               ;; ミニバッファ上に「nil」と表示させないために, 空文字をミニバッファに表示
               (minibuffer-message "")
               )))

;;(setq default-input-method "japanese-skk")

;;; init-skk.el ends here
