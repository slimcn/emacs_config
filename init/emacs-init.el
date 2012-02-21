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
; (setq default-path "/media/TOOLS/programs/dev/emacs/config/")
; (load-file (concat default-path "init/emacs-init.el"))
; ;;; end ;;; .emacs setup



(setq default-path-init (concat default-path "init/")) ; 配置文件路径
(setq default-path-package (concat default-path "package/")) ; 插件包文件路径

(load-file (concat default-path-init "_base24.el")) ; 基本设置

(load-file (concat default-path-init "_lib.el")) ; 自定义的通用函数库
(load-file (concat default-path-init "_slimcn.el")) ; slimcn个人设置

(load-file (concat default-path-init "_elpa.el")) ; 包设定

;; elpa version 24 is not very support
(load-file (concat default-path-init "_base.el")) ; 基本设置
(load-file (concat default-path-init "_ror.el")) ; 基本设置



(load-file (concat default-path-init "_base_gui.el"))
;; ;; 该函数在命令行模式下才需要
;; (add-hook 'after-make-frame-functions
;;           (lambda (new-frame)
;;             (select-frame new-frame)
;;             ;; ->在此填界面和字体的配置
;;             (load-file (concat default-path-init "_base_gui.el")) ; 只有在图形界面下才支持的配置
;; ))
