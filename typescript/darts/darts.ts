export const score = (x: number, y: number): number => {
  if (outOfDartboard(x, y)) return 0
  if (inInnerCircle(x, y)) return 10
  if (inMiddleCircle(x, y)) return 5
  if (inOuterCircle(x, y)) return 1
  return 0 
}

const outOfDartboard = (x: number, y: number): boolean => distance(x, y) > 10
const inInnerCircle = (x: number, y: number): boolean => distance(x, y) <= 1
const inMiddleCircle = (x: number, y: number): boolean => distance(x, y) <= 5
const inOuterCircle = (x: number, y: number): boolean => distance(x, y) <= 10
const distance = (x: number, y: number): number => Math.sqrt(x * x + y * y)

