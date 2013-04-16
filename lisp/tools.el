;;; Use "%" to jump to the matching parenthesis.
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis AND last command is a movement command, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (message "%s" last-command)
  (if (not (memq last-command '(
                                set-mark
                                cua-set-mark
                                goto-match-paren
                                down-list
                                up-list
                                end-of-defun
                                beginning-of-defun
                                backward-sexp
                                forward-sexp
                                backward-up-list
                                forward-paragraph
                                backward-paragraph
                                end-of-buffer
                                beginning-of-buffer
                                backward-word
                                forward-word
                                mwheel-scroll
                                backward-word
                                forward-word
                                mouse-start-secondary
                                mouse-yank-secondary
                                mouse-secondary-save-then-kill
                                move-end-of-line
                                move-beginning-of-line
                                backward-char
                                forward-char
                                scroll-up
                                scroll-down
                                scroll-left
                                scroll-right
                                mouse-set-point
                                next-buffer
                                previous-buffer
                                )
                 ))
      (self-insert-command (or arg 1))
    (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
          ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
          (t (self-insert-command (or arg 1))))))
;; (defun goto-match-paren (arg)
;;   "Go to the matching parenthesis if on parenthesis, otherwise insert
;; the character typed."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;;     ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;     (t                    (self-insert-command (or arg 1))) ))

;; someday might want to rotate windows if more than 2 of them
(defun swap-windows ()
  "If you have 2 windows, it swaps them."
  (interactive)
  (cond ((not (= (count-windows) 2))
   (message "You need exactly 2 windows to do this."))
  (t (let* ((w1 (first (window-list)))
              (w2 (second (window-list)))
              (b1 (window-buffer w1))
              (b2 (window-buffer w2))
              (s1 (window-start w1))
              (s2 (window-start w2)))
       (set-window-buffer w1 b2)
       (set-window-buffer w2 b1)
       (set-window-start w1 s2)
       (set-window-start w2 s1))))
         (other-window 1))

(defun rotate-windows ()
  "If you have more than two windows, rotate them clockwise."
  (interactive)
  (cond ((= (count-windows) 1)
         (message "You need more than one window to do this."))
;        ((= (count-windows) 2)
;         (swap-windows))
        (t (switch-to-buffer (window-buffer
                   (car (last (window-list)))))
           (dotimes (n (- (length (window-list)) 1) nil)
             (other-window 1)
             (switch-to-buffer nil))
           (if (> 2 (count-windows))
              (other-window -1)))))

;; Never understood why Emacs doesn't have this function.
;;
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME." (interactive "sNew name: ")
  (let ((name (buffer-name))
  (filename (buffer-file-name)))
    (if (not filename)
  (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
    (message "A buffer named '%s' already exists!" new-name)
  (progn 	 (rename-file name new-name 1)
     (rename-buffer new-name)
     (set-visited-file-name new-name)
     (set-buffer-modified-p nil))))))

;; Never understood why Emacs doesn't have this function, either.
;;
(defun move-buffer-file (dir)
  "Moves both current buffer and file it's visiting to DIR." (interactive "DNew directory: ")
 (let* ((name (buffer-name))
  (filename (buffer-file-name))
  (dir
    (if (string-match dir "\\(?:/\\|\\\\)$")
       (substring dir 0 -1) dir))
   (newname (concat dir "/" name)))

   (if (not filename)
     (message "Buffer '%s' is not visiting a file!" name)
 (progn (copy-file filename newname 1) (delete-file
          filename)
  (set-visited-file-name newname) (set-buffer-modified-p
           nil) t))))

(defun print-to-pdf ()
  (interactive)
  (ps-spool-buffer-with-faces)
  (switch-to-buffer "*PostScript*")
  (write-file "/tmp/tmp.ps")
  (kill-buffer "tmp.ps")
  (setq cmd (concat "ps2pdf14 /tmp/tmp.ps " (buffer-name) ".pdf"))
  (shell-command cmd)
  (shell-command "rm /tmp/tmp.ps")
  (message (concat "Saved to:  " (buffer-name) ".pdf")))

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
  (fill-paragraph nil)))

(defun increment-number-at-point ()
      (interactive)
      (skip-chars-backward "0123456789")
      (or (looking-at "[0123456789]+")
          (error "No number at point"))
      (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))

(defun msh-add-builtin (name)
  (interactive "sEnter builtin name: \n")
  (save-excursion
    (goto-char (point-min))
    (let* ((template (concat "int " name "(int argc, char **argv, FILE *std[3])"))
           (structstr (concat ",\n    {&" name ", \"" name "\"}"))
           (countpos (search-forward "BUILTIN_COUNT "))
           (protopos (search-forward "/* end builtin's */"))
           (structpos (- (search-forward "} };") 3)))
      (progn
        (goto-char structpos)
        (insert structstr))
      (progn
        (goto-char protopos)
        (move-beginning-of-line 1)
        (insert template ";\n"))
      (progn
        (goto-char countpos)
        (increment-number-at-point))
      (progn
        (goto-char (point-max))
        (insert "\n" template " {\n\n  return 0;\n}")))))

(provide 'ezephyr-lisp-tools)
