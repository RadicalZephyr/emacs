(defun get-window-props (window)
  (cons (window-start window) (cons (window-buffer window) '())))
(get-window-props (first (window-list)))

(defun set-window-props (window window-props)
  (set-window-start window (first window-props))
  (set-window-buffer window (second window-props)))

(defun rot-helper (list num)
  (let ((front (nthcdr num list)))
    (setcdr (nthcdr (- num 1) list)
            nil)
    (append front list)))

(defun rotate-list (list num)
  (cond ((nlistp list) '())
        ((or (not (integerp num))
             (zerop num)
             (= 0 (mod (abs num) (length list)))) list)
        (t
         (if (> (abs num) (length list))
             (setq num (- num (length list))))
         (cond ((> num 0) (rot-helper list num))
               ((< num 0) (rot-helper list
                                      (+ (length list)
                                         num)))))))
