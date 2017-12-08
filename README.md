# Lex/Flex + Yacc/Bison example for hierachical config parsing (lexical tie-in)
## Problem statement
When parsing a configuration file with hierarchical structures, for example the [test.config](./test.config), there could be sub-structures appearing at different levels, for example "prefix", a configuration item, may appear at "interface" or "pvd" level.
The different positions may require different actions in parsing, say update different data strucutres, one for "interface", and another for "pvd".

To handle this context dependency, one can employ a technique called lexical tie-in, more can be found in [Bison-handling context dependencies](http://dinosaur.compilertools.net/bison/bison_10.html).
The basic idea is to manipulate, in grammar definition, a global status flag, based on which one can switch the parsing behaviour.
This is the strategy adopted in this repository.

To push the idea further, lex/flex can parse a same pattern into different tokens depending on a status known as start condition, see more in [Flex-start conditions](http://dinosaur.compilertools.net/flex/flex_11.html).
This status can be exposed to yacc/bison and be manipulated there through a status stack offered by lex/flex.

## Usage and expected output
```
$ make
```
See the [Makefile](./Makefile) for intermediate and final output.
```
$ ./final < test.config
Scope: interface        Name:eth1       Prefix:1.1.1.0/24
Scope: interface        Name:eth0       Prefix:10.1.1.0/24
Scope: pvd      Name:test1.com  Prefix:20.1.1.0/24
Scope: pvd      Name:test2.com  Prefix:30.1.1.0/24
```
We can see in the above output, our toy parser understands the context of each "prefix" configuration.

