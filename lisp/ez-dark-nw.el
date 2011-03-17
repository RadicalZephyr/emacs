(require 'color-theme)
(color-theme-initialize)
(defun color-theme-ez-dark-nw ()
  "dark color theme created by ezephyr, Oct 2010"

  (interactive)
  (color-theme-install
   '(color-theme-ez-dark
       ((foreground-color . "white")
         (background-color . "black") 
         (background-mode . dark))
       (bold ((t (:bold t))))
       (bold-italic ((t (:italic t :bold t))))
       (default ((t (nil))))
       
       (font-lock-builtin-face ((t (:italic t :foreground "green"))))
       (font-lock-comment-face ((t (:italic t :foreground "#ff6767"))))
       (font-lock-comment-delimiter-face ((t (:foreground "#ff4545"))))
       (font-lock-constant-face ((t (:bold t :foreground "#0003bd"))))
       (font-lock-doc-string-face ((t (:foreground "#3041c4"))))
       (font-lock-doc-face ((t (:foreground "gray"))))
       (font-lock-reference-face ((t (:foreground "#04b6f4"))))
       (font-lock-function-name-face ((t (:bold t :foreground "#356da0"))))
       (font-lock-keyword-face ((t (:foreground "red"))))
       (font-lock-preprocessor-face ((t (:foreground "purple"))))
       (font-lock-string-face ((t (:foreground "yellow"))))
       (font-lock-type-face ((t (:bold t :foreground "purple"))))
       (font-lock-variable-name-face ((t (:bold :foreground "#7685de"))))
       (font-lock-warning-face ((t (:bold t :italic nil :underline nil 
                                     :foreground "yellow"))))
       (hl-line ((t (:background "yellow"))))
       (mode-line ((t (:foreground "black" :background "#04b6f4"))))
       (region ((t (:foreground "white" :background "green"))))
       (show-paren-match-face ((t (:bold t :foreground "blue" 
                                    :background "white")))))))
(color-theme-ez-dark-nw)