# xframes-perl

## Status

This is currently **not working** as XFrames runs in a separate thread, which currently causes

`Segmentation fault (core dumped)`

To note, with the exception of the XFrames JNI Library, whereby the JVM needs to be 're-attached' to the current thread, no other programming language gave such headaches.

## Instructions

### Install Perl

#### Windows

I recommend you use a package manager such as [scoop](https://scoop.sh/) and then run

`scoop install perl`

#### Linux

You're likely better off with the system Perl package

### Install dependencies

- `cpan FFI::Platypus`
- `cpan JSON` (may require root privileges on Ubuntu if using system Perl package)
- `cpan AnyEvent`
