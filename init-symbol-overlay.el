;;; init-symbol-overlay.el --- init-symbol-overlay.el
;;; Commentary:
;; Settings for symbol overlay.
;;; Code:

(when (require 'symbol-overlay nil t)
  (global-set-key (kbd "M-i") 'symbol-overlay-put)
  (global-set-key (kbd "M-n") 'symbol-overlay-switch-forward)
  (global-set-key (kbd "M-p") 'symbol-overlay-switch-backward)
  ;; (global-set-key (kbd "<f6>") 'symbol-overlay-mode)
  ;; (global-set-key (kbd "<f7>") 'symbol-overlay-remove-all)
  ;; (global-set-key (kbd "M-s") 'symbol-overlay-remove-all)

  ;; overlayで選択された状態で以下のキーでさらにオプション機能となる
  ;; "i" -> symbol-overlay-put
  ;; "n" -> symbol-overlay-jump-next
  ;; "p" -> symbol-overlay-jump-prev
  ;; "w" -> symbol-overlay-save-symbol
  ;; "t" -> symbol-overlay-toggle-in-scope
  ;; "e" -> symbol-overlay-echo-mark
  ;; "d" -> symbol-overlay-jump-to-definition
  ;; "s" -> symbol-overlay-isearch-literally
  ;; "q" -> symbol-overlay-query-replace
  ;; "r" -> symbol-overlay-rename  
  (define-key symbol-overlay-map (kbd "c") 'symbol-overlay-count)
  ;; (define-key symbol-overlay-map (kbd "M-r") 'symbol-overlay-remove-all))
  (define-key symbol-overlay-map (kbd "C-g") 'symbol-overlay-remove-all))

;;; init-symbol-overlay.el ends here
