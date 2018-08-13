# Introduction

This project is an [alfred](https://www.alfredapp.com/) workflow for daily working filter based on Ruby.

## Getting started
### Installation

- By github repo. 
  - [Download and install](https://github.com/joeeeeey/recources/blob/master/assets/Alfred%2B3.3.dmg.zip) alfred, make sure you can use powerpack for workflow.
  - Open termial.
  - Run `cd ~/Library/Application\ Support/Alfred\ 3/Alfred.alfredpreferences/workflows/`.
  - Git clone this repo.(Pull for update)

- By binary file.
  - [Download and install](https://github.com/joeeeeey/recources/blob/master/assets/Alfred%2B3.3.dmg.zip) alfred, make sure you can use powerpack for workflow.
  - [Download lastest realase.](https://github.com/joeeeeey/alfred_daily_filter/releases)
  - Double click `WorkingFilter.alfredworkflow` to install this workflow.
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

[View Interaction of `stf`.](https://upload-images.jianshu.io/upload_images/2674994-6419a000489bd769.gif?imageMogr2/auto-orient/strip)

### 2. Go to following web links faster.
- Jira tickets(Cache supported).
- Microapp web links for dev, stage, uat, prod environment(Search supported).
- Github repos of Overseas-Student-Living organization.

[View Interaction of `Jira`.](https://upload-images.jianshu.io/upload_images/2674994-355245325381fcab.gif?imageMogr2/auto-orient/strip)

[View Interaction of `stt`.](https://upload-images.jianshu.io/upload_images/2674994-8b1fa2d128c51d39.gif?imageMogr2/auto-orient/strip)

[View Interaction of `stg`.](https://upload-images.jianshu.io/upload_images/2674994-92abaeab7a06ea6e.gif?imageMogr2/auto-orient/strip)

## Keyword List

The following keywords can be easily changed by alfred.

## 1. stf

Filter keys which frequently used.

## 2. stc

Filter color keys frequently used, which is a subset of `stf`.

## 3. stt

Filter and navigate to microapp web links.

### Params in `stt`

Differnt from other filters, `stt` accecpt two params seqerated by ','.

Format: `stt ${env-area},${searchTerm}`

Eg: Type `stt stage,london` in alfred, it will use `london` as the search term.

## 4. jira/stj
Filter and navigate to jira by ticket number.
Will remember the search history of 'valid' ticket number.

## 5. stgh
Filter and navigate to github by repo name.

## Debug
1. go to the repo directory in termial.
2. run `make test_stt`.

## [Alfred xml format](https://github.com/joeeeeey/alfred_daily_filter/wiki)

## TODO:

* Add more filters
