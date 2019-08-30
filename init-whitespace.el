;;; init-whitespace.el --- init-whitespace.el
;;; Commentary:
;; Settings for whitespace mode.
;;; Code:


;; タブ・行末・空行表示
(require 'whitespace)
;; (setq whitespace-style '(face           ; faceで可視化
;;                          trailing       ; 行末
;;                          empty          ; 空行
;;                          spaces
;;                          tabs
;;                          ;; newline
;;                          space-mark     ; マークを表示
;;                          tab-mark
;;                          newline-mark
;;                          ))

;; 可視化するものを指定
(setq whitespace-style '(face           ; faceで可視化
                         ;; trailing       ; 行末
                         ;; empty          ; 空行
                         ;; spaces
                         tabs
                         newline
                         ;; space-mark     ; マークを表示
                         ;; tab-mark
                         newline-mark
                         ))


;; 可視化する際に色だけではなく、記号などを用いる場合はマッピングする
;; (setq whitespace-display-mappings '((space-mark ?\x3000 [?\u25a1])
;;                                     (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])
;;                                     ;; (newline-mark ?\n    [?\x2193 ?\n] [?$ ?\n])
;;                                     (newline-mark ?\n    [?\xAB ?\n])
;;                                     ))

;; 全角スペースのみ記号を表示
;; (setq whitespace-space-regexp "\\([\x0020\x3000]+\\)")


;; (setq whitespace-display-mappings
;;       '((tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])
;;         (newline-mark ?\n    [?\x2193 ?\n] [?$ ?\n])))


;; tabに対して記号を表示するようにマッピングすると、
;; indentのサイズが合わなくなる。バグか。
;; (setq whitespace-display-mappings
;;       '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])
;;         (newline-mark ?\n    [?\x2193 ?\n] [?$ ?\n])))

(setq whitespace-display-mappings
      '((newline-mark ?\n    [?\x2193 ?\n] [?$ ?\n])))


;; 可視化する際の色などを指定
;; (set-face-foreground 'whitespace-trailing "#099")
;; (set-face-background 'whitespace-trailing 'nil)
;; (set-face-underline  'whitespace-trailing t)


;; (set-face-attribute 'whitespace-empty nil
;;                     :background nil
;;                     :foreground "#999"
;;                     :underline t)


;; (set-face-foreground 'whitespace-space "#990")
;; (set-face-background 'whitespace-space 'nil)
;; (set-face-underline  'whitespace-space 'nil)

(set-face-attribute 'whitespace-tab nil
                    :background "gray6"
                    :foreground "LightSkyBlue"
                    :underline nil)

(set-face-attribute 'whitespace-newline nil
                    :background nil
                    :foreground "DimGray"
                    :underline nil)


(global-whitespace-mode 1)


;;; init-whitespace.el ends here
