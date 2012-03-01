#lang racket

(require "fulmar-core.rkt")
(require "core-chunk.rkt")
(require "writer.rkt")
(require "io.rkt")
(require "version.rkt")

; main for fulmar

(define cmdln-line-length (make-parameter 80))
(define cmdln-input-location (make-parameter #false))
(define cmdln-output-location (make-parameter #false))

;TODO: add checks to line length argument in case string is not a number (currently converts any input string into integer silently)
(define/contract (string->integer str)
  (-> string? exact-positive-integer?)
  (foldl (λ (i t) (+ (* t 10) i))
         0
         (map (λ (c) (- (char->integer c)
                        (char->integer #\0)))
              (string->list str))))

(command-line #:program "fulmar"
              #:once-each
              [("-i" "--in") input
                             "Specify input file"
                             (cmdln-input-location input)]
              [("-o" "--out") output
                              "Specify output file"
                              (cmdln-output-location output)]
              [("-l" "--line-length") length
                                      "Specify the length of a line (soft limit)"
                                      (cmdln-line-length (string->integer length))]
              #:args non-flag-args (if (or (and (<= 1 (length non-flag-args))
                                                (cmdln-input-location))
                                           (and (<= 2 (length non-flag-args))
                                                (cmdln-output-location)))
                                       (error "Malformed input. Use -h or --help for more information.")
                                       (let* ([input-string (cond [(cmdln-input-location)]
                                                                  [(< 0 (length non-flag-args)) (car non-flag-args)]
                                                                  [else #false])]
                                              [input (if input-string
                                                         (path->complete-path (string->path input-string))
                                                         (current-input-port))]
                                              [output-string (cond [(cmdln-output-location)]
                                                                   [(< 1 (length non-flag-args)) (cdar non-flag-args)]
                                                                   [else #false])]
                                              [output (if output-string
                                                          (path->complete-path (string->path output-string))
                                                          (current-output-port))]
                                              [input-chunk (read-chunk input)]
                                              [initial-comment-chunk (comment-env-chunk (concat-chunk "This file was generated by fulmar version "
                                                                                                      version-number
                                                                                                      "."))]
                                              [chunk (concat-chunk initial-comment-chunk
                                                                   new-line-chunk
                                                                   input-chunk)])
                                         (print-file! (write-nekot (chunk-transform chunk
                                                                                    (construct-context (cmdln-line-length))))
                                                      output))))