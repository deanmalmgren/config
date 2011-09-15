;; .emacs

;;; uncomment this line to disable loading of "default.el" at startup
;;(setq inhibit-default-init t)

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

;; ;; default to unified diffs
;; (setq diff-switches "-u")
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
;;   ;; Your init file should contain only one such instance.
;;  '(auto-compression-mode t nil (jka-compr))
;;  '(case-fold-search t)
;;  '(current-language-environment "UTF-8")
;;  '(default-input-method "rfc1345")
;;  '(global-font-lock-mode t nil (font-lock))
;;  '(show-paren-mode t nil (paren))
;; ;; '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
;;  '(transient-mark-mode t))
;; (custom-set-faces
;;   ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
;;   ;; Your init file should contain only one such instance.
;;  )

;; make emacs retain hard links appropriatly
(setq backup-by-copying 1)

;; specify colors
;; (set-foreground-color "white")
;; (set-background-color "dark green")

;; (set-foreground-color "lemon chiffon")
;; (set-background-color "dark slate gray")
;; (set-cursor-color "lemon chiffon")

;; (set-foreground-color "wheat")
;; (set-background-color "brown4")
;; (set-cursor-color "white")

;; (set-background-color "black")
;; (set-foreground-color "white")

;; (set-background-color "dim gray")
;; (set-foreground-color "snow")

;; stop emacs from loading
(setq inhibit-startup-message t)

;; scrollbar off
(set-scroll-bar-mode nil)

;; turn off the toolbar
(tool-bar-mode -1)

;; turn on paren matching
(show-paren-mode 1)

;; set python block comment prefix
(defvar py-block-comment-prefix "##")

;; turn off the friggin bell
(setq-default visible-bell t)

;; make sure we have auto-fill mode in text files
;; (add-hook 'text-mode-hook
;; 	  '(lambda () (auto-fill-mode 1)))
;; (add-hook 'text-mode-hook
;; 	  '(lambda () (set-fill-column 79)))


(add-to-list 'load-path "~/.emacs.d/site-lisp/")

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

;; set font size
(set-default-font "-misc-fixed-medium-r-semicondensed-*-13-*-*-*-c-*-koi8-r")

;; set frame size --- i can't believe that this can not be done from
;; the command line.  what the fuck
(set-frame-width (selected-frame) 80)
;;(set-frame-height (selected-frame) 80)
