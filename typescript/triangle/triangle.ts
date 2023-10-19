export class Triangle {

  private readonly sides: number[] = []

  constructor(...sides: number[]) {
    this.sides = sides
  }

  get isEquilateral() {
    return this.sides.length === 0
      || this.sides.every((x: number) => x > 0 && x === this.sides[0])
  }

  get isIsosceles() {
    return this.triangleInequality &&
      (this.isEquilateral || new Set(this.sides).size == 2)
  }

  get isScalene() {
    return this.triangleInequality && new Set(this.sides).size === 3
  }

  get triangleInequality() {
    const [a, b, c] = this.sides
    return a + b >= c && b + c >= a && a + c >= b
  }
}
