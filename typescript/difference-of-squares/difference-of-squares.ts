export class Squares {

  constructor(private readonly count: number) { }

  get sumOfSquares(): number {
    return sum(sequence(1, this.count).map(square))
  }

  get squareOfSum(): number {
    return square(gauss(this.count))
  }

  get difference(): number {
    return this.squareOfSum - this.sumOfSquares
  }
}

const gauss = (x: number): number => (x * (x + 1)) / 2
const square = (x: number): number => Math.pow(x, 2)
const sequence = (from: number, to: number): number[] => Array(to).fill(1).map((_, i) => i + from)
const sum = (xs: number[]): number => xs.reduce((acc, curr) => acc + curr, 0)
