;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; use tab indentation everywhere
(setq-default indent-tabs-mode t)
;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'solarized-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;;=============================================================================
;;========================== MY CONFIGURATION:=================================
;;=============================================================================

;;Org mode
(after! org
	(map! :map org-mode-map
				:n ". ." 'org-toggle-checkbox
				:n "SPC r" 'org-refile
				)

	(add-hook 'org-mode-hook #'visual-line-mode)
	(add-hook 'text-mode-hook #'visual-line-mode)
	(setq org-agenda-files '("~/org/inbox.org"
													"~/org/gtd.org"
													"~/org/tickler.org"
													"~/org/events.org")
				)
	(setq org-capture-templates '(("t" "Todo [inbox]" entry
																(file+headline "~/org/inbox.org" "Tasks")
																"* TODO %i%?")
																("n" "Notes [inbox]" entry
																(file+headline "~/org/inbox.org" "Notes")
																"* %t \n %i%?")
																("T" "Tickler" entry
																(file+headline "~/org/tickler.org" "Tickler")
																"* %i%? \n SCHEDULED %U")
																("M" "Meetings [events]" entry
																(file+headline "~/org/events.org" "Meetings")
																"* %i%? \n SCHEDULED: %T")
																("c" "Classes/seminar [events]" entry
																(file+headline "~/org/events.org" "Classes/Seminars")
																"* %i%? \n SCHEDULED: %T")
																("o" "Others [events]" entry

																(file+headline "~/org/events.org" "Others")
																"* %i%? \n SCHEDULED: %T"))
				)

	(setq org-refile-targets '(("~/org/gtd.org" :maxlevel . 3)
                           ("~/org/someday.org" :level . 1)
                           ("~/org/tickler.org" :maxlevel . 2)
													 ("~/org/notes.org"  :maxlevel . 2)
													 )
				)
	(setq org-startup-align-all-table t)

	(setq org-tag-alist '(("@KTH" . ?K) ("@home" . ?h) ("laptop" . ?l) ("meeting" . ?m) ("Nek5000" . ?N) ("paper" . ?p) ("write" . ?w)))

	(setq org-agenda-window-setup 'current-window)

	(setq org-todo-keywords '((sequence "TODO(T)" "|" "DONE(D)" "CANCELLED(c)")
								(sequence "TOREAD(t)" "|" "LEIDO(L)")
								(sequence "REC(R)")
								(sequence "TOPAY(p)" "|" "PAGADO")
								(sequence "TOBUY(b)" "|" "COMPRADO" )
								))
	 (setq org-reverse-note-order t) ;refile at the top of subtree
)
(def-package! org-super-agenda
	:after org-agenda
	:init 
	(setq org-super-agenda-groups
       '((:auto-property "NP"))
  )
	:config
	(org-super-agenda-mode)
)
;; Wrap text
(global-visual-line-mode t)

(setq-default tab-width 4)
(setq tab-width 4)
(setq octave-comment-char ?%)
(setq auto-mode-alist
	(cons '("\\.m$" . octave-mode) auto-mode-alist))
