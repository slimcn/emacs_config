; ;;; start ;;; .emacs setup
; (cond
;  ((not (boundp 'initial-window-system)) (load "emacs-console"))
;  ((memq initial-window-system '(x w32))
;   (cond
;    ((memq system-type '(windows-nt cygwin)) (setq default-path "D:/programs/dev/emacs/config/"))
;    ((memq system-type '(gnu/linux)) (setq default-path "/media/TOOLS/programs/dev/emacs/config/"))
;    )
;   )
;  )
;
; (load-file (concat default-path "init/emacs-init.el"))
; ;;; end ;;; .emacs setup



(setq default-path-init (concat default-path "init/")) ; 配置文件路径
(setq default-path-package (concat default-path "package/")) ; 插件包文件路径

(load-file (concat default-path-init "_tabbar.el")) ; 标签
(load-file (concat default-path-init "_base.el")) ; 基本设置
 (load-file (concat default-path-init "_color-theme.el")) ; 配色方案

(load-file (concat default-path-init "_org.el")) ; org-mode 个人信息管理及编写大纲

(load-file (concat default-path-init "_slimcn.el")) ; slimcn个人设置

;(load-file (concat default-path-init "_svn.el"))
(load-file (concat default-path-init "_git.el"))


(progn
  (add-to-list 'load-path (concat default-path-package "textmate"))
  (require 'textmate)
  (textmate-mode))

(progn
  (add-to-list 'load-path (concat default-path-package "redo"))
  (require 'redo)
  (global-set-key [(control -)] 'redo))

(progn
  (add-to-list  'load-path (concat default-path-package "maxframe"))
  (require 'maxframe)
  (add-hook 'window-setup-hook 'maximize-frame t)
  (add-hook 'window-setup-hook 'ecb-redraw-layout t))

(progn
  (load-file (concat default-path-package "cedet/common/cedet.el")))

(load-file (concat default-path-init "_ecb.el"))

(progn
  (add-to-list 'load-path (concat default-path-package "find-recursive"))
  (require 'find-recursive))

(progn
  (add-to-list 'load-path (concat default-path-package "anything"))
  (require 'anything))

(progn
  (add-to-list 'load-path (concat default-path-package "rcodetools"))
  (require 'anything-rcodetools)
  (setq rct-get-all-methods-command "PAGER=cat fri -l -L")
  (define-key anything-map "\C-z" 'anything-execute-persistent-action))

;; (progn
;;   (require 'ido) ; 打开文件和切换buffer的智能提示 (智能得有点乱七八糟)
;;   (ido-mode t))

(load-file (concat default-path-init "_dtd.el"))

(load-file (concat default-path-init "_ruby.el"))
(load-file (concat default-path-init "_ror.el"))

(load-file (concat default-path-init "_blog.el"))

(load-file (concat default-path-init "_emms.el"))