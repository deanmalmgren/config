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

;; add the site-lisp directory to the load path
(add-to-list 'load-path "~/.emacs.d/site-lisp")

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

;; NOTE: if color-theme is breaking, make sure it is properly
;; installed on this system (http://www.nongnu.org/color-theme/). In
;; ubuntu, this means running
;;
;; $ sudo apt-get install emacs-goodies-el

;; ;; specify colors https://github.com/bbatsov/zenburn-emacs 
;; (when (= emacs-major-version 23)
;;   (when (= emacs-minor-version 1)
;;     (require 'color-theme)
;;     (load "~/.emacs.d/site-lisp/zenburn-23.1.1")
;;     (eval-after-load "color-theme"
;;       '(progn
;;   	 (color-theme-zenburn)))
;;   )
;;   (when (> emacs-minor-version 1)
;;     (require 'color-theme-zenburn)
;;     (color-theme-zenburn)
;;   )
;; )
;; (when (equal emacs-major-version 24)
;;   (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
;;   (load-theme 'zenburn t)
;; )

;; use solarized color them
;; https://github.com/sellout/emacs-color-theme-solarized
(when (< emacs-major-version 24)
  (add-to-list 'load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
  (require 'color-theme-solarized)
  (color-theme-solarized-dark)
  ;; (color-theme-solarized-light)
)
(when (equal emacs-major-version 24)
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized") 
  ;; (load-theme 'solarized-dark t)
  (load-theme 'solarized-light t)
)

;; set font size
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 100)

;; set frame size --- i can't believe that this can not be done from
;; the command line.  what the fuck
(set-frame-width (selected-frame) 80)
;;(set-frame-height (selected-frame) 80)

;; enable emacs copy to put data in system clipboard
;; http://stackoverflow.com/a/65473/564709
(setq x-select-enable-clipboard t)

;; turn on paren matching
(show-paren-mode 1)

;; turn off the friggin bell
(setq-default visible-bell t)

;;====================================================== file-specific bindings
;; set python block comment prefix
(defvar py-block-comment-prefix "##")

;; deal with javascript mode
;; http://xahlee.org/emacs/emacs_installing_packages.html
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;; deal with scss mode
;; http://www.emacswiki.org/emacs/ScssMode
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(setq scss-compile-at-save nil)
(setq css-indent-offset 2)

;; deal with editing xsd documents
;; HACKED TOGETHER ON METRA, PROBABLY BETTER WAY TO DO THIS
(autoload 'xml-mode "xml-mode")
(add-to-list 'auto-mode-alist '("\\.xsd$" . xml-mode))

;; setup markdown mode. for details, see here:
;; http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode.el" 
	  "Major mode for editing Markdown files" t) 
(setq auto-mode-alist (cons '("\\.text" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.mdt" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.mdwn" . markdown-mode) auto-mode-alist))

;; setup handlebars mode. for details, see here:
;; https://github.com/danielevans/handlebars-mode
(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'handlebars-mode)

;; Setup puppet-mode for autoloading
(autoload 'puppet-mode "puppet-mode" "Major mode for editing puppet manifests")
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))

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
