export function valid(digitString: string): boolean {
  const digits = (digitString.match(/\d/g) ?? []).map(Number);

  return (
    greaterOne(digits) &&
    equals(length(digits))([...digitString].filter(notIsWhitespace).length) &&
    divisibleByTen(
      reverse(digits)
        .map((x, i) => {
          if (even(i)) {
            return x;
          }

          const doubled = x * 2;
          return doubled > 9 ? doubled - 9 : doubled;
        })
        .reduce((acc, curr) => acc + curr, 0),
    )
  );
}

const equals = (x: any) => (y: any): boolean => x === y;
const length = (x: any[]): number => x.length;
const greaterOne = (x: any[]): boolean => length(x) > 1;
const reverse = (x: any[]): any[] => [...x].reverse();
const divisibleByTen = (x: number): boolean => x % 10 === 0;
const notIsWhitespace = (x: string): boolean => !isWhitespace(x);
const isWhitespace = (x: string): boolean => x === " ";
const even = (x: number): boolean => x % 2 === 0;
