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
       (font-lock-comment-face ((t (:italic t :foreground "yellow"))))
       (font-lock-comment-delimiter-face ((t (:bold t :foreground "yellow"))))
       (font-lock-constant-face ((t (:bold t :foreground "red"))))
       (font-lock-doc-string-face ((t (:foreground "gray"))))
       (font-lock-doc-face ((t (:foreground "gray"))))
       (font-lock-reference-face ((t (:foreground "#04b6f4"))))
       (font-lock-function-name-face ((t (:bold t :foreground "green"))))
       (font-lock-keyword-face ((t (:foreground "red"))))
       (font-lock-preprocessor-face ((t (:foreground "purple"))))
       (font-lock-string-face ((t (:foreground "yellow"))))
       (font-lock-type-face ((t (:bold t :foreground "purple"))))
       (font-lock-variable-name-face ((t (:bold :foreground "cyan"))))
       (font-lock-warning-face ((t (:bold t :italic nil :underline nil 
                                     :foreground "yellow"))))
       (hl-line ((t (:background "yellow"))))
       (mode-line ((t (:foreground "white" :background "blue"))))
       (region ((t (:foreground "white" :background "magenta"))))
       (show-paren-match-face ((t (:bold t :foreground "blue" 
                                    :background "white")))))))
;; (color-theme-ez-dark-nw)