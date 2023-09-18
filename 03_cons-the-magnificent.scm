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
