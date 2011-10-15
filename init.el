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

(labels ((add-path (p)
		   (add-to-list 'load-path
				(concat emacs-root p))))
  (add-path ".emacs.d/elpa/")
  (add-path ".emacs.d/macros/")
  (add-path ".emacs.d/lisp/")
  (add-path ".emacs.d/color-theme/"))

(load-file "~/.emacs.d/macros/tools.macs")
(load-file "~/.emacs.d/lisp/keys.el")
(load-file "~/.emacs.d/lisp/tools.el")
(load-file "~/.emacs.d/lisp/ez-dark.el")
(load-file "~/.emacs.d/lisp/ez-dark-nw.el")
(load-file "~/.emacs.d/lisp/latex-tools.el")

(add-to-list 'auto-mode-alist '("\\.erl?$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.hrl?$" . erlang-mode))

(setq-default indent-tabs-mode nil)
(setq completion-ignored-extensions 
      (append '(".ali" ".exe" ".bean") completion-ignored-extensions))

;; Make system copy interact with emacs kill ring
(setq x-select-enable-clipboard t)

;; Daemon/server setup
(require 'midnight)
(midnight-delay-set 'midnight-delay "6:30am")

;; Visual Modifications

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

(require 'package)
(package-initialize)

(add-to-list 'package-archives
             '("marmalade" . 
               "http://marmalade-repo.org/packages/"))

(defun flymake-next-error ()
  (interactive)
  (if (ignore-errors (next-error)) t
    (flymake-goto-next-error)))

(defun init-c-mode ()
  (progn 
    (if (boundp 'subword-mode)
        (subword-mode 1))
    (local-set-key (kbd "C-c C-x C-c") 'compile)
    (local-set-key (kbd "C-x `") 'flymake-next-error)
    (flymake-mode t)))

(add-hook 'c-mode-hook 'init-c-mode)
                      

(require 'package)
(require 'erlang)
(require 'flymake-cursor)
(require 'face-list)


;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

(load "slime.el")

(slime-setup '(slime-repl))

(setq inferior-lisp-program "sbcl")