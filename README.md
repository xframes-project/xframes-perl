# xframes-perl

## Status

This is currently **not working** as XFrames spawns a separate thread (within the C++ universe), which currently causes

`Segmentation fault (core dumped)`

I would need to find a way to 're-attach' the Perl engine to the current thread, but I also came across [this](https://github.com/PerlFFI/FFI-Platypus?tab=readme-ov-file#i-get-seg-faults-on-some-platforms-but-not-others-with-a-library-using-pthreads):



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

sudo apt install -y libperl-dev ?

Ubuntu Perl source path

/usr/lib/x86_64-linux-gnu/perl/5.38.2/CORE