;;; .doom.d/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Clément Busschaert"
      user-mail-address "clement.busschaert@gmail.com")

(use-package! imenu-list
  :commands imenu-list-smart-toggle)

(load! "+keys")
(load! "+ui")
