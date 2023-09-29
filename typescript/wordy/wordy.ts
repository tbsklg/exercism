type Operation = (x: number) => number

interface ParseResult<T> {
  result: T,
  further: string,
}

const EMPTY_SPACE = ' '

const init = (xs: string): string => xs.substring(0, xs.length - 1)
const isNumber = (xs: string): boolean => !isNaN(Number(xs))
const words = (xs: string): string[] => xs.split(EMPTY_SPACE)
const isEmpty = (xs: string): boolean => xs === ''

const parseNumber = (xs: string): ParseResult<number> => {
  if (isEmpty(xs)) throw Error ('Syntax error')

  const [n, ...further] = words(xs.trim())
  if (isNumber(n)) return {
    further: further.join(EMPTY_SPACE),
    result: Number(n),
  }

  throw Error('Syntax error')
}

const parseAddition = (xs: string): ParseResult<Operation> => {
  const { result, further } = parseNumber(xs.split(/plus(.*)/s)[1])
  const add = (x: number) => (y: number) => x + y

  return {
    result: add(result),
    further
  }
}


const parseSubtraction = (xs: string): ParseResult<Operation> => {
  const { result, further } = parseNumber(xs.split(/minus(.*)/s)[1])
  const subtract = (x: number) => (y: number) => y - x

  return {
    result: subtract(result),
    further
  }
}

const parseMultiplication = (xs: string): ParseResult<Operation> => {
  const { result, further } = parseNumber(xs.split(/multiplied by(.*)/s)[1])
  const multiply = (x: number) => (y: number) => x * y

  return {
    result: multiply(result),
    further
  }
}

const parseDivision = (xs: string): ParseResult<Operation> => {
  const { result, further } = parseNumber(xs.split(/divided by(.*)/s)[1])
  const divide = (x: number) => (y: number) => y / x

  return {
    result: divide(result),
    further
  }
}

const addition = (xs: string): (ParseResult<Operation> | undefined) => {
  console.log('addition', xs)
  return xs.startsWith('plus')
    ? parseAddition(xs.trim())
    : undefined
}

const subtraction = (xs: string): (ParseResult<Operation> | undefined) => {
  return xs.startsWith('minus')
    ? parseSubtraction(xs)
    : undefined
}

const multiplication = (xs: string): (ParseResult<Operation> | undefined) => {
  return xs.startsWith('multiplied by')
    ? parseMultiplication(xs)
    : undefined
}

const division = (xs: string): (ParseResult<Operation> | undefined) => {
  return xs.startsWith('divided by')
    ? parseDivision(xs)
    : undefined
}

const parseOperations = (xs: string, result: Operation[] = []): Operation[] => {
  if (isEmpty(xs)) return result

  const operation = addition(xs)
    || subtraction(xs)
    || multiplication(xs)
    || division(xs)
  
  if (isNumber(xs.split(' ')[0])) throw Error('Syntax error')
  if (!operation) throw Error('Unknown operation')
  
  return parseOperations(operation.further, [...result, operation.result])
}

const performOperation = (operation: Operation, actual: number): number => {
  return operation(actual)
}

export const answer = (expression: string): number => {
  const [w, n] = init(expression).split('What is')
  if (!isEmpty(w)) throw Error('Unknown operation')
  if (isEmpty(n)) throw Error('Syntax error')

  const { result: start, further } = parseNumber(n.trim())
  const operations: Operation[] = parseOperations(further)

  return operations.reduce((acc, curr) => performOperation(curr, acc), start)
}

