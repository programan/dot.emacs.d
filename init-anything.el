;; Anything
(require 'anything-startup)
(global-set-key (kbd "C-;") 'anything-filelist+)
;Be sure Anything does not fight with ido-mode.
(anything-read-string-mode 0)
;; ctagsによる関数ジャンプ
(global-set-key (kbd "M-.") 'anything-c-etags-select)
