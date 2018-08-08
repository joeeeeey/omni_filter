# Introduction

This project is an [alfred](https://www.alfredapp.com/) workflow for daily working filter based on Ruby.

## Getting started
### Set Up

Use repo. 

1. Download and install [alfred](https://www.alfredapp.com/), make sure you can use powerpack for workflow.
2. open termial
3. run `cd ~/Library/Application\ Support/Alfred\ 3/Alfred.alfredpreferences/workflows/`
4. git clone this repo.

`which ruby`
# Make sure result is  => /usr/bin/ruby

5. Run `sudo gem install activesupport -v 4.2.10`
6. `sudo gem install builder`

Use binary file.

1. Download and install [alfred](https://www.alfredapp.com/), make sure you can use powerpack for workflow.
2. [Download lastest realase.](https://github.com/joeeeeey/alfred_daily_filter/releases)
3. Double click `WorkingFilter.alfredworkflow` to install this workflow.

## Keyword List

## 1. stt

For filter and navigate the website url you want.

### How to search

- 1.1 Search the website by `env`(dev, uat, stage, prod) and `area`(www) keyword.Specifically, for dev env, keyword `page name`(hp,srp, pp, sp) is optional.

![alt text](https://raw.githubusercontent.com/joeeeeey/alfred_daily_filter/master/assets/images/stt1.png)

- 1.2 Use the autocompele search result in student.com

Eg: Type `stt stage,london` in alfred, it will use `london` as the search term.

![alt text](https://raw.githubusercontent.com/joeeeeey/alfred_daily_filter/master/assets/images/stt2.png)

## 2. stf

For filter keys which frequently used.

![alt text](https://raw.githubusercontent.com/joeeeeey/alfred_daily_filter/master/assets/images/stf.png)

## 3. stc 

For filter color keys frequently used, which is a subset of `stf`.

## Debug
1. go to the repo directory in termial.
2. run `make test_stt`.

## Alfred xml format
```ruby
cat<<EOB
<?xml version="1.0"?>
<items>
<item uid="localip" arg="$LOCAL">
<title>Local IP: $LOCAL</title>
<subtitle>Press Enter to paste, or Cmd+C to copy</subtitle>
<icon>icon.png</icon>
</item>
<item uid="externalip" arg="$EXTERNAL">
<title>External IP: $EXTERNAL</title>
<subtitle>Press Enter to paste, or Cmd+C to copy</subtitle>
<icon>icon.png</icon>
</item>
</items>
EOB
```

## TODO:

* Add more filters
