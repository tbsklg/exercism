export class Clock {
  private minutes: number

  constructor(hour: number, minute?: number) {
    this.minutes = (hour * 60 + (minute || 0)) % 1440

    if (this.minutes < 0) {
      this.minutes += 1440
    }
  }

  public toString(): unknown {
    const hour = Math.floor(this.minutes / 60) 
    const minute = this.minutes % 60

    return `${this.printTime(hour)}:${this.printTime(minute)}`
  }
  
  private printTime = (time: number): string => time > 9 ? ''+time : (''+time).padStart(2, '0')

  public plus(minutes: number): Clock {
    return new Clock(0, this.minutes + minutes)
  }

  public minus(minutes: number): Clock {
    return new Clock(0, this.minutes - minutes)
  }

  public equals(other: Clock): boolean{
    return this.minutes === other.minutes
  }
}

