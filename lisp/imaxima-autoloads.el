;;; imaxima-autoloads.el --- autoload definitions for Imaxima, Imath, Maxima

;; This code autoloads basic functions for working with Maxima, so that
;; they work out-of-the-box without user customization.

(autoload 'imaxima "imaxima" "Maxima frontend" t)
(autoload 'imath-mode "imath" "Interactive Math mode" t)
(autoload 'maxima "maxima" "Interactive Maxima session" t)
(autoload 'maxima-mode "maxima" "Major mode for writing Maxima programs" t)
(autoload 'maxima-minor-mode "maxima" "Minor mode for working with Maxima" t)

(add-to-list 'auto-mode-alist '("\\.max" . maxima-mode) auto-mode-alist)

(provide 'imaxima-autoloads)
