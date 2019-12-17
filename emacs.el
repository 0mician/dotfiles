
(require 'package)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

(defvar my-packages '(ag
                      atomic-chrome
                      beacon
                      browse-kill-ring
                      flycheck
                      auto-complete
                      web-mode
                      clojure-mode
                      parinfer
                      elfeed
                      elfeed-goodies
                      clj-refactor
                      cider
                      exec-path-from-shell
                      ac-cider
                      jedi
                      js2-mode
                      js-comint
                      js2-refactor
                      rainbow-mode
                      synosaurus
                      ini-mode
                      ac-js2
                      flycheck-flow
                      comment-tags
                      sass-mode
                      yaml-mode
                      pdf-tools
                      ivy counsel swiper
                      tern
                      tern-auto-complete
                      coffee-mode
                      projectile
                      markdown-mode
                      anaconda-mode
                      enh-ruby-mode
                      robe
                      ledger-mode
                      impatient-mode
                      restclient
                      magit
                      darktooth-theme
                      which-key
                      writeroom-mode
                      writegood-mode
                      org-bullets
                      zenburn-theme
                      pyvenv
                      djangonaut
                      snakemake-mode
                      ess))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-refresh-contents)
    (package-install p))
  (add-to-list 'package-selected-packages p))

(setq initial-scratch-message nil)
(setq inhibit-startup-message t)
(global-font-lock-mode 1)
(setq show-paren-delay 0
      show-paren-style 'parenthesis)
(show-paren-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode -1)

(setq custom-safe-themes
   (quote
    ("df3e05e16180d77732ceab47a43f2fcdb099714c1c47e91e8089d2fcf5882ea3"
     "d09467d742f713443c7699a546c0300db1a75fed347e09e3f178ab2f3aa2c617"
     "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26"
     "85c59044bd46f4a0deedc8315ffe23aa46d2a967a81750360fb8600b53519b8a"
     default)))

(defun standard-mode ()
  "Default theme and font size.  Pendant: (presentation-mode)."
  (interactive)

  (set-face-attribute 'default nil :height 130)
  ;; Themes
    (set-frame-parameter nil 'background-mode 'dark)
  ;; Dark, High Contrast
  (load-theme 'wombat)
  (setq frame-background-mode (quote dark))
  ;; Dark, Low contrast
  ;; (load-theme 'darktooth)
  ;; Dark, Lowest contrast
  ;; (load-theme 'zenburn)
   )
(standard-mode)

(defun swap-buffers-in-windows ()
  "Put the buffer from the selected window in next window, and vice versa"
  (interactive)
  (let* ((this (selected-window))
     (other (next-window))
     (this-buffer (window-buffer this))
     (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)
    )
  )

;;; IDO Mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 108 :width normal)))))

;;; Org-mode
(require 'org-bullets)
(add-hook 'org-mode-hook
          (lambda ()
            (org-bullets-mode t)))
(setq org-ellipsis "⬇") 
(setq org-src-fontify-natively t)
(setq org-log-done 'time)
(define-key global-map "\C-cl" 'org-store-link)

(require 'org
  :config
  (setq org-startup-indented t))
;(setq org-agenda-files (list "~/agenda/agenda.org"
;                             "~/agenda/recurrent.org"))
(setq org-agenda-files (list "~/sorganon/agenda-encrypt.org.gpg"))
(define-key global-map "\C-ca" 'org-agenda)
;; (setq org-modules (quote (
;;                           org-bbdb
;;                           org-bibtex
;;                           org-docview
;;                           org-gnus
;;                           org-habit
;;                           org-info
;;                           org-irc
;;                           org-mhe
;;                           org-rmail
;;                           org-w3m)))

(setq org-treat-S-cursor-todo-selection-as-state-change nil)
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"))))
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "purple" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold))))
(custom-set-faces '(org-table ((t (:foreground "DodgerBlue1")))))
(custom-set-faces '(org-agenda-column-dateline ((t (:foreground "DodgerBlue1")))))
(custom-set-faces '(org-agenda-date ((t (:foreground "DodgerBlue1")))))
(require 'org-mu4e)
 ;; '(org-modules
 ;;   (quote
 ;;    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))

(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; (add-to-list 'load-path "~/.emacs.d/evil-tutor")

;; needed to simplify the prompt (CPR issues)
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")
(setq python-shell-interpreter "ipython"
  python-shell-interpreter-interactive-args "-i --simple-prompt")

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(setenv "WORKON_HOME" "/home/sid/anaconda2/envs")
(pyvenv-mode 1)

;;((nil
;;  (python-shell-process-environment . ("DJANGO_SETTINGS_MODULE=project.settings"))
;;  (python-shell-extra-pythonpaths . ("/path_to/project/"))
;;  (python-shell-virtualenv-root . "/path_to/venv/")))
