;;; init-backup-file.el --- init-backup-file.el
;;; Commentary:
;; Settings for backup file.
;;; Code:

;; *.~ とかのバックアップファイルを作らない
;;(setq make-backup-files nil)
;; .#* とかのバックアップファイルを作らない
;(setq auto-save-default nil)

;; バックアップとオートセーブファイルを~/.emacs.d/backups/へ集める
(add-to-list 'backup-directory-alist (cons "." "~/.emacs.d/backups/"))

(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "~/.emacs.d/backups/") t)))

;;; init-backup-file.el ends here
