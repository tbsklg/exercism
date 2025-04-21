export function valid(digitString: string): boolean {
  const digits = digitString.replace(/\D/g, "").split("").map(Number);

  return (
    digits.length > 1 &&
    digits
      .reverse()
      .map((x, i) => {
        if (even(i)) {
          return x;
        }

        const doubled = x * 2;

        return doubled > 9 ? doubled - 9 : doubled;
      })
      .reduce((acc, curr) => acc + curr, 0) %
      10 ===
      0
  );
}

const even = (x: number): boolean => x % 2 === 0;
