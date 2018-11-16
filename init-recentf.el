;; recentf
(when (require 'recentf nil t)
  (setq recentf-max-saved-items 2000)
  (setq recentf-exclude '(".recentf"))
  (setq recentf-auto-cleanup 10)
  (setq recentf-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))
;;(setq recentf-save-file "~/.emacs.d/.recentf")
;;(setq recentf-max-saved-items 100)            ;; recentf に保存するファイルの数
;;(setq recentf-exclude '(".recentf"))           ;; .recentf自体は含まない
;;(setq recentf-auto-cleanup 10)                 ;; 保存する内容を整理
;;(run-with-idle-timer 30 t 'recentf-save-list)  ;; 30秒ごとに .recentf を保存
