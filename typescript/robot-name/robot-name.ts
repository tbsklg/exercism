export class Robot {
  private names: Set<string> = new Set()

  public constructor(name?: string) {
    this.names.add(name || this.generateName())
  }

  get name(): string {
    return Array.from(this.names).pop() || "" 
  }

  private generateName(): string {
    const alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    const randomLetter = (): string => alphabet[Math.floor(Math.random() * alphabet.length)]
    const randomNumber = (): string => Math.floor(Math.random() * 10).toString()

    return `${randomLetter()}${randomLetter()}${randomNumber()}${randomNumber()}${randomNumber()}`
  }

  public resetName(): void {
    const newName = this.generateName()
    
    if (!this.names.has(newName)) {
      this.names.add(newName)
    } else {
      this.resetName()
    }
  }

  public static releaseNames(): void {
    return
  }
}
