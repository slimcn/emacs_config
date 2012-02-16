;;; https://github.com/purcell/mmm-mode

(add-to-list 'load-path (concat default-path-package "mmm-mode"))

(require 'mmm-mode)


(setq mmm-global-mode 'maybe)
(mmm-add-classes
  '(
    (js-ruby
     :submode javascript-mode
     :front "<script[^.>]*>"
     :back "</script>")))
(mmm-add-classes
  '(
    (css-ruby
     :submode css-mode
     :front "<style"
     :back "</style>")))

(add-to-list 'auto-mode-alist '("\\.html.erb$" . mmm-mode) '("\\.rhtml" . mmm-mode))

(mmm-add-mode-ext-class nil "\\.erb$" 'js-ruby)
(mmm-add-mode-ext-class nil "\\.erb$" 'css-ruby)

(set-face-background 'mmm-default-submode-face nil)
