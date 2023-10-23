type OneToMany = {
  [key: string]: string[]
}

type OneToOne = {
  [key: string]: number
}

export const transform = (board: OneToMany): OneToOne => {
  return Object.keys(board).reduce((acc: OneToOne, points: string) => ({
    ...acc,
    ...board[points].reduce((acc: OneToOne, curr: string) => ({
      ...acc,
      [curr.toLowerCase()]: Number(points),
    }), {})
  }), {})
}
