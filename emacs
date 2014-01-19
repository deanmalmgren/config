;;====================================================== general emacs behavior
;; tweak the window settings by turning off the scrollbar and removing
;; the toolbar. NOTE: this has to be at the top to properly omit the toolbar
(set-scroll-bar-mode nil)
(tool-bar-mode -1)

;; hide the emacs help screen / splash page on open
;; http://stackoverflow.com/a/744685/564709
(setq inhibit-default-init t)
(setq inhibit-startup-message t)
(add-hook 'emacs-startup-hook 'delete-other-windows)

;; try to get emacs to load faster...this is ridiculous
;; EUREKA!!! http://ubuntuforums.org/archive/index.php/t-183638.html
(modify-frame-parameters nil '((wait-for-wm . nil)))

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; emacs vc-hg not working properly
(setq vc-handled-backends nil) 

;; make emacs retain hard links appropriatly
(setq backup-by-copying 1)

;; set font size
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 100)

;; set frame size --- i can't believe that this can not be done from
;; the command line. what the fuck
(set-frame-width (selected-frame) 80)
;;(set-frame-height (selected-frame) 80)

;; enable emacs copy to put data in system clipboard
;; http://stackoverflow.com/a/65473/564709
(setq x-select-enable-clipboard t)

;; turn on paren matching
(show-paren-mode 1)

;; turn off the friggin bell
(setq-default visible-bell t)

;; nice for auto-indenting when possible
(defun indent ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;; these are handy
(global-set-key [f4] 'goto-line)
(global-set-key [f5] 'query-replace)
(global-set-key [f6] 'indent)

;;====================================================================== el-get
;; basic setup https://github.com/dimitri/el-get#basic-setup
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously
     "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch) ;; have to use master branch for floobits
      (goto-char (point-max))
      (eval-print-last-sexp)
    )
  )
)
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")

;; auto install missing packages everytime emacs starts, it will check
;; for those packages, if they are not installed, auto install them
(defvar tmtxt/el-get-packages
  '(
    floobits
    scss-mode 
    markdown-mode 
    puppet-mode 
    color-theme-solarized
    yaml-mode
))
(dolist (p tmtxt/el-get-packages)
  (when (not (el-get-package-exists-p p))
	(el-get-install p)))

;; sync everything
(el-get 'sync)

;;====================================================== package configurations
;; color theme configuration once everything has been installed
(load-theme 'solarized-dark t)
;;(load-theme 'solarized-light t)

;; configure scss mode
(setq scss-compile-at-save nil)
(setq css-indent-offset 2)


