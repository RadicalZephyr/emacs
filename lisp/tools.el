;;; Use "%" to jump to the matching parenthesis.
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis, otherwise insert
the character typed."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t                    (self-insert-command (or arg 1))) ))

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
	     (set-window-start w2 s1)))))


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