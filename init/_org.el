;; (setq org-home-pre-path "/media/data/home/")
;; (setq org-home-self-file-list (mapcar '(lambda (x)
;;                                          (concat  "self/ft" x))
;;                                       '(list "fantong_note.org")))

(setq org-file-regu ".*\.org$")
(setq org-agenda-list-self (append ;(dir-files "/media/data/home/self/ft" org-file-regu)
                                   (dir-files "/media/data/home/self/tmee" ".*\.org"))) ; home/self中的org文件
(setq org-agenda-list-pub (dir-files "/media/data/home/public" ".*\.org")) ; home/public中的org文件
(setq org-agenda-list-project (list "")) ; 各project中的org文件
(setq org-agenda-files-old (dir-files "/media/windata/project/home/orgEmacs" ".*\.org")) ; 以前的org文件

;(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-hide-leading-stars t)  ; 只高亮显示最后一个代表层级的*
(define-key global-map "\C-ca" 'org-agenda)  ; C-c a 进入日程表
(setq org-log-done 'time)  ; 给已完成事项打上时间戳。可选 note，附加注释

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  设置tags
(setq org-tag-alist (quote (
                            (:startgroup)
                            ("comp" . ?c)
                            ("job" . ?j)
                            ("life" . ?l)
                            ("misc" . ?m)
                            ("project" . ?p)
                            ("sports" . ?s)
                            ("tmee" . ?t)
                            (:endgroup)
                            ("PHONE" . ?h)
                            ("COMPUTER" . ?o)
                            ("INTERNET" . ?i)
                            ("NEXT" . ?n)
                            ("WAITING" . ?w))))

(setq org-agenda-files (append org-agenda-files-old
                               org-agenda-list-self
                               org-agenda-list-pub
                               org-agenda-list-project))

;; (setq org-agenda-files (list "E:/project/home/orgEmacs/TMEE_Thit.org"
;;                             "E:/project/home/orgEmacs/org.org"
;;                             "E:/project/home/orgEmacs/TMEE_rails.org"))




;; OrgMode & Remember
(setq org-directory "~/org")
(setq org-default-notes-file "~/org/.notes")
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

;; org project
(setq org-publish-project-alist
'(("org"
;;   :base-directory "~/org/"
   :base-directory "/media/windata/project/home/orgEmacs/"
   :base-extension = "org"
   :publishing-directory "/media/windata/project/home/orgEmacs/publish/"
   :publishing-function org-publish-org-to-html
   :exclude "PrivatePage.org"   ;; regexp
   :headline-levels 3
   :section-numbers nil
   :table-of-contents nil
   :style "<link rel=stylesheet
            href=\"../other/mystyle.css\"
            type=\"text/css\">"
   :auto-preamble t
   :auto-postamble nil)

  ("images"
   :base-directory "~/images/"
   :base-extension "jpg\\|gif\\|png"
   :publishing-directory "/ssh:user@host:~/html/images/"
   :publishing-function org-publish-attachment)

  ("other"
   :base-directory "~/other/"
   :base-extension "css\\|el"
   :publishing-directory "/ssh:user@host:~/html/other/"
   :publishing-function org-publish-attachment)
  ("website" :components ("orgfiles" "images" "other"))))


;; open appt message function
(appt-activate t)
(setq appt-display-format 'window)
(add-hook 'diary-hook 'appt-make-list)

;; org to appt
(setq appt-display-duration 30)
(setq appt-audible t)
(setq appt-display-mode-line t)
;;(appt-activate 1)
(setq appt-msg-countdown-list '(10 0))
;;(org-agenda)
(org-agenda-to-appt)


;;; start org文件格式：文件头部内容，在改后用 C-c C-c 刷新设置
;; #+STARTUP: overview
;; #+TAGS: { 桌面(d) 服务器(s) }  编辑器(e) 浏览器(f) 多媒体(m) 压缩(z)
;; #+TAGS:  { @Windows(w)  @Linux(l) }
;; #+TAGS:  { 糟糕(1) 凑合(2) 不错(3) 很好(4) 极品(5) }
;; #+SEQ_TODO: TODO(T) WAIT(W) | DONE(D!) CANCELED(C@)
;; #+COLUMNS: %10ITEM  %10PRIORITY %15TODO %65TAGS
;;; end org文件格式：文件头部内容，在改后用 C-c C-c 刷新设置 ,也可在.emacs中设置tags (setq org-tag-alist '(("编辑器" . ?e) ("浏览器" . ?f) ("多媒体" . ?m)))  在.emacs中设置全局事件状态：     (setq org-todo-keywords '((sequence "TODO" "|" "DONE"  "CANCELED")  (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED") ))

;;; start keys
;; alt-shift-enter 插入TODO项目
;; ctrl-c + ctrl-t 状态标记切换 closed
;; ctrl-c + ctrl-o 打开link
;; ctrl-c + l 将当前位置保存为link
;; ctrl-c + ctrl-l  添加链接 方向键可找到已保存的link
;; tab       显示分支、全部显示、全部隐藏几种状态间循环切换
;; shift-tab 全局文档折叠
;; ctrl-c a t 全局TODO列表
;;             t 标记为done
;;             a 周计划
;;             l 完成日志
;; ctrl-c ctrl-s 将当前todo列入日程表
;; C-c C-a      全部显示
;; C-c C-x b    在一个新缓冲区中显示当前分支
;;      向前    向后
;; 同级  C-c C-f         C-c C-b
;; 跨级  C-c C-n         C-c C-p
;; 上一级 C-c C-u
;; 跳转  C-c C-j
;; C-RET        加入新的同级标识
;; M-left       将当前项提升一级
;; M-right      将当前项降低一级
;; M-S-left     将当前分支提升一级
;; M-S-right    将当前分支降低一级
;; M-S-up       将当前分支向上移动
;; M-S-down     将当前分支向下移动
;; C-c C-x C-k  删除当前分支
;; C-c C-x M-w  复制当前分支
;; C-c C-x C-y  粘贴分支
;; C-c C-w      移动当前分支
;; C-c *        为当前分支加入内容
;; 将光标定位在当前项（Emacs）上，按下 C-c C-c
;;    *  注意回显区中的内容：[a-z]用快捷键选取 [SPC]清除所有标签 [RET]确认 [TAB]自由输入（不建议） [!]取消组（同一组签标可以多选） [C-c]单选多选切换
;;       使用快捷键 s 选中“服务器”，然后再按 d 选中桌面，可以看到，两个不能同时选，因为它们是一组标签，只能选一个。再分别按下 e 和 5,回车确认：
;; C-c \        搜索标签
;; C-c / T
;; C-u C-c \    搜索带 TODO 的标签
;;
;; 可以使用逻辑表达式限制条件，更准确灵活的搜索
;; +    和      a+b     同时有这两个标签
;; -    排除    a-b     有 a 但没有 b
;; |    或      a|b     有 a 或者有 b
;; &    和      a&b     同时有 a 和 b，可以用“+”替代
     (setq org-todo-keywords '((sequence "TODO" "|" "DONE"  "CANCELED")  (sequence "REPORT" "BUG" "KNOWNCAUSE" "|" "FIXED") ))

;;; start keys
;; alt-shift-enter 插入TODO项目
;; ctrl-c + ctrl-t 状态标记切换 closed
;; ctrl-c + ctrl-o 打开link
;; ctrl-c + l 将当前位置保存为link
;; ctrl-c + ctrl-l  添加链接 方向键可找到已保存的link
;; tab       显示分支、全部显示、全部隐藏几种状态间循环切换
;; shift-tab 全局文档折叠
;; ctrl-c a t 全局TODO列表
;;             t 标记为done
;;             a 周计划
;;             l 完成日志
;; ctrl-c ctrl-s 将当前todo列入日程表
;; C-c C-a      全部显示
;; C-c C-x b    在一个新缓冲区中显示当前分支
;;      向前    向后
;; 同级  C-c C-f         C-c C-b
;; 跨级  C-c C-n         C-c C-p
;; 上一级 C-c C-u
;; 跳转  C-c C-j
;; C-RET        加入新的同级标识
;; M-left       将当前项提升一级
;; M-right      将当前项降低一级
;; M-S-left     将当前分支提升一级
;; M-S-right    将当前分支降低一级
;; M-S-up       将当前分支向上移动
;; M-S-down     将当前分支向下移动
;; C-c C-x C-k  删除当前分支
;; C-c C-x M-w  复制当前分支
;; C-c C-x C-y  粘贴分支
;; C-c C-w      移动当前分支
;; C-c *        为当前分支加入内容
;; 将光标定位在当前项（Emacs）上，按下 C-c C-c
;;    *  注意回显区中的内容：[a-z]用快捷键选取 [SPC]清除所有标签 [RET]确认 [TAB]自由输入（不建议） [!]取消组（同一组签标可以多选） [C-c]单选多选切换
;;       使用快捷键 s 选中“服务器”，然后再按 d 选中桌面，可以看到，两个不能同时选，因为它们是一组标签，只能选一个。再分别按下 e 和 5,回车确认：
;; C-c \        搜索标签
;; C-c / T
;; C-u C-c \    搜索带 TODO 的标签
;;
;; 可以使用逻辑表达式限制条件，更准确灵活的搜索
;; +    和      a+b     同时有这两个标签
;; -    排除    a-b     有 a 但没有 b
;; |    或      a|b     有 a 或者有 b
;; &    和      a&b     同时有 a 和 b，可以用“+”替代

;; C-u C-c C-t  手动输入 TODO 状态，如果设定快捷则使用快捷键输入
;; S-right      循环切换 TODO 状态，两个以上 TODO 状态时使用
;; S-left
;; C-S-right    组间切换
;; C-S-left
;; C-c C-v      查询视图
;; C-c / t
;; C-c a t      全局 TODO 列表

;; C-c C-d 设定截止日期(DEADLINE)；
;; C-c C-s 设定计划(SCHEDULED)：
;; C-c .        插入时间戳；如果连续插入两个时间戳，则插入一个时间范围
;; C-u C-c .    更加精确的时间戳，在日程表中以时间线显示
;; C-c !        插入时间戳，不在日程表中显示
;; C-c <        直接插入时间戳（当前日期）
;; C-c >        查看日历
;; C-c C-o      访问当前时间戳的日程表
;; S-left|S-right       以天为单位调整时间戳时间
;; S-up|S-down  调整光标所在时间单位；如果光标在时间戳之外，调整时间戳类型（是否在日程表中显示）
;; C-c C-y      计算时间范围长度
;;
;; C-c C-x C-c  进入列视图
;;              r|g  刷新
;;              q    退出
;;              left|right   在列间移动
;;              S-left|S-right       改变当前列的值
;;              n|p
;;              1~9,0        用编号选择值
;;              v    查看当前值
;;; end keys
