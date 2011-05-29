(global-set-key "%" 'goto-match-paren)
(global-set-key "\C-x\C-b" 'switch-to-buffer)
(global-set-key "\C-x\C-o" 'other-window)

(global-set-key "\C-cw" 'what-face)

;; Probably shouldn't be here, but what the hell
(global-set-key "\C-c\C-l" 'edebug-defun)

(global-set-key [kp-subtract] 'undo)
(global-set-key [insert]    'overwrite-mode)
(global-set-key [kp-insert] 'overwrite-mode)

(global-set-key "\M-n" 'goto-line)

(global-set-key "\C-c\C-c" 'comment-or-uncomment-region)

(global-set-key [f12] 'man)

;; Swap regex-isearch and isearch
(global-set-key "\C-r" 'isearch-backward-regexp)
(global-set-key "\C-s" 'isearch-forward-regexp)

(global-set-key "\C-\M-r" 'isearch-backward-regexp)
(global-set-key "\C-\M-s" 'isearch-forward-regexp)

;; Swap line upwards
(global-set-key "\C-xt" (lambda ()
                           (interactive)
                           (transpose-lines -1)))
