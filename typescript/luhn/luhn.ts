export const valid = (raw: string): boolean =>
  !isEmpty(raw) && luhn(raw)(extractDigits(raw));

const luhn =
  (raw: string) =>
  (digits: number[]): boolean => {
    return and([
      greaterOne(digits),
      equals(length(digits), [...raw].filter(notIsWhitespace).length),
      divisibleByTen(
        sum(
          mapIndexed(reverse(digits), (digit, i) =>
            even(i) ? digit : transformOdd(digit),
          ),
        ),
      ),
    ]);
  };

const extractDigits = (x: string): number[] =>
  (x.match(/\d/g) ?? []).map(Number);
const equals = (x: any, y: any): boolean => x === y;
const length = (x: any[]): number => x.length;
const greaterOne = (x: any[]): boolean => length(x) > 1;
const reverse = (x: any[]): any[] => [...x].reverse();
const divisibleByTen = (x: number): boolean => x % 10 === 0;
const notIsWhitespace = (x: string): boolean => !isWhitespace(x);
const isWhitespace = (x: string): boolean => x === " ";
const even = (x: number): boolean => x % 2 === 0;
const isEmpty = (x: string): boolean => x.trim() === "";
const sum = (x: number[]): number => x.reduce((acc, curr) => acc + curr, 0);
const transformOdd = (x: number): number => {
  const doubled = x * 2;
  return doubled > 9 ? doubled - 9 : doubled;
};
const mapIndexed = <T, U>(arr: T[], fn: (item: T, index: number) => U): U[] =>
  arr.map((item, index) => fn(item, index));
const and = (predicates: boolean[]): boolean =>
  predicates.every((predicate) => predicate);
