;;; ~/.doom.d/+keys/evil.el -*- lexical-binding: t; -*-
;;
;; Copied from ~/.emacs.d/modules/config/default/+evil-bindings.el
;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Evil everywhere ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (featurep! :editor evil +everywhere)
  ;; Have C-u behave similarly to `doom/backward-to-bol-or-indent'.
  ;; NOTE SPC u replaces C-u as the universal argument.
  (map! :gi "C-u" #'doom/backward-kill-to-bol-and-indent
        :gi "C-w" #'backward-kill-word
        ;; Vimmish ex motion keys
        :gi "C-b" #'backward-word
        :gi "C-f" #'forward-word)

  ;;; Ex commands ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define-key! evil-ex-completion-map
    "C-a" #'move-beginning-of-line
    "C-b" #'backward-word
    "C-s" (if (featurep! :completion ivy)
              #'counsel-minibuffer-history
            #'helm-minibuffer-history))

  ;;; Minibuffer ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define-key! :keymaps +default-minibuffer-maps
    [escape] #'abort-recursive-edit
    "C-v"    #'yank
    "C-z"    (λ! (ignore-errors (call-interactively #'undo)))
    "C-a"    #'move-beginning-of-line
    "C-b"    #'backward-word
    "C-r"    #'evil-paste-from-register
    ;; Scrolling lines
    "C-j"    #'next-line
    "C-k"    #'previous-line
    "C-S-j"  #'scroll-up-command
    "C-S-k"  #'scroll-down-command)

  ;;; Read expr ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (define-key! read-expression-map
    "C-j" #'next-line-or-history-element
    "C-k" #'previous-line-or-history-element))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; General bindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map!
 ;;; Smart tabs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 :i [tab] (general-predicate-dispatch nil ; fall back to nearest keymap
            (and (featurep! :editor snippets)
                 (bound-and-true-p yas-minor-mode)
                 (yas-maybe-expand-abbrev-key-filter 'yas-expand))
            #'yas-expand
            (and (featurep! :completion company +tng)
                 (+company-has-completion-p))
            #'+company/complete)
 :n [tab] (general-predicate-dispatch nil
            (and (featurep! :editor fold)
                 (save-excursion (end-of-line) (invisible-p (point))))
            #'+fold/toggle
            (fboundp 'evil-jump-item)
            #'evil-jump-item)
 :v [tab] (general-predicate-dispatch nil
            (and (bound-and-true-p yas-minor-mode)
                 (or (eq evil-visual-selection 'line)
                     (not (memq (char-after) (list ?\( ?\[ ?\{ ?\} ?\] ?\))))))
            #'yas-insert-snippet
            (fboundp 'evil-jump-item)
            #'evil-jump-item)

 ;;; Newlines ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 :i [remap newline] #'newline-and-indent  ; auto-indent on newline
 :i "C-j"           #'+default/newline    ; default behavior

 ;;; Links and buttons ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 :n "gl" #'ace-link
 (:after help :map help-mode-map
   :n "o"       #'ace-link-help)
 (:after helpful :map helpful-mode-map
   :n "o"       #'ace-link-help)
 (:after info :map Info-mode-map
   :n "o"       #'ace-link-info)
 (:after apropos :map apropos-mode-map
   :n "o"       #'ace-link-help
   :n "TAB"     #'forward-button
   :n [tab]     #'forward-button
   :n [backtab] #'backward-button)
 (:after view :map view-mode-map
   [escape]  #'View-quit-all)
 (:after man :map Man-mode-map
   :n "q"    #'kill-current-buffer)

 ;;; Easymotion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 :m "gs"     #'+evil/easymotion  ; lazy-load `evil-easymotion'

 ;;; Font and frame sizes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 :n "C-S-f"  #'toggle-frame-fullscreen
 :n "C-+"    #'doom/reset-font-size
 ;;; Buffer-local font resizing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 :n "C-="    #'text-scale-increase
 :n "C--"    #'text-scale-decrease
 ;;; Frame-local font resizing ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 :n "M-C-="  #'doom/increase-font-size
 :n "M-C--"  #'doom/decrease-font-size)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MODULES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map!
 ;;; Company ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (:when (featurep! :completion company)
   :i "C-@"      #'+company/complete
   :i "C-SPC"    #'+company/complete
   (:after company
     (:map company-active-map
       "C-w"     nil  ; don't interfere with `evil-delete-backward-word'
       "C-n"     #'company-select-next
       "C-p"     #'company-select-previous
       "C-j"     #'company-select-next
       "C-k"     #'company-select-previous
       "C-h"     #'company-show-doc-buffer
       "C-u"     #'company-previous-page
       "C-d"     #'company-next-page
       "C-s"     #'company-filter-candidates
       "C-S-s"   (cond ((featurep! :completion helm) #'helm-company)
                       ((featurep! :completion ivy)  #'counsel-company))
       "C-SPC"   #'company-complete-common
       "TAB"     #'company-complete-common-or-cycle
       [tab]     #'company-complete-common-or-cycle
       [backtab] #'company-select-previous)
     (:map company-search-map  ; applies to `company-filter-map' too
       "C-n"     #'company-select-next-or-abort
       "C-p"     #'company-select-previous-or-abort
       "C-j"     #'company-select-next-or-abort
       "C-k"     #'company-select-previous-or-abort
       "C-s"     (λ! (company-search-abort) (company-filter-candidates))
       "ESC"     #'company-search-abort))
   ;; TAB auto-completion in term buffers
   (:after comint :map comint-mode-map
     "TAB" #'company-complete
     [tab] #'company-complete))

 ;;; Ivy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (:when (featurep! :completion ivy)
   (:after ivy
     :map ivy-minibuffer-map
     "C-SPC" #'ivy-call-and-recenter  ; preview file
     "C-l"   #'ivy-alt-done
     "C-v"   #'yank)
   (:after counsel
     :map counsel-ag-map
     "C-SPC"    #'ivy-call-and-recenter ; preview
     "C-l"      #'ivy-done
     [C-return] #'+ivy/git-grep-other-window-action))

 ;;; Helm ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (:when (featurep! :completion helm)
   (:after helm :map helm-map
     [left]     #'left-char
     [right]    #'right-char
     "C-S-f"    #'helm-previous-page
     "C-S-n"    #'helm-next-source
     "C-S-p"    #'helm-previous-source
     "C-S-j"    #'helm-next-source
     "C-S-k"    #'helm-previous-source
     "C-j"      #'helm-next-line
     "C-k"      #'helm-previous-line
     "C-u"      #'helm-delete-minibuffer-contents
     "C-s"      #'helm-minibuffer-history
     ;; Swap TAB and C-z
     "TAB"      #'helm-execute-persistent-action
     [tab]      #'helm-execute-persistent-action
     "C-z"      #'helm-select-action)
   (:after helm-ag :map helm-ag-map
     "C--"      #'+helm-do-ag-decrease-context
     "C-="      #'+helm-do-ag-increase-context
     [left]     nil
     [right]    nil)
   (:after helm-files :map (helm-find-files-map helm-read-file-map)
     [C-return] #'helm-ff-run-switch-other-window
     "C-w"      #'helm-find-files-up-one-level)
   (:after helm-locate :map helm-generic-files-map
     [C-return] #'helm-ff-run-switch-other-window)
   (:after helm-buffers :map helm-buffer-map
     [C-return] #'helm-buffer-switch-other-window)
   (:after helm-occur :map helm-occur-map
     [C-return] #'helm-occur-run-goto-line-ow)
   (:after helm-grep :map helm-grep-map
     [C-return] #'helm-grep-run-other-window-action)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ui ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map!
 ;;; Popup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (:when (featurep! :ui popup)
   :n "C-`"   #'+popup/toggle
   :n "C-~"   #'+popup/raise
   :g "C-x p" #'+popup/other)

 ;;; Workspaces ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (:when (featurep! :ui workspaces)
   :n "C-t"   #'+workspace/new
   :n "C-S-t" #'+workspace/display
   :g "M-1"   #'+workspace/switch-to-0
   :g "M-2"   #'+workspace/switch-to-1
   :g "M-3"   #'+workspace/switch-to-2
   :g "M-4"   #'+workspace/switch-to-3
   :g "M-5"   #'+workspace/switch-to-4
   :g "M-6"   #'+workspace/switch-to-5
   :g "M-7"   #'+workspace/switch-to-6
   :g "M-8"   #'+workspace/switch-to-7
   :g "M-9"   #'+workspace/switch-to-8
   :g "M-0"   #'+workspace/switch-to-final
   (:when IS-MAC
     :g "s-t"   #'+workspace/new
     :g "s-T"   #'+workspace/display
     :n "s-1"   #'+workspace/switch-to-0
     :n "s-2"   #'+workspace/switch-to-1
     :n "s-3"   #'+workspace/switch-to-2
     :n "s-4"   #'+workspace/switch-to-3
     :n "s-5"   #'+workspace/switch-to-4
     :n "s-6"   #'+workspace/switch-to-5
     :n "s-7"   #'+workspace/switch-to-6
     :n "s-8"   #'+workspace/switch-to-7
     :n "s-9"   #'+workspace/switch-to-8
     :n "s-0"   #'+workspace/switch-to-final)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Editor ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map!
 ;;; Format ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (:when (featurep! :editor format)
   :n "gQ" #'+format:region)

 ;;; Rotate-text ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (:when (featurep! :editor rotate-text)
   :n "!"  #'rotate-text)

 ;;; Multiple cursors ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (:when (featurep! :editor multiple-cursors)
   ;; evil-multiedit
   :v  "R"     #'evil-multiedit-match-all
   :n  "M-d"   #'evil-multiedit-match-symbol-and-next
   :n  "M-D"   #'evil-multiedit-match-symbol-and-prev
   :v  "M-d"   #'evil-multiedit-match-and-next
   :v  "M-D"   #'evil-multiedit-match-and-prev
   :nv "C-M-d" #'evil-multiedit-restore
   (:after evil-multiedit
     (:map evil-multiedit-state-map
       "M-d"    #'evil-multiedit-match-and-next
       "M-D"    #'evil-multiedit-match-and-prev
       "RET"    #'evil-multiedit-toggle-or-restrict-region
       [return] #'evil-multiedit-toggle-or-restrict-region)))

 ;;; Snippets ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (:when (featurep! :editor snippets)
   ;; auto-yasnippet
   :i  [C-tab] #'aya-expand
   :nv [C-tab] #'aya-create))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Tools ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(when (featurep! :tools eval)
  (map! "M-r" #'+eval/buffer))
