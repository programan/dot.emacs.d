;; Emacs24から標準搭載されたパッケージマネージャの設定
;; package.elの設定
(when (require 'package nil t)
  ;;パッケージリポジトリにMarmaladeと開発運営のELPAを追加
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives
	       '("ELPA" . "http://tromey.com/elpa/"))
  ;;インストールしたパッケージにロードパスを通して読み込む
  (package-initialize))
