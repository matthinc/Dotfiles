;;+--------------------------------+
;;|           	       	           |
;;| General configuration      	   |
;;|                                |
;;+--------------------------------+

(put 'downcase-region 'disabled nil)

(defvar gnutls-algorithm-priority "NORMAL:-VERS-TLS1.2")

;; Melpa package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; General configuration
(setq inhibit-startup-screen t)

(add-to-list 'default-frame-alist '(font . "Hack 10"))

(set-face-attribute 'default t :font "Hack 10")

(tool-bar-mode -1)

(menu-bar-mode -1)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save/" t)))

(setq create-lockfiles nil)

;; Line numbers
(global-linum-mode t)

;; Indentation
(setq-default indent-tabs-mode nil)
(setq-local javascript-indent-level 2)
(setq js-indent-level 2)

;; Recents
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Terminal
(setq explicit-shell-file-name "/usr/bin/zsh")

;;+--------------------------------+
;;|             	       	   |
;;| Package configurations         |
;;|                                |
;;+--------------------------------+

;; ag
(use-package ag
  :ensure t)

;; sidebar
(use-package dired-sidebar
  :bind (("M-0" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (when (boundp 'aw-ignored-buffers)
                (push 'dired-sidebar-mode aw-ignored-buffers))
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)
  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-face 'dired-sidebar-face-sans)
  (setq dired-listing-switches "-aBhl  --group-directories-first")
  (setq dired-sidebar-use-custom-font t)
  )

;; ivy
(use-package ivy
  :config
  (ivy-mode)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-ignore-order)))
  :bind
  ("C-S-b" . 'ivy-switch-buffer)
  ("C-S-f" . 'projectile-find-file)
  :ensure t)

;; org-bullets
(use-package org-bullets
  :ensure t
  :init
  (add-hook 'org-mode-hook (lambda ()
                             (org-bullets-mode 1))))

;; auctex
(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t)
  (use-package auctex-latexmk
    :ensure t
    :config
    (auctex-latexmk-setup)))

(setq font-latex-fontify-sectioning 'color)
(setq font-latex-fontify-sectioning 1.0)

;; format
(use-package format-all
  :ensure t)

;; yml
(use-package yaml-mode
  :mode ("\\.yml$" . yaml-mode))

;; vscode icons
(use-package vscode-icon
  :ensure t
  :commands (vscode-icon-for-file))

;; magit
(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

;; company
(use-package company :ensure t :pin melpa)

;;+--------------------------------+
;;|             	       	   |
;;| Assign modes to extensions     |
;;|                                |
;;+--------------------------------+
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;;+--------------------------------+
;;|            	       	           |
;;| Variables and packages         |
;;|                                |
;;+--------------------------------+

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (tsdh-light)))
 '(js-indent-level 2 t)
 '(package-selected-packages
   (quote
    (company git-gutter magit vscode-icon rjsx-mode projectile leuven-theme dired-sidebar ag ivy use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-slide-title-face ((t (:inherit (variable-pitch font-lock-type-face) :weight normal :height 1.01)))))
