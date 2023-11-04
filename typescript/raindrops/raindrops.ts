export const convert = (x: number): string =>
  (
    [
      [3, "Pling"],
      [5, "Plang"],
      [7, "Plong"],
    ] as [number, string][]
  ).reduce(
    (acc: string, [factor, sound]) => x % factor === 0 ? acc + sound : acc, ""
  ) || x.toString()

