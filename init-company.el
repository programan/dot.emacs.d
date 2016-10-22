;; company

(when (require 'company nil t)
  ;; 全バッファで有効にする
  (global-company-mode +1)
  ;; (global-company-mode) 

  ;; 自動補完を offにしたい場合は, company-idle-delayを nilに設定する
  ;; auto-completeでいうところの ac-auto-start にあたる.
  ;; (custom-set-variables
  ;;  '(company-idle-delay nil))


  ;; (add-hook 'python-mode-hook 'company-mode)
  ;; (add-hook 'python-mode-hook 'company-mode)
  ;; (add-hook 'php-mode-hook 'company-mode)
  ;; (add-hook 'ruby-mode-hook 'company-mode)
  ;; (add-hook 'web-mode-hook 'company-mode)
  ;; (add-hook 'c-mode-hook 'company-mode)
  ;; (add-hook 'c++-mode-hook 'company-mode)
  ;; (add-hook 'swift-mode-hook 'company-mode)
  ;; (add-hook 'js2-mode-hook 'company-mode)
  ;; (add-hook 'jade-mode-hook 'company-mode)
  ;; (add-hook 'lua-mode-hook 'company-mode)
  ;; (add-hook 'markdown-mode-hook 'company-mode)


  (setq company-idle-delay 0.5) ; デフォルトは0.5
  (setq company-minimum-prefix-length 3) ; デフォルトは4
  (setq company-selection-wrap-around t) ; 候補の一番下でさらに下に行こうとすると一番上に戻る

  ;; 色をauto-completeっぽく
  (set-face-attribute 'company-tooltip nil
                      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common nil
                      :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common-selection nil
                      :foreground "white" :background "steelblue")
  (set-face-attribute 'company-tooltip-selection nil
                      :foreground "black" :background "steelblue")
  (set-face-attribute 'company-preview-common nil
                      :background nil :foreground "lightgrey" :underline t)
  (set-face-attribute 'company-scrollbar-fg nil
                      :background "orange")
  (set-face-attribute 'company-scrollbar-bg nil
                      :background "gray40")

  ;; (global-set-key (kbd "C-M-i") 'company-complete)

  ;; C-n, C-pで補完候補を次/前の候補を選択
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)

  ;; C-sで絞り込む
  (define-key company-active-map (kbd "C-s") 'company-filter-candidates)

  ;; TABで候補を設定
  (define-key company-active-map (kbd "C-i") 'company-complete-selection)

  ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
  ;; (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete)
  )


;; companyでrobeの補完を表示
;; (push 'company-robe company-backends)





