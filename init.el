(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(ecb-options-version "2.40")
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(iswitchb-mode t)
 '(nxml-child-indent 2)
 '(rng-schema-locating-files (quote ("schemas.xml" "/usr/share/emacs/24.1.50/etc/schema/schemas.xml" "~/.emacs.d/xml/schemas.xml")))
 '(safe-local-variable-values (quote ((Syntax . ANSI-Common-Lisp) (Base . 10))))
 '(save-place t nil (saveplace))
 '(show-paren-mode t nil (paren))
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(transient-mark-mode (quote identity)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'cl)

(defvar emacs-root
  (cond ((file-accessible-directory-p "/home/shannog/.emacs.d/") "/home/shannog/.emacs.d/")
        ((file-accessible-directory-p "c:/cygwin/home/geoff/.emacs.d/") "c:/cygwin/home/geoff/.emacs.d/")
        ((file-accessible-directory-p "/Users/geoff/.emacs.d/") "/Users/geoff/.emacs.d/")
        (t "/home/geoff/.emacs.d/")) "My home directory.")

(labels ((add-path-list (list-to-add)
                        (cond ((null list-to-add) t)
                              (t (add-to-list 'load-path
                          (concat emacs-root (car list-to-add)))
                 (add-path-list (cdr list-to-add)))))
         (add-auto-mode-list (list-to-add)
                             (cond ((null list-to-add) t)
                                   (t (add-to-list 'auto-mode-alist
                           (car list-to-add))
                      (add-auto-mode-list (cdr list-to-add))))))
  (add-path-list '("elpa/"
                   "el-get/el-get"
                   "lisp/"
                   "color-theme/"
                   "auto-complete/"
                   "python-mode.el-6.0.4/"
                   "ecb-2.4.1/"
                   "jdee-2.4.0.1/lisp/"
                   "jdibug/"))
  (add-auto-mode-list '(("\\.erl?$" . erlang-mode)
                        ("\\.hrl?$" . erlang-mode)
                        ("\\.php?$" . php-mode))))

;;(require 'ezephyr-indentation "indentation.el")
(require 'ezephyr-keys "keys.el")
(require 'ezephyr-lisp-tools "tools.el")
(require 'ezephyr-latex-tools "latex-tools.el")

(require 'ezephyr-dark-theme "ez-dark.el")
(require 'ezephyr-dark-theme-nw "ez-dark-nw.el")

;; Bootstrap elpa and el-get, now we can call (el-get 'sync ...)
(require 'elpa-bootstrap)

(setq el-get-user-package-directory
      (concat emacs-root "recipes/"))

(setq my-el-get-packages
      (append
       '(paredit ws-trim
         autopair magit
         slime slime-repl
         smart-tab clojure-mode
         clojure-test-mode clojurescript-mode
         php-mode php-completion
         flymake-php)
       (mapcar 'el-get-source-name el-get-sources)))

(el-get 'sync my-el-get-packages)

(load-file (concat emacs-root "macros/tools.macs"))

(setq-default indent-tabs-mode nil)

;; Mac specific changes
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq special-display-regexps (remove "[ ]?\\*[hH]elp.*" special-display-regexps)))

;; CEDET
;;(load-file (concat emacs-root "cedet-1.1/common/cedet.el"))

;; JDEE
;; (require 'jde)
;; (defun screen-width nil -1)
;; (define-obsolete-function-alias 'make-local-hook 'ignore "21.1")

;; JDIBUG
;;(require 'jdibug)

;; ECB
;;(require 'ecb)

;; Setup template mode
(require 'template)
(template-initialize)
(setq template-default-directories (cons (concat emacs-root "templates/") template-default-directories))

;; Setup python-mode
(setq py-install-directory (concat emacs-root "python-mode.el-6.0.4/"))
(require 'python-mode)

;; Setup auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat emacs-root "auto-complete/ac-dict"))
(ac-config-default)

(setq completion-ignored-extensions
      (append '(".ali" ".exe" ".beam") completion-ignored-extensions))

;; Make system copy interact with emacs kill ring
(setq x-select-enable-clipboard t)

;; Daemon/server setup
(server-start)
(desktop-save-mode 1)
(require 'midnight)
(midnight-delay-set 'midnight-delay "6:30am")

;; Visual Modifications

(setq default-tab-width 4)

(setq x-stretch-cursor t)
(set-face-attribute 'default nil :height 150)

(column-number-mode)

(global-linum-mode)

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(setq visible-bell t)

(if window-system
    (color-theme-ez-dark)
  (color-theme-ez-dark-nw))


;; More functional mods

(require 'cc-mode)

(defun flymake-next-error ()
  (interactive)
  (if (ignore-errors (next-error)) t
    (flymake-goto-next-error)))

(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(define-key c-mode-base-map (kbd "C-x `") 'flymake-next-error)

;; flymake setups
(when (not (boundp 'flymake-buildfile-dirs))
  (setq flymake-buildfile-dirs '()))

(setq flymake-buildfile-dirs
 (append '("build") flymake-buildfile-dirs))

(require 'erlang)
(require 'flymake-cursor)
(require 'face-list)
(require 'flymake-ecj)

(set-default 'ws-trim-level 3)
(global-ws-trim-mode t)

;; (load "slime.el")

;; (slime-setup '(slime-repl))

;; (when
;;     (load "slime.el")
;;   (slime-setup '(slime-repl))
;;   (setq inferior-lisp-program "sbcl")
;;   (ansi-color-for-comint-mode-on))

(put 'narrow-to-region 'disabled nil)

(ansi-color-for-comint-mode-on)

(setq default-tab-width 2)
