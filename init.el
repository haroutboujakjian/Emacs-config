(setq user-emacs-directory (file-truename "~/.emacs.d/"))

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
	    '(("melpa" . "https://melpa.org/packages/")
	     ("org" . "http://orgmode.org/elpa/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile (require 'use-package))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (json-mode web-mode exec-path-from-shell ess virtualenvwrapper elpy jedi flycheck zenburn-theme which-key use-package try ox-reveal org-bullets htmlize auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package exec-path-from-shell
  :ensure t)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))


(global-visual-line-mode t) ;soft wrap for lines

(setq inhibit-startup-screen t)
;;(menu-bar-mode 0)
(tool-bar-mode 0)
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore) ;; stop emacs sounds

(global-hl-line-mode t) ;; highlights current line of cursor
(add-hook 'python-mode-hook 'linum-mode) ;; displaying line numbers


(setq frame-resize-pixelwise t)
(set-frame-position (selected-frame) 4 5)


(setq make-backup-files nil) ; stop creating backup ~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil) ; stop creating temporary symbolic link file #something

(cond
 ((string-equal system-type "gnu/linux")
  (progn
    (set-default-font "Ubuntu Mono-12"))))


(use-package zenburn-theme
  :ensure t)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(setq evil-default-state 'emacs) ;; changes default state to emacs


(use-package try
	     :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package org
  :ensure t
  :pin org)

;; Org-mode bullets format
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode)) 
  
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

(defalias 'list-buffers 'ibuffer-other-window) ;; creates buffer list in other window

(windmove-default-keybindings) ;;shift key to move between windwos

(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))

;; need to modify ox-reveal, not working properly
(use-package ox-reveal
  :ensure ox-reveal
  :config
  (require 'ox-reveal)
  (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
  (setq org-reveal-mathjax t))

(use-package htmlize
  :ensure t)

(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
  )

(use-package json-mode
  :ensure t) ;; additional syntax highlighting on top of js-mode

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

(use-package ess ;; statistical packages
  :ensure t
  :init
  (require 'ess-site))

(use-package jedi
  :ensure t
  :init
   (add-hook 'python-mode-hook 'jedi:setup))
   (add-hook 'pyvenv-mode-hook 'jedi:setup)

(require 'python)
(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "--simple-prompt -i --pylab")

;; (setq python-shell-interpreter "jupyter"
;;       python-shell-interpreter-args "console --simple-prompt")
;; (setq python-shell-completion-native-enable nil)

;; (use-package elpy
;;   :ensure t
;;   :init
;;   (elpy-enable))

