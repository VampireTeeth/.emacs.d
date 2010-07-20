;;-*-coding: utf-8; mode: emacs-lisp -*-
;; TODO: switch to templates for the programming modes

(define-abbrev-table 'c++-mode-abbrev-table
  '(
    ;; ("for" "" c++-for-skel)
    ;; ("if" "" c++-if-skel)
    ))

;; ("if" "if (  ) ;" (lambda()
;; 			(backward-char 5)) 0)

;; ("for" "for ( = ; ; )
;;   {

;;   }" (lambda()
;;        (previous-line)) 0)

;;   ("ifl" "if (  )
;;   ;
;; else
;;   ;" (lambda()
;; 	 (previous-line 3)
;; 	 (backward-char)) 0)
;;   )

(define-abbrev-table 'c-mode-abbrev-table 
  '(
    ;; ("for" "" c++-for-skel)
    ;; ("if" "" c++-if-skel)
    ))

(define-abbrev-table 'global-abbrev-table '(    ))

(define-abbrev-table 'lisp-mode-abbrev-table '(    ))

(define-abbrev-table 'shell-mode-abbrev-table '(    ))

(define-abbrev-table 'basic-text-mode-abbrev-table 
  '(("bg" "background" nil 0)
    ("distrib" "distribution" nil 0)
    ))

(define-abbrev-table 'text-mode-abbrev-table
  '(("bg" "background" nil 0)
    ("sig" "signal" nil 0)
    ("distrib" "distribution" nil 0)
    ("Delta" "Δ" nil 0)
    ("Gamma" "Γ" nil 0)
    ("Lambda" "Λ" nil 0)
    ("Omega" "Ω" nil 0)
    ("Phi" "Φ" nil 0)
    ("Pi" "Π" nil 0)
    ("Psi" "Ψ" nil 0)
    ("Sigma" "Σ" nil 0)
    ("Theta" "Θ" nil 0)
    ("alpha" "α" nil 0)
    ("beta" "β" nil 0)
    ("chi" "χ" nil 0)
    ("delta" "δ" nil 0)
    ("epsilon" "ε" nil 0)
    ("eta" "η" nil 0)
    ("gamma" "γ" nil 0)
    ("lambda" "λ" nil 0)
    ("mu" "μ" nil 0)
    ("nu" "ν" nil 0)
    ("omega" "ω" nil 0)
    ("phi" "φ" nil 0)
    ("pi" "π" nil 0)
    ("psi" "ψ" nil 0)
    ("rho" "ρ" nil 0)
    ("sigma" "σ" nil 0)
    ("tau" "τ" nil 0)
    ("theta" "θ" nil 0)
    ))
