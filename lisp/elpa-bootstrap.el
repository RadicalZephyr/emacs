;; Bootstrap package.el if not installed
; derived from ELPA installation
; http://tromey.com/elpa/install.html
(defun eval-url (url)
  (let ((buffer (url-retrieve-synchronously url)))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (re-search-forward "^$" nil 'move)
      (eval-region (point) (point-max))
      (kill-buffer (current-buffer)))))

(defun install-elpa ()
  (eval-url "http://tromey.com/elpa/package-install.el"))

(defun install-el-get ()
  (eval-url
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"))

(if (require 'package nil t)
    (progn
      ;; Emacs 24+ includes ELPA, but requires some extra setup
      ;; to use the (better) tromey repo
      (if (>= emacs-major-version 24)
          (setq package-archives
                (append '(("marmalade" .
                           "http://marmalade-repo.org/packages/")
                          ("tromey" .
                           "http://tromey.com/elpa/"))
                        package-archives)))
      (package-initialize))
  (install-elpa))

(unless (require 'el-get nil t)
  (install-el-get))

(provide 'elpa-bootstrap)
