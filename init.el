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


(org-babel-load-file (expand-file-name "~/.emacs.d/myinit.org"))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	 (quote
		(all-the-icons all-the-icons-install-fonts doom-modeline ob-ipython linum-relative org-pdfview pdf-tools ido-vertical-mode highlight-indentation-mode aggressive-indent undo-tree evil evil-surround magit ensime engine-mode ac-js2 js2-mode neotree json-mode web-mode exec-path-from-shell ess virtualenvwrapper elpy jedi flycheck zenburn-theme which-key use-package try ox-reveal org-bullets htmlize auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
