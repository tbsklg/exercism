export class SimpleCipher {
  public readonly key: string

  constructor (key?: string) {
    this.key = key || generateKey()
  }

  encode(xs: string): string {
    const encode = (c: string, k: string) => 
      String.fromCodePoint(97 + (((c.codePointAt(0)! + k.codePointAt(0)!) - 194) % 26))

    return [...xs].map((c: string, i: number) => encode(c, this.key[i % this.key.length])).join('')
  }

  decode(xs: string): string {
    const decode = (c: string, k: string) =>
      String.fromCodePoint(97 + (((c.codePointAt(0)! - k.codePointAt(0)!) + 26) % 26))

    return [...xs].map((c: string, i: number) => decode(c, this.key[i % this.key.length])).join('')
  }
}

const alphabet = "abcdefghijklmnopqrstuvwxyz"
const generateKey = (length: number = 100) => 
  Array.from({length}).map(_ => Math.floor(Math.random() * 25)).map(i => alphabet[i]).join('')

