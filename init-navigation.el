;; emacs-nav
(require 'nav)
(cond
 ((eq window-system 'w32)
  (setq nav-width 20))
 ((eq window-system 'ns)
  (setq nav-width 15))
 ((eq window-system 'mac)
  (setq nav-width 15))
 ((eq window-system 'x)
  (setq nav-width 15)))

(setq nav-split-window-direction 'vertical) ;; 分割したフレームを垂直に並べる
;;(global-set-key "\C-x\C-d" 'nav-toggle)     ;; C-x C-d で nav をトグル 
;;(global-set-key "\C-x\C-o" 'nav-toggle)
