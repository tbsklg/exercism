export class DiffieHellman {

  constructor(readonly p: number, readonly g: number) {
    if (!this.isValid(p) || !this.isValid(g)) throw new Error()
  }

  getPublicKey = (privateKey: number): number => {
    if (!this.isValidPrivateKey(privateKey, this.p)) throw new Error()

    return Math.pow(this.g, privateKey) % this.p
  }

  getSecret = (theirPublicKey: number, myPrivateKey: number): number =>
    Math.pow(theirPublicKey, myPrivateKey) % this.p

  private isInRange = (x: number): boolean => x > 0 && x < 100

  private isPrime = (x: number): boolean =>
    Array.from(
      { length: Math.floor(Math.sqrt(x)) }, (_, i) => i + 2
    )
      .every(n => x % n !== 0)

  private isValid = (x: number): boolean =>
    this.isInRange(x) && this.isPrime(x)

  private isValidPrivateKey = (pk: number, p: number): boolean =>
    pk > 1 && pk < p
}
