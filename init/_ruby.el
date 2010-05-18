
;; ruby-mode
(add-to-list 'load-path (concat default-path-package "ruby-mode"))
(require 'ruby-mode)
(require 'ruby-electric)
(add-hook 'ruby-mode-hook 'turn-on-font-lock)
(add-to-list 'auto-mode-alist '("\\.rjs$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode)) ;;文件后缀名不为.rb，但是脚本第一行有#!ruby之类的说明


;; ruby-block
(add-to-list 'load-path (concat default-path-package "ruby-block"))
(require 'ruby-block)

;; ruby electric
(defun try-complete-abbrev (old)
  (if (expand-abbrev) t nil))

;; yaml
(add-to-list 'load-path (concat default-path-package "yaml-mode"))
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;; rdebug
(add-to-list 'load-path (concat default-path-package "rdebug"))
(require 'rdebug)
(setq rdebug-short-key-mode t)


;; ri-emacs
(setq ri-ruby-script (expand-file-name (concat default-path-package "ri-emacs/ri-emacs.rb")))
(load (concat default-path-package "ri-emacs/ri-ruby.el"))


;; ruby-mode-hook
(add-hook 'ruby-mode-hook
         (lambda()
           (add-hook 'write-file-functions
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
           (set (make-local-variable 'indent-tabs-mode) 'nil)
           (set (make-local-variable 'tab-width) 2)
           (imenu-add-to-menubar "IMENU")
;           (require 'ruby-electric)
           (ruby-electric-mode t)
;           (require 'ruby-block)
           (ruby-block-mode t)
;           (local-set-key 'f1 'ri)
           (local-set-key "\M-\C-i" 'ri-ruby-complete-symbol)
;           (local-set-key 'f4 'ri-ruby-show-args)
           (define-key ruby-mode-map "\M-\C-o" 'rct-complete-symbol)
           (local-set-key (kbd "<return>") 'newline-and-indent)
))

;; nxhtml
;(setq *nxhtml-autostart-file* (expand-file-name "~/Package/emacs-rails-spastorino/plugins/nxhtml/autostart.el"))
;(load *nxhtml-autostart-file*)
;(setq
;      nxhtml-global-minor-mode t
;      mumamo-chunk-coloring 'submode-colored
;      nxhtml-skip-welcome t
;      indent-region-mode t
;      nxhtml-default-encoding "utf8"
;      rng-nxml-auto-validate-flag nil
;      nxml-degraded t)
;(add-to-list 'auto-mode-alist '("\\.html$" . nxhtml-mumamo-mode))
;(add-to-list 'auto-mode-alist '("\\.html\\.erb$" . eruby-nxhtml-mumamo-mode))
;(add-hook 'nxhtml-mumamo-mode-hook 'tabkey2-mode)
;(add-hook 'eruby-nxhtml-mumamo-mode-hook 'tabkey2-mode)


;; flymake
(add-to-list  'load-path (concat default-path-package "flymake"))
(require 'flymake)

;; I don't like the default colors :)
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

;; Feature request: have flymake create its temp files in the system temp file directory instead of in the same directory as the file. When using it with Ruby on Rails and autotest, autotest sees the temp file and tries to do something with it and dies, forcing me to restart it, thus killing the magic of autotest. Putting flymake’s temp files elsewhere seems like the easiest way to dodge this.
;;
;; I second the above request. I know there are workarounds for autotest, but it seems like we don’t want to find work arounds for every new web framework, we want to get flymake working in a way that won’t conflict with any other tools.
;;
;; It is easy to patch your autotest to ignore flymake files. I have submitted a patch which hopefully will be included in future releases. For more info see: Emacs, flymake and autotest: the fix
;;
;; Here is a suggestion for a solution (100% untested). Replace flymake-create-temp-inplace above with

(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))


;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-intemp))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '(".+\\.rjs$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(add-hook 'ruby-mode-hook
          '(lambda ()

             ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
             (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                 (flymake-mode))
             ))

(require 'flymake-jslint)
(add-hook 'javascript-mode-hook
          '(lambda ()
             ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
             (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                 (flymake-mode))
             ))


;; Rinari
(add-to-list 'load-path (concat default-path-package "rinari"))
(require 'rinari)
(setq rinari-tags-file-name "TAGS")


;; yasnippet
(add-to-list 'load-path (concat default-path-package "yasnippet"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat default-path-package "yasnippet/snippets"))
(setq require-final-newline nil)

;; yasnippet rails
(load (concat default-path-package "yasnippets-rails/setup.el"))


(add-to-list 'load-path (concat default-path-package "autotest"))
(require 'autotest)


;; rhtml-mode
(add-to-list 'load-path (concat default-path-package "rhtml"))
(require 'rhtml-mode)
(add-hook 'rhtml-mode-hook
  (lambda () (rinari-launch)))

(add-hook 'rhtml-mode
          (let ((original-command (lookup-key rhtml-mode-map [tab])))
            `(lambda ()
               (setq yas/fallback-behavior
                     '(apply ,original-command))
               (local-set-key [tab] 'yas/expand))))


(add-to-list 'load-path (concat default-path-package "auto-complete"))
(require 'auto-complete-config)
;(global-auto-complete-mode t)
;(define-key ac-complete-mode-map "\C-n" 'ac-next)
;(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;;     ;; start completion when entered 3 characters
;(setq ac-auto-start 2)
;; Add following code to your .emacs.
;;
;(define-key ac-complete-mode-map "\t" 'ac-complete)
;(define-key ac-complete-mode-map "\r" nil)


;(add-to-list 'load-path (concat default-path-package "auto-complete"))
; (when (require 'auto-complete nil t)
;   (require 'auto-complete-yasnippet)
;   (require 'auto-complete-ruby)
;   (require 'auto-complete-css)

   (global-auto-complete-mode t)           ;enable global-mode
   (setq ac-auto-start t)                  ;automatically start
   (setq ac-dwim 3)                        ;Do what i mean
   (setq ac-override-local-map nil)        ;don't override local map
;;   (define-key ac-complete-mode-map "\t" 'ac-expand)
;;   (define-key ac-complete-mode-map "\r" 'ac-complete)
;;   (define-key ac-complete-mode-map "\M-n" 'ac-next)
;;   (define-key ac-complete-mode-map "\M-p" 'ac-previous)
   (set-default 'ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer))

   (setq ac-modes
         (append ac-modes
                 '(eshell-mode
                   ;org-mode
                   )))
   ;(add-to-list 'ac-trigger-commands 'org-self-insert-command)

   (add-hook 'emacs-lisp-mode-hook
             (lambda ()
               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-symbols))))

   (add-hook 'eshell-mode-hook
             (lambda ()
               (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-files-in-current-dir ac-source-words-in-buffer))))

   (add-hook 'ruby-mode-hook
             (lambda ()
               (setq ac-omni-completion-sources '(("\\.\\=" ac-source-rcodetools)))));)


;; ri
;(load (concat default-path-package "ri/ri.el"))

;; snippet
;(add-to-list 'load-path (concat default-path-package "snippet"))

;; rails-emacs
;(add-to-list 'load-path (concat default-path-package "emacs-rails"))
;(require 'rails)

;(kill-buffer "*ESS*")
;(kill-buffer "*Compile-Log*")
;(kill-buffer "*Messages*")

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

