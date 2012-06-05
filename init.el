(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(iswitchb-mode t)
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
  (cond ((file-accessible-directory-p "/home/shannog/") "/home/shannog/")
        ((file-accessible-directory-p "c:/cygwin/home/geoff/") "c:/cygwin/home/geoff/")
        ((file-accessible-directory-p "/Users/geoff/") "/Users/geoff/")
        (t "/home/geoff/")) "My home directory.")

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
  (add-path-list '(".emacs.d/elpa/"
                   ".emacs.d/lisp/"
                   ".emacs.d/color-theme/"
                   ".emacs.d/auto-complete"
                   ".emacs.d/python-mode.el-6.0.4/"
                   ".emacs.d/cedet-1.1/common/"
                   ".emacs.d/ecb-2.40/"
                   ".emacs.d/jdee-2.4.0.1/lisp"))
  (add-auto-mode-list '(("\\.erl?$" . erlang-mode)
                        ("\\.hrl?$" . erlang-mode)
                        ("\\.php?$" . php-mode))))
(require 'ezephyr-keys "keys.el")
(require 'ezephyr-lisp-tools "tools.el")
(require 'ezephyr-latex-tools "latex-tools.el")

(require 'ezephyr-dark-theme "ez-dark.el")
(require 'ezephyr-dark-theme-nw "ez-dark-nw.el")

(load-file "~/.emacs.d/macros/tools.macs")

(setq-default indent-tabs-mode nil)

;; Mac specific changes
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq special-display-regexps (remove "[ ]?\\*[hH]elp.*" special-display-regexps)))

;; Setup template mode
(require 'template)
(template-initialize)
(setq template-default-directories (cons (concat emacs-root ".emacs.d/templates/") template-default-directories))

;; Setup python-mode
(setq py-install-directory (concat emacs-root ".emacs.d/python-mode.el-6.0.4/"))
(require 'python-mode)

;; Setup auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat emacs-root ".emacs.d/auto-complete/ac-dict"))
(ac-config-default)

(setq completion-ignored-extensions
      (append '(".ali" ".exe" ".beam") completion-ignored-extensions))

;; ;; CEDET initializations
;; (require 'cedet)
;; (global-ede-mode 1)
;; (semantic-load-enable-code-helpers)
;; (global-srecode-minor-mode 1)

;; ;; JDEE initializations
;; (require 'jde)

;; ;; Setup ecb-autoloads
;; (require 'ecb-autoloads)

;; Make system copy interact with emacs kill ring
(setq x-select-enable-clipboard t)

;; Daemon/server setup
(require 'midnight)
(midnight-delay-set 'midnight-delay "6:30am")

;; Visual Modifications

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

(defun flymake-next-error ()
  (interactive)
  (if (ignore-errors (next-error)) t
    (flymake-goto-next-error)))

(defun init-c-mode ()
  (progn
    (if (boundp 'subword-mode)
        (subword-mode 1))
    (local-set-key (kbd "C-x `") 'flymake-next-error)
    (flymake-mode t)))

(add-hook 'c-mode-hook 'init-c-mode)


(require 'package)
(require 'erlang)
(require 'flymake-cursor)
(require 'face-list)
(require 'flymake-ecj)

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (concat emacs-root ".emacs.d/elpa/package.el"))
  (package-initialize))

(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))

(load "slime.el")

(slime-setup '(slime-repl))

(when 
    (load "slime.el")
  (slime-setup '(slime-repl))
  (setq inferior-lisp-program "sbcl")
  (ansi-color-for-comint-mode-on))

(put 'narrow-to-region 'disabled nil)

(ansi-color-for-comint-mode-on)

(setq default-tab-width 2)

