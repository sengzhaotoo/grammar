;;;; -*- Mode: Lis
;;; Syntax: Common-Lisp -*-
;;; Code from Paradigms of Artificial Intelligence Programming
;;; Copyright (c) 1991 Peter Norvig

;;; ==============================

(defun one-of (set)
  "Pick one element of set, and make a list of it."
  (list (random-elt set)))

(defun random-elt (choices)
  "Choose an element from a list at random."
  (elt choices (random (length choices))))

;;; ==============================

(defparameter *simple-grammar*
  '((sentence -> (noun-phrase verb-phrase))
    (noun-phrase -> (Article Noun))
    (verb-phrase -> (Verb noun-phrase))
    (Article -> the a)
    (Noun -> man ball woman table)
    (Verb -> hit took saw liked))
  "A grammar for a trivial subset of English.")

(defvar *grammar* *simple-grammar*
  "The grammar used by generate.  Initially, this is
  *simple-grammar*, but we can switch to other grammers.")

;;; ==============================

(defun rule-lhs (rule)
  "The left hand side of a rule."
  (first rule))

(defun rule-rhs (rule)
  "The right hand side of a rule."
  (rest (rest rule)))

(defun rewrites (category)
  "Return a list of the possible rewrites for this category."
  (rule-rhs (assoc category *grammar*)))

;;; ==============================

(defun mappend (fn list)
  "Append the results of calling fn on each element of list.
  Like mapcon, but uses append instead of nconc."
  (apply #'append (mapcar fn list)))

(defun generate (phrase)
  "Generate a random sentence or phrase"
  (cond ((listp phrase)
         (mappend #'generate phrase))
        ((rewrites phrase)
         (generate (random-elt (rewrites phrase))))
        (t (list phrase))))

;;; ==============================

(defparameter *bigger-grammar*
  '((sentence -> (noun-phrase verb-phrase))
    (noun-phrase -> (Article Adj* Noun PP*) (Name) (Pronoun))
    (verb-phrase -> (Verb noun-phrase PP*))
    (PP* -> () (PP PP*))
    (Adj* -> () (Adj Adj*))
    (PP -> (Prep noun-phrase))
    (Prep -> to in by with on)
    (Adj -> big little blue green adiabatic)
    (Article -> the a)
    (Name -> Pat Kim Lee Terry Robin)
    (Noun -> man ball woman table)
    (Verb -> hit took saw liked)
    (Pronoun -> he she it these those that)))

;; (setf *grammar* *bigger-grammar*)

;;; ==============================

(defun generate-tree (phrase)
  "Generate a random sentence or phrase,
  with a complete parse tree."
  (cond ((listp phrase)
         (mapcar #'generate-tree phrase))
        ((rewrites phrase)
         (cons phrase
               (generate-tree (random-elt (rewrites phrase)))))
        (t (list phrase))))

;;; ==============================

(defun generate-all (phrase)
  "Generate a list of all possible expansions of this phrase."
  (cond ((null phrase) (list nil))
        ((listp phrase)
         (combine-all (generate-all (first phrase))
                      (generate-all (rest phrase))))
        ((rewrites phrase)
         (mappend #'generate-all (rewrites phrase)))
        (t (list (list phrase)))))

;(defun combine-all (xlist ylist)
;  "Return a list of lists formed by appending a y to an x.
;  E.g., (combine-all '((a) (b)) '((1) (2)));  -> ((A 1) (B 1) (A 2) (B 2))."
;   (mappend #'(lambda (y)
;               (mapcar #'(lambda (x) (append x y)) xlist))
;           ylist)

;; Cartesian Product 
(defun cartesian-product (fn xlist ylist)
  "Return a list of all (fn x y) values."
  (mappend #'(lambda (y)
	       (mapcar #'(lambda (x) (funcall fn x y)) xlist))
	   ylist))

(defun combile-all (xlist ylist)
  (cartesian-product #'append xlist ylist))

;;; Rules 
;;  Friendly Advice
;;  Use (format t "~{~a ~}" (generate '( phrase ))) to produce human-readable format :) 

(defparameter *c-grammar*
  '(
    (class -> (header (newline) function-assignment))
    (header -> ((\#include) (<(header-file-name)>) ))
    (function-assignment -> (return-type function-name (\() parameter-variable-declaration (\)) ({)
			     newline
			     function-body
			     newline (}) )) 
    (function-body -> (variable-declaration newline
		       loop-increment newline
		       loops newline
		       return-value)) ; assumming that functions do return some sort of value
    (parameter-declaration -> (return-type variable-name parameter-variable-assignment value))
    (variable-declaration -> (return-type variable-name = value statement-terminator))
    (conditional-statement -> (variable-name conditions value)) ;; for if-statement ( ... ) 
    (if-statement -> ((if) (\() conditional-statement (\))) )

    (parameter-variable-declaration -> ((int) variable-name = value))
    (loop-increment -> (variable-name loop-assignment))
    (return-value -> ((return) variable-name))
    (loop-body -> (variable-declaration newline loop-increment newline))

    ;; Loops 
    (loops -> for-loop while-loop)
    (for-loop -> ( (for) (\() parameter-variable-declaration statement-terminator
		  conditional-statement statement-terminator
		  variable-name loop-assignment statement-terminator (\))
		  ({) newline loop-body(}) ))

    (while-loop -> (while (\() conditional-statement (\)) (\{) newline loop-body (\})))

    ;; Terminators / Terminating values 
    (header-file-name -> stdio.h math.h stdlib.h string.h)
    (function-name -> fps price b)
    (variable-name -> foo x y)
    (return-type -> int char double float void)
    (conditions -> < <= > >= == !=)
    (value -> 0 1 10 100)
    (loop-assignment -> ++ --)
    (general-assignment -> = += -=)

    (statement-terminator -> \;)
    (newline -> #\Newline)
    )
  )
    ;;
