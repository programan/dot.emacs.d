;; 自動文法チェック
(require 'flymake)


;;rubyとかphpとかの本体が無いとだめなのかも

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; objc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mode config
;(setq auto-mode-alist
;      (append '(("\\.h$" . objc-mode)
;                ("\\.m$" . objc-mode))))
;(require 'flymake-objc)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C# support
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'csharp-mode-hook
	  '(lambda ()
	     (flymake-mode t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ruby
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Invoke ruby with '-c' to get syntax checking
(defvar my-local-ruby-path nil)
(if (eq window-system 'w32)
    (progn
      (cond
       ((executable-find "c:/cygwin/bin/ruby.exe")
	(setq my-local-ruby-path "c:/cygwin/bin/ruby.exe"))
       ((executable-find "ruby")
	(setq my-local-ruby-path "ruby"))
       (t (setq my-local-ruby-path nil))))
  (progn
    (cond
     ((executable-find "ruby")
      (setq my-local-ruby-path "ruby"))
     (t (setq my-local-ruby-path nil)))))
;(print my-local-ruby-path)
;(print "aaaaaa")

(defun flymake-ruby-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
    (list my-local-ruby-path (list "-c" local-file))))
(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
(add-hook
 'ruby-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    ;;(if (not (null buffer-file-name)) (flymake-mode t))
    (if (not (null buffer-file-name)) (flymake-mode))
    ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
    (define-key ruby-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; php
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'flymake-php)
;(add-hook 'php-mode-hook 'flymake-php-load)
(defvar my-local-php-path nil)
;(setq my-local-php-path nil)
(if (eq window-system 'w32)
    (progn
      (cond
       ((executable-find "c:/cygwin/bin/php.exe")
	(setq my-local-php-path "c:/cygwin/bin/php.exe"))
       ((executable-find "c:/xampp/php/php.exe")
	(setq my-local-php-path "c:/xampp/php/php.exe"))
       ((executable-find "php")
	(setq my-local-php-path "php"))
       (t (setq my-local-php-path nil))))
  (progn
    (cond
     ((executable-find "php")
      (setq my-local-php-path "php"))
     (t (setq my-local-php-path nil)))))

(defun flymake-php-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
         (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name))))
;    (list "c:/xampp/php/php.exe" (list "-f" local-file "-l"))))
    (list my-local-php-path (list "-f" local-file "-l"))))

(push '(".+\\.php$" flymake-php-init) flymake-allowed-file-name-masks)
(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)
(add-hook
 'php-mode-hook
 '(lambda ()
    ;; Don't want flymake mode for ruby regions in rhtml files
    (if (not (null buffer-file-name)) (flymake-mode t))
    ;; エラー行で C-c d するとエラーの内容をミニバッファで表示する
    (define-key php-mode-map "\C-cd" 'credmp/flymake-display-err-minibuf)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flymake display error minibuffer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun credmp/flymake-display-err-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count               (length line-err-info-list))
         )
    (while (> count 0)
      (when line-err-info-list
        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)
          )
        )
      (setq count (1- count)))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pyflake - flake8 - pep8
;;(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)
;; (setq flymake-python-pyflakes-executable "/usr/local/bin/flake8")
(setq flymake-python-pyflakes-executable "~/.pyenv/shims/flake8")
(custom-set-variables
 '(flymake-python-pyflakes-extra-arguments (quote ("--max-line-length=99" "--ignore=E124" "--ignore=E126" "--ignore=E128"))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Swift
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(add-hook 'after-init-hook #'global-flycheck-mode)
;; (add-hook 'swift-mode-hook
;; 	  '(lambda()
;; 	     (add-to-list 'flycheck-checkers 'swift)
;; 	     (setq flycheck-swift-sdk-path
;; 		   (replace-regexp-in-string
;; 		    "\n+$" "" (shell-command-to-string
;; 			       "xcrun --show-sdk-path --sdk macosx")))
;; 	     )
;; 	  )



