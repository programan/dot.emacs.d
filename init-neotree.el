;;; init-neotree.el --- init-neotree.el
;;; Commentary:
;; Settings for neotree.
;;; Code:

(when (require 'neotree nil t)
  ;; Press '?' for neotree help.
  ;; 隠しファイルをデフォルトで表示
  (setq neo-show-hidden-files t)
  ;; キーバインドをシンプルにする
  (setq neo-keymap-style 'concise)
  ;; neotree ウィンドウを表示する毎に current file のあるディレクトリを表示する
  (setq neo-smart-open t)


  ;; all-the-icons
  ;; Install fonts file after install package.
  ;; M-x all-the-icons-install-fonts
  (when (require 'all-the-icons nil t)
    ;;(insert (all-the-icons-icon-for-file "foo.js"))
    ;; Inserts a javascript icon
    ;; #("js-icon" 0 1 (display (raise -0.24) face (:family "alltheicon" :height 1.08 :foreground "#FFD446")))
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

  (setq neo-window-fixed-size nil)
  (setq neo-window-width 40)
  (setq neo-autorefresh t)

  ;; (global-set-key "\C-q" 'neotree-toggle)
  (global-set-key [f8] 'neotree-toggle))

;;; init-neotree.el ends here
