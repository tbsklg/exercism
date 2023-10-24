export class Series {

  constructor(readonly series: string) { }

  slices(sliceLength: number): number[][] {
    if (this.series.length === 0)
      throw new Error('series cannot be empty')

    if (this.series.length < sliceLength)
      throw new Error('slice length cannot be greater than series length')

    if (sliceLength === 0)
      throw new Error('slice length cannot be zero')

    if (sliceLength < 0)
      throw new Error('slice length cannot be negative')

    const chunk = (xs: number[], chunks: number[][] = []): number[][] =>
      (xs.length < sliceLength)
        ? chunks
        : chunk(
          xs.slice(1),
          [...chunks, xs.slice(0, sliceLength)],
        )

    return chunk(this.series.split('').map(Number))
  }
}
