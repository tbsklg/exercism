export class Matrix {
  private readonly matrix: number[][]

  constructor(raw: string) {
    this.matrix = raw.split('\n').map((row) => row.split(' ').map(Number))
  }

  get rows(): number[][] {
    return this.matrix
  }

  get columns(): number[][] {
    
    const transpose = (matrix: number[][]): number[][] => {
      if (matrix.every((row) => row.length === 0)) return []

      const colums = matrix.map((row) => row[0])
      return [colums, ...transpose(matrix.map((row) => row.slice(1)))]
    }

    return transpose(this.matrix)
  }
}
