# Introduction

This project is an [alfred](https://www.alfredapp.com/) workflow for daily working filter based on Ruby.

## Getting started
### Set Up

Install by repo. 

1. Download and install [alfred](https://www.alfredapp.com/), make sure you can use powerpack for workflow.
2. Open termial.
3. Run `cd ~/Library/Application\ Support/Alfred\ 3/Alfred.alfredpreferences/workflows/`.
4. Git clone this repo.

Install by binary file.

1. Download and install [alfred](https://www.alfredapp.com/), make sure you can use powerpack for workflow.
2. [Download lastest realase.](https://github.com/joeeeeey/alfred_daily_filter/releases)
3. Double click `WorkingFilter.alfredworkflow` to install this workflow.

~~May need install dependency of ruby gems.~~
- ~~Open termial~~
- ~~Make sure result of `which ruby` is `/usr/bin/ruby`, otherwise disable `rvm` or `rbenv`~~
- ~~Run `sudo gem install activesupport -v 4.2.10`~~
- ~~Run `sudo gem install builder`~~

## Features

### 1. Filter frequently-used variables for frontend develop.
- Colors(Able to preview the real color).
- Fronts.

### 2. Go to following web links faster.
- Jira tickets(Cache supported).
- Microapp web links for dev, stage, uat, prod environment(Search supported).
- Github repos of Overseas-Student-Living organization.


## Keyword List

## 1. stf

Filter keys which frequently used.

<!-- ![alt text](https://raw.githubusercontent.com/joeeeeey/alfred_daily_filter/master/assets/images/stf.png) -->

## 2. stc

Filter color keys frequently used, which is a subset of `stf`.

## 3. stt

Filter and navigate to microapp web links.

### How to search

- 3.1 Search the website by `env`(dev, uat, stage, prod) and `area`(www) keyword.Specifically, for dev env, keyword `page name`(hp,srp, pp, sp) is optional.

<!-- ![alt text](https://raw.githubusercontent.com/joeeeeey/alfred_daily_filter/master/assets/images/stt1.png) -->

- 3.2 Use the search api of student.com by search term.

Eg: Type `stt stage,london` in alfred, it will use `london` as the search term.

<!-- ![alt text](https://raw.githubusercontent.com/joeeeeey/alfred_daily_filter/master/assets/images/stt2.png) -->

## 4. jira/stj
Filter and navigate to jira by ticket number.
It will remember the search history of 'valid' ticket number.

## 5. stgh
Filter and navigate to github by repo name.

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
