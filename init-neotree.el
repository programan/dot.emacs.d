(when (require 'neotree nil t)
  ;; Press '?' for neotree help.
  ;; 隠しファイルをデフォルトで表示
  (setq neo-show-hidden-files t)
  ;; キーバインドをシンプルにする
  (setq neo-keymap-style 'concise)
  ;; neotree ウィンドウを表示する毎に current file のあるディレクトリを表示する
  (setq neo-smart-open t)
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (setq neo-window-fixed-size nil)
  ;; (global-set-key "\C-q" 'neotree-toggle)
  (global-set-key [f8] 'neotree-toggle))
