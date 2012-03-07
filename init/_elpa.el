(require 'package)

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))


(setq package-archives (cons '("tromey" . "http://tromey.com/elpa/") package-archives))
(package-initialize)

(add-to-list 'load-path (concat default-path-package "el-get"))
(require 'el-get)

;;; package set
;(load-file (concat default-path-init "_ror24.el"))

;;;
(el-get 'sync)
