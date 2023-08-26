export const hey = (message: string): string => {
  const containsLetter = /[a-zA-Z]/g.test(message)
  const yelling = containsLetter && message === message.toUpperCase()
  const asking = message.trimEnd().at(-1) === '?'
  const silence = !message.replace(/\s/g, '').length
  
  if (silence) return "Fine. Be that way!"
  if (yelling && asking) return "Calm down, I know what I'm doing!"
  if (yelling) return 'Whoa, chill out!'
  if (asking) return 'Sure.'

  return 'Whatever.'
}
