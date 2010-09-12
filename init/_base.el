
;;; 关闭出错时的提示声
(setq visible-bell t)
;;; 关闭开机时的启动画面
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
;;; 关闭工具栏
(tool-bar-mode)
(set-scroll-bar-mode 'right) ;;滚动条设在右侧
;(scroll-bar-mode)
;;; 显示列号
(setq column-number-mode t)
;;; 不用tab键缩进
(setq-default indent-tabs-mode nil)
(setq default-tab-width 8)
(setq tab-stop-list ())
;(loop for x downfrom 40 to 1 do
;      (setq tab-stop-list (cons (* x 4) tab-stop-list)))
;;; 防止页面滚动时跳动， scroll-margin 3 可以在靠近屏幕边沿3行时就开始滚动，可以很好的看到上下文
(setq scroll-step 1
      scroll-margin 3
      scroll-conservatively 10000)
;;; 缺省的 major mode 设置为 text-mode
(setq default-major-mode 'text-mode)
;;; 括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线
(mouse-avoidance-mode 'animate)
;;; 将光标设置为短线，而非box
(setq-default cursor-type 'bar)
;;; 在标题栏显示buffer的名字
;(setq frame-title-format "%b@sjm")
(setq frame-title-format;设置标题栏显示文件的完整路径名
      '("%S" (buffer-file-name "%f"
                               (dired-directory dired-directory "%b"))))
;;; 让 Emacs 可以直接打开和显示图片
(auto-image-file-mode)
;;; 进行语法加亮
(global-font-lock-mode t)
;;; 让 dired 可以递归的拷贝和删除目录
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;;; 高亮显示当前行
(hl-line-mode)

;;分割窗口亦换行
(setq-default truncate-partial-width-windows nil)

;;; 时间相关
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-use-mail-icon t) ;时间栏旁边启用邮件设置
(setq display-time-interval 10) ;时间的变化频率，单位多少来着
(display-time)
(setq todo-file-do "~/emacs/todo/do")
(setq todo-file-done "~/emacs/todo/done")
(setq todo-file-top "~/emacs/todo/top")
(setq diary-file "~/emacs/diary")
(setq diary-mail-addr "you@your.email.address")
(add-hook 'diary-hook 'appt-make-list)
(setq appt-issue-message t)             ; 约会提醒
(hl-line-mode)                          ; 高亮当前行

;;; 保存桌面环境
(desktop-save-mode 1)

;; ;;; 最大化
;; (defun w32-restore-frame ()
;;   "Restore a minimized frame"
;;   (interactive)
;;   (w32-send-sys-command 61728))
;; (defun w32-maximize-frame ()
;;   "Maximize the current frame"
;;   (interactive)
;;   ;(w32-send-sys-command 61488)
;;   )
;; (w32-maximize-frame)
;; (add-hook 'after-make-frame-functions 'w32-maximize-frame)



(put 'upcase-region 'disabled nil)

;; ;;允许emacs和外部其他程序的粘贴
 (setq x-select-enable-clipboard t)
;; ;;-------------------------向其他X程序粘贴中文---------------
;; (when (fboundp 'utf-translate-cjk-mode)
;; ;; Load modified utf-translate-cjk-mode
;; (require 'gbk-utf-mode)
;; ;; Turn on utf-translate-cjk-mode
;; (utf-translate-cjk-mode 1)
;; ;; Setup X selection for unicode encoding
;; (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))


;;; shell 中乱码
(setq ansi-color-for-comint-mode t)
;(customize-group 'ansi-colors)

'(recentf-mode t) ; File menu recent-file item
'(transient-mark-mode t) ; 高亮选中

(setq make-backup-files nil)
(setq query-replace-highlight t)
(setq search-highlight t)
(setq font-lock-maximum-decoration t)
(fset 'yes-or-no-p 'y-or-n-p)
(setq require-final-newline t)
(setq major-mode 'text-mode)

(setq default-directory (concat default-path "/home/")) ; 默认路径

(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev ; 当前buffer
        try-expand-dabbrev-visible ; 别的可见窗口
        try-expand-dabbrev-all-buffers ; 所有打开的buffer
        try-expand-dabbrev-from-kill ; kill-ring
        try-complete-file-name-partially ; 文件名列表
        try-complete-file-name
        try-expand-all-abbrevs ; 简称列表
        try-expand-list ; list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

