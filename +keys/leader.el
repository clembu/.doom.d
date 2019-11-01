;;; ~/.doom.d/+keys/leader.el -*- lexical-binding: t; -*-

;;; Leader map ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :leader

      ;;; > Erasing unwanted defaults ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "IGNORED"                         "/"    nil
      :desc "IGNORED"                         "`"    nil
      :desc "IGNORED"                         "h"    nil
      :desc "IGNORED"                         ","    nil
      :desc "IGNORED"                         "<"     nil
      :desc "IGNORED"                         "'"    nil
      :desc "IGNORED"                         "."    nil

      ;;; > Top-level leader keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; > > Navigation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Switch to last buffer"           "TAB"  #'evil-switch-to-windows-last-buffer

      ;;; > Sub-maps ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; > > S is for Search ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "search"                          "s"    doom-leader-search-map
      ;;; > > L is for Layouts ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "layouts"                         "l"    doom-leader-workspace-map)

;;; Search map ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :map doom-leader-search-map
      ;;; > Erasing unwanted defaults ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "IGNORED"                         "/"    nil

      ;;; > Remapping defaults ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Search"                          "s"    #'swiper
      ;;; > Resuming search ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Resume last search"              "r"
        (cond ((featurep! :completion ivy)   #'ivy-resume)
              ((featurep! :completion helm)  #'helm-resume)))

;;; Code map ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :map doom-leader-code-map
      ;;; > Control compilation
      :desc "Kill compilation"                "k"    #'kill-compilation
      ;;; > List items
      :desc "List code items"                 "l"    #'imenu-list-smart-toggle)

;;; Versioning map ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :map doom-leader-git-map
      ;;; > Merging ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("m" . "merge")
        ;;; > > Navigating hunks ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;; next
        :desc "Next hunk"                     "n"    #'smerge-next
        :desc "Next hunk"                     "j"    #'smerge-next
        ;; prev
        :desc "Prev hunk"                     "n"    #'smerge-prev
        :desc "Prev hunk"                     "k"    #'smerge-prev
        ;;; > > Keeping hunks ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Keep current"                  "c"    #'smerge-keep-current
        :desc "Keep other"                    "o"    #'smerge-keep-other
        :desc "Keep upper"                    "u"    #'smerge-keep-upper
        :desc "Keep lower"                    "l"    #'smerge-keep-lower
        :desc "Keep base"                     "b"    #'smerge-keep-base
        :desc "Keep mine"                     "m"    #'smerge-keep-mine
        :desc "Keep all"                      "a"    #'smerge-keep-all
        ;;; > > Transforming hunks ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Refine chunk"                  "r"    #'smerge-refine
        :desc "Combine hunks"                 "C"    #'smerge-combine-with-next
        :desc "Swap chunks"                   "S"    #'smerge-swap
        ;;; > > Diffing
        :desc "Ediff"                         "e"    #'smerge-ediff
        :desc "Diff"                          "d"    #'smerge-diff-upper-lower))

;;; Insertions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(map! :map doom-leader-insert-map
      ;;; > Snippets ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:when (featurep! :editor snippets)
          (:prefix-map ("S" . "Snippets")
            :desc "View snippet for mode"     "/"    #'+snippets/find-for-current-mode
            :desc "View snippet (global)"     "?"    #'+snippets/find
            :desc "Edit snippet"              "c"    #'+snippets/edit
            :desc "View private snippet"      "f"    #'+snippets/find-private
            :desc "New snippet"               "n"    #'+snippets/new
            :desc "New snippet alias"         "N"    #'+snippets/new-alias
            :desc "Reload snippets"           "r"    #'yas-reload-all
            :desc "Create temporary snippet"  "s"    #'aya-create
            :desc "Expand temporary snippet"  "e"    #'aya-expand)))
