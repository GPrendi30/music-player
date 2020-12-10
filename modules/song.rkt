;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname song) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require racket/base)
(require (except-in racket/gui tag))
(require taglib)

(define root "/home/geri/Desktop/svn/pf1-project/")
  
(define (create-absolute-path a-relative-path)
    (string-append root a-relative-path))

(provide ;creating
         (struct-out SONG)
         create-SONG
         resize
         create-absolute-path
         ;song-struct
         SONG
         ;song functions
         get-info
         get-image
         get-duration-seconds)

(define-struct SONG [path tag audio-prop image-path])
(define FFMPEG (create-absolute-path "lib/ffmpeg/ffmpeg"))
(define MOGRIFY (create-absolute-path "lib/mogrify/mogrify"))

(define song2 "/home/geri/Music/Mzk/BEATS/mark.mp3")

(define (make-image a-song-path save-filename)
  (process* FFMPEG "-i" a-song-path save-filename))

(define (resize a-png-path dimensions)
  (process* MOGRIFY "-resize" dimensions a-png-path)
  a-png-path)

(define (create-image a-song-path save-path save-name)
  (let
      [(save-file-path (string-append save-path "cover/" save-name ".png"))
       (save-file-icon-path (string-append save-path "icons/" save-name "-icon.png"))
       (cover-size "220x220!")
       (icon-size "80x80!")]
    (make-image  a-song-path save-file-path)
    (make-image a-song-path save-file-icon-path)
    (resize save-file-path cover-size)
    (resize save-file-icon-path icon-size)
    (list save-file-path save-file-icon-path)))

(define (if-unknown? metadata)
  (if metadata
      metadata
      (list
       (tag "Unknown"
            "Unknown"
            "Unknown"
            "Unknown"
            "Unknown"
            "Unknown"
            "Unknown"
            )
       (audio-properties
         0
         0
         0
         0))))
       
      
(define (create-SONG a-song-path)
  (local
    [(define metadata (if-unknown? (get-metadata a-song-path)))
     (define audio-tag  (first metadata))
     (define audio-props (second metadata))
     (define album (tag-album audio-tag))
     (define title (tag-title audio-tag))
     (define default-dir (create-absolute-path "db/images/"))
     (define image-path
       (if (= (string-length album) 0)
          (create-image a-song-path default-dir title)
          (create-image a-song-path default-dir album)))]
    (make-SONG a-song-path audio-tag audio-props image-path)))


;get-info from a SONG
(define (get-info a-song info-type)
  (local
    [(define audio-tag (SONG-tag a-song))
     (define audio-props (SONG-audio-prop a-song))
     (define album (tag-album audio-tag))
     (define title (tag-title audio-tag))
     (define author (tag-artist audio-tag))
     (define comment (tag-comment audio-tag))
     (define genre (tag-genre audio-tag))
     (define year (tag-year audio-tag))
     (define track (tag-track audio-tag))
     (define song-path (SONG-path a-song))
     (define duration (get-duration a-song))
     (define image-path (SONG-image-path a-song))
     (define icon (second image-path))
     (define cover (first image-path))]
    (cond
      [(equal? info-type "author") author]
      [(equal? info-type "title") title]
      [(equal? info-type "comment") comment]  
      [(equal? info-type "album") album]
      [(equal? info-type "genre") genre]
      [(equal? info-type "year") year]
      [(equal? info-type "track-number") track]
      [(equal? info-type "path") song-path]
      [(equal? info-type "cover") cover]
      [(equal? info-type "icon") icon]
      [(equal? info-type "duration") duration]
      [rest #f])))


(define (get-duration a-song)
  (local
    [(define properties (SONG-audio-prop a-song))
     (define seconds (audio-properties-length properties))
     (define minutes (floor (/ seconds 60)))
     (define left-sec (- seconds (* minutes 60)))
     (define minutes-str (number->string minutes))
     (define left-sec-str (number->string left-sec))]
    (string-append minutes-str ":" left-sec-str)))

(define (get-duration-seconds a-song)
  (local
    [(define properties (SONG-audio-prop a-song))
     (define seconds (audio-properties-length properties))]
    seconds))
     
(define (get-image a-song type)
  (let
    [(icon (make-object image-snip% (get-info a-song "icon")))
     (cover (make-object image-snip% (get-info a-song "cover")))]
  (cond
    [(equal? type "icon") (send icon get-bitmap)]
    [(equal? type "cover") (send cover get-bitmap)]
    [else #f])))
