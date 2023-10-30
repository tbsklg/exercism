export class List<T> {

  private constructor(readonly values: T[]) { }

  public static create<T>(...values: T[]): List<T> {
    return new List(values)
  }

  forEach(cb: (item: any) => void): void {
    for (const item of this.values) {
      cb(item)
    }
  }

  append(list: List<T>): List<T> {
    return List.create(...this.values, ...list.values)
  }

  concat(list: List<List<T>>): List<T> {
    return list.foldl((acc: List<T>, curr: List<T>) => acc.append(curr), List.create(...this.values))
  }

  filter<T>(fn: ((item: T) => Boolean)): T[] {
    return this.foldr((acc: T[], curr: T) => fn(curr) ? [curr, ...acc] : acc, [])
  }

  length(): number {
    return this.foldr((acc: number, _: any) => acc + 1, 0)
  }

  map<T>(fn: ((item: any) => T)): T[] {
    return this.foldr((acc: T[], curr: any) => [fn(curr), ...acc], [])
  }

  foldl<T, R>(fn: ((acc: R, curr: T) => R), acc: R): R {
    this.forEach((item: T) => {
      acc = fn(acc, item)
    })

    return acc
  }

  foldr<T, R>(fn: ((acc: R, curr: T) => R), acc: R): R {
    const newList = List.create(...this.values.reverse())
    return newList.foldl(fn, acc)
  }

  reverse(): T[] {
    const newList = List.create(...this.values.reverse())
    return newList.values
  }
}

