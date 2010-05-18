(defun xi-replace-template-name (name)
  "替换XI脚本模板中的name变量：+Name+ --> Name"
  (interactive "sName : ")
  (save-excursion  
    (goto-char (point-min))
    (replace-string "+Name+" name)))
(defun xi-replace-template-nameCN (nameCN)
  "替换XI脚本模板中的中文name变量：+NameCN+ --> nameCN"
  (interactive "sNameCN : ")
  (save-excursion  
    (goto-char (point-min))
    (replace-string "+NameCN+" name)))
(defun xi-replace-template-table (table)
  "替换XI脚本模板中的table变量：+Table+ --> table"
  (interactive "sTable Name : ")
  (save-excursion  
    (goto-char (point-min))
    (replace-string "+Table+" table)))


(defun xi-create-sheet-from-table-line (arg)
  "根据表结构字段行（以tab或空格分隔）获得属性列表以对应脚本中相关的属性，以此生成脚本.
       输入：与属性列表同顺序的数据集，同行记录属性间以tab键间隔
  xi-property-list(xi-property(区域名称 区域标题 区域类型))"
  (interactive "s类别（m：单；d：多；t：树）：")
  (setq xi-area-property-list-mast (list "区域" "标题" "类型" "允许为空" "正常来源" "提交去向" "输入方式" "按钮图标" "默认值" "允许输入" "隐藏条件" "组" "行" "列" "宽度" "高度" "切换顺序" "允许切换" "显示格式"))  ; 属性串——单记录区域
  (setq xi-area-property-list-detail (list "区域" "标题" "类型" "允许为空" "正常来源" "提交去向" "输入方式" "按钮图标" "默认值" "允许输入" "隐藏条件" "宽度" "切换顺序" "允许切换" "显示格式"))  ; 属性串——多记录区域
  (setq xi-area-property-list-tree (list "区域" "类型" "正常来源" "权限许可"))  ; 属性串——树区域
  (setq xi-area-property-list-unused (list "精度来源" "加密字符" "字符格式" "转录来源" "审核去向" "输入掩码" "提交约束" "修改约束" "审核约束" "权限许可" "提示"))
  (setq xi-area-property-list-mast-std (list "区域" "标题" "类型" "精度来源" "加密字符" "字符格式" "允许为空" "正常来源" "转录来源" "提交去向" "审核去向" "输入方式" "输入掩码" "按钮图标" "提交约束" "修改约束" "审核约束" "默认值" "允许输入" "隐藏条件" "权限许可" "组" "行" "列" "宽度" "高度" "切换顺序" "允许切换" "提示" "显示格式"))
  (setq xi-area-property-list-detail-std (list "区域" "标题" "类型" "精度来源" "加密字符" "字符格式" "允许为空" "正常来源" "转录来源" "提交去向" "审核去向" "输入方式" "输入掩码" "按钮图标" "提交约束" "修改约束" "审核约束" "默认值" "允许输入" "隐藏条件" "权限许可" "宽度" "允许切换" "提示" "显示格式"))

  ;; 设置属性列表 
  (if (equal (upcase arg) "D")  
	  ;(setq xi-area-property-list (append xi-area-property-list-detail xi-area-property-list-unused))
	  (setq xi-area-property-list xi-area-property-list-detail-std)
	(if (equal (upcase arg) "T")
		(setq xi-area-property-list xi-area-property-list-tree)
	  ;;(setq xi-area-property-list (append xi-area-property-list-mast xi-area-property-list-unused))
	  (setq xi-area-property-list xi-area-property-list-mast-std)
	  ))

  (setq xi-area-string "")  ; 初始区域串，以防止nil错误
  (setq line-number-old 0)  ; 前次处理的行位置，以控制循环
  (save-excursion
	(goto-char (point-max))
	(setq line-number-max (line-number-at-pos)))  ; 获得最大行数，防止 next-line 函数可能的出错
  ;(goto-char 0)  ;移动到开始，准备操作
  (save-excursion
	(setq line-number-now (line-number-at-pos))
	(while (> line-number-now line-number-old)
	  (if (= (line-beginning-position) (line-end-position))
		  ()
		(progn 
		  (setq line-string (buffer-substring (line-beginning-position) (line-end-position))) ;获得行内容串
		  (setq line-string-list (split-string line-string "\t" nil)) ;分割行内容串为列表，顺序同属性列表
		  (setq xi-area-string (concat xi-area-string (xi-create-area-from-value-list xi-area-property-list line-string-list arg)))))
	  (setq line-number-old line-number-now)
	  (if (< (line-number-at-pos) line-number-max)
		  (next-line))
	  (setq line-number-now (line-number-at-pos)))) ; 根据脚本格式及属性列表生成区域脚本
(insert "\n")
  (insert xi-area-string))

(defun kill-ring-save-current-line ()
  "copy the current non-empty line to the kill-ring"
  (interactive)
  (unless (equal (line-beginning-position) (line-end-position))
    (kill-ring-save (line-beginning-position) (line-end-position))))

(defun xi-create-area-from-value-list (property-list value-list object-type)
  "根据传入的区域属性值列表（与属性列表对应）获得x+i格式的区域脚本"
  (if (equal "区域" (car property-list))
	  (progn
		(setq prefix-string1 (make-string 8 ? ))
		(setq prefix-string2 (make-string 12 ? ))))
  (setq area-string (concat prefix-string1 (car property-list) " : " (car value-list) "\n"))  ;设置第一个属性，同时为变量符初值，以避免对nil的操作出错
  (setq property-list-temp (cdr property-list))
  (setq value-list-temp (cdr value-list))
  (while property-list-temp
	(if (equal "允许输入" (car property-list-temp))
		(setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = @" (car value-list-temp) "\n")))
	  (if (equal "隐藏条件" (car property-list-temp))
		  (setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = @" (car value-list-temp) "\n")))
		(if (equal "允许切换" (car property-list-temp))
			(setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = @" (car value-list-temp) "\n")))
		  (if (equal "正常来源" (car property-list-temp))
			  (if (equal "D" (upcase object-type))
				  (setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = [A?" (car value-list-temp) "]\n")))
				(if (equal "DI" (upcase object-type))
					(setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = [G?" (car value-list-temp) "]\n")))
				  (setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = [B?" (car value-list-temp) "]\n")))))				
			(setq area-string (concat area-string (concat prefix-string2 (car property-list-temp) " = " (car value-list-temp) "\n")))))))
		  
		  
	(setq property-list-temp (cdr property-list-temp))
	(setq value-list-temp (cdr value-list-temp)))
  (setq area-string (concat area-string (concat prefix-string1 "块尾\n")))
  area-string)
