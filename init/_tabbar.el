(load-file (concat default-path-package "tabbar.el"))

(require 'tabbar)
(tabbar-mode)
(global-set-key [M-up] 'tabbar-backward-group)
(global-set-key [M-down] 'tabbar-forward-group)
(global-set-key [M-left] 'tabbar-backward)
(global-set-key [M-right] 'tabbar-forward)


;;; Tabbar Faces
;;
(custom-set-faces
'(tabbar-default-face
  ((t(:inherit variable-pitch :height 0.8 :foreground "black" :background
"lightgrey" )))
  "Default face used in the tab bar."
  :group 'tabbar)

'(tabbar-unselected-face
  ((t(:inherit tabbar-default-face )))
  "Face used for uselected tabs."
  :group 'tabbar)

'(tabbar-selected-face
  ((t(:inherit tabbar-default-face :box (:line-width 1 :color "lightyellow"
:style pressed-button) :foreground "blue")))
  "Face used for the selected tab."
  :group 'tabbar)


'(tabbar-separator-face
  ((t(:inherit tabbar-default-face :height 0.2)))
  "Face used for the select mode button."
  :group 'tabbar)

'(tabbar-button-face
  ((t(:inherit tabbar-default-face :box (:line-width 1 :color "white" :style
released-button) :foreground "dark red")))
  "Face used for the select mode button."
  :group 'tabbar)
)

;
;(setq tabbar-buffer-groups-function
;    (lambda (b) (list "All Buffers")))
;; ignore groups, max group=2
(setq tabbar-buffer-groups-function 'tabbar-buffer-ignore-groups)
(defun tabbar-buffer-ignore-groups (buffer)
"Return the list of group names BUFFER belongs to.
Return only one group for each buffer."
(with-current-buffer (get-buffer buffer)
(cond
((or (get-buffer-process (current-buffer))
(memq major-mode
'(comint-mode compilation-mode)))
'("Process")
)
((member (buffer-name)
'("*scratch*" "*Messages*"))
'("Common")
)
((eq major-mode 'dired-mode)
'("Dired")
)
((memq major-mode
'(help-mode apropos-mode Info-mode Man-mode))
'("Help")
)
((memq major-mode
'(rmail-mode
rmail-edit-mode vm-summary-mode vm-mode mail-mode
mh-letter-mode mh-show-mode mh-folder-mode
gnus-summary-mode message-mode gnus-group-mode
gnus-article-mode score-mode gnus-browse-killed-mode))
'("Mail")
)
(t
(list
"default" ;; no-grouping
(if (and (stringp mode-name) (string-match "[^ ]" mode-name))
mode-name
(symbol-name major-mode)))
)
)))


(setq tabbar-buffer-list-function
    (lambda ()
        (remove-if
          (lambda(buffer)
             (find (aref (buffer-name buffer) 0) " *"))
          (buffer-list))))

; (setq tabbar-buffer-groups-function 'tabbar-buffer-ignore-groups)
;
; (defun tabbar-buffer-ignore-groups (buffer)
;   "Return the list of group names BUFFER belongs to.
; Return only one group for each buffer."
;   (with-current-buffer (get-buffer buffer)
;     (cond
;      ((or (get-buffer-process (current-buffer))
;           (memq major-mode
;                 '(comint-mode compilation-mode)))
;       '("Process")
;       )
;      ((member (buffer-name)
;               '("*scratch*" "*Messages*"))
;       '("Common")
;       )
;      ((eq major-mode 'dired-mode)
;       '("Dired")
;       )
;      ((memq major-mode
;             '(help-mode apropos-mode Info-mode Man-mode))
;       '("Help")
;       )
;      ((memq major-mode
;             '(rmail-mode
;               rmail-edit-mode vm-summary-mode vm-mode mail-mode
;               mh-letter-mode mh-show-mode mh-folder-mode
;               gnus-summary-mode message-mode gnus-group-mode
;               gnus-article-mode score-mode gnus-browse-killed-mode))
;       '("Mail")
;       )
;      (t
;       (list
;        "default"  ;; no-grouping
;        (if (and (stringp mode-name) (string-match "[^ ]" mode-name))
;            mode-name
;          (symbol-name major-mode)))
;       )
;
;      )))

;;;; 设置tabbar外观
;; 设置默认主题: 字体, 背景和前景颜色，大小
(set-face-attribute 'tabbar-default nil
                    :family "Vera Sans YuanTi Mono"
                    :background "gray80"
                    :foreground "gray30"
                    :height 1.0
                    )
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "gray30")
                    )
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "DarkGreen"
                    :background "LightGoldenrod"
                    :box '(:line-width 2 :color "DarkGoldenrod")
                    ;; :overline "black"
                    ;; :underline "black"
                    :weight 'bold
                    )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    :box '(:line-width 2 :color "gray70")
                    )
