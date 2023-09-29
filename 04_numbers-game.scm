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


;;
;; THE FIRST COMMANDMENT
;; (first revision)
;; When recurring on a list of atoms, lat ask two questions
;; about it: (null? lat) and else
;;
;; When recurring on a number, n ask two questions about it
;; (zero? n) and else
;;

;; what does cons do?
;;
;; it builds lists
;;
;; what does addtup do?
;;
;; it summs up all the numbers in a touple
;;
;; what is the terminal condition life of addtup?
;; ((null? tup) 0)
;;
;; what is the natural recursion for add tup?
;; (cons (+ (car tup) (addtup (cdr tup)))
;;
;;
;; write addtup


(define addtup
  (lambda (tup)
    (cond
     ((null? tup) 0)
     (else (+
            (car tup)
            (addtup (cdr tup))))
     )))

;; what is
(* 5 13)
;; 63


;; what does (* n m) do?
;; it multiplies n by m
;;
;; what is the terminal condition for the
;; * function?

;; (zero? m)
;;
;;
;; since (zero? m) is the terminal condition
;; m, must eventually be reduced to zero. What
;; function is used to do this?
;;
;; (sub1 m)
;;
;;
;;
;;  FOURTH COMMANDMENT
;;  Always change at least one argument while recurring. It must be changed
;;  to be closer to termination. The changing argument must be tested
;;  at the termination condition.
;;
;;  when using cdr, the test termination with null?
;;  when using sub1, the test termination with zero?
;;
;; write the function multiply


(define multiply
  (lambda (n m)
    (cond
     ((zero? m) 0)
     (else (+ n
              (multiply n (sub1 m)))
              ))
     ))

;; aleternatively
;;
(define multiply1
  (lambda (n m)
    (cond
     ((eq? m 1) n)
     (else (+ n
              (multiply n (sub1 m)))
              ))
     ))

(multiply 5 3)
(multiply 7 7)

(multiply1 5 3)
(multiply1 7 7)

;; neat

;; THE FIFTH COMMANDMENT
;; when building a value with +, always use
;; 0 for the value of the terminating line,
;; for adding 0 does not change the value of an addition.
;;
;; when building a value with *, always use 1 for the value
;; of the terminating line, for multiplying by 1 does not
;; change the value of a multiplication
;;
;; When building a value with cons, always consider () for
;; the value of the terminating line

;; what is
(define tup1 '(3 6 9 11 4))
(define tup2 '(8 5 2 0 7))
(tup+ tup1 tup2)


;; how many questions to ask when recurring on a tup?
;; two, (null? tup) and else
;;
;; how many questions to ask when recurring on two tups?
;; 4, (null? tup1) (not null tup 1) (null? tup2)  (not null tup 2)

;; write the function tup+

(define tup+
  (lambda (tup1 tup2)
    (cond
     ((and (null? tup1) (null? tup2)) '())
     (else (cons
            (+ (car tup1) (car tup2))
            (tup+ (cdr tup1) (cdr tup2))))
     )))


;; what problem arises when we want (tup+ '(3 7) (4 6 8 1))
;; we will get an error, because eventually the 1st tup will be '()
;; and you cant do a cdr of '()
;;
;;  in actually, we would want => (7 13 8 1) to be the answer
;;
;; can we still write tup+ even if the tups
;; are not the same length?
;; => yes
;;
;; what new terminal condition line can we add to get the correct
;; final value?
;; (null? tup1)
;; (null? tup2)
;; (and (null? tup1) (null? tup2))

;; here is a defintion of tup+ that works for any two tups
(define tup+-unclean
  (lambda (tup1 tup2)
    (cond
     ((and (null? tup1) (null? tup2)) '())
     ((null? tup1) tup2)
     ((null? tup2) tup1)
     (else (cons
            (+ (car tup1) (car tup2))
            (tup+-unclean (cdr tup1) (cdr tup2))))
     )))

(tup+-unclean
 '(3 7)
 '(4 6 8 1))

(tup+-unclean
 '(4 6 8 1)
 '(3 7)
 )
;; seems to work
;;
;; can you simplify the function?
;;
(define tup+-clean
  (lambda (tup1 tup2)
    (cond
     ((null? tup1) tup2)
     ((null? tup2) tup1)
     (else (cons
            (+ (car tup1) (car tup2))
            (tup+-unclean (cdr tup1) (cdr tup2))))
     )))

(tup+-clean
 '(3 7)
 '(4 6 8 1))

(tup+-clean
 '(4 6 8 1)
 '(3 7)
 )

;; what is
(> 12 133)
;; #f

;; what is
(> 120 11)
;; #t

;; on how many number do we have to recur > ?
;;
;; n and m

;; how do we recur
;; using sub1
;;
;; now many questions to ask about n and m
;; (null? n)
;; (null? m)
;; else


;; write the function greater-than
;; using zero and sub1

(define greather-than
  (lambda (n m)
    (cond
     ((null? n) #f)
     ((null? m) #t)
     (else (greather-than (sub1 n) (sub1 m)))
     )))

(greather-than 120 11)

;; here is the definition of equals-num

(define equals-sum1
  (lambda (n m)
    (cond
     ((zero? n) (zero? m))
     ((zero? m) #f)
     (else (equals-sum
            (sub1 n)
            (sub1 m)
            )))))

(equals-sum1 3 20)
(equals-sum2 20 20)

;; now write it using < and >
(define equals-sum2
  (lambda (n m)
    (cond
     ((< n m) #f)
     ((> n m) #f)
     (else #t)
     )))

;; does this mean we have two different
;; functions for testing equality of atoms?


;; yes! its = numbers, and eq? for the others
(up 1 1) ;; => 1
(up 2 3) ;; => 8
(up 5 3) ;; => 125

;; now write the function up

(define up
  (lambda (n m)
    (cond
     ((zero? m) 1)
     (else (* n (up n (sub1 m))))
     )))



;; what is a good name for this function
(define ???
  (lambda (n m)
    (cond
     ((< n m) 0)
     (else (add1 (??? (- n m) m)))
     )))

;; what does the first question ask?
;; => it determines wether the first argument
;; is less than the 2nd one
;;
;; what does the 2nd question ask?
;; it adds as many 1's as ms can fit in ns
;;
;; in other words, division

;; what is (/ 15 4)
;; => 3
;;
;;
;; how do we get there?
;; (/ 15 4) = 1 + (/ 11 4)
;;          = 1 + 1 + (/ 7 4)
;;          = 1 + 1 + 1 + (/ 3 4)
;;          = 1 + 1 + 1 + 0
;;          = 3

;; what is the value of
(define lat '(hotdogs with mustard sauerkraut and pickels))
(length lat) ;; 6

;; write the funciton length
(define length1
  (lambda (lat)
    (cond
     ((null? lat) 0)
     (else (add1 (length1 (cdr lat))))
     )))

(length1 lat) ;; 6

;; what is
(define lat '(lasagna spagetti ravioli macaroni meatball))
(pick 4 lat) ;; => macaroni
(pick-ref 4 lat) ;; => macaroni

;; what is
(pick 0 '(a)) ;; => no answer
(pick-ref 0 '(a)) ;; => no answer

;; write the funciton pick
(define pick
  (lambda (n lat)
    (cond
     ((zero? n) '())
     ((eq? n 1) (car lat))
     (else (pick (sub1 n) (cdr lat)))
     )))

;; reference implementation from book
(define pick-ref
  (lambda (n lat)
    (cond
     ((zero? (sub1 n)) (car lat))
     (else (pick-ref (sub1 n) (cdr lat))))))

;; what is
(define n 3)
(define lat '(hotdogs with hot mustard))
(rempick n lat) ;; => (hotdogs with mustard)

;; write rempick
(define rempick
  (lambda (n lat)
    (cond
     ((zero? (sub1 n)) (cdr lat))
     (else (cons (car lat)
            (rempick (sub1 n) (cdr lat))))
     )))

;; true or false?
(number? 'tomato)

;; true or false?
(number? 76)

;; can you write number?
;; => no because it's a primitive
;; function

;; write no-nums which gives
;; as a final value a lat
;; obtained by removing all the numbers from the lat

(define no-nums
  (lambda (lat)
    (cond
    ((null? lat) '())
    ((number? (car lat)) (no-nums (cdr lat)))
    (else (cons (car lat) (no-nums (cdr lat))))
    )))


;; test
(define lat '(5 pears 6 prunes 9 dates))
(no-nums lat)
(all-nums)

;; write all nums, which extracts
;; a tup of all the numbers in lat
(not #f)

(define all-nums
  (lambda (lat)
    (cond
     ((null? lat) '())
     ((not (number? (car lat)))
      (all-nums (cdr lat)))
     (else (cons
            (car lat)
            (all-nums (cdr lat))
            )))))



(define lat '(5 pears 6 prunes 9 dates))
(all-nums lat)

;; write the function egan?
;; which is true if its
;; two arguments a1, a2
;; are the same atom, remember
;; to use = for numbers and eq? for other atoms

(define egan?
  (lambda (a1 a2)
    (cond
     ((and (number? a1) (number? a2)) (= a1 a2))
     (else (eq? a1 a2))
     )))

(egan? 1 3)
(egan? 3 3)
(egan? 'a 'a)
(egan? 1 'a)
