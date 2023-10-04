

(define a 'cup)
(define l '((coffee)
            cup
            ((tea) cup)
            (and (hick))
            (cup)
            ))
;; what is
;;
(rember* a l)

;; => (
;;  (coffee)
;;  ((tea))
;;  (and (hick))
;; )
;; note: rember* is pronounced
;; idiomatically as rember-star

(define a 'sauce)
(define l '(((tomato sauce))
            ((bean) sauce)
            (and ((flying) sauce))
            ))

;; what is
(rember* a l)

;; =>
;; (
;;  ((tomato))
;;  ((bean) sauce)
;;  (and ((flying)))
;; )

;; now write rember*

(define rember*
  (lambda (a l)
    (cond
     ((null? l) '())
     ((list? (car l))
      (cons
       (rember* a (car l))
       (rember* a (cdr l))))
     ((eq? a (car l))
      (rember* a (cdr l)))
     (else
      (cons
       (car l)
       (rember* a (cdr l))))
     )))

;; what is
(define old 'chuck)
(define l '(
           (how much (wood))
           could
           ((a (wood) chuck))
           (((chuck)))
           (if (a) ((wood chuck)))
           could chuck wood
            ))
;; =>
;; '(
;;   (how much wood (wood))
;;   could
;;   ((a (woo) chuck roast))
;;   (((chuck roast)))
;;   (if (a) ((wood chuck roast)))
;;   could chuck roast wood
;;   )
;;
;; wood
(insertR* new old l)

;; write insertR*

(cons a '(b c))  ;; => '(a b c)
(define insertR*
  (lambda (new old l)
    (cond
     ((null? l) '())
     ((list? (car l))
      (cons
       (insertR* new old (car l))
       (insertR* new old (cdr l))))
     ((eq? (car l) old)
      (cons
       (car l)
       (cons new
             (insertR* new old (cdr l)))))
     (else (cons (car l)
                 (insertR* new old (cdr l))))
     )))

;; alright, looks good
;; test also works


;; THE FIRST COMMANDMENT
;; (final revision)
;;
;; When recurring on a list of atoms lat
;; ask two questions about it
;; (null? lat) and else
;;
;; When recurring on a number n, ask two questions
;; about it: (zero? n) and else
;;
;; When recurring on a list of S-expressions "lists of lists" l
;; ask three questions about it:
;; (null? l) (atom? (car l)) and else
;; in my case i ask 4, to make the cond more readable
;;
;; (null? l) (list? (car l)) (is-condition-met? (car l) condition) and else

;; how are insertR* and rember* similar?
;;
;; each recurs on the (car l) if (car l) if (list? (car l)) => #t

;; how are rember* and multirember different?
;;
;; multirember -> works only on flat lists
;; rember* -> works on lists that are arbitrarily deep

;; said in a more lispy way:
;;
;; rember* recurs on (car l) and (cdr l)
;; multirember recurs only on (cdr l)

;; how are all *-functions similar?
;;
;; they can be used on lists that are
;; arbitrarily deep

;; in the terms of the book and said in a more
;; programmatic way
;;
;; they always ask 3 questions:
;; -> (null? l)
;; -> (list? (car l))
;; -> else



;; THE FOURTH COMMANDMENT
;; (final revision)
;;
;; Always change at least one argument
;; while recurring.
;;
;; When recurring on a list of atoms, use (cdr lat)
;;
;; When recurring on a number n, use (sub1 n)
;;
;; And when recurring on a list of S-expressios l, use (car l) and (cdr l)
;; in case (list? (car l)) => #t
;;
;; the recursion must be changed with every iteration
;; to be closer to termination. The chaning argument
;; must be tested in the termination condition:
;;
;; when using cdr, test termination with null?
;; when using sub1, test termination with zero?

;; what is
(define a 'banana)
(define l '(
            (banana)
            (split ((((banana ice))))
                   cream (banana))
            (banana)
            (bread)
            (banana brandy)
            ))

(occour* a l)
'(a b c d)
;; => 5

;; write the occour* function
(define occour*
  (lambda (a l)
    (cond
     ((null? l) 0)
     ((list? (car l))
      (+
       (occour* a (car l))
       (occour* a (cdr l))))
     ((eq? a (car l))
      (add1 (occour* a (cdr l))))
     (else (occour* a (cdr l)))
     )))

;; write subst*
(define subst*
  (lambda (new old l)
    (cond
     ((null? l) '())
     ((list? (car l))
      (cons
       (subst* new old (car l))
       (subst* new old (cdr l))))
     ((eq? old (car l))
      (cons
       new
       (subst* new old (cdr l))
       ))
     (else
      (cons
       (car l)
       (subst* new old (cdr l))))
     )))


;; test
(define new 'orange)
(define old 'banana)
(define l '(
            (banana)
            (split ((((banana ice))))
                   cream (banana))
            (banana)
            (bread)
            (banana brandy)
            ))

(subst* new old l)

;; looks good!



;; write insertL
;;
;; helper function so I don't have to cons
;; twice
(cons* 'a 'b '(c d e))

(define insertL*
  (lambda (new old l)
    (cond
     ((null? l) '())
     ((list? (car l))
      (cons
       (insertL* new old (car l))
       (insertL* new old (cdr l))))
     ((eq? old (car l))
      (cons* old new (cdr l)))
     (else (cons
            (car l)
            (insertL* new old (cdr l)))
     ))))


;; test
(define new 'pecker)
(define old 'chuck)
(define l '(
            (how much (wood))
            could
            ((a (wood) chuck))
            (((chuck)))
            (if (a) ((wood chuck)))
            could chuck wood
            ))
(insertL* new old l)
;; looks good


;; now write member*

;; one way (probably cheating)
(define member*
  (lambda (a l)
    (> (occour* a l) 0)))

;; the way it was probably meant to be written
(define member1*
  (lambda (a l)
    (cond
     ((null? l) #f)
     ((list? (car l))
      (or
       (member1* a (car l))
       (member1* a (cdr l))))
     ((eq? a (car l)) #t)
     (else (or (member1* a (cdr l))))
     )))



(define a 'chips)
(define l '((potato) (chips ((with) fish) (chips))))
(define ll '(((())) this))
(member* a l)


;; write the function leftmost
(define leftmost
  (lambda (l)
    (cond
     ((null? (car l)) '())
     ((list? (car l)) (leftmost (car l)))
     (else (car l))
     )))


;; test
(define l
  '((potato)
   (chips (with) fish)
   (chips))
  )


(leftmost l)


;; a simpler definition
(define leftmost1
  (lambda (l)
    (cond
     ((atom? (car l)))
     (else (car l))
     )))
