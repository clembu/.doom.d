;;; ~/.doom.d/+keys/leader.el -*- lexical-binding: t; -*-

(map! :leader

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; TOP LEVEL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; C-u is used by evil
      :desc "Universal argument"                "u"   #'universal-argument
      ;;; > Running commands ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Eval expression"                   ";"   #'eval-expression
      :desc "M-x"                               ":"   #'execute-extended-command
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; > Find stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Find file"                         "."   #'find-file
      :desc "Find file in project"              "SPC" #'projectile-find-file
      :desc "Blink cursor line"                 "DEL" #'+nav-flash/blink-cursor
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; > Other stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Org Capture"                       "X"   #'org-capture

      :desc "window"                            "w"   evil-window-map

      (:when (featurep! :ui popup)
        :desc "Toggle last popup"               "~"   #'+popup/toggle)

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; QUITTING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("q" . "Quit")
        ;;; > Just Quit ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Abort mission"                   "K"   #'save-buffers-kill-emacs
        :desc "Quit"                            "q"   #'save-buffers-kill-terminal
        :desc "Quit I says!"                    "Q"   #'evil-quit-all-with-error-code
        ;;; > Quit and come back ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Reload"                          "r"   #'doom/restart-and-restore
        :desc "Restart"                         "R"   #'doom/restart)

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; SEARCH ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; > Resume search ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Resume last search"                "'"
      (cond ((featurep! :completion ivy)   #'ivy-resume)
            ((featurep! :completion helm)  #'helm-resume))
      ;;; > Global search ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Jump to bookmark"                  "RET" #'bookmark-jump
      ;;; > Search in project ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Search for symbol in project"      "*"   #'+default/search-project-for-symbol-at-point
      (:prefix-map ("s" . "Search")
        :desc "Search project"                  "p"   #'+default/search-project
        :desc "Search other project"            "P"   #'+default/search-other-project
        ;;; > Search in buffer ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Search"                          "s"   #'swiper
        :desc "Search for thing at point"       "S"   #'swiper-thing-at-point
        ;;; > > Search in index ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "iMenu"                           "i"   #'imenu
        ;;; > Search in folder ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Search in folder"                "d"   #'+default/search-cwd
        :desc "Search elsewhere"                "D"   #'+default/search-other-cwd
        ;;; > Search documentation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Look up online"                  "o"   #'+lookup/online
        :desc "Look up documentation"           "k"   #'+lookup/in-docsets
        :desc "Look up in all docsets"          "K"   #'+lookup/in-all-docsets)

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; LAYOUTS & WORKSPACES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:when (featurep! :ui workspaces)
        (:prefix-map ("l" . "Workspaces")
          ;;; > List workspaces ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          :desc "Display tab bar"               "TAB" #'+workspace/display
          ;;; > Go to workspace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          :desc "Switch workspace"              "."   #'+workspace/switch-to
          :desc "Switch to last workspace"      "`"   #'+workspace/other
          :desc "Next workspace"                "]"   #'+workspace/switch-right
          :desc "Previous workspace"            "["   #'+workspace/switch-left
          :desc "Switch to 1st workspace"       "1"   #'+workspace/switch-to-0
          :desc "Switch to 2nd workspace"       "2"   #'+workspace/switch-to-1
          :desc "Switch to 3rd workspace"       "3"   #'+workspace/switch-to-2
          :desc "Switch to 4th workspace"       "4"   #'+workspace/switch-to-3
          :desc "Switch to 5th workspace"       "5"   #'+workspace/switch-to-4
          :desc "Switch to 6th workspace"       "6"   #'+workspace/switch-to-5
          :desc "Switch to 7th workspace"       "7"   #'+workspace/switch-to-6
          :desc "Switch to 8th workspace"       "8"   #'+workspace/switch-to-7
          :desc "Switch to 9th workspace"       "9"   #'+workspace/switch-to-8
          :desc "Switch to last workspace"      "0"   #'+workspace/switch-to-final
          ;;; > Create workspaces ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          :desc "New workspace"                 "n"   #'+workspace/new
          :desc "Load workspace from file"      "l"   #'+workspace/load
          :desc "Restore last session"          "R"   #'+workspace/restore-last-session
          ;;; > Delete workspaces ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          :desc "Delete session"                "x"   #'+workspace/kill-session
          :desc "Delete this workspace"         "d"   #'+workspace/delete
          ;;; > Rename workspaces ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          :desc "Rename workspace"              "r"   #'+workspace/rename
          ;;; > Save workspaces ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
          :desc "Save workspace to file"        "s"   #'+workspace/save))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; BUFFERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; > Open buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      :desc "Switch buffer"                     ","   #'switch-to-buffer
      (:when (featurep! :ui workspaces)
        :desc "Switch workspace buffer"         ","   #'persp-switch-to-buffer
        :desc "Switch buffer"                   "<"    #'switch-to-buffer)
      :desc "Switch to last buffer"             "TAB" #'evil-switch-to-windows-last-buffer
      (:prefix-map ("b" . "Buffers")
        :desc "Previous buffer"                 "["   #'previous-buffer
        :desc "Next buffer"                     "]"   #'next-buffer
        (:when (featurep! :ui workspaces)
          :desc "Switch workspace buffer"       "b"   #'persp-switch-to-buffer
          :desc "Switch buffer"                 "B"   #'switch-to-buffer)
        (:unless (featurep! :ui workspaces)
          :desc "Switch buffer"                 "b"   #'switch-to-buffer)
        :desc "Next buffer"                     "n"   #'next-buffer
        :desc "Previous buffer"                 "p"   #'previous-buffer
        ;;; > Creating buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "New empty buffer"                "N"   #'evil-buffer-new
        :desc "Toggle narrowing"                "-"   #'doom/toggle-narrow-buffer
        ;;; > List buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "List buffers"                    "l"   #'ibuffer
        ;;; > Writing buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Save buffer"                     "s"   #'basic-save-buffer
        :desc "Save all buffers"                "S"   #'evil-write-all
        ;;; > > Unwriting buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Revert buffer"                   "r"   #'revert-buffer
        ;;; > Kill buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Kill buffer"                     "k"   #'kill-current-buffer
        :desc "Kill all buffers"                "K"   #'doom/kill-all-buffers
        :desc "Kill buffer"                     "d"   #'kill-current-buffer
        :desc "Kill other buffers"              "O"   #'doom/kill-other-buffers
        ;;; > > Almost-kill buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Bury buffer"                     "z"   #'bury-buffer
        :desc "Kill buried buffers"             "Z"   #'doom/kill-buried-buffers
        ;;; > Scratch buffers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Pop up scratch buffer"           "x"   #'doom/open-scratch-buffer
        :desc "Switch to scratch buffer"        "X"   #'doom/switch-to-scratch-buffer)
      :desc "Pop up scratch buffer"             "x"   #'doom/open-scratch-buffer

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; CODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("c" . "Code")
        ;;; > Compile that code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Compile"                         "c"   #'compile
        :desc "Recompile"                       "C"   #'recompile
        :desc "Kill compilation"                "k"   #'kill-compilation
        ;;; > Navigate that code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "List symbols"                    "i"   #'imenu-list-smart-toggle
        (:when (featurep! :tools lookup)
          :desc "Jump to definition"            "d"   #'+lookup/definition
          :desc "Jump to documentation"         "D"   #'+lookup/documentation
          :desc "Find occurences"               "o"   #'+lookup/references)
        ;;; > Run that code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        (:when (featurep! :tools eval)
          :desc "Evaluate buffer/region"        "e"   #'+eval/buffer-or-region
          :desc "Evaluate & replace region"     "E"   #'+eval:replace-region
          :desc "Send to repl"                  "s"   #'+eval/send-region-to-repl)
        ;;; > Format that code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        (:when (featurep! :editor format)
          :desc "Format buffer/region"          "f"   #'+format/region-or-buffer)
        (:when (featurep! :tools lsp)
          :desc "LSP Format buffer/region"      "F"   #'+default/lsp-format-region-or-buffer)
        :desc "Comment lines"                   "l"   #'comment-line
        :desc "Delete trailing whitespace"      "w"   #'delete-trailing-whitespace
        :desc "Delete trailing newlines"        "W"   #'doom/delete-trailing-newlines
        ;;; > Refactor that code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        (:when (featurep! :tools lsp)
          :desc "LSP Rename"                    "r"   #'lsp-rename)
        ;;; > Debug that code ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        (:when (featurep! :tools flycheck)
          :desc "List errors"                   "x"   #'flycheck-list-errors)
        (:unless (featurep! :tools flycheck)
          :desc "List errors"                   "x"   #'flymake-show-diagnostics-buffer))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; FILES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("f" . "file")
        :desc "Find file"                       "."   #'find-file
        :desc "Find file from here"             "/"
        (if (featurep! :completion ivy)
            #'counsel-file-jump
          (λ! (doom-project-find-file default-directory)))
        :desc "Open project editorconfig"       "c"   #'editorconfig-find-current-editorconfig
        :desc "Copy this file"                  "C"   #'doom/copy-this-file
        :desc "Find directory"                  "d"   #'dired
        :desc "Delete this file"                "D"   #'doom/delete-this-file
        :desc "Find file in emacs.d"            "e"   #'+default/find-in-emacsd
        :desc "Browse emacs.d"                  "E"   #'+default/browse-emacsd
        :desc "Find file from here"             "f"   #'find-file
        :desc "Locate file"                     "l"   #'locate
        :desc "Move/rename file"                "m"   #'doom/move-this-file
        :desc "Find file in private config"     "p"   #'doom/find-file-in-private-config
        :desc "Browse private config"           "P"   #'doom/open-private-config
        :desc "Recent files"                    "r"   #'recentf-open-files
        :desc "Recent project files"            "R"   #'projectile-recentf
        :desc "Save file"                       "s"   #'save-buffer
        :desc "Save file as..."                 "S"   #'write-file
        :desc "Sudo find file"                  "u"   #'doom/sudo-find-file
        :desc "Sudo this file"                  "U"   #'doom/sudo-this-file
        :desc "Yank filename"                   "y"   #'+default/yank-buffer-filename)

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; VERSION CONTROL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("g" . "git")
        :desc "Git revert file"                 "R"   #'vc-revert
        :desc "Copy git link"                   "y"   #'git-link
        :desc "Copy git link to homepage"       "Y"   #'git-link-homepage
        (:when (featurep! :ui vc-gutter)
          :desc "Git revert hunk"               "r"   #'git-gutter:revert-hunk
          :desc "Git stage hunk"                "s"   #'git-gutter:stage-hunk
          :desc "Git time machine"              "t"   #'git-timemachine-toggle
          :desc "Jump to next hunk"             "]"   #'git-gutter:next-hunk
          :desc "Jump to previous hunk"         "["   #'git-gutter:previous-hunk)
        (:when (featurep! :tools magit)
          :desc "Magit dispatch"                "/"   #'magit-dispatch
          :desc "Forge dispatch"                "'"   #'forge-dispatch
          :desc "Magit switch branch"           "b"   #'magit-branch-checkout
          :desc "Magit status"                  "g"   #'magit-status
          :desc "Magit file delete"             "D"   #'magit-file-delete
          :desc "Magit blame"                   "B"   #'magit-blame-addition
          :desc "Magit clone"                   "C"   #'+magit/clone
          :desc "Magit fetch"                   "F"   #'magit-fetch
          :desc "Magit buffer log"              "L"   #'magit-log
          :desc "Git stage file"                "S"   #'magit-stage-file
          :desc "Git unstage file"              "U"   #'magit-unstage-file
          (:prefix ("f" . "find")
            :desc "Find file"                   "f"   #'magit-find-file
            :desc "Find gitconfig file"         "g"   #'magit-find-git-config-file
            :desc "Find commit"                 "c"   #'magit-show-commit
            :desc "Find issue"                  "i"   #'forge-visit-issue
            :desc "Find pull request"           "p"   #'forge-visit-pullreq)
          (:prefix ("o" . "open in browser")
            :desc "Browse region or line"       "o"   #'+vc/git-browse-region-or-line
            :desc "Browse remote"               "r"   #'forge-browse-remote
            :desc "Browse commit"               "c"   #'forge-browse-commit
            :desc "Browse an issue"             "i"   #'forge-browse-issue
            :desc "Browse a pull request"       "p"   #'forge-browse-pullreq
            :desc "Browse issues"               "I"   #'forge-browse-issues
            :desc "Browse pull requests"        "P"   #'forge-browse-pullreqs)
          (:prefix ("l" . "list")
            (:when (featurep! :tools gist)
              :desc "List gists"                "g"   #'+gist:list)
            :desc "List repositories"           "r"   #'magit-list-repositories
            :desc "List submodules"             "s"   #'magit-list-submodules
            :desc "List issues"                 "i"   #'forge-list-issues
            :desc "List pull requests"          "p"   #'forge-list-pullreqs
            :desc "List notifications"          "n"   #'forge-list-notifications)
          (:prefix ("c" . "create")
            :desc "Initialize repo"             "r"   #'magit-init
            :desc "Clone repo"                  "R"   #'+magit/clone
            :desc "Commit"                      "c"   #'magit-commit-create
            :desc "Fixup"                       "f"   #'magit-commit-fixup
            :desc "Branch"                      "b"   #'magit-branch-and-checkout
            :desc "Issue"                       "i"   #'forge-create-issue
            :desc "Pull request"                "p"   #'forge-create-pullreq)
          (:prefix ("m" . "merge")
            :desc "Next hunk"                   "n"   #'smerge-next
            :desc "Previous hunk"               "N"   #'smerge-prev
            :desc "Keep all"                    "a"   #'smerge-keep-all
            :desc "Keep base"                   "b"   #'smerge-keep-base
            :desc "Keep mine"                   "m"   #'smerge-keep-mine
            :desc "Keep other"                  "o"   #'smerge-keep-other
            :desc "Keep current"                "c"   #'smerge-keep-current
            :desc "Combine hunks"               "C"   #'smerge-combine-with-next
            :desc "Refine"                      "r"   #'smerge-refine)))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; INSERTION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("i" . "Insert")
        :desc "From clipboard"                  "y"   #'+default/yank-pop
        :desc "From evil register"              "r"   #'evil-ex-registers
        :desc "Unicode"                         "u"   #'unicode-chars-list-chars
        ;;; SNIPPETS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        :desc "Snippet"                         "s"   #'yas-insert-snippet
        (:when (featurep! :editor snippets)
          (:prefix-map ("S" . "Snippets")
            :desc "View snippet for mode"       "/"   #'+snippets/find-for-current-mode
            :desc "View snippet (global)"       "?"   #'+snippets/find
            :desc "Edit snippet"                "c"   #'+snippets/edit
            :desc "View private snippet"        "f"   #'+snippets/find-private
            :desc "Insert snippet"              "i"   #'yas-insert-snippet
            :desc "New snippet"                 "n"   #'+snippets/new
            :desc "New snippet alias"           "N"   #'+snippets/new-alias
            :desc "Reload snippets"             "r"   #'yas-reload-all
            :desc "Create temporary snippet"    "s"   #'aya-create
            :desc "Expand temporary snippet"    "e"   #'aya-expand)))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; NOTES TAKING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("n" . "notes")
        :desc "Browse notes"                    "."   #'+default/browse-notes
        :desc "Search notes"                    "/"   #'+default/org-notes-search
        :desc "Search notes for symbol"         "*"   #'+default/search-notes-for-symbol-at-point
        :desc "Org agenda"                      "a"   #'org-agenda
        :desc "Org capture"                     "c"   #'org-capture
        :desc "Open deft"                       "d"   #'deft
        :desc "Search org agenda headlines"     "h"   #'+default/org-notes-headlines
        :desc "Org store link"                  "l"   #'org-store-link
        :desc "Tags search"                     "m"   #'org-tags-view
        :desc "Find file in notes"              "n"   #'+default/find-in-notes
        :desc "Browse notes"                    "N"   #'+default/browse-notes
        :desc "Todo list"                       "t"   #'org-todo-list
        :desc "View search"                     "v"   #'org-search-view
        :desc "Org export to clipboard"         "y"   #'+org/export-to-clipboard
        :desc "Org export to clipboard as RTF"  "Y"   #'+org/export-to-clipboard-as-rich-text

        (:when (featurep! :lang org +journal)
          (:prefix ("j" . "journal")
            :desc "New Entry"                   "j"   #'org-journal-new-entry
            :desc "Search Forever"              "s"   #'org-journal-search-forever)))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; OPENING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("o" . "open")
        :desc "Org agenda"                      "A"   #'org-agenda
        (:prefix ("a" . "org agenda")
          :desc "Agenda"                        "a"   #'org-agenda
          :desc "Todo list"                     "t"   #'org-todo-list
          :desc "Tags search"                   "m"   #'org-tags-view
          :desc "View search"                   "v"   #'org-search-view)
        :desc "Default browser"                 "b"   #'browse-url-of-file
        :desc "Start debugger"                  "d"   #'+debugger/start
        :desc "New frame"                       "f"   #'make-frame
        :desc "Open link"                       "l"   #'ace-link
        :desc "REPL"                            "r"   #'+eval/open-repl-other-window
        :desc "REPL (same window)"              "R"   #'+eval/open-repl-same-window
        :desc "Dired"                           "-"   #'dired-jump
        (:when (featurep! :ui neotree)
          :desc "Project sidebar"               "p"   #'+neotree/open
          :desc "Find file in project sidebar"  "P"   #'+neotree/find-this-file)
        (:when (featurep! :ui treemacs)
          :desc "Project sidebar"               "p"   #'+treemacs/toggle
          :desc "Find file in project sidebar"  "P"   #'+treemacs/find-file)
        (:when (featurep! :term shell)
          :desc "Toggle shell popup"            "t"   #'+shell/toggle
          :desc "Open shell here"               "T"   #'+shell/here)
        (:when (featurep! :term term)
          :desc "Toggle terminal popup"         "t"   #'+term/toggle
          :desc "Open terminal here"            "T"   #'+term/here)
        (:when (featurep! :term vterm)
          :desc "Toggle vterm popup"            "t"   #'+vterm/toggle
          :desc "Open vterm here"               "T"   #'+vterm/here)
        (:when (featurep! :term eshell)
          :desc "Toggle eshell popup"           "e"   #'+eshell/toggle
          :desc "Open eshell here"              "E"   #'+eshell/here)
        (:when (featurep! :tools macos)
          :desc "Reveal in Finder"              "o"   #'+macos/reveal-in-finder
          :desc "Reveal project in Finder"      "O"   #'+macos/reveal-project-in-finder
          :desc "Send to Transmit"              "u"   #'+macos/send-to-transmit
          :desc "Send project to Transmit"      "U"   #'+macos/send-project-to-transmit
          :desc "Send to Launchbar"             "l"   #'+macos/send-to-launchbar
          :desc "Send project to Launchbar"     "L"   #'+macos/send-project-to-launchbar)
        (:when (featurep! :tools docker)
          :desc "Docker"                        "D"   #'docker))

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; PROJECTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("p" . "project")
        :desc "Browse project"                  "."   #'+default/browse-project
        :desc "Browse other project"            ">"   #'doom/browse-in-other-project
        :desc "Find file in project"            "/"   #'projectile-find-file
        :desc "Find file in other project"      "?"   #'doom/find-file-in-other-project
        :desc "Run cmd in project root"         "!"   #'projectile-run-shell-command-in-root
        :desc "Add new project"                 "a"   #'projectile-add-known-project
        :desc "Switch to project buffer"        "b"   #'projectile-switch-to-buffer
        :desc "Compile in project"              "c"   #'projectile-compile-project
        :desc "Repeat last command"             "C"   #'projectile-repeat-last-command
        :desc "Remove known project"            "d"   #'projectile-remove-known-project
        :desc "Edit project .dir-locals"        "e"   #'projectile-edit-dir-locals
        :desc "Find file in project"            "f"   #'projectile-find-file
        :desc "Browse project"                  "F"   #'+default/browse-project
        :desc "Configure project"               "g"   #'projectile-configure-project
        :desc "Invalidate project cache"        "i"   #'projectile-invalidate-cache
        :desc "Kill project buffers"            "k"   #'projectile-kill-buffers
        :desc "Find other file"                 "o"   #'projectile-find-other-file
        :desc "Switch project"                  "p"   #'projectile-switch-project
        :desc "Find recent project files"       "r"   #'projectile-recentf
        :desc "Run project"                     "R"   #'projectile-run-project
        :desc "Save project files"              "s"   #'projectile-save-project-buffers
        :desc "Pop up scratch buffer"           "x"   #'doom/open-project-scratch-buffer
        :desc "Switch to scratch buffer"        "X"   #'doom/switch-to-project-scratch-buffer
        :desc "List project tasks"              "t"   #'+default/project-tasks
        :desc "Test project"                    "T"   #'projectile-test-project)

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; REMOTE EDITING ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:when (featurep! :tools upload)
        (:prefix-map ("r" . "remote")
          :desc "Upload local"                  "u"   #'ssh-deploy-upload-handler
          :desc "Upload local (force)"          "U"   #'ssh-deploy-upload-handler-forced
          :desc "Download remote"               "d"   #'ssh-deploy-download-handler
          :desc "Diff local & remote"           "D"   #'ssh-deploy-diff-handler
          :desc "Browse remote files"           "."   #'ssh-deploy-browse-remote-handler
          :desc "Detect remote changes"         ">"   #'ssh-deploy-remote-changes-handler))


      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;; TOGGLES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (:prefix-map ("t" . "toggle")
        :desc "Big mode"                        "b"   #'doom-big-font-mode
        (:when (featurep! :tools flycheck)
          :desc "Flycheck"                      "f"   #'flycheck-mode)
        (:unless (featurep! :tools flycheck)
          :desc "Flymake"                       "f"   #'flymake-mode)
        :desc "Frame fullscreen"                "F"   #'toggle-frame-fullscreen
        :desc "Evil goggles"                    "g"   #'evil-goggles-mode
        (:when (featurep! :ui indent-guides)
          :desc "Indent guides"                 "i"   #'highlight-indent-guides-mode)
        :desc "Indent style"                    "I"   #'doom/toggle-indent-style
        :desc "Line numbers"                    "l"   #'doom/toggle-line-numbers
        (:when (featurep! :lang org +present)
          :desc "org-tree-slide mode"           "p"   #'+org-present/start)
        :desc "Read-only mode"                  "r"   #'read-only-mode
        (:when (featurep! :tools flyspell)
          :desc "Flyspell"                      "s"   #'flyspell-mode)
        (:when (featurep! :lang org +pomodoro)
          :desc "Pomodoro timer"                "t"   #'org-pomodoro)
        :desc "Word-wrap mode"                  "w"   #'+word-wrap-mode))
