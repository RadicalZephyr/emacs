(deftheme radical-zephyr
  "Created 2014-04-12.")

(custom-theme-set-variables
 'radical-zephyr
 '(case-fold-search t)
 '(custom-safe-themes (quote ("8eef22cd6c122530722104b7c82bc8cdbb690a4ccdd95c5ceec4f3efa5d654f5" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(inhibit-startup-screen t)
 '(iswitchb-buffer-ignore (quote ("^ ")))
 '(nxml-child-indent 2)
 '(ruby-indent-level 2)
 '(semantic-default-submodes (quote (global-semantic-decoration-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-local-symbol-highlight-mode)))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(save-place t)
 '(global-font-lock-mode t)
 '(iswitchb-mode t)
 '(show-paren-mode t)
 '(transient-mark-mode (quote identity)))

(custom-theme-set-faces
 'radical-zephyr
 '(mode-line ((t (:background "dim gray" :foreground "#ffffff"))))
 '(minibuffer-prompt ((t (:background "#293433" :foreground "#006600"))))
 '(region ((t (:foreground nil :background "#555555"))))
 '(show-paren-match ((t (:bold t :foreground "#ffffff" :background "#050505"))))
 '(font-lock-builtin-face ((t (:foreground "#0c7deb"))))
 '(font-lock-comment-face ((t (:slant italic :foreground "#c08a20"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#ed0212"))))
 '(font-lock-constant-face ((t (:weight bold :foreground "#729fd0"))))
 '(font-lock-doc-face ((t (:foreground "#c08a20"))))
 '(font-lock-function-name-face ((t (:bold t :foreground "#458db0"))))
 '(font-lock-keyword-face ((t (:bold t :foreground "#ef1322"))))
 '(font-lock-preprocessor-face ((t (:foreground "#e3ea94"))))
 '(font-lock-string-face ((t (:foreground "#aca000"))))
 '(font-lock-type-face ((t (:bold t :foreground "#77608c"))))
 '(font-lock-variable-name-face ((t (:bold t :foreground "#ffffff"))))
 '(font-lock-warning-face ((t (:bold t :italic nil :underline nil :foreground "yellow"))))
 '(default ((t (:foreground "#b9d3cf" :background "#282828")))))

(provide-theme 'radical-zephyr)
