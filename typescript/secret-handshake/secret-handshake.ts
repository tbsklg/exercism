export const commands = (n: number): string[] => {
  const toBinary = (n: number): string => n.toString(2)
  
  return toBinary(n).split('').reverse().reduce((acc: string[], curr: string, i: number) => {
    if (curr === '1') {
      switch (i) {
        case 0: return [...acc, 'wink']
        case 1: return [...acc, 'double blink']
        case 2: return [...acc, 'close your eyes']
        case 3: return [...acc, 'jump']
        case 4: return acc.reverse()
      }
    } 
    return acc
  }, [])
}

