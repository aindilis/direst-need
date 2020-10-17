;; (global-set-key "C-ccccccc" 'load-fcms)

(defun load-fcms (&optional fcms-current-app-arg fcms-current-dir-arg)
 (progn

  (setq auto-mode-alist (append '(("\\.tt$" . web-mode)) auto-mode-alist ))
  (setq auto-mode-alist (append '(("\\.tt2$" . web-mode)) auto-mode-alist ))

  (add-to-list 'load-path ".")
  (require 'fcms-mvc-util-exported)

  (global-set-key "\C-cffcm" 'fcms-open-model)
  (global-set-key "\C-cffcv" 'fcms-open-view)
  (global-set-key "\C-cffcc" 'fcms-open-controller)
  (global-set-key "\C-cffct" 'fcms-open-template)
  (global-set-key "\C-cffcP" 'fcms-open-plugin)

  (global-set-key "\C-cffsm" 'fcms-search-models)
  (global-set-key "\C-cffsv" 'fcms-search-views)
  (global-set-key "\C-cffsc" 'fcms-search-controllers)
  (global-set-key "\C-cffst" 'fcms-search-templates)
  (global-set-key "\C-cffsp" 'fcms-search-plugins)

  (defun fcms-load-directories (&optional fcms-current-app-arg fcms-current-dir-arg)
   ""
   (setq fcms-current-dir (or fcms-current-dir-arg "/var/lib/myfrdcsa/codebases/independent/direst-need/DirestNeed"))
   (setq fcms-current-app (or fcms-current-app-arg "DirestNeed"))

   (setq fcms-current-model-dir (frdcsa-el-concat-dir (list fcms-current-dir "lib" fcms-current-app "Model")))
   (setq fcms-current-view-dir (frdcsa-el-concat-dir (list fcms-current-dir "lib" fcms-current-app "View")))
   (setq fcms-current-controller-dir (frdcsa-el-concat-dir (list fcms-current-dir "lib" fcms-current-app "Controller")))
   (setq fcms-current-plugin-dir (frdcsa-el-concat-dir (list fcms-current-dir "lib" "Template" "Plugin")))

   (if (string= fcms-current-app "DirestNeed")
    (setq fcms-current-template-dir (frdcsa-el-concat-dir (list fcms-current-dir "root" "src")))
    (setq fcms-current-template-dir (frdcsa-el-concat-dir (list fcms-current-dir "root"))))
   )
  
  (defun fcms-open-model ()
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (let* ((pattern "")
	  (completions
	   (kmax-grep-list-regexp
	    (split-string
	     (shell-command-to-string
	      (concat "find " (shell-quote-argument fcms-current-model-dir) " | grep '\.pm$'"))
	     "\n")
	    "."))
	  (completion (try-completion pattern completions))
	  ;; (initial-input (all-completions pattern choices))
	  )
    (ffap
     (ido-completing-read "FCMS Template?: " completions 
      nil nil
      completion nil nil pattern))))

  (defun fcms-search-models (&optional search-arg)
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (kmax-search-files
    (or search-arg (read-from-minibuffer "Search?: "))
    (kmax-grep-list-regexp
     (split-string
      (shell-command-to-string
       (concat "find " (shell-quote-argument fcms-current-model-dir) " | grep '\.pm$'"))
      "\n")
     "[^~]$")
    "*FCMS Model Search*"
    ))

  (defun fcms-open-view ()
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (let* ((pattern "")
	  (completions
	   (kmax-grep-list-regexp
	    (split-string
	     (shell-command-to-string
	      (concat "find " (shell-quote-argument fcms-current-view-dir) " | grep '\.pm$'"))
	     "\n")
	    "."))
	  (completion (try-completion pattern completions))
	  ;; (initial-input (all-completions pattern choices))
	  )
    (ffap
     (ido-completing-read "FCMS View?: " completions 
      nil nil
      completion nil nil pattern))))

  (defun fcms-search-views (&optional search-arg)
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (kmax-search-files
    (or search-arg (read-from-minibuffer "Search?: "))
    (kmax-grep-list-regexp
     (split-string
      (shell-command-to-string
       (concat "find " (shell-quote-argument fcms-current-view-dir) " | grep '\.pm$'"))
      "\n")
     "[^~]$")
    "*FCMS View Search*"
    ))

  (defun fcms-open-plugin ()
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (let* ((pattern "")
	  (completions
	   (kmax-grep-list-regexp
	    (split-string
	     (shell-command-to-string
	      (concat "find " (shell-quote-argument fcms-current-plugin-dir) " | grep '\.pm$'"))
	     "\n")
	    "."))
	  (completion (try-completion pattern completions))
	  ;; (initial-input (all-completions pattern choices))
	  )
    (ffap
     (ido-completing-read "FCMS Plug-In?: " completions 
      nil nil
      completion nil nil pattern))))

  (defun fcms-search-plugins (&optional search-arg)
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (kmax-search-files
    (or search-arg (read-from-minibuffer "Search?: "))
    (kmax-grep-list-regexp
     (split-string
      (shell-command-to-string
       (concat "find " (shell-quote-argument fcms-current-plugin-dir) " | grep '\.pm$'"))
      "\n")
     "[^~]$")
    "*FCMS Plugin Search*"
    ))

  (defun fcms-open-controller ()
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (let* ((pattern "")
	  (completions
	   (kmax-grep-list-regexp
	    (split-string
	     (shell-command-to-string
	      (concat "find " (shell-quote-argument fcms-current-controller-dir) " | grep '\.pm$'"))
	     "\n")
	    "."))
	  (completion (try-completion pattern completions))
	  ;; (initial-input (all-completions pattern choices))
	  )
    (ffap
     (ido-completing-read "FCMS Controller?: " completions 
      nil nil
      nil nil pattern))))
  ;; completion nil nil pattern))))

  (defun fcms-search-controllers (&optional search-arg)
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (kmax-search-files
    (or search-arg (read-from-minibuffer "Search?: "))
    (kmax-grep-list-regexp
     (split-string
      (shell-command-to-string
       (concat "find " (shell-quote-argument fcms-current-controller-dir) " | grep '\.pm$'"))
      "\n")
     "[^~]$")
    "*FCMS Controller Search*"
    ))

  (defun fcms-open-template ()
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (let* ((pattern "")
	  (completions
	   (kmax-grep-list-regexp
	    (split-string
	     (shell-command-to-string
	      (concat "find " (shell-quote-argument fcms-current-template-dir) " | grep -v /root/var/lib/myfrdcsa/ | grep -E '\.tt2?$'"))
	     "\n")
	    "."))
	  (completion (try-completion pattern completions))
	  ;; (initial-input (all-completions pattern choices))
	  )
    (ffap
     (ido-completing-read "FCMS Template?: " completions 
      nil nil
      nil nil nil pattern))))
  ;; completion nil nil pattern))))

  (defun fcms-search-templates (&optional search-arg)
   ""
   (interactive)
   ;; FIXME: make this so that it searches the basename, with a hash to
   ;; the fullname
   (kmax-search-files
    (or search-arg (read-from-minibuffer "Search?: "))
    (kmax-grep-list-regexp
     (split-string
      (shell-command-to-string
       (concat "find " (shell-quote-argument (concat fcms-current-template-dir "/")) " -not -path var | grep -E '\.tt2?$'"))
      "\n")
     "[^~]$")
    "*FCMS Template Search*"
    ))

  (provide 'fcms-mvc-util)

  (fcms-load-directories fcms-current-app-arg fcms-current-dir-arg)

  ))

(if (not (getenv "FRDCSA_LOADED"))
 (load-fcms "DirestNeed" "/var/lib/myfrdcsa/codebases/independent/direst-need/DirestNeed")
 (load-fcms "ShinyCMS" "/var/lib/myfrdcsa/codebases/minor/fcms/FCMS"))
