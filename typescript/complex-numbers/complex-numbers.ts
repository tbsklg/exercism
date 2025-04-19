export class ComplexNumber {
  readonly _real: number;
  readonly _imaginary: number;

  constructor(real: number, imaginary: number) {
    this._real = real;
    this._imaginary = imaginary;
  }

  public get real(): number {
    return this._real;
  }

  public get imag(): number {
    return this._imaginary;
  }

  public add(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(
      this._real + other.real,
      this._imaginary + other.imag,
    );
  }

  public sub(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(
      this._real - other.real,
      this._imaginary - other.imag,
    );
  }

  public div(other: ComplexNumber): ComplexNumber {
    const denominator = other.real * other.real + other.imag * other.imag;
    if (denominator === 0) {
      throw new Error("Division by zero");
    }

    const realPart =
      (this._real * other.real + this._imaginary * other.imag) / denominator;
    const imagPart =
      (this._imaginary * other.real - this._real * other.imag) / denominator;

    return new ComplexNumber(realPart, imagPart);
  }

  public mul(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(
      this._real * other.real - this._imaginary * other.imag,
      this._real * other.imag + this._imaginary * other.real,
    );
  }

  public get abs(): number {
    return Math.sqrt(
      this._real * this._real + this._imaginary * this._imaginary,
    );
  }

  public get conj(): ComplexNumber {
    return new ComplexNumber(
      this._real,
      this._imaginary === 0 ? 0 : -1 * this._imaginary,
    );
  }

  public get exp(): ComplexNumber {
    const expReal = Math.exp(this._real);
    return new ComplexNumber(
      expReal * Math.cos(this._imaginary),
      expReal * Math.sin(this._imaginary),
    );
  }
}
