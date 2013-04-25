;; MiniMap
;; http://www.emacswiki.org/emacs/MiniMap
(require 'minimap)
(setq minimap-window-location 'right)
(setq minimap-width-fraction 0.15)
(setq minimap-hide-fringes nil)
(setq minimap-dedicated-window t)
(defun minimap-toggle ()
  "Toggle minimap for current buffer."
  (interactive)
  (if (null minimap-bufname)
      (minimap-create)
    (minimap-kill)))

;(defun minimap-toggle ()
;  "Toggle minimap for current buffer."
;  (interactive)
;  (if (not (boundp 'minimap-bufname))
;      (setf minimap-bufname nil))
;  (if (null minimap-bufname)
;      (progn (minimap-create)
;	     (set-frame-width (selected-frame) 100))
;    (progn (minimap-kill)
;	   (set-frame-width (selected-frame) 80))))
(global-set-key [f7] 'minimap-toggle)
