;;; init-ediff.el --- init-ediff.el
;;; Commentary:
;; Settings for ediff.
;;; Code:

;; コントロール用のバッファを同一フレーム内に表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのバッファを上下ではなく左右に並べる
(setq ediff-split-window-function 'split-window-horizontally)

(add-hook 'ediff-load-hook
          (lambda ()
            (set-face-foreground
             ediff-even-diff-face-A "navy")
            (set-face-foreground
             ediff-even-diff-face-B "navy")
            (set-face-foreground
             ediff-even-diff-face-C "navy")
            (set-face-foreground
             ediff-odd-diff-face-A "navy")
            (set-face-foreground
             ediff-odd-diff-face-B "navy")
            (set-face-foreground
             ediff-odd-diff-face-C "navy")
            (set-face-background
             ediff-even-diff-face-A "dark gray")
            (set-face-background
             ediff-even-diff-face-B "dark gray")
            (set-face-background
             ediff-even-diff-face-C "dark gray")
            (set-face-background
             ediff-odd-diff-face-A "dark gray")
            (set-face-background
             ediff-odd-diff-face-B "dark gray")
            (set-face-background
             ediff-odd-diff-face-C "dark gray")))

;; (add-hook 'ediff-load-hook
;;           (lambda ()
;;             (set-face-foreground
;;              ediff-even-diff-face-A "royal blue")
;;             (set-face-background
;;              ediff-current-diff-face-B "red")
;;             (make-face-italic
;;              ediff-current-diff-face-B)))

;;; init-ediff.el ends here
