;; タブ・行末・空行表示
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         empty          ; 空行
                         spaces
                         tabs
                         ;; newline
                         space-mark     ; マークを表示
                         tab-mark
                         newline-mark
                         ))
(setq whitespace-display-mappings '((space-mark ?\x3000 [?\u25a1])
                                    (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])
                                    ;; (newline-mark ?\n    [?\x2193 ?\n] [?$ ?\n])
                                    (newline-mark ?\n    [?\xAB ?\n])
                                    ))
(setq whitespace-space-regexp "\\([\x0020\x3000]+\\)")
(set-face-foreground 'whitespace-trailing "#099")
(set-face-background 'whitespace-trailing 'nil)
(set-face-underline  'whitespace-trailing t)

(set-face-foreground 'whitespace-empty "#990")
(set-face-background 'whitespace-empty 'nil)
(set-face-underline  'whitespace-empty t)

(set-face-foreground 'whitespace-space "#990")
(set-face-background 'whitespace-space 'nil)
(set-face-underline  'whitespace-space 'nil)

(set-face-foreground 'whitespace-tab "#990")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)

;; (set-face-foreground 'whitespace-newline "#990")
;; (set-face-background 'whitespace-newline 'nil)
;; (set-face-underline  'whitespace-newline 'nil)

(global-whitespace-mode 1)

