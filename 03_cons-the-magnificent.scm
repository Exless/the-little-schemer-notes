(use-modules (basic-definitions))

(atom? 'a)
(member? 'a '(a b c))
;; modules work


(rember 'mint '(lamb chops and mint jelly))
;; => (lamb chops and jelly)

;; rember stands for remove a member

(define a 'cup)
(define lat '(coffee cup tea cup and hick cup))
(rember a lat) ;; (coffee tea cup and hick cup)

;; what does (rember a lat) do?
;;
;; it removes the first occourance of a (if there is any)
;; from lat

;; what steps should we use to do this?
;;
;; create a 2nd list, fill it up element wise,
;; and where the member to be removed is equal
;; to the current iterated member we remove it
;; and then attach the rest of the list to it!
;;
;; scratch that!
;; first we need to do null?... don't forget about the
;; first commandment!

;; so first we do (null? lat)
;;
;; and what if (null? lat) is true?
;; => return '()
;;
;; what do we know if (null? lat) is not true?
;; => that we have a list with at least one atom in it
;;
;; is there any other question we should ask?
;; about the lat?
;;
;; => if (eq? (car lat) a)
;;
;; how do we ask questions?
;; by using (cond
;;              ((question1) return-sexp1)
;;              ((question2) return-sexp2)
;;              )
;;
;;
;; how do we ask if a is the same as (car lat)
;; (eq? (car lat) a)
;;
;; what would be the value of (rember a lat)
;; if (eq? (car lat) a) was true?
;; => (cdr lat)
;;
;; what do we do if a is not the same as
;; (car lat)
;; we want to keep (car lat) but we also want to
;; know if (cdr lat) has the a in it, and remove it
;;
;; how do we remove the first occurence of a
;; in the rest of lat?
;; (rember a (cdr lat))
;;
;; is there any other question we should ask?
;; => No.



;; let's write down what we have so far

(define rember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) a) (cdr lat))
     (else (cons (car lat)
                 (rember a (cdr lat))
                 ))
     )))

;; welp i figured out the rest on my own it seems
;; nice

;; the answer was figured out by me
;; but here is the commandment with cons
;;
;; THE SECOND COMMANDMENT
;; USE cons TO BUILD LISTS
;;


;; what is
(define l '((apple peach pumpkin)
            (plum pear cherry)
            (grape raisin pea)
            (bean carrot egpglant)))

(firsts l)
;; => (apple plum grape bean)

;; what is
(define l '((a b) (c d) (e f)))
(firsts l)
;; => (a c e)

(define l '())
(firsts l)
;; => '()

;; what is
(define l '((five plums)
            (four)
            (eleven green oranges)))
(firsts l)
;; => (five four eleven)

(define l '(((five plums) four)
           (eleven green oranges)
           ((no) more)))
(firsts l)
(seconds l)
;; => ((five plums) eleven (no))

;; what does first do?
;; takes a list of lists
;; returns a list with each element
;; being the first element from each
;; list

;; try to write the funciton firsts

(define firsts
  (lambda (x)
    (cond
     ((null? x) '())
     (else
      (cons
       (car (car x))
       (firsts (cdr x))
       ))
     )))

;; try to write the funciton seconds
(define seconds
  (lambda (x)
    (cond
     ((null? x) '())
     (else (cons
            ;; get the 2nd element
            (car (cdr (car x)))
            (seconds (cdr x))
            ))
     )))


;;
;; THE THIRD COMMANDMENT
;; WHEN BUILDING A LIST, DESCRIBE THE FIRST TYPICAL ELEMENT
;; AND THEN cons IT ONTO THE NATURAL RECURSION

;; what is the typical element and the natural recursion
;; of first?

(cons
 (car (car x))
 ;; ^ typical element
 firsts (cdr x)
 ;; ^ natural recursion
 )

;; for the 3rd commandment the cond line
((null? x) '())
;; is important
;; we can not return #f,
;; that is only valid when we want to answer
;; questions about lists
;;
;; when we want to actually build lists
;; as we are commanded by cons
;; we need to use '() as the null?


;; what is
(define old 'fudge)
(define new 'topping)
(define lat '(ice cream fudge for dessert))

(insertR new old lat)
(insertL new old lat)
;; => (ice cream fudge topping for dessert)
(define old 'and)
(define new 'jalapeno)
(define lat '(tacos tamales and salsa))

(insertR new old lat)
(insertL new old lat)
;; => (tacos tamales and jalapeno salsa)

;; what does (insertR new old lat) do?
;; goes from the right to the left in lat
;; when it finds the old element
;; it inserts the new into it from the right


;; try to write insertR

(define insertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat))
      (cons (car lat)
            (cons new (cdr lat)))
      )
     (else (cons
            (car lat)
            (insertR new old (cdr lat)))
           )
     )))

;; try with insertL
(define insertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat))
      (cons new
            lat))
     (else
      (cons (car lat) (insertL new old (cdr lat)))
      )))
  )

;; now try subst
;; subst should replace old with new
;; and return the new list

(define old 'and)
(define new 'jalapeno)
(define lat '(tacos tamales and salsa))

(subst new old lat)
;; => (tacos tamales jalapeno salsa)

(define subst
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? old (car lat)) (cons
                           new (cdr lat)))
     (else (cons
            (car lat)
            (subst old new (cdr lat))))
     ))
  )

;; now try subst2


(define subst2
  (lambda (new o1 o2 lat)
    (cond
     ((null? lat) '())
     ((eq? o1 (car lat)) (cons new (cdr lat)))
     ((eq? o2 (car lat)) (cons new (cdr lat)))
     (else (cons
            (car lat)
            (subst2 new o1 o2 (cdr lat))
                 ))
     )))

;; rewrite subst2 as subst3 using an or

(define subst3
  (lambda (new o1 o2 lat)
    (cond
     ((null? lat) '())
     ((or
       (eq? o1 (car lat))
       (eq? o2 (car lat))
       ) (cons new (cdr lat)))
     (else (cons
            (car lat)
            (subst3 new o1 o2 (cdr lat))
            ))
     )))






(define new 'vanilla)
(define o1 'chocolate)
(define o2 'banana)
(define lat '(banana ice cream
              with cocolate topping))

(subst2 new o2 o1 lat)
(subst3 new o1 o2 lat)
;; => (vanila ice cream with cocolate topping)

;; write the function multirember which
;; gives as its final value the lat with
;; all occurences of a removed

(define multirember
  (lambda (a lat)
    (cond
     ((null? lat) '())
     ((eq? a (car lat))
      (multirember a (cdr lat)))
     (else (cons (car lat) (multirember a (cdr lat))))
     )))

(define a 'cup)
(define lat '(coffee cup tea cup and hick cup))
(multirember a lat)


;; now write the function multiinsertR

(define multiinsertR
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old)
      (cons
       (car lat)
       (cons new
             (multiinsertR new old (cdr lat))
             )))
     (else
      (cons
       (car lat)
       (multiinsertR new old (cdr lat))))
     )))

;; now do multiinsertL
(define multiinsertL
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old)
      (cons
       new
       (cons
        (car lat)
        (multiinsertL new old (cdr lat)))
       ))
     (else
      (cons
       (car lat)
       (multiinsertL new old (cdr lat))
       ))
     )))

(define new 'sugar)
(define old 'cup)
(define lat '(coffee cup tea cup and hick cup))
(multiinsertR new old lat)
(multiinsertL new old lat)


;;
;; THE FOURTH COMMANDMENT (preliminary)
;; Always change AT LEAST ONE ARGUMENT while recurring.
;; It must be changed to be CLOSER TO TERMINATION.
;; The chaning argument must be tested in the
;; termination condition: WHEN USING cdr,
;; TEST TERMINATION WITH null?
;;

;; now write the function multisubst
(define multisubst
  (lambda (new old lat)
    (cond
     ((null? lat) '())
     ((eq? (car lat) old)
      (cons new
            (multisubst new old (cdr lat))
            ))
     (else
      (cons
       (car lat)
       (multisubst new old (cdr lat))
       ))
     )))

(define new 'sugar)
(define old 'cup)
(define lat '(coffee cup tea cup and hick cup))
(multisubst new old lat)
