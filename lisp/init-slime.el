(require-package 'slime)
;; package.el compiles the contrib subdir, but the compilation order
;; causes problems, so we remove the .elc files there. See
;; http://lists.common-lisp.net/pipermail/slime-devel/2012-February/018470.html
(mapc #'delete-file
      (file-expand-wildcards (concat user-emacs-directory "elpa/slime-2*/contrib/*.elc")))

(require-package 'ac-slime)
(require-package 'hippie-expand-slime)


;;; Lisp buffers

(defun sanityinc/slime-setup ()
  "Mode setup function for slime lisp buffers."
  (set-up-slime-hippie-expand)
  (set-up-slime-ac t))


(setq inferior-lisp-program "sbcl --noinform --no-linedit"
      slime-default-lisp "sbcl --noinform --nolinedit"
      common-lisp-hyperspec-root "/usr/share/doc/HyperSpec/")

(setq slime-protocol-version 'ignore)
(setq slime-net-coding-system 'utf-8-unix)

(setq slime-contribs '(slime-scratch slime-editing-commands slime-fancy))
(slime-setup '(slime-fancy slime-repl slime-fuzzy))

(eval-after-load "slime"
  '(progn
     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol
           slime-fuzzy-completion-in-place t
           slime-enable-evaluate-in-emacs t
           slime-autodoc-use-multiline-p t
           slime-auto-start 'always)

     (define-key slime-mode-map (kbd "TAB") 'slime-indent-and-complete-symbol)
     (define-key slime-mode-map (kbd "C-c C-s") 'slime-selector)
     (setq slime-complete-symbol*-fancy t)
     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)

     (add-hook 'slime-mode-hook 'sanityinc/slime-setup)

     (add-hook 'lisp-mode-hook '(lambda () (show-paren-mode t)))
     (add-hook 'lisp-mode-hook '(lambda () (paredit-mode 1)))
     (add-hook 'lisp-mode-hook '(setq font-lock-maximum-decoration t))

     (add-to-list 'auto-mode-alist '("\\.asd$" . lisp-mode))
     (add-to-list 'auto-mode-alist '("\\.sbclrc\\'" . lisp-mode))
     (add-to-list 'auto-mode-alist '("\\.cl\\'" . lisp-mode))
     (set-language-environment "UTF-8")
     (setenv "LC_LOCALE" "en_GB.UTF-8")
     (setenv "LC_CTYPE" "en_GB.UTF-8")))

;;; REPL

(defun sanityinc/slime-repl-setup ()
  "Mode setup function for slime REPL."
  (sanityinc/lisp-setup)
  (set-up-slime-hippie-expand)
  (set-up-slime-ac t)
  (setq show-trailing-whitespace nil))

(after-load 'slime-repl
  ;; Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('
  (after-load 'paredit
    (define-key slime-repl-mode-map (read-kbd-macro paredit-backward-delete-key) nil))

  ;; Bind TAB to `indent-for-tab-command', as in regular Slime buffers.
  (define-key slime-repl-mode-map (kbd "TAB") 'indent-for-tab-command)

  (add-hook 'slime-repl-mode-hook 'sanityinc/slime-repl-setup))

(after-load 'auto-complete
  (add-to-list 'ac-modes 'slime-repl-mode))


(provide 'init-slime)
