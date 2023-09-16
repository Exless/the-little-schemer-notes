; is this an atom?
(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))
    ))

; this should evaluate to not an atom
(atom? (quote ()))

; is this an atom?
(atom? 'atom) ; => yes, just a bunch of characters
(atom? 'turkey)

(atom? 1492) ; => yes, just a number

(atom? 'u) ; => yes, just a letter

(atom? '*abc$) ; => yes, however "(" and  ")" are
               ; kinda taboo here

(atom? '(atom)) ; => the function atom is just
                ; data in this case


(list? '(atom turkey or)) ; => yes, its just a bunch of
                          ; atoms enclosed by parentheses

(define sexp?
  (lambda (x)
    (or (atom? x) (list? x))
    )
  )

(sexp? 'xyz) ; => yes, because all s-expressions are atoms
(sexp? '(x y z)) ; => yes because it is a list

(sexp? '((x y) y)) ; => yes, because all lists are sexps

(sexp? '(how are you doing so far)) ; => yes, because its
                                    ; a collection of
                                    ; s-expressions
                                    ; enclosed by parentheses

(length '(how are you doing so far)) ; => 6

(length '(((how) are) ((you) (doing so)) (far))) ; => 3

(atom? '()) ; => no, because '() is just a list
(list? '(() () () ()))  ; => yes, because it is a collection
                        ; of sexps encodsed in parenthesies

(car '(a b c)) ; => a, because it is the first sexp of
               ; this list

(define l '((a b c) x y z))

(car l) ; => (a b c) because it's the first sexp of l

;; (car 'hotdog) ; => you cannot ask for the car of an
              ; atom

;; (car '())  ; => you cannot ask of the car of an
           ; empty list

;;
;; The law of car
;;
;; The primitive car is defined only for
;; non empty lists!
;;

(define l '(((hotdogs)) (and) (pickle) (relish)))

;; what is the car of l?
(car l)

(define l '(((hotdogs)) (and)))

;; what is
(car (car l))


;; what is
(cdr '(a b c))

;; what is
(cdr '(hamburger))


;; what is
(define l '((x) t r))
(cdr l)

;; what is
;; (cdr 'hotdogs) => you cannot ask for the
;; cdr of an atom!

(atom? 'hotdogs)

;; what is
;; (cdr '()) => you cannot ask for the cdr of
;; the null list

;;
;; THE LAW OF cdr
;;
;; The primitive cdr is defined
;; only non-empty lists. The cdr of
;; an non empty list is always another list
;;


;; what is
(define l '((b) (x y) ((c))))
(car (cdr l))

;; what is
(define l '(a (b (c)) d))
;; (cdr (car l)) => no answer, since
;; (car l) returns an atom and cdr
;; can't handle atoms

;; what does car take as an argument
;; what does cdr take as an argument
;; => both take any non empty lists

(define l '(butter and jelly))
(define a 'peanut)
(cons a l)
;; also reads as cons the atom a onto the list l

;; what is
(define s '(bannana and))
(define l '(peanut butter and jelly))
(cons s l)

;; maybe not what you expect, because
;; cons does not concatinate, but
;; adds any S-expression to the front
;; of a list

(define s '((help) this))
(define l '(is very ((hard) to learn)))

(cons s l)

;; =>  (((help) this) is very ((hard) to learn))

;; what does cons take as its argument
;; => 1. any S-expresison
;; 2. any list

;; what is
(define s '(a b (c)))
(define l '())
(cons s l)
;; => because l is a list,
;; the null list also applies

;; what is
(define s 'a)
(define l '())
(cons s l)


;; what is
(define s '((a b c)))
(define l 'b)
;; (cons s l) => no answer
;; because 2. argument must be a list!

;; what is
(define s 'a)
(define l 'b)
;; (cons s l) => no answer... Why?


;;
;;
;; THE LAW OF cons
;;
;; The primitive cons takes two arguments
;; the 2nd argument to cons must be a list.
;; The result is a list
;;

;; what is

(define s 'a)
(define l '((b) c d))
;; (cons s (car l)) => no answer, why?

;; what is

(define s 'a)
(define l '((b) c d))
(cons s (car l))

;; what is
(define s 'a)
(define l '((b) c d))
(cons s (cdr l))


;; is it true
(define l '())
;; l is the null list?
(null? l)
;; => yes, because it's a list comprised of zero expressions
;; and l is a reference to it


;; is it true
(null? '(a b c))
;; false, because '(a b c) is a non-empty list

(null? 'spagetti)
;; no answer (technically #f)
;; because you cannot ask null? of an atom
;; in practice (null?) is false for everything
;; except '()

;;
;; THE LAW OF null?
;; the primitive null? is defined
;; only for lists
;;

;; is it true or false:
(define s 'harry)
(atom? s)

;; is it true
(define s '(harry had a heap of apples))
(atom? s) ;; => false, s is a list

;; how many arguments does an atom take
;; and what are they?
;;
;; 1 & not a list


;; true or false
(define l '(harry had a heap of apples))
(atom? (car l))

;; true or false
(define l '(harry had a heap of apples))
(atom? (cdr l))

;; true or false
(define l '(harry))
(atom? (cdr l)) ;; because a '() is not an atom

;; true or false
(define l '(swing low sweet cherry oat))
(atom? (car (cdr l)))

;; true or false
(define l '(swing (low sweet) cherry oat))
(atom? (car (cdr l)))

;; true or false
(define a1 'harry)
(define a2 'harry)
;; are a1 and a2 the same atom?
;; yes, because they both reference
;; i.e. represent 'harry

;; true or false
(eq? a1 a2)

;; eq? i.e. are the arguments the same non
;; numeric atom?

(define a1 'margarine)
(define a2 'butter)
(eq? a1 a2)

;; how many arguments does eq? take
;; and what are they?

;; two, and both of the must
;; be non numeric atoms

;; true or false?
(eq? '() '(strawberry))

;; true or false?
(eq? 6 7)

;;
;; THE LAW OF eq?
;;
;; the primitive eq? takes two arguments
;; each must be a non-numeric atom
;;

;; true or false
(define l '(mary had a little lamb chop))
(define a 'mary)
(eq? (car l) a)



;; true or false
(define l '(soured milk))
(define a 'milk)
(eq? (cdr l) a)

;; true or false
(define l '(beans beans we need jelly beans))
(eq? (car l) (car (cdr l)))
