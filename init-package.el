;;; init-package.el --- init-package.el
;;; Commentary:
;; Settings for package manager.
;;; Code:

;; Emacs24から標準搭載されたパッケージマネージャの設定
;; package.elの設定
(when (require 'package nil t)
  ;;パッケージリポジトリにMarmaladeと開発運営のELPAを追加
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
	       '("ELPA" . "http://tromey.com/elpa/"))
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.org/packages/") t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
  
  ;;インストールしたパッケージにロードパスを通して読み込む
  (package-initialize))

;;(provide 'init-package)
;;; init-package.el ends here
