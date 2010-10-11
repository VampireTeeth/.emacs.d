;; -*- mode: emacs-lisp -*-
;;; .emacs --- my uber kewl .emacs on bhishma.homelinux.net
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; libraries in use:							 ;;
;; 	dired-details, dired-details+,					 ;;
;; 	dired-sort-menu, dired-sort-menu+, dired-sort-map		 ;;
;; libraries loaded as required:					 ;;
;; 	cedet, semantic, easist						 ;;
;; libraries ready to use:						 ;;
;; 	auto-install, ecb						 ;;
;; 									 ;;
;; NB:	the fn to set $ROOTSYS works only for network mounted		 ;;
;; 	directories. have to append user@host in front to make		 ;;
;; 	it work for all situations					 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Code:
;; (setq debug-on-error t)
      ;; debug-on-signal t
      ;; debug-on-quit t)

;; faces
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completions-common-part ((t (:foreground "forest green"))))
 '(completions-first-difference ((t (:bold t :weight bold :foreground "salmon"))))
 '(info-menu-header ((t (:bold t :family "Sans Serif" :foreground "tomato" :weight bold))))
 '(info-node ((t (:italic t :bold t :foreground "gold" :slant italic :weight bold))))
 '(info-xref ((t (:bold t :foreground "powder blue" :weight bold))))
 '(minibuffer-prompt ((t (:foreground "dark cyan" :weight bold))))
 '(org-done ((t (:background "ForestGreen" :foreground "DarkSeaGreen2" :slant oblique :weight bold))))
 '(org-todo ((t (:background "royalblue4" :foreground "thistle" :weight bold))))
 '(rst-level-1-face ((t (:background "grey85" :foreground "black"))) t)
 '(woman-bold ((t (:bold t :weight bold :foreground "forest green"))))
 '(woman-italic ((t (:italic t :slant italic :foreground "salmon")))))

;; configs
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(abbrev-mode t)
 '(browse-url-browser-function (quote (("http.*emacswiki.org/.*" . w3m-browse-url) ("." . browse-url-default-browser))))
 '(case-fold-search nil)
 '(column-number-mode t)
 '(dabbrev-case-replace nil)
 '(diff-switches "-u")
 '(dired-listing-switches "-alh")
 '(ecb-options-version "2.40")
 '(ediff-custom-diff-options "-u")
 '(ediff-split-window-function (quote split-window-horizontally))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(flyspell-default-dictionary "en_GB")
 '(ibuffer-mode-hook (quote (ibuffer-auto-mode)))
 '(inhibit-startup-screen t)
 '(isearch-allow-scroll t)
 '(iswitchb-mode t)
 '(mouse-avoidance-mode (quote exile) nil (avoid))
 '(mouse-yank-at-point nil)
 '(occur-mode-hook (quote (turn-on-font-lock next-error-follow-minor-mode)))
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("ELPA" . "http://tromey.com/elpa/"))))
 '(savehist-mode t nil (savehist))
 '(set-mark-command-repeat-pop t)
 '(show-paren-mode t)
 '(speedbar-use-images nil)
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(transient-mark-mode t)
 '(truncate-lines t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(w3m-use-cookies t))

;; load path for elisp files
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;; (add-to-list 'load-path (expand-file-name "~sali/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "/opt/emacs-lisp/share/emacs/contrib"))
(add-to-list 'load-path "~/.emacs.d/lisp/yasnippet")

;; Emacs 23 stuff
(when (string-match "23.2" emacs-version)
  (add-to-list 'load-path (expand-file-name "/opt/emacs-lisp/share/emacs/24.0.50/lisp/org"))
  (require 'org-install))

;; Info directory
(add-to-list 'Info-default-directory-list
	     (expand-file-name "/opt/emacs-lisp/share/info"))

;; colour themes using color-theme.el
(load-file "~/.emacs.d/lisp/color-theme-dark-emacs.el")

(eval-after-load "color-theme"
  (progn
    (setq color-theme-is-global nil)
    (when (window-system) ; needed for the first frame
      (colour-theme-dark-emacs)
      )))

(add-hook 'after-make-frame-functions
	  '(lambda (f)
	     (with-selected-frame f
	       (if (window-system f)
		   (colour-theme-dark-emacs)
		 ))))

;; alternate theming API, supported by native Emacs >=24
;; (when (window-system) ; needed for the first frame
;;   (load-theme 'dark-emacs))

;; (add-hook 'after-make-frame-functions
;; 	  '(lambda (f)
;; 	     (with-selected-frame f
;; 	       (if (window-system f)
;; 		   (load-theme 'dark-emacs)
;; 		 ))))


;; hostname and buffer-name in frame title
;; code originally written by Michael Albinus
;; and a post in emacs-fu.blogspot.com (dotemacs trickery)
(setq-default
 frame-title-format
 '(:eval
   (if (string-match-p "^\\*.+\\*$" (buffer-name))
       "%b" ; buffer name
     ;; (format "%s@%s:%s"
     ;; 	(or (file-remote-p default-directory 'user) user-login-name)
     (format "%s:%s"
	     (or (file-remote-p default-directory 'host) system-name)
	     (buffer-name)))))

;; `minimal-mode' customisation
(load-library "minimal")
(setq minimal-zap-mode-line nil)
(setq minimal-zap-menu-bar nil)
(minimal-mode)


;; Navigation
;; side scrolling on
(put 'scroll-left 'disabled nil)
;; narrow-to-region enabled
(put 'narrow-to-region 'disabled nil)
;; window configuration undo support
(winner-mode t)
;; navigate thru windows using M-<arrow>
(windmove-default-keybindings 'meta)
;; Move point to the first non-whitespace character on this line.
(define-key global-map (kbd "s-a") 'back-to-indentation)
;; Completion
(define-key global-map (kbd "s-<tab>") 'completion-at-point)


;; Editing
;; enabling disabled commands
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
;; tabs with respect to the previous non-blank line
;; (define-key global-map (kbd "S-<iso-lefttab>") 'indent-relative)
(define-key global-map (kbd "<backtab>") 'indent-relative)
;; (global-set-key '[(backtab)] 'indent-relative)

;; undo-tree (not in vanilla Emacs)
(require 'undo-tree)
(global-undo-tree-mode)

;; browse-kill-ring (not in vanilla Emacs)
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; FIXME:
;; marking region with `C-M-@' and trying to comment with
;; `comment-dwim' with `M-;' invokes `delete-region'
;; same error when marking regions with starting and ending on
;; the first column and invoking `comment-dwim'.
;; advising delete-char to delete-region
;; marking a region from lower row to upper row triggers it
(defadvice delete-char
  (around delete-char-maybe (arg &optional killflag))
  ;; arguments compatible with the arg list for delete-char
  "If mark is active, run `delete-region' instead."
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))
(ad-activate 'delete-char)

;; advising backward-delete-char-untabify to delete-region
(defadvice backward-delete-char-untabify
  (around backward-delete-char-untabify-maybe (arg &optional killflag))
  ;; arguments compatible with the arg list for backward-delete-char-untabify
  "If mark is active, run `delete-region' instead."
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))
(ad-activate 'backward-delete-char-untabify)

;; (defadvice isearch-yank-kill
;; (around toggle-case-fold-search-maybe)
;; "If case-fold-search is t toggle it. Restore it after isearch finishes."
;; (let ((tmp-case-fold-search case-fold-search))
;;   (if case-fold-search
;;       (progn (setq case-fold-search nil)
;; 	     ad-do-it)
;;     ad-do-it)
;;   (setq case-fold-search tmp-case-fold-search)))
;; (ad-activate 'isearch-yank-kill)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs pimped up!					   ;;
;; Skeletons, Templates, Abbreviations and Keyboard Macros ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Skeletons (and abbrev customisations)
(load-file "~/.emacs.d/lisp/skeletons.el")

;; Abbreviations
;; location of the abbreviation definition file
(setq abbrev-file-name (expand-file-name "~/.emacs.d/lisp/abbrev_defs"))
(setq save-abbrevs nil)

;; this hook wraps around the `expand-abbrev' function call
(add-hook 'after-change-major-mode-hook
	  (lambda ()
	    (add-hook 'abbrev-expand-functions 'expand-abbrev-in-context nil t)))

;; yasnippet tempaltes
(when (string= (getenv "USER") "jallad")
  (require 'yasnippet)
  (yas/initialize)
  (yas/load-directory "~/.emacs.d/lisp/yasnippet/snippets"))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Mode hooks and other mode specific customisations ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `text-mode' and `org-mode' madness ;)
(load-file "~/.emacs.d/lisp/org-mode-settings.el")
(load-file "~/.emacs.d/lisp/text-mode-like-settings.el")

(defun my-text-mode-like-hook()
  "My customisations for all `text-mode' like modes."
  (if (org-mode-p)
      (my-org-mode-hook)
    (my-text-mode-hook)))
(add-hook 'text-mode-hook 'my-text-mode-like-hook)
(add-hook 'muse-mode-hook 'my-text-mode-like-hook)
(add-hook 'org-mode-hook 'my-text-mode-like-hook)

;; w3m
(add-hook 'w3m-mode-hook 'my-w3m-mode-hook)

;; shell-script-mode customisations
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; ANSI colours in Emacs shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; version control related customisations

;; auto-revert-mode for files under version control
(add-hook 'find-file-hook
	  (lambda ()
	    (if (vc-working-revision (buffer-file-name))
		(auto-revert-mode t))))


;; ;; special buffers
;; (setq special-display-buffer-names
;;	 '("*grep*" "*tex-shell*" "*compilation*" "*find*"))

;; ;; create a backup file directory
;; (defun make-backup-file-name (file)
;; (concat “~/.emacs_backups/” (file-name-nondirectory file) “~”))

;; start a server and make sure it has a name
;; (require 'server)
;; (setq server-host (system-name)
;; 	       server-use-tcp t)
;; (server-start)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; onyanyo jhinchak stuff:			;;
;; auto-install, dired-details, dired-details+, ;;
;; icicles, dired-sort-menu, dired-sort-menu+	;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; auto-install settings (not in vanilla Emacs)
(eval-after-load 'auto-install
  (setq auto-install-directory "~/.emacs.d/lisp/"))
;; (eval-after-load 'auto-install
;;   (setq auto-install-directory "~sali/.emacs.d/lisp/"))
;; the "/" at the end of the path is absolutely essential,
;; otherwise the elisp files are saved as elisp*.el instead of elisp/*.el


;; dired
(put 'dired-find-alternate-file 'disabled nil)

;; `dired-details' & `dired-details+' by Drew Adams
;; reported a bug for this 1 ;) (not in vanilla Emacs)
(require 'dired-details)
(require 'dired-details+)
(require 'dired-sort-menu)
(require 'dired-sort-menu+)
(require 'dired-sort-map)

;; ;; load dired-x in dired (enables omitting files)
;; (add-hook 'dired-load-hook
;;	  (lambda ()
;;	    (require 'dired-x)))
;; ;; turns omiting on by default
;; (setq dired-omit-mode t)

;; `dired-mode' key bindings
(define-key dired-mode-map (kbd "C-<down>") 'dired-next-subdir)
(define-key dired-mode-map (kbd "C-<up>") 'dired-prev-subdir)
(define-key dired-mode-map (kbd "C-<left>") 'dired-tree-up)
(define-key dired-mode-map (kbd "C-<right>") 'dired-tree-down)
(define-key dired-mode-map (kbd "<tab>") 'dired-hide-subdir)


;; lazy-bones
(defalias 'yes-or-no-p 'y-or-n-p)
;; session management (not in vanilla Emacs)
(require 'session)
(add-hook 'after-init-hook 'session-initialize)


;; File associations
;; conf-mode for .*rc files
;; (add-to-list 'auto-mode-alist (cons "\\.*rc\\'" 'conf-mode))

;; thunderbird external editor mode `tbemail-mode'
(autoload 'tbemail-mode "tbemail"
  "Mode to be used with the external editor plugin for Thunderbird." t)
(add-to-list 'auto-mode-alist (cons "\\.eml\\'" 'tbemail-mode))
(add-hook 'tbemail-mode-hook 'my-text-mode-like-hook)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Development tools:				     ;;
;; Collection of Emacs Development Environment Tools ;;
;; & Emacs Code Browser	and many more customisations ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; load and setup CEDET
(autoload 'setup-cedet "autoloads"
  "Setup CEDET if it is already not loaded" t)
;; (autoload 'semantic-default-elisp-setup "semantic-el"
;;   "Setup hook function for Emacs Lisp files and Semantic.")


;; Python customisations
;; (add-hook 'python-mode-hook 'setup-cedet)


;; Lisp/Elisp customisations
(defun my-lisp-mode-hook ()
  (eldoc-mode t)
  (setup-cedet))
(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode-hook)

;; C++ customisations
;; force `c++-mode' for `*.h' header files
(add-to-list 'auto-mode-alist (cons "\\.h\\'" 'c++-mode))

;; keybindings
;; (defun c-mode-common-keymaps()
;;   "C/C++ mode keybindings for my skeletons."
;;   ;; keybindings for skeletons
;;   (define-key c-mode-base-map (kbd "C-c f") 'c++-for-skel)
;;   (define-key c-mode-base-map (kbd "C-c i") 'c++-if-skel))

;; define my-c-mode-common-hook here
;; include things like (setup-cedet)

;; hooks
(add-hook 'c-mode-common-hook 'setup-cedet)
;; (add-hook 'c-mode-common-hook 'c-mode-common-keymaps)

;; Documentation tools
;; doxymacs
(require 'doxymacs)
;; (eval-after-load "doxymacs"
;;   (define-key c-mode-base-map '[(C-c d)] doxymacs-))


;; ATLAS specific modes
;; `cmt-mode' for CMT requirements files
(autoload 'cmt-mode "cmt-mode"
  "Mode to fontify and syntax highlight buffer while editing CMT requirements file." t)
(add-to-list 'auto-mode-alist (cons "\\requirements\\'" 'cmt-mode))

;; `han-mode' for HAN configuration files
(autoload 'han-mode "han-mode"
  "Major mode for editing HAN configuration files" t)
(add-to-list 'auto-mode-alist
	     (cons "\\(run\\|minutes[0-9]\\{1,3\\}\\).config\\'" 'han-mode))



;;; Keyboard macros
;; kmacro to insert comment block in python
(fset 'comment-block-python
      (lambda (&optional arg)
	"Keyboard macro to insert comment block in python."
	(interactive "p")
	(kmacro-exec-ring-item
	 (quote ([35 21 53 48 45 return 35 return 35 21 53 48 45 return] 0 "%d")) arg)))

;; kmacro to insert a block of comment
(fset 'block-comment
      (lambda (&optional arg)
        "Keyboard macro to insert a block of comment."
        (interactive "p")
        (kmacro-exec-ring-item
         (quote ([47 47 21 51 48 45 return 47 47 45 45 32 return 47 47 21 51 48 45 return] 0 "%d")) arg)))


;; get directory of a file in the current buffer
;; (file-name-directory buffer-file-name)

;;; .emacs ends here