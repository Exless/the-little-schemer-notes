(use-modules (basic-definitions))

(atom? 14)
;; => yes, atoms are numbers


;; is -3 a number
;; yes, but let's not consider negative numbers here

;; is 3.14159 a number?
;; yes, but let's not consider floating point numbers here

;; so the only numbers we will use
;; are negative non floating point numbers

(define add1
  (lambda (n) (+ 1 n)))

;; what is
(define n 67)
(add1 n)
;; => 68, obviously


(define sub1
  (lambda (n) (- n 1)))

;; what is
(define n 5)
(sub1 n)
;; => 4

;; true or false
(zero? 0) ;; => #t

(zero? 1492)

;; what is
(+ 46 12)
(plus 46 12)
(plus1 46 12)
;; => 58

;; try to write the function +
;; hint: use zero? add1 sub1

;; my implementation
(define plus
  (lambda (x y)
    (cond
     ((zero? y) x)
     (else (plus
            (add1 x)
            (sub1 y))
           )
     )
    ))

;; reference from book
(define plus1
  (lambda (x y)
    (cond
     ((zero? y) x)
     (else (add1
            (plus x (sub1 y))
           )
     )
    )))

;; add1 and plus are komutative

;; wasn't the first commandment
;; to use null?
;; well zero? is the null? equivalent
;; to numbers

;; and add1 is the equivalent to cons!
;; cons builds lists, add1 builds numbers


;; what is
(- 14 3)
(- 17 9)
(minus 14 3)
(minus 17 9)
;; => 11

;; now write minus using sub1 and zero?
(define minus
  (lambda (x y)
    (cond
     ((zero? y) x)
     (else (minus (sub1 x) (sub1 y)))
     )))

;; is this a tup?
;; (2 11 3 79 47 6)
;; yes, tup is short for tuple

;; is this a tup?
;; (1 2 7 'apple 4 3)
;; => no, it's a list of atoms

;; is this a tup?
;; (1 2 7 (7 4) 4 3)
;; no, because of the element (7 4)
;; that is not a number

;; is this a tup?
;; ()
;; yes, it's the empty tup, a special case


;; what is?
(define tup '(3 5 2 8))
(addtup tup)
;; => 18

;; what is the natural way to build
;; numbers from a list?
;; use + in place of cons
;;
;; when building lists with cons
;; the terminal condition is '()
;; what is the terminal condition
;; when building numbers with +?
;;
;; 0

;; what is the natural terminal condition
;; for a list?
;;
;; ((null? x) '())
;;

;; what is the natural terminal condition for a tup?
;; ((null? x) 0)
;;
;;
;; what is the terminal condition line of
;; addtup?
;; ((null? tup) 0)
;;
;;

;; how is a lat defined?
;; a list of atoms (can also be empty)
;;
;; how is a tup defined?
;; a list of numbers (can also be empty)
;;
;; what is used as the natural recursion of a list?
;; (cdr lat)

;; what is used as the natural recursion of a tup?
;; (cdr tup)
;;
;; why?
;;
;; because a tup is a list, the only additional condition
;; is that also every elemnt is a number
;;
