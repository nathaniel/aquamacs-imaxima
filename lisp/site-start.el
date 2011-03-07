(require 'imaxima-autoloads)

(setq imaxima-plugin-dir
      (or (file-name-directory load-file-name)
	  (locate-library "imaxima")))
;; set PATH to include Gnuplot and Maxima binaries in Imaxima-Plugin
;; update Emacs' `exec-path' as well
(setenv "PATH" (concat
		(getenv "PATH")
		":" imaxima-plugin-dir "/Maxima.app/Contents/Resources/bin"
		":" imaxima-plugin-dir "/Gnuplot.app/Contents/Resources/bin"))
(setq exec-path (append exec-path
			(list (concat imaxima-plugin-dir
				      "/Maxima.app/Contents/Resources/bin")
			      (concat imaxima-plugin-dir
				      "/Gnuplot.app/Contents/Resources/bin"))))
;; set path for AquaTerm, for Gnuplot when not used inline from Maxima
(setenv "AQUATERM_PATH" (concat imaxima-plugin-dir
	"/Gnuplot.app/Contents/Resources/lib/AquaTerm.app/"))

;; generate maxima's temporary files for gnuplot in an appropriate
;; temp directory (else they end up in $HOME !)
(setenv "MAXIMA_TEMPDIR" temporary-file-directory)
(setenv "MAXIMA_USERDIR" 
	(expand-file-name "~/Library/Application Support/Aquamacs Emacs/maxima"))

(aquamacs-set-defaults
 `((imaxima-use-maxima-mode-flag t)
   (maxima-save-input-history t)
   (maxima-input-history-file
    "~/Library/Application Support/Aquamacs Emacs/maxima_history")
   (imaxima-html-dir "~/Desktop/") ;; else default location is $HOME
   (maxima-use-full-color-in-process-buffer t)
   ))
