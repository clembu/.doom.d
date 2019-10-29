;;; ~/.doom.d/+ui.el -*- lexical-binding: t; -*-

(setq doom-font
      (font-spec
       :family (cond ((featurep! :ui pretty-code +iosevka) "Iosevka")
                     ((featurep! :ui pretty-code +fira) "Fira Code")
                     (t "Source Code Pro"))
       :size 13))

(setq which-key-idle-delay 0.5)
