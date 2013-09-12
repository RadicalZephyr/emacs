(require 'color-theme)
(color-theme-initialize)
(defun color-theme-ezephyr-dark ()
  "dark color theme created by ezephyr, Oct 2010"

  (interactive)
  (color-theme-install
   '(color-theme-ezephyr-dark
       ((foreground-color . "#b9d3cf")
         (background-color . "#282828")
         (background-mode . dark))
       (bold ((t (:bold t))))
       (bold-italic ((t (:italic t :bold t))))
       (default ((t (nil))))

       (font-lock-builtin-face ((t (:foreground "#0c7deb"))))
       (font-lock-comment-face ((t (:italic t :foreground "#c08a20"))))
       (font-lock-comment-delimiter-face ((t (:foreground "#ed0212"))))
       (font-lock-constant-face ((t (:bold t :foreground "#729fd0"))))
       (font-lock-doc-string-face ((t (:foreground "#c08a20"))))
       (font-lock-doc-face ((t (:foreground "grey"))))
       (font-lock-reference-face ((t (:foreground "white"))))
       (font-lock-function-name-face ((t (:bold t :foreground "#458db0"))))
       (font-lock-keyword-face ((t (:bold t :foreground "#ef1322"))))
       (font-lock-preprocessor-face ((t (:foreground "#e3ea94"))))
       (font-lock-string-face ((t (:foreground "#aca000"))))
       (font-lock-type-face ((t (:bold t :foreground "#77608c"))))
       (font-lock-variable-name-face ((t (:bold t :foreground "#ffffff"))))
       (font-lock-warning-face ((t (:bold t :italic nil :underline nil
                                     :foreground "yellow"))))
       (hl-line ((t (:background "#112233"))))
       (mode-line ((t (:foreground "#ffffff" :background "#293433"))))
       (minibuffer ((t (:bold t :foreground "#8b0000" :background "#e2cb36"))))
       (minibuffer-prompt ((t (:foreground "#006600"))))
       (region ((t (:foreground nil :background "#555555"))))
       (show-paren-match-face ((t (:bold t :foreground "#ffffff"
                                    :background "#050505")))))))
(provide 'ezephyr-dark)
