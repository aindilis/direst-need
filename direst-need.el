(require 'fcms-mvc-util)

(global-set-key "\C-cdns" 'direst-need-quick-start)

(defun direst-need-quick-start ()
 ""
 (interactive)
 (load-fcms "DirestNeed" "/var/lib/myfrdcsa/codebases/independent/direst-need/DirestNeed"))
