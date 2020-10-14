;; exported FRDCSA helper functions for direst need

(defun join (separator list)
  "Same as Perl join"
  (setq value "")
  (let* ((first nil)
	 (value
	  (dolist (elt list value)
	    (setq value (concat value (if first separator "") elt))
	    (setq first t))))
   value))

(defun non-nil (arg)
 (if (symbolp arg)
  (and (boundp arg)
   (not (equal arg nil)))
  t))

(defvar frdcsa-el-os-directory-separator "/")

(defun frdcsa-el-concat-dir (list)
 (listp list)
 (join frdcsa-el-os-directory-separator (mapcar #'kmax-strip-trailing-forward-slashes list)))

(defun kmax-strip-trailing-forward-slashes (filename)
 (string-match "^\\(.+?\\)\/*$" filename)
 (match-string 1 filename))

(defun kmax-grep-list-regexp (list regexp &optional temporary-case-fold-search)
 "accept a list and grep through the list for matches, returning the matching list"
 (let ((outputlist nil)
       (current-case-fold-search case-fold-search))
  (setq case-fold-search temporary-case-fold-search)
  (mapcar (lambda (item) (if (non-nil (string-match regexp item)) (push item outputlist))) list)
  (setq case-fold-search current-case-fold-search)
  outputlist))

(defun kmax-search-files (search files &optional buffer-name flags filters)
 ""
 (interactive)
 (let* ((file-containing-files-to-search (make-temp-file "/tmp/kmax-search-files-" nil ".txt"))
	(command
	 (concat
	  "tr '\\n' '\\0' <"
	  file-containing-files-to-search
	  " | LANG=C xargs -r0 grep -iF "
	  flags
	  " "
	  (shell-quote-argument search)
	  " "
	  (or filters "")
	  " 2> /dev/null")))
  (kmax-write-string-to-file (join "\n" files) file-containing-files-to-search)
  (if buffer-name
   (run-in-shell command buffer-name)
   (shell-command-to-string command))))

(defun kmax-write-string-to-file (string file)
 ""
 (save-excursion
  (let ((buffer-name "*kmax-save-string*"))
   (switch-to-buffer (get-buffer-create buffer-name))
   (insert string)
   (write-file file)
   (kill-buffer (current-buffer)))))

(defun run-in-shell (command &optional name optional-message mode)
 ""
 (let (
       (mybuffer
	(progn
	 ;; (split-window-right)
	 (get-buffer-create 
	  (or name
	   (generate-new-buffer-name "*shell*")))))
       )
  (message command)
  (shell mybuffer)
  (if mode
   (kmax-funcall mode nil))
  ;; (switch-to-buffer mybuffer)
  (radar-shell-do-command command optional-message)
  ))

(defun kmax-funcall (function args &optional else finally error-msg)
 ""
 ;; e.g. (kmax-funcall 'concat (list "a" "b"))
 (interactive)
 ;; (kmax-fixme-silent "implement else finally etc")
 (condition-case ex
  (progn
   (eval (append (list 'funcall 'function) args))
   )   
  ('error
   (see (or error-msg (concat "Function <" function "> did not work with args <" (join " " args) ">"))))))

(defun radar-shell-do-command (command &optional optional-message delay)
 ""
 (progn
  (end-of-buffer)
  
  ;; FIXME: have to do this somehow without making it a command that
  ;; is then executed

  ;; (if optional-message
  ;;  (insert (concat optional-message "\n"))
  ;; )

  (insert command)
  (sit-for (or delay 2))
  (ignore-errors
   (eshell-send-input))
  (ignore-errors
   (comint-send-input))
  )
 )

(provide 'fcms-mvc-util-exported)
