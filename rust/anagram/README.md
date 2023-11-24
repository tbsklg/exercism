# Anagram

Welcome to Anagram on Exercism's Rust Track.
If you need help running the tests or submitting your code, check out `HELP.md`.

## Instructions

An anagram is a rearrangement of letters to form a new word: for example `"owns"` is an anagram of `"snow"`.
A word is not its own anagram: for example, `"stop"` is not an anagram of `"stop"`.

Given a target word and a set of candidate words, this exercise requests the anagram set: the subset of the candidates that are anagrams of the target.

The target and candidates are words of one or more ASCII alphabetic characters (`A`-`Z` and `a`-`z`).
Lowercase and uppercase characters are equivalent: for example, `"PoTS"` is an anagram of `"sTOp"`, but `StoP` is not an anagram of `sTOp`.
The anagram set is the subset of the candidate set that are anagrams of the target (in any order).
Words in the anagram set should have the same letter case as in the candidate set.

Given the target `"stone"` and candidates `"stone"`, `"tones"`, `"banana"`, `"tons"`, `"notes"`, `"Seton"`, the anagram set is `"tones"`, `"notes"`, `"Seton"`.

The solution is case insensitive, which means `"WOrd"` is the same as `"word"` or `"woRd"`. It may help to take a peek at the [std library](https://doc.rust-lang.org/std/primitive.char.html) for functions that can convert between them.

The solution cannot contain the input word. A word is always an anagram of itself, which means it is not an interesting result. Given `"hello"` and the list `["hello", "olleh"]` the answer is `["olleh"]`.

You are going to have to adjust the function signature provided in the stub in order for the lifetimes to work out properly. This is intentional: what's there demonstrates the basics of lifetime syntax, and what's missing teaches how to interpret lifetime-related compiler errors.

Try to limit case changes. Case changes are expensive in terms of time, so it's faster to minimize them.

If sorting, consider [sort_unstable](https://doc.rust-lang.org/std/primitive.slice.html#method.sort_unstable) which is typically faster than stable sorting. When applicable, unstable sorting is preferred because it is generally faster than stable sorting and it doesn't allocate auxiliary memory.

## Source

### Created by

- @EduardoBautista

### Contributed to by

- @andrewclarkson
- @ashleygwilliams
- @bobahop
- @chancancode
- @ClashTheBunny
- @coriolinus
- @cwhakes
- @Dimkar3000
- @EduardoBautista
- @efx
- @ErikSchierboom
- @gris
- @IanWhitney
- @kytrinyx
- @lutostag
- @mkantor
- @nfiles
- @petertseng
- @pminten
- @quartsize
- @rofrol
- @stevejb71
- @stringparser
- @xakon
- @ZapAnton

### Based on

Inspired by the Extreme Startup game - https://github.com/rchatley/extreme_startup