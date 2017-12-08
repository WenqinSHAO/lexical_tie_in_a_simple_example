# Lex/Flex + Yacc/Bison example for hierachical config parsing (lexical tie-in)
When parsing a configuration file with hierarchical structures, for example the [test.config](./test.config), there could be sub-structures appearing at different levels, for example "prefix", a configuration item, may appear at "interface" or "pvd" level.
The different positions may require different actions in parsing, say update different data strucutres, one for "interface", and another for "pvd".

To handle this context dependency, one can employ a technique called lexical tie-in, more can be found in [Bison-handling context dependencies](http://dinosaur.compilertools.net/bison/bison_10.html).
The basic idea is to manipulate, in grammar definition, a global status flag, based on which one can switch the parsing behaviour.
This is the strategy adopted in this repository.

To push the idea further, lex/flex can parse a same pattern into different tokens depending on a status known as start condition, see more in [Flex-start conditions](http://dinosaur.compilertools.net/flex/flex_11.html).
This status can be exposed to yacc/bison and be manipulated there through a status stack offerred by lex/flex.