# movie_bot 
[![Build Status](https://travis-ci.org/antoinerg/movie_bot.png?branch=master)](https://travis-ci.org/antoinerg/movie_bot)

I made this library to rename and clean up a bunch of folders containing movies. It is very opiniated for now.

## Installation

    $ git clone https://github.com/antoinerg/movie_bot.git
    $ cd movie_bot
    $ rake install

## Usage

### Clean movie folder

Once installed you can clean up a folder and move it somewhere else

    $ DEST_DIR=/path/movie_library movie_bot clean "Vanya 42nd Street"
    
### Scan folder for movies

You can scan a folder containing movie folders to see if they have a NFO file with a link to their IMDB page. Moreover, if you have mediainfo, it will analyze the video file.

    $ movie_bot scan .

## Todo

- Write a more complete usage section
- Convert VIDEO_TS into iso image
- Interactively look for the IMDB id of a movie
