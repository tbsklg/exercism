export class Rational {
  public numerator: number
  public denominator: number

  constructor(numerator: number, denominator: number) {
    this.numerator = numerator
    this.denominator = denominator
  }

  add({numerator: n, denominator: d}: Rational): Rational {
    return new Rational(
      this.numerator * d + this.denominator * n,
      this.denominator === d ? 1 : this.denominator * d,
    )
  }

  sub({numerator: n, denominator: d}: Rational): Rational {
    return new Rational(
      this.numerator * d - this.denominator * n,
      this.denominator === d ? 1 : this.denominator * d,
    )
  }

  mul({numerator: n, denominator: d}: Rational): Rational {
    return new Rational(this.numerator * n, this.denominator * d).reduce()
  }

  div({numerator: n, denominator: d}: Rational): Rational {
    return this.mul(new Rational(d, n)).reduce()
  }

  abs(): Rational {
    return new Rational(Math.abs(this.numerator), Math.abs(this.denominator)).reduce()
  }

  exprational(n: number): Rational {
    if (n < 0) {
      return new Rational(this.denominator ** Math.abs(n), this.numerator ** Math.abs(n)).reduce()
    }

    return new Rational(this.numerator ** n, this.denominator ** n).reduce()
  }

  expreal(n: number): number {
    return Math.pow(n ** this.numerator, 1 / this.denominator);
  }

  reduce(): Rational {
    const _gcd = gcd(this.numerator, this.denominator)
    
    const numerator = this.numerator / _gcd
    const denominator = this.denominator / _gcd

    return new Rational(denominator < 0 ? -numerator : numerator, Math.abs(denominator))
  }

}

const gcd = (a: number, b: number): number => {
  if (b === 0) return Math.abs(a)
  
  return gcd(b, a % b)
}
