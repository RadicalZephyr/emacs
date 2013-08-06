(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(ecb-options-version "2.40")
 '(exec-path (quote ("/home/shannog/local/bin" "/usr/lib/lightdm/lightdm" "/usr/local/sbin" "/usr/local/bin" "/usr/sbin" "/usr/bin" "/sbin" "/bin" "/usr/games" "/usr/local/games" "/home/shannog/local/libexec/emacs/24.0.95/x86_64-unknown-linux-gnu")))
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(iswitchb-mode t)
 '(nxml-child-indent 2 t)
 '(rng-schema-locating-files (quote ("schemas.xml" "/usr/share/emacs/24.1.50/etc/schema/schemas.xml" "~/.emacs.d/xml/schemas.xml")))
 '(ruby-indent-level 2)
 '(safe-local-variable-values (quote ((Syntax . ANSI-Common-Lisp) (Base . 10))))
 '(save-place t nil (saveplace))
 '(semantic-default-submodes (quote (global-semantic-decoration-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-local-symbol-highlight-mode)))
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
  (cond ((file-accessible-directory-p
          "/home/shannog/.emacs.d/")
         "/home/shannog/.emacs.d/")
        ((file-accessible-directory-p
          "c:/cygwin/home/geoff/.emacs.d/")
         "c:/cygwin/home/geoff/.emacs.d/")
        ((file-accessible-directory-p
          "/Users/geoff/.emacs.d/")
         "/Users/geoff/.emacs.d/")
        (t (concat (getenv "HOME")
                   "/.emacs.d/")))
  "My home directory.")

(setenv "PATH"
        (concat (getenv "HOME")
                "/local/bin" ";"
                (getenv "PATH")))

(dolist (dir '("elpa/"
               "lisp/"
               "color-theme/"
               "auto-complete/"
               "python-mode.el-6.0.4/"
               "ecb-2.4.1/"
               "jdee-2.4.0.1/lisp/"
               "jdibug/"))
  (add-to-list 'load-path
               (concat emacs-root dir)))

(dolist (auto-mode-pair '(("\\.php\\'" . php-mode)
                          ("\\.rkt\\'" . scheme-mode)
                          ("\\.md\\'" . markdown-mode)
                          ("\\.markdown\\'" . markdown-mode)))
  (add-to-list 'auto-mode-alist
               auto-mode-pair))

;;(require 'ezephyr-indentation "indentation.el")
(require 'ezephyr-keys "keys.el")
(require 'ezephyr-lisp-tools "tools.el")
(require 'ezephyr-latex-tools "latex-tools.el")

(require 'ezephyr-dark-theme "ez-dark.el")
(require 'ezephyr-dark-theme-nw "ez-dark-nw.el")

(load-file (concat emacs-root "macros/tools.macs"))

(setq-default indent-tabs-mode nil)

;; Mac specific changes
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq special-display-regexps
        (remove "[ ]?\\*[hH]elp.*" special-display-regexps)))

;; Windows specific changes
(when (eq system-type 'windows-nt)
  (setq magit-git-executable "C:\\Program Files (x86)\\Git\\bin\\git.exe"))

;; CEDET/Semantic Setup
(require 'semantic/ia)
(require 'semantic/bovine/gcc)

(global-ede-mode)

;; Setup template mode
(require 'template)
(template-initialize)
(setq template-default-directories
      (cons (concat emacs-root "templates/")
            template-default-directories))

;; Setup python-mode
(setq py-install-directory
      (concat emacs-root "python-mode.el-6.0.4/"))
(require 'python-mode)

;; Setup auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             (concat emacs-root "auto-complete/ac-dict"))
(ac-config-default)

(setq completion-ignored-extensions
      (append '(".ali" ".exe" ".beam")
              completion-ignored-extensions))

;; Make system copy interact with emacs kill ring
(setq x-select-enable-clipboard t)

;; Daemon/server setup
(server-start)
(desktop-save-mode)
(require 'midnight)
(midnight-delay-set 'midnight-delay "6:30am")

;; Visual Modifications

(setq default-tab-width 2)

(setq x-stretch-cursor t)
(set-face-attribute 'default nil :height 150)

;; Enable some modes
(dolist (mode '(column-number-mode
                global-linum-mode))
  (when (fboundp mode)
    (funcall mode)))

;; Disable some modes
(dolist (mode '(scroll-bar-mode
                tool-bar-mode
                menu-bar-mode))
  (when (fboundp mode)
    (funcall mode -1)))

(setq visible-bell t)

(if window-system
    (color-theme-ez-dark)
  (color-theme-ez-dark-nw))

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

(require 'ws-trim)
(set-default 'ws-trim-level 3)
(global-ws-trim-mode t)

;; Package setup
(when
    (or (require 'package)
        (load
         (concat emacs-root "elpa/package.el")))
  (add-to-list 'package-archives
               '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))

(package-refresh-contents)

;; Make sure extra packages are installed
(dolist (pname '(autopair
                 batch-mode
                 clojure-mode
                 csharp-mode
                 clojure-test-mode
                 erefactor
                 flymake-php
                 gnuplot
                 inf-ruby
                 magit
                 nrepl
                 nrepl-ritz
                 paredit
                 php-mode
                 smart-tab
                 markdown-mode
                 markdown-mode+))
  (when (not (package-installed-p pname))
    (package-install pname)))

;; autopair
(require 'autopair)

(add-hook 'c-mode-common-hook
          (lambda ()
            (autopair-mode)
            (add-to-list 'ac-sources
                         'ac-source-semantic)))

;; csharp
(add-hook 'csharp-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (set (make-local-variable 'compile-command) "xbuild")
            (push ?{
                  (getf autopair-dont-pair :never))))

;; nREPL
(setq nrepl-hide-special-buffers t)
(setq nrepl-popup-stacktraces nil)
(setq nrepl-popup-stacktraces-in-repl t)

(add-to-list 'same-window-buffer-names "*nrepl*")

(add-hook 'nrepl-interaction-mode-hook
  'nrepl-turn-on-eldoc-mode)
(add-hook 'nrepl-mode-hook 'subword-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)

;; Ruby mode configs
(require 'inf-ruby)
(add-hook 'ruby-mode-hook 'inf-ruby-setup-keybindings)

;; Lisp mode setups
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'scheme-mode-hook 'paredit-mode)
(add-hook 'lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)

;; (load "slime.el")

;; (slime-setup '(slime-repl))

;; (when
;;     (load "slime.el")
;;   (slime-setup '(slime-repl))
;;   (setq inferior-lisp-program "sbcl")
;;   (ansi-color-for-comint-mode-on))

(put 'narrow-to-region 'disabled nil)

(ansi-color-for-comint-mode-on)
