export const find = (haystack: number[], needle: number): number => {
  const binarySearch = (from: number, to: number): number => {
    const middleIndex = Math.floor((from + to) / 2)
    const middleValue = haystack[middleIndex]

    if (middleValue === needle) return middleIndex
    if (from >= to) throw new Error('Value not in array')
    if (needle < middleValue) return binarySearch(from, middleIndex)
    if (needle > middleValue) return binarySearch(middleIndex + 1, to)
    
    throw new Error('Value not in array')
  }
  
  return binarySearch(0, haystack.length - 1)
}

