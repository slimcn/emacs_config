(defun slimcnror-comment (type name)
  "注释模板(html):"
  (interactive "s注释类型：\ns注释名称：")
  (if (equal "html" type)
      (progn (insert "\n" "<!--// start // " name " -->\n")
            (save-excursion
              (insert "\n<!--// end // >" name " -->\n")))))

(defun slimcnror-add-detail (master detail details)
  "细表调用模板:主表对象/细表对象/细表对象复数"
  (interactive "sMaster:\nsDetail:\nsDetails:")
  (let (var1)
    (setq var1 1)
    (insert "\n")
    (insert "  <fieldset>\n    <legend><%= t('details') %></legend>\n    <%= error_messages_for :" detail " %>\n    <table id=\"" details "\">\n      <tr align=\"center\">\n        <%= fields_table_head({'name' => \"" master "." detail "\"}, @sheet_detail_fields) %>\n      </tr>\n      <%= render :partial => \"" details "/" detail "\", :collection => @" master "." details " %>\n    </table>\n    <%= add_link t(\"add\".downcase), :" detail " %>\n  </fieldset>\n")))

(defun slimcnror-detail-frame (master detail fields)
   "细表模板："
   (interactive "sMaster:\nsDetails:\nsFields:")
   (setq fields-list (split-string fields " "))
   (insert "\n")
   (save-excursion
     (insert "<% if @controller.action_name == \"show\" -%>\n  <% fields_for_associated :" master ", " detail" do |t_form| %>\n  <tr class=\"" detail "\">")
     (slimcnror-insert-field-from-list-td fields-list ", index => nil, 'disabled' => 'true'")
     (insert "\n  </tr>\n  <% end %>\n<% else %>\n  <% fields_for_associated :" master ", " detail " do |t_form| %>\n  <tr class=\"" detail "\">")
     (slimcnror-insert-field-from-list-td fields-list ", index => nil")
     (insert "\n  </tr>\n  <% end %>\n<% end %>\n")))

(defun slimcnror-insert-field-from-list-td (field-list a-string)
  "插入表格单元格：\n    <td><%= t_form.text_field :fieldName String %></td>"
  (interactive "sList:\nsString:")
  (setq tmp-list field-list)
  (while tmp-list
    (setq field (car tmp-list))
    (insert "\n    <td><%= t_form.text_field :" field  a-string" %></td>")
    (setq tmp-list (cdr tmp-list))))

(defun slimcnror-insert-controller-init (master edit-form-type)
   "插入对象初始化设置：对象name/编辑模式/字段列表/细表字段列表"
   (interactive "sName:\nsEdit Type (multi_model or jqgrid_form):jqgrid_form")
   (let (var1)
     (insert "\n")
     (save-excursion
       (insert "  before_filter :init_sheet")
       (insert "\n\n  def init_sheet\n    @sheet_options = {'name' => '" master "',\n                      'edit_form_type' => '" edit-form-type "' # multi_model:主细表窗体；jqgrid_form：jqgrid默认窗体\n                      }")
       (insert "\n   @sheet_fields = [{ :field => '', :width => 80, :editable => true },\n                    { :field => '', :width => 80, :editable => true },\n                    { :field => 'remarks', :type => 'text_area', :rows => 2, :cols => 20, :editable => ture },\n                    ]")
       (insert "\n   @sheet_detail_fields = [{ :field => '" master "_id', :width => 60, :editable => true },\n                    { :field => '', :width => 60, :editable => true },\n                    ]")
       (insert "\n  end\n\n  def post_data\n    # 此处可加入必要的数据校验\n    super\n  end\n\n")
       )))

(defun slimcnror-insert-index (master)
  "index文件内容"
  (interactive "sMaster:")
  (let ()
    (insert "<h1><%= t('Listing'.downcase) %>: <%= t('activerecord.models.'+'" master "') %></h1>\n\n<%= jqgrid_index(@sheet_fields) %>")))

(defun slimcnror-insert-form (master masters detail details form-type)
  "new文件内容"
  (interactive "sMaster:\nsMasters:\nsDetail:\nsDetails:\nsFormType(new edit show index):")
  (let (operate links)
    (setq operate (if (string= "new" form-type)
                      "Adding"
                    (if (string= "edit" form-type)
                        "Editing"
                      (if (string= "show" form-type)
                          "Showing"
                        (if (string= "index" form-type)
                            "Listing")))))
    (setq links (if (string= "new" form-type)
                      "back"
                    (if (string= "edit" form-type)
                        "show back"
                      (if (string= "show" form-type)
                          "edit back"
                        (if (string= "index" form-type)
                            "add")))))
    (save-excursion
      (slimcnror-insert-form-title master operate)
      (slimcnror-insert-form_for master detail details)
      (slimcnror-insert-form-end-link master masters link))))

(defun slimcnror-insert-form-title (master form-type)
  "标题"
  (interactive "sMaster:\nsForm Type(Adding Edit):")
  (let (var1)
    (setq var1 1)
    (insert "<h1><%= t('" form-type "'.downcase) %>: <%= t('activerecord.models.'+'" master "') %></h1>\n")))

(defun slimcnror-insert-form-end-link (master masters links)
  "编辑界面导航链接"
  (interactive "sMasters:\nsLinks(back、edit back、show back):")
  (let (link-list)
    (setq link-list (split-string links " "))
    (insert "\n")
    (while link-list
      (setq link (car link-list))
      (if (string= (downcase link) "back")
          (insert "| <%= link_to t('Back'.downcase), " masters "_path %>")
        (if (string= (downcase link) "show")
            (insert "| <%= link_to t('Show'.downcase), @" master " %>")
          (if (string= (downcase link) "edit")
              (insert "| <%= link_to t('Edit'.downcase), edit_" master "_path %>"))))
      (setq link-list (cdr link-list)))))

(defun slimcnror-insert-form_for (master detail details)
  "标题"
  (interactive "sMaster:\nsDetail:\nsDetails:")
  (let (var1)
    (setq var1 1)
    (insert "\n<% tagged_form_for(@" master ") do |f| %>\n  <%= f.error_messages %>\n")
    (insert "  <%= fields_table_form(f, @sheet_fields, 2, 300) %>\n")
    (if (not (string= "nil" detail))
        (slimcnror-add-detail master detail details))
    (insert "\n  <p>\n    <%= f.submit t('Update'.downcase) %>\n  </p>\n<% end %>\n")))

(defun slimcnror-model-master (details)
  "插入主表关系"
  (interactive "sDetails:")
  (insert "\n")
  (save-excursion
    (insert "  has_many :" details ", :dependent => :destroy\n")
    (insert "  has_many_with_attributes :" details ", :dependent => :destroy\n")))

(defun slimcnror-model-detail (master)
  "插入细表关系"
  (interactive "sMaster:")
  (insert "\n")
  (save-excursion
    (insert "  belongs_to :" master "\n")))

(defun slimcnror-i18n-yml (str tran)
  "插入翻译项"
  (interactive "sStr:\nsTran:")
  (move-end-of-line 1)
  (newline-and-indent)
  (insert str ": \"" tran "\""))

(defun slimcnror-multimodel-fieldset (master detail details)
  "multimodel_form 中fieldset内容"
  (interactive "sMaster:\nsDetail:\nsDetails:")
  (save-excursion
    (insert "\n")
    (insert "  <fieldset>\n")
    (insert "    <legend><%= t('details') %></legend>\n")
    (insert "    <%= error_messages_for :" detail " %>\n")
    (insert "    <table id='" details "'>\n")
    (insert "      <tr align='center'>\n")
    (insert "        <%= fields_table_head({'name' => '" master "." detail "'}, @sheet_detail_fields) %>\n")
    (insert "      </tr>\n")
    (insert "      <%= render :partial => '" details "/" detail ", :collection => @" master "." details " %>\n")
    (insert "    </table>\n")
    (insert "    <%= add_link t('add'.downcase), :" detail " %>\n")
    (insert "  </fieldset>\n")))

(defun slimcnror-multimodel-detail (master detail)
  "multimodel_form 中_details内容"
  (interactive "sMaster:\nsDetail:")
  (insert "<% if @controller.action_name == 'show' -%>\n")
  (insert "  <% fields_for_associated :" master ", " detail " do |t_form| %>\n")
  (insert "  <tr class='" detail "'>\n")
  (insert "    <td><%= t_form.select :_id,Menu.all.collect {|p| [ p.code+p.name, p.id ] }, {:include_blank=>true,:index => ''},{:index => '', 'disabled' => 'true'}%></td>\n")
  (insert "    <td><%= t_form.text_field :commodity_name, :index => nil, 'disabled' => 'true' %></td>\n")
  (insert "  </tr>\n")
  (insert "  <% end %>\n")
  (insert "<% else %>\n")
  (insert "  <% fields_for_associated :" master ", " detail " do |t_form| %>\n")
  (insert "  <tr class='" detail "'>\n")
  (insert "    <td><%= t_form.select :_id,Menu.all.collect {|p| [ p.code+p.name, p.id ] }, {:include_blank=>true,:index => ''},{:index => ''}%></td>\n")
  (insert "    <td><%= t_form.text_field :commodity_name, :index => nil %></td>\n")
  (insert "    <td><%= delete_link_for(" detail ", t('delete'), t_form) %></td>\n")
  (insert "  </tr>\n")
  (insert "  <% end %>\n")
  (insert "<% end %>\n"))
