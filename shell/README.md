# TODO

> root config (confirmation on rm/cp/mv/ln)


# Functions

Files containing functions to use in terminal or in scripts. 

Most files containing a unique function can be either sourced or run.  
However some features (mostly related to environment variables) will only work when sourced.

TODO: what about missing shellbangs ?


## Naming

Files' extension are meant to indicate the target.
 - `.bash` -> For bash
 - `.zsh`  -> For zsh
 - `.sh`   -> **Special case**: for any shell


## Dependencies

Scripts will rely on external tools, like `find` or `grep`.  
Some might be replaced by newer tools, producing the same work, but possibly with different syntaxes.
