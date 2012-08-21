;;; Compiled by f2cl version:
;;; ("f2cl1.l,v c4abe8cf9af0 2011/11/24 07:12:32 toy $"
;;;  "f2cl2.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl3.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl4.l,v 96616d88fb7e 2008/02/22 22:19:34 rtoy $"
;;;  "f2cl5.l,v 11bea7dae5a0 2011/06/11 17:53:39 toy $"
;;;  "f2cl6.l,v 1d5cbacbb977 2008/08/24 00:56:27 rtoy $"
;;;  "macros.l,v c4abe8cf9af0 2011/11/24 07:12:32 toy $")

;;; Using Lisp CMU Common Lisp 20c release-20c (20C Unicode)
;;; 
;;; Options: ((:prune-labels nil) (:auto-save t) (:relaxed-array-decls t)
;;;           (:coerce-assigns :as-needed) (:array-type ':array)
;;;           (:array-slicing t) (:declare-common nil)
;;;           (:float-format single-float))

(in-package "LAPACK")


(let* ((one (f2cl-lib:cmplx 1.0d0 0.0d0)) (zero (f2cl-lib:cmplx 0.0d0 0.0d0)))
  (declare (type (f2cl-lib:complex16) one)
           (type (f2cl-lib:complex16) zero)
           (ignorable one zero))
  (defun zlarf (side m n v incv tau c ldc work)
    (declare (type (f2cl-lib:complex16) tau)
             (type (array f2cl-lib:complex16 (*)) work c v)
             (type (f2cl-lib:integer4) ldc incv n m)
             (type (simple-array character (*)) side))
    (f2cl-lib:with-multi-array-data
        ((side character side-%data% side-%offset%)
         (v f2cl-lib:complex16 v-%data% v-%offset%)
         (c f2cl-lib:complex16 c-%data% c-%offset%)
         (work f2cl-lib:complex16 work-%data% work-%offset%))
      (prog ((i 0) (lastv 0) (lastc 0) (applyleft nil))
        (declare (type (f2cl-lib:integer4) i lastv lastc)
                 (type f2cl-lib:logical applyleft))
        (setf applyleft (lsame side "L"))
        (setf lastv 0)
        (setf lastc 0)
        (cond
          ((/= tau zero)
           (tagbody
             (cond
               (applyleft
                (setf lastv m))
               (t
                (setf lastv n)))
             (cond
               ((> incv 0)
                (setf i
                        (f2cl-lib:int-add 1
                                          (f2cl-lib:int-mul
                                           (f2cl-lib:int-sub lastv 1)
                                           incv))))
               (t
                (setf i 1)))
            label100000
             (if
              (not
               (and (> lastv 0)
                    (= (f2cl-lib:fref v-%data% (i) ((1 *)) v-%offset%) zero)))
              (go label100001))
             (setf lastv (f2cl-lib:int-sub lastv 1))
             (setf i (f2cl-lib:int-sub i incv))
             (go label100000)
            label100001
             (cond
               (applyleft
                (setf lastc (ilazlc lastv n c ldc)))
               (t
                (setf lastc (ilazlr m lastv c ldc)))))))
        (cond
          (applyleft
           (cond
             ((> lastv 0)
              (zgemv "Conjugate transpose" lastv lastc one c ldc v incv zero
               work 1)
              (zgerc lastv lastc (- tau) v incv work 1 c ldc))))
          (t
           (cond
             ((> lastv 0)
              (zgemv "No transpose" lastc lastv one c ldc v incv zero work 1)
              (zgerc lastc lastv (- tau) work 1 v incv c ldc)))))
        (go end_label)
       end_label
        (return (values nil nil nil nil nil nil nil nil nil))))))

(in-package #-gcl #:cl-user #+gcl "CL-USER")
#+#.(cl:if (cl:find-package '#:f2cl) '(and) '(or))
(eval-when (:load-toplevel :compile-toplevel :execute)
  (setf (gethash 'fortran-to-lisp::zlarf fortran-to-lisp::*f2cl-function-info*)
          (fortran-to-lisp::make-f2cl-finfo
           :arg-types '((simple-array character (1))
                        (fortran-to-lisp::integer4) (fortran-to-lisp::integer4)
                        (array fortran-to-lisp::complex16 (*))
                        (fortran-to-lisp::integer4)
                        (fortran-to-lisp::complex16)
                        (array fortran-to-lisp::complex16 (*))
                        (fortran-to-lisp::integer4)
                        (array fortran-to-lisp::complex16 (*)))
           :return-values '(nil nil nil nil nil nil nil nil nil)
           :calls '(fortran-to-lisp::zgerc fortran-to-lisp::zgemv
                    fortran-to-lisp::ilazlr fortran-to-lisp::ilazlc
                    fortran-to-lisp::lsame))))

