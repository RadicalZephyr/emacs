(defun latex-insert-matrix (rows cols left right)
  "Insert a matrix in latex array format, prompting for values"
  (interactive "nRows: \nnColumns: \ncLeft delim: \ncRight delim: \n")
  (let ((rowc rows)
        (colc cols))
    (insert "\\left" left "\\begin{array}{")
    (while (> colc 0)
      (setq colc (1- colc))
      (insert "c"))
    (insert "}\n")
    (while (> rowc 0)
      (setq colc cols)
      (setq rowc (1- rowc))
      (while (> colc 1)
        (setq colc (1- colc))
        (insert (read-from-minibuffer "Next entry: ")
                " & "))
      (insert (read-from-minibuffer "Next entry: ")
              " \\\\\n"))
    (insert "\\end{array}\\right" right)))

(add-hook 'LaTeX-mode-hook (lambda ()
                             (local-set-key 
                              "\C-c\C-m" 
                              'latex-insert-matrix)))
