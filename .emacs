(put 'downcase-region 'disabled nil)

(defvar gnutls-algorithm-priority "NORMAL:-VERS-TLS1.2")

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

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

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package ag
  :ensure t)

(use-package dired-sidebar
  ;; :after (ace-window)
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

  (setq dired-sidebar-subtree-line-prefix "  ")
  (setq dired-sidebar-theme 'ascii)
  (setq dired-sidebar-face 'dired-sidebar-face-sans)
  ;; (setq dired-sidebar-should-follow-file t)
  (setq dired-sidebar-use-custom-font t)
  )

(use-package ivy
  :config
  (ivy-mode)
  (setq ivy-re-builders-alist
  '((t . ivy--regex-fuzzy)))
  :bind
  ("C-S-b" . 'ivy-switch-buffer)
  ("C-S-f" . 'projectile-find-file)
  :ensure t)

 (use-package org-bullets
    :ensure t
        :init
        (add-hook 'org-mode-hook (lambda ()
                            (org-bullets-mode 1))))

(use-package neotree
  :config
  (add-hook 'neotree-mode-hook
            (lambda ()
              (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
              (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
              (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))
  :bind ("<f1>" . neotree-project-dir))


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

(use-package format-all
  :ensure t)

(use-package yaml-mode
  :mode ("\\.yml$" . yaml-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (tsdh-light)))
 '(package-selected-packages (quote (leuven-theme dired-sidebar ag ivy use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-slide-title-face ((t (:inherit (variable-pitch font-lock-type-face) :weight normal :height 1.01)))))

(global-set-key (kbd "C-ö o") 'org-mode)
(global-set-key (kbd "C-ö t") 'text-mode)
(global-set-key (kbd "C-ö l") 'LaTeX-mode)
(global-set-key (kbd "C-ö a") 'artist-mode)
