export const isIsogram = (word: string): boolean => {
    const letters = word.toLowerCase().replace(/[^a-z]/g, '').split('');
    const uniqueLetters = new Set(letters);
    return letters.length === uniqueLetters.size;
}

