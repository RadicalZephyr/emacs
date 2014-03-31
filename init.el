(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(custom-safe-themes (quote ("8eef22cd6c122530722104b7c82bc8cdbb690a4ccdd95c5ceec4f3efa5d654f5" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" default)))
 '(ecb-options-version "2.40")
 '(global-font-lock-mode t nil (font-lock))
 '(inhibit-startup-screen t)
 '(iswitchb-buffer-ignore (quote ("^ ")))
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

;; (setenv "PATH"
;;         (concat (getenv "HOME")
;;                 "/local/bin" ";"
;;                 (getenv "PATH")))

(dolist (dir '("elpa/"
               "lisp/"
               "color-theme/"
               "auto-complete/"))
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

(require 'ezephyr-dark)
(require 'ezephyr-dark-nw)

(load-file (concat emacs-root "macros/tools.macs"))

(setq-default indent-tabs-mode nil)

;; Mac specific changes
(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setenv "GIT_SSH" "/usr/bin/ssh")
  (setq special-display-regexps
        (remove "[ ]?\\*[hH]elp.*" special-display-regexps)))

;; Windows specific changes
(when (eq system-type 'windows-nt)
  (setq magit-git-executable "C:\\Program Files (x86)\\Git\\bin\\git.exe"))

;; School specific changes
(when (file-accessible-directory-p "/home/shannog")
  (add-to-list 'exec-path "/home/shannog/local/bin"))

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

;; Setup auto-complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories
             (concat emacs-root "auto-complete/ac-dict"))
(ac-config-default)

;; Setup iswitchb-mode
(add-to-list 'iswitchb-buffer-ignore "*Messages*")

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
                global-linum-mode
                toggle-frame-maximized))
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
    (color-theme-ezephyr-dark)
  (color-theme-ezephyr-dark-nw))

(require 'cc-mode)

(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(require 'erlang)
(require 'face-list)

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
(dolist (pname '(
                 ;; Great utilities
                 magit
                 smart-tab
                 smartparens
                 exec-path-from-shell

                 ;; Clojure
                 ac-cider-compliment
                 cider
                 clojure-mode
                 clojure-test-mode
                 clojure-cheatsheet
                 nrepl
                 nrepl-ritz
                 paredit

                 ;; PHP
                 flymake-php
                 php-mode

                 ;; Ruby
                 inf-ruby
                 rinari
                 yari
                 ruby-tools

                 ;; flycheck
                 flycheck
                 flycheck-tip
                 flycheck-color-mode-line

                 ;; Other cool stuff
                 android-mode
                 batch-mode
                 erefactor
                 gnuplot
                 csharp-mode
                 fsharp-mode
                 markdown-mode
                 markdown-mode+))
  (when (not (package-installed-p pname))
    (package-install pname)))

(exec-path-from-shell-initialize)

(smartparens-global-mode t)

(add-hook 'c-mode-common-hook
          (lambda ()
            (add-to-list 'ac-sources
                         'ac-source-semantic)))

;; csharp
(add-hook 'csharp-mode-hook
          (lambda ()
            (setq indent-tabs-mode t)
            (set (make-local-variable 'compile-command) "xbuild")))

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
(defun ez-paredit-no-smartparens ()
  (smartparens-mode -1)
  (paredit-mode t))

(add-hook 'emacs-lisp-mode-hook 'ez-paredit-no-smartparens)
(add-hook 'scheme-mode-hook 'ez-paredit-no-smartparens)
(add-hook 'lisp-mode-hook 'ez-paredit-no-smartparens)
(add-hook 'clojure-mode-hook 'ez-paredit-no-smartparens)

(add-hook 'text-mode-hook (lambda ()
                            (smartparens-mode -1)
                            (flyspell-mode 1)))

(put 'narrow-to-region 'disabled nil)

(ansi-color-for-comint-mode-on)

;; Android mode setup
(require 'android-mode)
(setq android-mode-sdk-dir (concat (getenv "HOME") "/local/android-sdk-linux"))
