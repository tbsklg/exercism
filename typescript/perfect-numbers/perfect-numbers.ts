export const classify = (n: number): string => {
  if (n <= 0) throw new Error('Classification is only possible for natural numbers.')

  const sum = factorSum(n)

  if (sum === n) return 'perfect'
  if (sum > n) return 'abundant'

  return 'deficient'
}

const factorSum = (num: number): number => {
  return [...Array(Math.floor(num))]
    .reduce((acc: number, _: number, i: number) =>
      num % i === 0
        ? acc + i
        : acc, 0)
}
