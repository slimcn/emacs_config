(add-hook 'python-mode-hook 'my-python-hook)

(defun py-outline-level ()
"This is so that `current-column` DTRT in otherwise-hidden text"
;; from ada-mode.el
(let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "\t ")
      (current-column))))

; this fragment originally came from the web somewhere, but the outline-regexp
; was horribly broken and is broken in all instances of this code floating
; around. Finally fixed by Charl P. Botha <<a href="http://cpbotha.net/">http://cpbotha.net/</a>>
(defun my-python-hook ()
  (setq outline-regexp "[^ \t\n]\\|[ \t]*\\(def[ \t]+\\|class[ \t]+\\)")
; enable our level computation
  (setq outline-level 'py-outline-level)
; do not use their \C-c@ prefix, too hard to type. Note this overides
;some python mode bindings
  (setq outline-minor-mode-prefix "\C-c")
; turn on outline mode
  (outline-minor-mode t)
; initially hide all but the headers
  (hide-body)
  (show-paren-mode 1))
