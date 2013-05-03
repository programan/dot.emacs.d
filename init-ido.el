;; Interactively Do Things (highly recommended, but not strictly required)
;; ファイルやバッファのオープン、切り替えをサポート
;; C-sで次のファイルを選択、C-rで前のファイルを選択
;; tabで補完一覧表示。一覧が一つしかない時はそのファイルを開く。
;; C-fすると通常のC-x C-fの状態に戻る
;; //でルートディレクトリへ
;; C-x C-dでDired
(when (require 'ido nil t)
  ;;(ido-mode t)
  (ido-mode 'buffer)
  (setq ido-enable-flex-matching t)
  (setq ido-confirm-unique-completion t)
  (setq ido-default-buffer-method 'samewindow)
  (setq ido-use-filename-at-point t)
  (ido-mode t)
  (ido-everywhere t)
  ;;(set-face-background 'ido-first-match "Gray")
  ;;(set-face-foreground 'ido-subdir "blue3")
  (icomplete-mode 1)
  (custom-set-variables
   '(ido-enable-last-directory-history nil)
   '(ido-record-commands nil)
   '(ido-max-work-directory-list 0)
   '(ido-max-work-file-list 0)))
