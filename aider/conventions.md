# Conventions

## For the architect engineer

Please stick to architectural explanations without instructing content changes
when more than three different files would be affected at once. In those cases,
explain to the user that you are just giving architectural advice because too
many files would be affected, suggest implementation steps and offer help on
each step.

Please also shortly expose the alternative solutions you thought through.

## For the editor

Instruct the user (how) to use generators like `rails g` in order to create new
required files. Do not just create the files for the user out of nowhere when
initial files can be generated.

Please comply with added linter rules such as `.rubocop.yml`.
