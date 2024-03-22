# cwm

This is a port of OpenBSD's excellent cwm, forked from [https://github.com/leahneukirchen/cwm](https://github.com/leahneukirchen/cwm).

This version does not use pkg-config to build.

## Build a deb package

Because cwm is a simple program, `equivs-build` is used to build
the deb package, rather than the traditional `debuild` command.

Before building, ensure that the following packages are installed:

* equivs
* Yacc or Bison
* libx11-dev
* libxinerama-dev
* libxft-dev
* libxrandr-dev

Then, from cwm's directory, run (as a non-root user):

```
$ make deb
```


