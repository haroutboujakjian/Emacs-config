(setq user-emacs-directory (file-truename "~/.emacs.d/"))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (manoj-dark)))
 '(package-selected-packages (quote (which-key try use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq inhibit-startup-screen t)
;;(menu-bar-mode 0)
(tool-bar-mode 0)

(setq make-backup-files nil) ; stop creating backup ~ files
(setq auto-save-default nil) ; stop creating #autosave# files
(setq create-lockfiles nil) ; stop creating temporary symbolic link file #something

(set-default-font "Ubuntu Mono-13")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

(setq evil-default-state 'emacs) ;; changes default state to emacs

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package try
	     :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

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
