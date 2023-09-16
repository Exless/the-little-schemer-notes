(load "basic-definitions.scm")

(atom? 'x)
(atom? 1)

;; true or false
(define l '(Jack Sprat could eat no chicken fat))
(lat? l) ;; yes!

;; true or false
(define l '((Jack) Sprat could eat no chicken fat))
(lat? l) ;; no, because '(Jack) is a list

;; true or false
(define l '(Jack (Sprat could) eat no chicken fat))
(lat? l) ;; no, because '(Sprat could) is a list

;; true or false
(define l '())
(lat? l)

;; true or false
;; a lat is a list of atoms

;; write the function lat? using some but
;; not nessesarily all of the following functions
;; car cdr cons null? atom? and eq?


;; .....


;; "you were not expected to be able to do this
;; yet, because you were missing some ingredients.
;; Go on to the next question"
;;

;;
;; are you rested?
;; do it again and again and again!!
;;


(define lat?
  (lambda (x)
    (cond
     ((null? x) #t)
     ((atom? (car x)) (lat? (cdr x)))
     (else #f)
     )))



;; true or false

(define l '(bacon and eggs))
(lat? l)

;; how do we dertermine the answer #t for
;; the appliation (lat? l)

;; if its null, right away return #t
;; else take the first element with car
;; check if its an atom, then recursively
;; call the function lat? on the rest
;; of the function on cdr?
;;
;; if there is a list somewhere in there
;; atom? will strike false
;; and we will return #f with the
;; (else #f) sexp

;; what is the first question asked by (lat? l)
;;  => if we have a null list


;; what is the meaning of the cond line
;; ((null? l) #t)
;; null? is also the break criteria
;; when we are done iterating through
;; a list null? evaualtes to true, and
;; tells us to stop
;;
;; (null? l) is the test sexp, if
;; if evaluates to true, we excute the argument
;; in the cond line, in our case #f (the 2nd argument
;; in the cond line is the return value, if the
;; test evaluates to true)


;; what is the meaning of the line
;;(define l '(bacon and eggs))
;;((atom? (car l)) (lat? (cdr l)))

;; if the first element, of l (car l)
;; is true, we recursively iterate
;; lat? on the rest of the list
;; with (lat? (cdr l))

;; what is the meaning of
(lat? (cdr l))
;; iterate the rest of the list l (without first elem)
;; using lat?

;; with the previous question
;; what is the argument x for lat now?

;; => (and eggs)

;; what is the next question
;; (null? '(and eggs))

;; what is the meaning of the line now?
;; ((null? x) #t)
;; it will be skipped since (null? x) will
;; evaluate to false!

;; what is the next question?
;; => ((atom? (car x)) (lat? (cdr x)))

;; what will it evaluate to this time?

;; (atom? (car x)) evaluates to true
;; and we continue iterating through the list
;; (cdr x) => '(eggs)

(lat? '(bacon (and eggs))) ;; => #f


;; is else true?
;; yes! else is always true

;; can you describe how we determined
;; the value #f for
;; (lat? l)
;; where l is (bacon (and eggs))
;;
;; first we we went and asked
;; (null? '(bacon (and eggs)) => #f
;; then we asked
;; (atom? (car '(bacon (and eggs)))) => #t
;;
;; then we passed (and eggs) with cdr to lat?
;;
;; then we asked (null? '((and eggs))) => #f
;; then we asked (atom? (car '((and eggs)))) => #f
;; then we went into else and asked if else is true
;; with (else) => and else is always true
;; so we return #t

(define l1 '())
(define l2 '(d e f g))
(or (null? l1) (atom? l2))

;; (atom? l2) => #f
;; (null? l1) => #t
;; (or #t #f) => #t
;;
(define l1 '(a b c))
(define l2 '())
(or (null? l1) (null? l2))

;; what does (or ...) do?

;; logical or between the arguments
;; with short circuits built in

;; true or false
(define lat '(coffee tea or milk))
(list? (member 'tea lat))


(define member?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     (else (or (eq? (car lat) a)
               (member? a (cdr lat))
               )
           ))))


(member? 'tea lat) ;; => #t


;; so the initial pattern for recursive list processing
;; in lisps is,
;;
;; 1. check if the funciton is null
;; return #t or #f, depending on the context,
;; or if you are folding a number, or some sort of
;; other data structure
;;
;; 2. process the car element
;; and recursively call the function
;; you are defining on cdr


;; how do we determine the value #t
;; in the function member?
;;
;; by either the car member of the list being
;; eq to a, or one of the other members
;; with get recursively eq'ed with cdr

;;
;;
;;  THE FIRST COMMANDMENT
;;
;;  always ask null? as the first question
;;  expressing any function
;;
;;

;; what happens after we ask of null? and it evaluates to false
;; we ask the else question
;;
;; is else really a question?
;; YES! else is a question whoos value
;; is always true
;;

;; NOTE: also we could have defined
;; member? as the following
(define member?
  (lambda (a lat)
    (cond
     ((null? lat) #f)
     ((eq? (car lat) a) #t)
     (else (member? a (cdr lat))
               ))))

;; a bit cleaner in my opinion
;; we trade the or for an implicit check
