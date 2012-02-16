
;;; 将子文件加入list
(defun add-to-list-with-subdirs (base exclude-list include-list)
  (dolist (f (directory-files base))
    (let ((name (concat base "/" f)))
      (when (and (file-directory-p name)
                 (not (member f exclude-list)))
        (add-to-list 'load-path name)
        (when (member f include-list)
          (add-to-list-with-subdirs name exclude-list include-list)))))
  (add-to-list 'load-path base))

;;;获得当前目录下某类型的文件列表
;;;  (dir-files "/media/data/home/self/ft" ".*\.org") ; 获取直接目录下所有org文件
(defun dir-files (base match-regexp)
  (setq file-list '())
  (dolist (f (directory-files base nil match-regexp))
    (let ((name (concat base "/" f)))
      (add-to-list 'file-list name)
      ))
  file-list)

;;; TODO 获得当前目录及子目录下某类型的文件列表
;;;  (dir-files "/media/data/home/self" ".*org") ; 获取直接目录下所有org文件
(defun TODO-subdir-files (base match-regexp)
  (setq file-list '())
  (dolist (f (directory-files base nil match-regexp))
    (let ((name (concat base "/" f)))
      (when (file-directory-p name)
        ()
        ())

      (add-to-list 'file-list name)
      ))
  file-list)


