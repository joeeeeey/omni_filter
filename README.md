# Introduction

This project is an [alfred](https://www.alfredapp.com/) workflow for daily working filter based on Ruby.

## Getting started
### Installation

By github repo. 

1. Download and install [alfred](https://www.alfredapp.com/), make sure you can use powerpack for workflow.
2. Open termial.
3. Run `cd ~/Library/Application\ Support/Alfred\ 3/Alfred.alfredpreferences/workflows/`.
4. Git clone this repo.(Pull for update)

By binary file.

1. Download and install [alfred](https://www.alfredapp.com/), make sure you can use powerpack for workflow.
2. [Download lastest realase.](https://github.com/joeeeeey/alfred_daily_filter/releases)
3. Double click `WorkingFilter.alfredworkflow` to install this workflow.
(Reinstall for update)

~~May need install dependency of ruby gems.~~
- ~~Open termial~~
- ~~Make sure result of `which ruby` is `/usr/bin/ruby`, otherwise disable `rvm` or `rbenv`~~
- ~~Run `sudo gem install activesupport -v 4.2.10`~~
- ~~Run `sudo gem install builder`~~

## Features

### 1. Filter frequently-used variables for frontend develop.
- Colors(Able to preview the real color).
- Fronts.

Interaction demo of `stf`

[View Interaction demo of `stf`.](https://upload-images.jianshu.io/upload_images/2674994-6419a000489bd769.gif?imageMogr2/auto-orient/strip)

### 2. Go to following web links faster.
- Jira tickets(Cache supported).
- Microapp web links for dev, stage, uat, prod environment(Search supported).
- Github repos of Overseas-Student-Living organization.

[View Interaction demo of `Jira`.](https://upload-images.jianshu.io/upload_images/2674994-355245325381fcab.gif?imageMogr2/auto-orient/strip)

[View Interaction demo of `stt`.](https://upload-images.jianshu.io/upload_images/2674994-8b1fa2d128c51d39.gif?imageMogr2/auto-orient/strip)

[View Interaction demo of `stg`.](https://upload-images.jianshu.io/upload_images/2674994-92abaeab7a06ea6e.gif?imageMogr2/auto-orient/strip)

## Keyword List

The following keywords can be easily changed by alfred.

## 1. stf

Filter keys which frequently used.

## 2. stc

Filter color keys frequently used, which is a subset of `stf`.

## 3. stt

Filter and navigate to microapp web links.

### How to search

- 3.1 Search the website by `env`(dev, uat, stage, prod) and `area`(www) keyword.Specifically, for dev env, keyword `page name`(hp,srp, pp, sp) is optional.

- 3.2 Use the search api of student.com by search term.

Eg: Type `stt stage,london` in alfred, it will use `london` as the search term.

## 4. jira/stj
Filter and navigate to jira by ticket number.
It will remember the search history of 'valid' ticket number.

## 5. stgh
Filter and navigate to github by repo name.

## Debug
1. go to the repo directory in termial.
2. run `make test_stt`.

## [Alfred xml format](https://github.com/joeeeeey/alfred_daily_filter/wiki)

## TODO:

* Add more filters
