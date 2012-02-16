(defun ror-replace-blog (array-fields)
  "根据输入的字段列表[ f1 type1 \n f2 type2...]生成ror gengerate scaffold参数"
  (interactive "sArray : ")
  (save-excursion
    (query-replace "records" "@blog")
    (query-replace "search_form_paht" "support_blogs_path")
    (query-replace "batch_destroy_path" "batch_destroy_support_blogs_path")
    (query-replace "rec_name" "博文")
    ))



(defun ror-format-fields-to-generate (array-fields)
  "根据输入的字段列表[ f1 type1 \n f2 type2...]生成ror gengerate scaffold参数"
  (interactive "sArray : ")
  (save-excursion
    (setq ret array-fields)
    (setq fields_list (split-string ret "\n"))
    (insert "\n     ruby script/generate scaffold ")
    (mapcar (lambda(lst)
              ""
              (setq lst (split-string lst))
              (let ((x (car lst)) ; 第一段，字段名
                     (y (car (cdr lst)))) ; 第二段，字段类型
                 (insert " " x ":" y))
                ) fields_list)
    (insert "\n")
    ))

(defun ror-format-fields-to-generate-cmd (array-fields)
  "根据给定字段参数生成rails generate 命令：[[class-name,[[field1, f1-type],[field2, f2-type]...]]]"
  )
