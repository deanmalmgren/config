;; .emacs

;; hide the emacs help screen / splash page on open
;; http://stackoverflow.com/a/744685/564709
(setq inhibit-default-init t)
(setq inhibit-startup-message t)
(add-hook 'emacs-startup-hook 'delete-other-windows)

;; add the site-lisp directory to the load path
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; try to get emacs to load faster...this is ridiculous
;; EUREKA!!! http://ubuntuforums.org/archive/index.php/t-183638.html
(modify-frame-parameters nil '((wait-for-wm . nil)))

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))

;; enable visual feedback on selections
;; (setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))

;; emacs vc-hg not working properly
(setq vc-handled-backends nil) 

;; make emacs retain hard links appropriatly
(setq backup-by-copying 1)

;; specify colors in emacs 23 https://github.com/bbatsov/zenburn-emacs
(require 'color-theme-zenburn)
(color-theme-zenburn)

;; ;; specify colors in emacs 24 https://github.com/bbatsov/zenburn-emacs
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
;; (load-theme 'zenburn t)

;; stop emacs from loading
(setq inhibit-startup-message t)

;; scrollbar off
(set-scroll-bar-mode nil)

;; turn off the toolbar
(tool-bar-mode -1)

;; turn on paren matching
(show-paren-mode 1)

;; turn off the friggin bell
(setq-default visible-bell t)

;; make sure we have auto-fill mode in text files
;; (add-hook 'text-mode-hook
;; 	  '(lambda () (auto-fill-mode 1)))
;; (add-hook 'text-mode-hook
;; 	  '(lambda () (set-fill-column 79)))

;; set python block comment prefix
(defvar py-block-comment-prefix "##")

;; ;; povray stuff
;; (add-to-list 'load-path "~/bin/pov-mode-3.2")
;; (autoload 'pov-mode "pov-mode" "PoVray scene file mode" t)
;; (add-to-list 'auto-mode-alist '("\\.pov\\'" . pov-mode))
;; (add-to-list 'auto-mode-alist '("\\.inc\\'" . pov-mode))

;; deal with javascript mode
;; http://xahlee.org/emacs/emacs_installing_packages.html
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))

;; deal with scss mode
;; http://www.emacswiki.org/emacs/ScssMode
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq scss-compile-at-save nil)
(setq css-indent-offset 2)

;; deal with editing xsd documents
;; HACKED TOGETHER ON METRA, PROBABLY BETTER WAY TO DO THIS
(autoload 'xml-mode "xml-mode")
(add-to-list 'auto-mode-alist '("\\.xsd$" . xml-mode))

;; set font size
(set-default-font "-misc-fixed-medium-r-semicondensed-*-13-*-*-*-c-*-koi8-r")

;; set frame size --- i can't believe that this can not be done from
;; the command line.  what the fuck
(set-frame-width (selected-frame) 80)
;;(set-frame-height (selected-frame) 80)

;; setup markdown mode. for details, see here:
;; http://jblevins.org/projects/markdown-mode/
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t) 
(setq auto-mode-alist (cons '("\\.text" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.mdt" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.mdwn" . markdown-mode) auto-mode-alist))

;; setup handlebars mode. for details, see here:
;; https://github.com/danielevans/handlebars-mode
(add-to-list 'load-path "~/.emacs.d/vendor/")
(require 'handlebars-mode)
