# DocTest.js TestKit
A Shell tool to get you started with doctest.js http://doctestjs.org/

## Requirements
**Python**: If you work on a Linux machine or a Mac you should already have it. You can check it by opening a Terminal and typing `python`.

##Install 
`git clone` or download a zip.
Optionally you can create an alias in `~/.bashrc`

Ex:
`alias doctestjs='bash /path/to/doctest.sh'

You'll need to fetch the `doctest.js` code from github. Its included in this repo as a submodule and you can easily install it using `./doctest.js --install`

##Usage:

```
doctestjs -t tests.js -l http://code.jquery.com/jquery-1.8.3.min.js,mylib.js -p 8999

```
You should then see

```
Staring Test on port: 8999
...type k then Enter to end
```

You can access your test page at 

`http://127.0.0.1:8999/`

Typing `k` and then `Enter` will kill the session.

##Options
`$ doctestjs --help`

Display this help text


`$ doctestjs -t`

A list of tests to build into test page. Ex: `./doctestjs -t mytest.js,/path/to/other.js`

`$ doctestjs -l`


A list of additinal libraries or scripts to include in your test page. You can pass externaly hosted libraries like cdn hosted jquery (aka via http) or your own. Ex: 

```
$ doctestjs -t tests.js -l http://code.jquery.com/jquery-1.8.3.min.js,mylib.js

```

`$ doctestjs -p`

The port the server runs on. Defaults to 8999
