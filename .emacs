;; Melpa package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(defvar gnutls-algorithm-priority "NORMAL:-VERS-TLS1.2")

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


;;+--------------------------------+
;;|                                |
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
 '(custom-enabled-themes (quote (flucui-light)))
 '(custom-safe-themes
   (quote
	("0eccc893d77f889322d6299bec0f2263bffb6d3ecc79ccef76f1a2988859419e" "efbe8f0a87281bcfa5e560d5ca10268c735de3a3bb160b54c520d02609aed9d8" "a11808699b77d62f5d10dd73cd474af3057d84cceac8f0301b82ad3e4fb0433e" "a3b9c613ca9beaae6539fd76ce09c78baed7700a7f513dc33a1069592f8bbe07" "672bb062b9c92e62d7c370897b131729c3f7fd8e8de71fc00d70c5081c80048c" "0dd2666921bd4c651c7f8a724b3416e95228a13fca1aa27dc0022f4e023bf197" "e6ccd0cc810aa6458391e95e4874942875252cd0342efd5a193de92bfbb6416b" default)))
 '(js-indent-level 2 t)
 '(package-selected-packages
   (quote
	(which-key yaml-mode google-translate spotify auctex-latexmk dashboard protobuf-mode comment-tags yasnippet editorconfig dired-rainbow glsl-mode nyan-mode dockerfile-mode md4rd haskell-mode latex-preview-pane zeno-theme habamax-theme flucui-themes hemera-theme one-themes company-go go-complete go-mode tide typescript-mode markdown-mode gandalf-theme company git-gutter magit vscode-icon rjsx-mode projectile leuven-theme dired-sidebar ag use-package yasnippet))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cursor ((t (:background "medium blue" :foreground "white"))))
 '(font-latex-slide-title-face ((t (:inherit (variable-pitch font-lock-type-face) :weight normal :height 1.01))))
 '(org-done ((t (:foreground "SeaGreen4" :weight thin))))
 '(org-level-1 ((t (:inherit outline-1 :foreground "black" :weight bold))))
 '(org-level-3 ((t (:inherit nil))))
 '(org-special-keyword ((t (:foreground "dim gray"))))
 '(org-todo ((t (:foreground "red" :weight bold))))
 '(region ((t (:background "blue4" :foreground "white")))))

;;+--------------------------------+
;;|                                |
;;| General configuration          |
;;|                                |
;;+--------------------------------+

;; Prevent `function definition is void error`
(package-install-selected-packages)

(put 'downcase-region 'disabled nil)

(setq package-enable-at-startup nil)


;; Dashboard
(dashboard-setup-startup-hook)

;; Which key
(which-key-mode)

;; General configuration
(setq inhibit-startup-screen t)

(tool-bar-mode -1)

(menu-bar-mode -1)

;;(setq debug-on-error t)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq auto-save-default nil)
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))
(setq make-backup-files nil)
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/auto-save/" t)))

(setq create-lockfiles nil)

(remove-hook 'text-mode-hook 'turn-on-auto-fill)

;; Line numbers
(global-linum-mode t)

;; Indentation
;; (setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-local javascript-indent-level 2)
(setq js-indent-level 2)

;; Recents
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Terminal
(setq explicit-shell-file-name "/usr/bin/zsh")

;; nyan
(nyan-mode)

;; DEPRECATED BECAUSE OF EDITORCONFIG
;; Untabify on save
;;(defun untabify-on-save ()
;;    (untabify (point-min) (point-max)))

;;
;; (add-hook 'before-save-hook 'untabify-on-save)

;;+--------------------------------+
;;|                                |
;;| Package configurations         |
;;|                                |
;;+--------------------------------+

;; editorconfig
(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

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
  (setq dired-sidebar-use-custom-font t))

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
(define-key company-active-map (kbd "C-n") 'company-select-next-or-abort)
(define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort)

;; eglot
(use-package eglot :ensure t)

;; markdown-mode
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; tide (ts/tsx)
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

;;+--------------------------------+
;;|                                |
;;| Org mode                       |
;;|                                |
;;+--------------------------------+

;; Auto-export org files to html when saved 
;;(defun org-mode-export-hook()
;;  "Auto export html"
;;  (when (eq major-mode 'org-mode)
;;    (org-html-export-to-html)))

(setq org-startup-folded nil)

;;+--------------------------------+
;;|                                |
;;| Assign modes to extensions     |
;;|                                |
;;+--------------------------------+
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\Dockerfile\\'" . dockerfile-mode))
(add-to-list 'auto-mode-alist '("\\.glxl\\'" . glxl-mode))
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))

;;+--------------------------------+
;;|                                |
;;| Eglot                          |
;;|                                |
;;+--------------------------------+

(defun eglot-enabled ()
  (eglot-ensure)
  (company-mode))

(add-hook 'c-mode-hook 'eglot-enabled)
(add-hook 'go-mode-hook 'eglot-enabled)
(add-hook 'python-mode-hook 'eglot-enabled)
(add-hook 'haskell-mode-hook 'eglot-enabled)
(add-hook 'shell-script-mode-hook 'eglot-enabled)

;;+--------------------------------+
;;|                                |
;;| Yasnippet                      |
;;|                                |
;;+--------------------------------+

(yas-global-mode 1)

;;+--------------------------------+
;;|                                |
;;| Comment tags                   |
;;|                                |
;;+--------------------------------+

(setq comment-tags-keymap-prefix (kbd "C-c t"))
(with-eval-after-load "comment-tags"
  (setq comment-tags-keyword-faces
        `(("TODO" . ,(list :weight 'bold :foreground "#34c9eb"))
          ("FIXME" . ,(list :weight 'bold :foreground "#ffb833"))
          ("BUG" . ,(list :weight 'bold :foreground "#ff003c"))
          ("HACK" . ,(list :weight 'bold :foreground "#854900"))))
  (setq comment-tags-comment-start-only t
        comment-tags-require-colon t
        comment-tags-case-sensitive t
        comment-tags-show-faces t
        comment-tags-lighter nil))

(add-hook 'find-file-hook 'comment-tags-mode)

;;+--------------------------------+
;;|                                |
;;| Custom shortcuts               |
;;|                                |
;;+--------------------------------+

(defun terminal-right ()
  (interactive)
  (split-window-below)
  (other-window 1)
  (shrink-window 10)
  (ansi-term "/usr/bin/zsh"))

(global-set-key (kbd "C-ö t") 'terminal-right)
(global-set-key (kbd "C-ö o") 'org-mode)
(global-set-key (kbd "C-ö c") 'company-mode)
(global-set-key (kbd "C-ö m") 'magit)
(global-set-key (kbd "C-ö s") 'yas-insert-snippet)
(global-set-key (kbd "C-ö C-g t") 'google-translate-query-translate)
(global-set-key (kbd "C-ö a") 'ag)
;; Helm
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
