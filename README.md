# Grammar

## Introduction
***Common Lisp*** is a dialect of the Lisp programming language. 
The Common Lisp language was developed as a standardized and improved successor of Maclisp. By the early 1980s several groups were already
at work on diverse successors to MacLisp: Lisp Machine Lisp (aka ZetaLisp), Spice Lisp, NIL and S-1 Lisp. 
Common Lisp sought to unify, standardise, and extend the features of these MacLisp dialects. 
Common Lisp is not an implementation, but rather a language specification. Several implementations of the Common Lisp standard 
are available, including free and open source software and proprietary products. Common Lisp is a general-purpose, multi-paradigm 
programming language. It supports a combination of procedural, functional, and object-oriented programming paradigms. 
As a dynamic programming language, it facilitates evolutionary and incremental software development, with iterative compilation into 
efficient run-time programs. This incremental development is often done interactively without interrupting the running application.

## Machine Problem
In this *completed* machine problem, it focuses on the functionality of grammar usage in Common Lisp. The similarity of this *grammar* 
rule can be seen in several areas in Computer Science, and particularly in programming translators, or in other terms, compilers. In 
any compilers, it uses lexical and syntax analysis to analyze the character and token streams in order to generate into an Abstract Syntax
Tree (AST) and eventually with semantics analysis, a target code/language is generated. 

A breakdown of the procress can be seen below: 
![alt-text](http://github.com/sengzhaotoo/grammar/screenshot/img.png)

***Brrrr...*** Back to this machine problem.

The ultimate objective of the machine problem is to generate a grammar rule for any selected programming languages, in this case, C. 
It consist of a dozen (12) rules, and be capable of generating "programs" consisting of one or more primary modularization constructs
(classes or functions), and some basic control constructs (e.g., loops and conditional statements) and statements 
(function calls and assignments). The programs generated are (should be) syntactically valid (though one can stick to using lisp symbols, 
and therefore ignore case sensitivity of language keywords), but not necessarily semantically so
(e.g., identifier names may be chosen at random for variable references and/or function calls).

#### Generalization of combine-all function
The combine-all function called by the generate-all function works by effectively calling append on the elements of the Cartesian 
product of the argument lists. Write a general higher-order function called cartesian-product, and define combine-all in terms of it. 
Your function should take the following form:
<pre>
  <code> (defun cartesian-product (fn xlist ylist)
    "Return a list of all (fn x y) values."
    )
  </code>
</pre>

Here are some of the test cases for the function:
<pre>
  <code>
  > (cartesian-product #'+ '(1 2 3) '(10 20 30))
  (11 12 13 21 22 23 31 32 33)
  </code>
</pre>
<pre>
  <code>
  > (cartesian-product #'list '(a b c) '(1 2 3))
  ((A 1) (B 1) (C 1) (A 2) (B 2) (C 2) (A 3) (B 3) (C 3))
  </code>
</pre>
