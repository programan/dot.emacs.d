;;; init-company.el --- init-company.el
;;; Commentary:
;; Settings for company.
;;; Code:

;; company

;; (when (require 'company nil t)
;;   ;; 全バッファで有効にする
;;   (global-company-mode +1)
;;   ;; (global-company-mode)

;;   ;; 自動補完を offにしたい場合は, company-idle-delayを nilに設定する
;;   ;; auto-completeでいうところの ac-auto-start にあたる.
;;   ;; (custom-set-variables
;;   ;;  '(company-idle-delay nil))


;;   ;; (add-hook 'python-mode-hook 'company-mode)
;;   ;; (add-hook 'python-mode-hook 'company-mode)
;;   ;; (add-hook 'php-mode-hook 'company-mode)
;;   ;; (add-hook 'ruby-mode-hook 'company-mode)
;;   ;; (add-hook 'web-mode-hook 'company-mode)
;;   ;; (add-hook 'c-mode-hook 'company-mode)
;;   ;; (add-hook 'c++-mode-hook 'company-mode)
;;   ;; (add-hook 'swift-mode-hook 'company-mode)
;;   ;; (add-hook 'js2-mode-hook 'company-mode)
;;   ;; (add-hook 'jade-mode-hook 'company-mode)
;;   ;; (add-hook 'lua-mode-hook 'company-mode)
;;   ;; (add-hook 'markdown-mode-hook 'company-mode)


;;   (setq company-idle-delay 0.5) ; デフォルトは0.5
;;   (setq company-minimum-prefix-length 3) ; デフォルトは4
;;   (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

;;   ;; 色をauto-completeっぽく
;;   (set-face-attribute 'company-tooltip nil
;;                       :foreground "black" :background "lightgrey")
;;   (set-face-attribute 'company-tooltip-common nil
;;                       :foreground "black" :background "lightgrey")
;;   (set-face-attribute 'company-tooltip-common-selection nil
;;                       :foreground "white" :background "steelblue")
;;   (set-face-attribute 'company-tooltip-selection nil
;;                       :foreground "black" :background "steelblue")
;;   (set-face-attribute 'company-preview-common nil
;;                       :background nil :foreground "lightgrey" :underline t)
;;   (set-face-attribute 'company-scrollbar-fg nil
;;                       :background "orange")
;;   (set-face-attribute 'company-scrollbar-bg nil
;;                       :background "gray40")

;;   ;; (global-set-key (kbd "C-M-i") 'company-complete)

;;   ;; C-n, C-pで補完候補を次/前の候補を選択
;;   (define-key company-active-map (kbd "C-n") 'company-select-next)
;;   (define-key company-active-map (kbd "C-p") 'company-select-previous)
;;   (define-key company-search-map (kbd "C-n") 'company-select-next)
;;   (define-key company-search-map (kbd "C-p") 'company-select-previous)

;;   ;; C-sで絞り込む
;;   (define-key company-active-map (kbd "C-s") 'company-filter-candidates)

;;   ;; TABで候補を設定
;;   (define-key company-active-map (kbd "C-i") 'company-complete-selection)

;;   ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
;;   ;; (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
;;   )


;; ;; companyでrobeの補完を表示
;; ;; (push 'company-robe company-backends)


;; company-box

(when (require 'company nil t)
  ;; 全バッファで有効にする
  ;; (global-company-mode +1)
  ;; プログラミング言語時に有効にする
  (add-hook 'prog-mode-hook 'company-mode)
  )


(when (require 'company-box nil t)
  (setq company-box-backends-colors nil)
  ;; (setq company-box-backends-colors '((company-yasnippet . (:all "gold" :selected (:background "black" :foreground "blue")))))
  ;; (setq company-box-backends-colors '((company-yasnippet . (:all "gold" :selected (:background "gray1" :foreground "DarkTurquoise")))))
  ;; (setq company-box-backends-colors '((company-yasnippet . (:candidate "yellow" :annotation "gray1"))
  ;;                                     (company-elisp . (:icon "yellow" :selected (:background "orange" :foreground "black")))
  ;;                                     (company-dabbrev . "purple")))

  (setq company-box-show-single-candidate t)
  (setq company-box-max-candidates 50)
  ;; (setq company-box-icons-alist 'company-box-icons-all-the-icons)
  ;; (setq company-box-doc-enable nil)
  (add-hook 'company-mode-hook 'company-box-mode))

;;; init-company.el ends here
