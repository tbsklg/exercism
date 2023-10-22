export class Gigasecond {
  private readonly _date: Date

  constructor(readonly from: Date) {
    this._date = from
  }

  plusOneGigasecond(date: Date): Date {
    return new Date(date.valueOf() + 1000000000000)
  }

  public date(): Date {
    return this.plusOneGigasecond(this._date)
  }
}
