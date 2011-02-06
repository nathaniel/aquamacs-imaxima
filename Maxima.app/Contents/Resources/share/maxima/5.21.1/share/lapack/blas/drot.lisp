;;; Compiled by f2cl version:
;;; ("f2cl1.l,v 1.215 2009/04/07 22:05:21 rtoy Exp $"
;;;  "f2cl2.l,v 1.37 2008/02/22 22:19:33 rtoy Exp $"
;;;  "f2cl3.l,v 1.6 2008/02/22 22:19:33 rtoy Exp $"
;;;  "f2cl4.l,v 1.7 2008/02/22 22:19:34 rtoy Exp $"
;;;  "f2cl5.l,v 1.200 2009/01/19 02:38:17 rtoy Exp $"
;;;  "f2cl6.l,v 1.48 2008/08/24 00:56:27 rtoy Exp $"
;;;  "macros.l,v 1.112 2009/01/08 12:57:19 rtoy Exp $")

;;; Using Lisp CMU Common Lisp 19f (19F)
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format double-float))

(in-package :blas)


(defun drot (n dx incx dy incy c s)
  (declare (type (double-float) s c)
           (type (array double-float (*)) dy dx)
           (type (f2cl-lib:integer4) incy incx n))
  (f2cl-lib:with-multi-array-data
      ((dx double-float dx-%data% dx-%offset%)
       (dy double-float dy-%data% dy-%offset%))
    (prog ((i 0) (ix 0) (iy 0) (dtemp 0.0))
      (declare (type (double-float) dtemp) (type (f2cl-lib:integer4) iy ix i))
      (if (<= n 0) (go end_label))
      (if (and (= incx 1) (= incy 1)) (go label20))
      (setf ix 1)
      (setf iy 1)
      (if (< incx 0)
          (setf ix
                  (f2cl-lib:int-add
                   (f2cl-lib:int-mul (f2cl-lib:int-sub 1 n) incx)
                   1)))
      (if (< incy 0)
          (setf iy
                  (f2cl-lib:int-add
                   (f2cl-lib:int-mul (f2cl-lib:int-sub 1 n) incy)
                   1)))
      (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                    ((> i n) nil)
        (tagbody
          (setf dtemp
                  (+ (* c (f2cl-lib:fref dx-%data% (ix) ((1 *)) dx-%offset%))
                     (* s (f2cl-lib:fref dy-%data% (iy) ((1 *)) dy-%offset%))))
          (setf (f2cl-lib:fref dy-%data% (iy) ((1 *)) dy-%offset%)
                  (- (* c (f2cl-lib:fref dy-%data% (iy) ((1 *)) dy-%offset%))
                     (* s (f2cl-lib:fref dx-%data% (ix) ((1 *)) dx-%offset%))))
          (setf (f2cl-lib:fref dx-%data% (ix) ((1 *)) dx-%offset%) dtemp)
          (setf ix (f2cl-lib:int-add ix incx))
          (setf iy (f2cl-lib:int-add iy incy))
         label10))
      (go end_label)
     label20
      (f2cl-lib:fdo (i 1 (f2cl-lib:int-add i 1))
                    ((> i n) nil)
        (tagbody
          (setf dtemp
                  (+ (* c (f2cl-lib:fref dx-%data% (i) ((1 *)) dx-%offset%))
                     (* s (f2cl-lib:fref dy-%data% (i) ((1 *)) dy-%offset%))))
          (setf (f2cl-lib:fref dy-%data% (i) ((1 *)) dy-%offset%)
                  (- (* c (f2cl-lib:fref dy-%data% (i) ((1 *)) dy-%offset%))
                     (* s (f2cl-lib:fref dx-%data% (i) ((1 *)) dx-%offset%))))
          (setf (f2cl-lib:fref dx-%data% (i) ((1 *)) dx-%offset%) dtemp)
         label30))
      (go end_label)
     end_label
      (return (values nil nil nil nil nil nil nil)))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::drot fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo
           :arg-types '((fortran-to-lisp::integer4) (array double-float (*))
                        (fortran-to-lisp::integer4) (array double-float (*))
                        (fortran-to-lisp::integer4) (double-float)
                        (double-float))
           :return-values '(nil nil nil nil nil nil nil)
           :calls 'nil)))

