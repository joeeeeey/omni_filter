### Introduction

This project is an [alfred](https://www.alfredapp.com/) workflow for daily working filter based on Ruby.

## Getting started
### Set Up

1. download and install [alfred](https://www.alfredapp.com/)
2. double click `WorkingFilter.alfredworkflow` to install this workflow


### Api List

1. `stt` for all keys search
2. `stc` for color name filter
3. `stw` for website filter

### Debug

/usr/bin/ruby main.rb "color-"

### Alfred xml format
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

### TODO:

* Add more filters
