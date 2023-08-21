export const isLeap = (year: number) => {
  const isDivisibleBy = (n: number): boolean => {
    return year % n === 0
  }

  return isDivisibleBy(4) && (!isDivisibleBy(100) || isDivisibleBy(400))
}
