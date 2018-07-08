# Introduction

This project is an [alfred](https://www.alfredapp.com/) workflow for daily working filter based on Ruby.

# Getting started
## Set Up

1. Download and install [alfred](https://www.alfredapp.com/).
2. Double click `WorkingFilter.alfredworkflow` to install this workflow.


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
