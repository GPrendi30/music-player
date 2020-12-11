
----------db------------
database -> variable ; creates a hash of the list that contains all the different types of song lists (albums, songs, authors, favorites, playlist)
db_show -> accepts no arguments ; returns the datatbase
(db_get-song a-song-id) -> accepts a-song-id ; takes the id of a soong and returns the song
(db_add-song a-song [a-song-list (db_list-id "song") ; takes a song and adds it to the database
(db_get-song a-song-key) ; takes the id of a soong and returns the song
(check-album-empty a-song) ; checks if the song has an album in its data
(check-artist-empty a-song) ; checks if the song has an author in its data
(db_get-album a-album-key) ; returns the songs that are in an album
(db_get-author a-author-key) ; returns the songs made by an author
(db_add-playlist playlist-name song-list) ; sets a playlist to be played
(db_get-playlist a-playlist-key) ; returns a playlist
(db_add-single-to-playlist a-playlist-key a-song) ; adds a song to a playlist
(db_add-to-favorites a-song) ; adds a song to favorites
(db_remove-from-favorites a-song) ; removes a song from favorites
db_get-favorites-list -> accepts no arguments ; returns the favorites list

---------player------------
init-player -> variable
(add a-song)
stop!  ->  accepts no arguments 
stop!  ->  accepts no arguments
pause! ->  accepts no arguments
play!  ->  accepts no arguments
(update! a-path)
dec-vol -> accepts no arguments
inc-vol -> accepts no arguments
get-volume -> accepts no arguments
(set-volume val)
current-time -> accepts no arguments

-----------queue-------------
QUEUE -> empty ; empty list, initial state of the queue(empty)
(enqueue element) ; take a song and add it to the queue / take an album and add the songs to the queue
(dequeue element) ; removes a song from the queue
(removev2 element QUEUE) ; takes a list and an element in that list and removes it from the list
queue_first-> accepts no arguments ; returns the first song in the queue
queue_last -> accepts no arguments ; returns the last song in the queue
queue_show -> accepts no arguments ; shows the entire queue
queue_reset-> accepts no arguments ; sets the queue to its initial state(empty)

-----------song----------------
SONG [path tag audio-prop image-path]
(create-SONG a-song-path)
(resize a-png-path dimensions)
(create-absolute-path a-relative-path)
(get-info a-song info-type)
(get-image a-song type)
(get-duration-seconds a-song)

------------sort-----------------
(sortv2 list [mode "asc"])
(sortv3 list [mode "asc"])
(searchv2 a-string los)
(searchv3 a-string los)
(extract-nth a-list index)
