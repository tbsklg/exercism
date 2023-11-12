export const steps = (x: number, n: number = 0): number => {
  if (x <= 0 || !Number.isInteger(x))
    throw new Error('Only positive integers are allowed')

  if (x === 1) return n

  if (isEven(x)) return steps(x / 2, n + 1)

  return steps(x * 3 + 1, n + 1)
}

const isEven = (x: number): boolean => x % 2 === 0
