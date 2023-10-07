;; is 1 an arithmetic expression?
;; => yes
;;
;; is 1 + 3 an arithmetic expression?
;; => yes
;;
;; is 1 + 3 * 4 an arithmetic expression?
;; => definitely
;;
;; is cookie an arithmetic expression?
;; => yes (wierd)
;;
;; what is an arithmetic expression
;;
;; for the purposes of this chapter:
;; it's either an atom (including numbers),
;; or two arithmetic expressions combined
;; by +, * or exp
;;
;;
;; what is '(a)
;; => a
;;
;; what is '+
;; => the atom +, not the function
;;
;; what does '* stand for?
;; => the atom *, not the operation

(define y 'a)
;; true or false
(eq? '(a) y)

;; is (n + 3) an arithmetic expression?
;; no, since there are paretheses
;; around n + 3, our definition of arithmetic
;; expressions does not mention that!
;;
;; what could you call
(n + 3)
;; an arithmetic expression

;; true or false
(define x 1)
(numbered? x)
;; => #t

;; how do you represent 3 + 4 * 5
;;
;;   '(+ 3 (* 4 5)))
(numbered? '(3 + (4 + 5)))

;; true or false
;; => #t
;; it is a function that determines
;; wether a representation of an arithmetic
;; expression contains only numbers besides the
;; +, * and exp
(car (cdr (cdr '(1 + 2))))

;; write numbered such that it delivers
;; the answer wether we have an arithmetic expression
(define numbered?
  (lambda (aexp)
    (cond
     ;; why ask the atom? and then number?
     ;; => because we want to know if all
     ;; arithmetic expressions that are atoms
     ;; are numbers
     ((atom? aexp) (number? aexp))
     ;; (car cdr ...) => the 2nd element
     ((eq? (car (cdr aexp)) '(+))
      (and
       (numbered? (car aexp))
       (numbered? (car (cdr (cdr aexp)))))
      )
     ((eq? (car (cdr aexp)) '(*))
      (and
       (numbered? (car aexp))
       (numbered? (car (cdr (cdr aexp)))))
      )
     ((eq? (car (cdr aexp)) '(expt))
      (and
       (numbered? (car aexp))
       (numbered? (car (cdr (cdr aexp)))))
      )
     (else #f)
     )))

;; simplify it now
(define numbered?
  (lambda (aexp)
    (cond
     ;; why ask the atom? and then number?
     ;; => because we want to know if all
     ;; arithmetic expressions that are atoms
     ;; are numbers
     ((atom? aexp) (number? aexp))
     ((eq? (car (cdr aexp)) '(expt))
      (and
       (or (eq? ('+ (car (cdr aexp))))
           (eq? ('expt (car (cdr aexp))))
           (eq? ('* (car (cdr aexp))))
           )
       (numbered? (car aexp))
       (numbered? (car (cdr (cdr aexp)))))
      )
     (else #f)
     )))

;; what is
(define u 13)
(value u)
;; => 13

;; what is
(value '(1 + 3))
;; => 4

;; what is
(value '(1 + (3 expt 4)))
;; => 82

;; what is
(define z 'cookie)
(value z)
;; => no answer

;; write value
(define value
  (lambda (nexp)
    (cond
     ((not (numbered? nexp)) '())
     ()
     )))
