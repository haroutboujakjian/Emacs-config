;;; init.el --- Initialization file for Emacs
;;; Commentary: Emacs Startup File --- initialization for Emacs
(setq user-emacs-directory (file-truename "~/.emacs.d/"))

;; shortcut to pull up init file
(global-set-key [f7] (lambda () (interactive) (find-file user-init-file)))

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
			'(("melpa" . "https://melpa.org/packages/")
				("melpa-stable" . "https://stable.melpa.org/packages/")
				("gnu" . "https://elpa.gnu.org/packages/")
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
		(org-pdfview pdf-tools ido-vertical-mode highlight-indentation-mode aggressive-indent undo-tree evil evil-surround magit ensime engine-mode ac-js2 js2-mode neotree json-mode web-mode exec-path-from-shell ess virtualenvwrapper elpy jedi flycheck zenburn-theme which-key use-package try ox-reveal org-bullets htmlize auto-complete))))
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

(setq-default tab-width 2)
(setq tab-stop-list (number-sequence 2 200 2))

(electric-pair-mode 1) ; closes brackets automatically

(global-visual-line-mode t) ;soft wrap for lines

(setq inhibit-startup-screen t)
;;(menu-bar-mode 0)
(tool-bar-mode 0)
(fset 'yes-or-no-p 'y-or-n-p)
(setq ring-bell-function 'ignore) ;; stop emacs sounds

(global-hl-line-mode t) ;; highlights current line of cursor
;;(add-hook 'python-mode-hook 'linum-mode) ;; displaying line numbers


(setq frame-resize-pixelwise t)
(set-frame-position (selected-frame) 4 5)

(winner-mode 1) ;; history of window configurations to back to previous layout

(setq make-backup-files nil) ; stop creating backup ~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil) ; stop creating temporary symbolic link file #something

(cond
 ((string-equal system-type "gnu/linux")
  (progn
    (set-frame-font "Ubuntu Mono-12")
		
		;; section for pdf viewer
		(use-package pdf-tools
			:ensure t)

		(use-package org-pdfview
			:ensure t)

		(pdf-tools-install)
		(require 'pdf-tools)
		(require 'org-pdfview)
		)))


(use-package zenburn-theme
  :ensure t)


(use-package evil
  :ensure t
  :config
  (evil-mode 1)

  (use-package evil-surround
		:ensure t
		:config
		(global-evil-surround-mode 1)
		)
  )
;;(setq evil-default-state 'emacs) ;; changes default state to emacs

;; highlights line indents, does not work globally
(use-package highlight-indentation
	:ensure t
	:config
	(highlight-indentation-mode t))

;; indents lines even with copy and paste
(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1)
  )

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

;; find files opens vertically
(use-package ido-vertical-mode
	:ensure t
	:config
	(ido-vertical-mode 1)
	)

(defalias 'list-buffers 'ibuffer-other-window) ;; creates buffer list in other window

(windmove-default-keybindings) ;;shift key to move between windwos

;;enables use of search engine
(use-package engine-mode
  :defer 3
  :config
  (defengine duckduckgo
    "https://duckduckgo.com/?q=%s"
    :keybinding "d")

  (defengine github
    "https://github.com/search?ref=simplesearch&q=%s"
    :keybinding "g")

	(defengine stack-overflow
    "https://stackoverflow.com/search?q=%s"
    :keybinding "s")
  (engine-mode t))


(use-package magit
  :ensure t
  :init
  (progn
		(bind-key "C-x g" 'magit-status)
		))


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
	(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
	(setq web-mode-enable-current-column-highlight t)
  (setq web-mode-ac-sources-alist
				'(("css" . (ac-source-css-property))
					("html" . (ac-source-words-in-buffer ac-source-abbrev))
					("js" . (ac-js2-mode))))
  )

(defun my-web-mode-hook()
	"Hooks for Web mode. Adjust indents"
	(setq web-mode-markup-indent-offset 2)
	(setq web-mode-css-indent-offset 2)
	(setq web-mode-code-indent-offset 2)
	)
(add-hook 'web-mode-hook 'my-web-mode-hook)


;; (use-package js2-mode
;;   :ensure t
;;   :ensure ac-js2
;;   :init
;;   (progn
;; 		(add-hook 'js-mode-hook 'js2-minor-mode)
;; 		(add-hook 'js2-mode-hook 'ac-js2-mode)
;; 		))

(use-package json-mode
  :ensure t) ;; additional syntax highlighting on top of js-mode

(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode t))

;; Scala section
(use-package ensime
  :ensure t
  :config
  (add-to-list 'exec-path "/usr/local/bin")
	)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)


(use-package ess ;; statistical packages
  :ensure t
  :init
  (require 'ess-site))

(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup))
(add-hook 'pyvenv-mode-hook 'jedi:setup)

;; ipython shell with PyQt5 plot backend
(require 'python)
(setq python-shell-interpreter "ipython")
(setq python-shell-interpreter-args "--simple-prompt -i --pylab")
