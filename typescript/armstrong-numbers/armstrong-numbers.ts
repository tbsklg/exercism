export const isArmstrongNumber = (number: bigint | number): boolean => {
  const digits: number[] = [... '' + number].map(Number)
  const pow = (digits: bigint) => (n: bigint) => n ** digits
  const powNumberOfDigits = pow(BigInt(digits.length))

  return (typeof number !== 'bigint' ? BigInt(number) : number) === digits
    .map(BigInt)
    .map(powNumberOfDigits)
    .reduce((acc: bigint, curr: bigint) => acc + curr, BigInt('0'))
}
