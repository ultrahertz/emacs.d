;;; init-local.el --- My local settings.             -*- lexical-binding: t; -*-

;; Copyright (C) 2015

;; Author:  <jef@workstation.jef.me.uk>
;; Keywords: lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(setq user-full-name "James Fletcher"
      user-mail-address "m@jef.me.uk")

(set-frame-font "Terminus-14")

(load-theme 'wombat t)
(blink-cursor-mode -1)
(setq-default cursor-type 'bar)
(set-cursor-color "#999999")

;;* Org mode
(defvar ora-org-basedir "~/org/")

(defun ora-org-expand (file)
  (expand-file-name file ora-org-basedir))
(setq org-agenda-files
      (mapcar #'ora-org-expand '("todo.org" "gtd.org" "work.org")))

(setq diary-file (ora-org-expand "diary"))
(setq org-agenda-include-diary t)

;; org-mode wiki
(use-package plain-org-wiki
             :commands plain-org-wiki plain-org-wiki-helm
             :config
             (setq pow-directory
                   (ora-org-expand "wiki/")))

(global-unset-key (kbd "C-x m"))
(global-unset-key (kbd "C-x C-m"))
(global-unset-key (kbd "C-x j"))
(global-unset-key (kbd "C-x p"))

(global-set-key (kbd "C-x m") 'eshell)
(global-set-key (kbd "C-x C-n") 'elfeed)
(global-set-key (kbd "C-x C-m") 'smex)

(require 'elfeed)
(setq elfeed-feeds
      '("http://nullprogram.com/feed/"
        "http://emacsredux.com/atom.xml"
        "http://emacs-fu.blogspot.com/feeds/posts/default"
        "http://feeds.feedburner.com/GotEmacs?format=xml"
        "http://www.wisdomandwonder.com/tag/emacs/feed"
        "http://irreal.org/blog/?tag=emacs&feed=rss2"
        "http://feeds.feedburner.com/tuxicity-emacs?format=xml"
        "http://jbm.io/categories/emacs/atom.xml"
        "https://www.blogger.com/feeds/4394570295456001999/posts/default/-/Emacs"
        "http://dialectical-computing.de/blog/emacs.xml"
        "http://technomancy.us/feed/atom"
        "https://www.blogger.com/feeds/8696405790788556158/posts/default/-/emacs"
        "http://www.randomsample.de/dru5/taxonomy/term/2/0/feed"
        "https://www.blogger.com/feeds/4166588008280027121/posts/default/-/planetemacsen"
        "http://bling.github.io/atom.xml"
        "http://axisofeval.blogspot.com/feeds/posts/default"
        "http://endlessparentheses.com/atom.xml"
        "http://oremacs.com/atom.xml"))

(provide 'init-local)
;;; init-local.el ends here
