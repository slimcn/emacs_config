;; 默认进入outline-mode/auto-fill模式
;;(setq default-major-mode 'outline-mode)
;;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;; 脚本模板设置
(defun xi-Event (EventName)
  "事件模板"
  (interactive "sEvent Name:")
  (if (equal "*" (substring EventName 0 1))
      (insert "\n**    事件 : ")
    (insert "\n    事件 : "))
  (if (equal "*" (substring EventName 0 1))
      (setq EventName (substring EventName 1 nil) FirstActionName "*EventCondition")
    (setq FirstActionName "EventCondition"))
  (insert EventName)
  (insert "\n        条件 =\n        事务支持 =\n        状态许可 =\n        后续状态 =\n        热键 =")
  (xi-Action FirstActionName)
  (save-excursion
    (next-line)
    (insert "\n    块尾")))

(defun xi-Action (ActionName)
  "动作模板"
  (interactive "sAction Name:")
  (if (equal "*" (substring ActionName 0 1))
      (insert "\n***        动作 : ")
    (insert "\n        动作 : "))
  (if (equal "*" (substring ActionName 0 1))
      (setq ActionName (substring ActionName 1 nil)))
      (insert ActionName)
      (insert "\n            条件 = \n            动作 = ")
      (save-excursion
        (insert "\n        块尾")))

(defun xi-Compute (Name)
  "中间计算模板"
  (interactive "sName:")
  (if (equal "*" (substring Name 0 1))
      (insert "\n***            中间计算 : ")
    (insert "\n            中间计算: "))
  (if (equal "*" (substring Name 0 1))
      (setq Name (substring Name 1 nil)))
      (insert Name)
      (save-excursion
                (insert "\n                计算来源 = ")
                (insert "\n            块尾")))

(defun xi-AreaS (VarName)
  "单记录区域模板"
  (interactive "sSimple Area Name:")
  (if (equal "*" (substring VarName 0 1))
      (insert "\n***        区域 : ")
    (insert "\n        区域 : "))
  (if (equal "*" (substring VarName 0 1))
      (setq VarName (substring VarName 1 nil)))
      (insert VarName)
      (save-excursion
        (insert "\n            标题 = \n            类型 = s(30)\n            精度来源 = \n            加密字符 = \n            字符格式 = \n            允许为空 = 是\n            正常来源 = [B?]\n            转录来源 = \n            提交去向 = \n            输入方式 = 直接\n            输入掩码 = \n            按钮图标 = \n            提交约束 = \n            修改约束 = \n            审核约束 = \n            默认值 = \n            允许输入 = @1\n            隐藏条件 = @0\n            权限许可 = \n            组 = g\n            行 = 1\n            列 = 1\n            宽度 = 3\n            高度 = 1\n            切换顺序 = \n            允许切换 = @1\n            提示 = \n            显示格式 = \n        块尾")
       ))

(defun xi-AreaD (VarName)
  "多记录区域模板"
  (interactive "sDetail Area Name:")
  (if (equal "*" (substring VarName 0 1))
      (insert "\n***        区域 : ")
    (insert "\n        区域 : "))
  (if (equal "*" (substring VarName 0 1))
      (setq VarName (substring VarName 1 nil)))
      (insert VarName)
      (save-excursion
        (insert "\n            标题 = \n            类型 = s(30)\n            精度来源 = \n            加密字符 = \n            字符格式 = \n            允许为空 = 是\n            正常来源 = [A?]\n            转录来源 = \n            提交去向 = \n            输入方式 = 直接\n            输入掩码 = \n            按钮图标 = \n            提交约束 = \n            修改约束 = \n            审核约束 = \n            默认值 = \n            允许输入 = @1\n            隐藏条件 = @0\n            宽度 = 60\n            高度 = 1\n            允许切换 = @1\n            提示 = \n            显示格式 = \n        块尾")
       ))

;;; 初始化基本设置

(defun xi-format-to-outline ()
  "格式化脚本为outline格式"
  (interactive)
  (let ((inhibit-field-text-motion-old inhibit-field-text-motion)
        (xi-script-regexp0 " *\\(表单 :\\|窗体 :\\|主窗体 :\\|皮肤列表 :\\)+")
        ;(xi-outline-regexp0 "\* *[表单 :\|窗体 :]+")
        (xi-script-regexp1 " *\\(单记录对象 :\\|多记录对象 :\\|树状对象 :\\|状态 :\\|数据去向 :\\|事件 :\\|按钮栏 :\\|按钮 :\\|右键菜单 :\\|状态栏 :\\|图片 :\\|画板 :\\|单选框 :\\|多选框 :\\|组织机构表 :\\|账套表 :\\|菜单表 :\\|状态表 :\\|皮肤 :\\)+")
        ;(xi-outline-regexp1 "\* *[单记录对象 :\|多记录对象 :\|树对象 :\|事件 :]+")
        (xi-script-regexp2 " *\\(区域 :\\|对象账目 :\\|组 :\\|动作 :\\)+")
        (xi-script-regexp3 " *\\(区域账目 :\\|中间计算 :\\)+"))
    (save-excursion
      (setq inhibit-field-text-motion nil)
      (goto-char (point-min))
      (while (equal (eobp) nil)
          (if (looking-at xi-script-regexp0)
              (insert "*")
            (if (looking-at xi-script-regexp1)
                (insert "**")
              (if (looking-at xi-script-regexp2)
                  (insert "***")
                (if (looking-at xi-script-regexp3)
                    (insert "****")))))
          (beginning-of-line 2))
      (setq inhibit-field-text-motion inhibit-field-text-motion-old))))

(defun xi-format-to-script ()
  "格式化outline型脚本为规范脚本"
  (interactive)
  (let ((inhibit-field-text-motion-old inhibit-field-text-motion)
        (xi-outline-regexp0 "*+ *\\(表单 :\\|窗体 :\\|主窗体 :\\|皮肤列表 :\\)+")
        ;(xi-outline-regexp0 "\* *[表单 :\|窗体 :]+")
        (xi-outline-regexp1 "*+ *\\(单记录对象 :\\|多记录对象 :\\|树状对象 :\\|状态 :\\|数据去向 :\\|事件 :\\|按钮栏 :\\|按钮 :\\|右键菜单 :\\|状态栏 :\\|图片 :\\|画板 :\\|单选框 :\\|多选框 :\\|组织机构表 :\\|账套表 :\\|菜单表 :\\|状态表 :\\|皮肤 :\\)+")
        ;(xi-outline-regexp1 "\* *[单记录对象 :\|多记录对象 :\|树对象 :\|事件 :]+")
        (xi-outline-regexp2 "*+ *\\(区域 :\\|对象账目 :\\|组 :\\|动作 :\\)+")
        (xi-outline-regexp3 "*+ *\\(区域账目 :\\|中间计算 :\\)+"))
    (save-excursion
      (setq inhibit-field-text-motion nil)
      (goto-char (point-min))
      (while (equal (eobp) nil)
          (if (looking-at xi-outline-regexp0)
              (delete-char 1)
            (if (looking-at xi-outline-regexp1)
                (delete-char 2)
              (if (looking-at xi-outline-regexp2)
                  (delete-char 3)
                (if (looking-at xi-outline-regexp3)
                    (delete-char 4)))))
          (beginning-of-line 2))
      (setq inhibit-field-text-motion inhibit-field-text-motion-old))))


(defun xi-formatSP-to-run ()
  "格式化BizMgr中的存储过程跟踪语句为可执行的规范sql语句"
  (interactive)
  (save-excursion
        (save-excursion
          ;(move-beginning-of-line)
          (replace-string "执行存储过程语句: " "EXEC ")
          (replace-string "[" " ")
          (replace-regexp "@[a-zA-Z0-9_]*:[isdhf](" " ")
          ;(replace-regexp ")," " , ")
          (replace-regexp ")]." "\n"))
        (replace-regexp ")," " , ")))


(defun xi-noteS (comment)
  "设置脚本初始说明注释，传入参数为注释内容。"
  (interactive "sFile Description : ")
  ;(setq date-current (decode-time))
  (save-excursion
    (insert "//-----------------------------------------------\n")
    (insert "// 作者名   : SLimcn (")
    (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
    (insert ")\n// 修改记录 : \n// 脚本描述 : ")
    (insert comment)
    (insert "\n// 需求描述 : \n//-----------------------------------------------\n")
    (newline)))

(defun xi-note (comment)
  "设置脚本头注释，传入参数为注释内容。"
  (interactive "sNote Comment:")
  ;(setq date-current (decode-time))
  (save-excursion
    (insert )
    (insert "//     修改人   : SLimcn (")
    (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
    (insert ")\n//     修改内容 : ")
    (insert comment)
        (newline)))
(defun xi-ignore (comment)
  "设置行注释，传入参数为注释内容。"
  (interactive "sNote Comment:")
  ;(setq date-current (decode-time))
  (save-excursion
    (insert )
    (insert "// ")
    (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
    (insert " slimcn ")
    (insert comment)
    (insert " ")))

(defun xi-init ()
  "初始化Xi模式：将模式转化为 outline mode，并增加层级标识 "
  (interactive)
  (save-excursion
    (xi-format-to-outline)
    (outline-mode)
    (hide-body)))

(defun xi-save ()
  "保存Xi脚本：删除层级标识，保存脚本文件"
  (interactive)
  (save-excursion
     (show-all)
     (xi-format-to-script)
     (save-buffer)))

(defvar Xi-mode-map nil

  "Local kymap for Xi mode buffers.")

;设置本模式键盘布局
;;(if xi-mode-map
;;    nil
;;  (setq xi-mode-map (make-sparse-keymap))
;;  (define-key xi-mode-map "\C-c s" 'xi-save)
;;  (define-key xi-mode-map "\C-c a" 'xi-init))

(defun xi-mode ()
  "xi major mode,just for TiEAM.COM Scripts."
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'xi-mode)
  (setq mode-name "Xi")
  (use-local-map xi-mode-map)
  )

;;; 存储过程相关

(defun xi-sp-create (name)
  "存储过程创建模板"
  (interactive "sProcedure Name : ")
  (insert "\n\nSET QUOTED_IDENTIFIER ON\nGO\nSET ANSI_NULLS OFF\nGO\n\nif exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[")
  (insert name)
  (insert "]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)\ndrop procedure [dbo].[")
  (insert name)
  (insert "]\nGO\n\n-- ==================================================================\n-- 名    称 : ")
  (save-excursion
    (insert "\n-- 功    能 : \n-- 参    数 : \n-- 输    出 : \n-- 作    者 : SLimcn ")
    (insert (format-time-string "%Y-%m-%d %H:%M:%S"))
    (insert "\n-- 流    程 :\n--        1 : \n--      1.1 : \n--        2 : \n--        3 : \n-- 修改记录 :\n-- \n-- 调试信息 : \n-- \n-- ==================================================================\nCREATE   PROCEDURE ")
    (insert name)
    (insert "\n  @p_\n, @p_iDebug int = 0 -- 是否输出调试信息 (0:不输出,1:输出)\nAS\nbegin\n")
    (insert "\nend\nGO\n\nSET QUOTED_IDENTIFIER OFF\nGO\nSET ANSI_NULLS ON\nGO\n")))

(defun xi-sp-debug ()
  "插入存储过程调试信息模板"
  (interactive)
  (insert "\nif @p_iDebug = 1 \nbegin\n  select ")
  (save-excursion
    (insert "\nend\n")))
