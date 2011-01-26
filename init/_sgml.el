

;; folding for sgml-mode
(add-hook 'sgml-mode-hook
          '(lambda()
             (hs-minor-mode 1)))
(add-to-list 'hs-special-modes-alist
             '(sgml-mode
               "<!--\\|<[^/>]>\\|<[^/][^>]*[^/]>"
               ""
               "<!--"
               sgml-skip-tag-forward
               nil))
