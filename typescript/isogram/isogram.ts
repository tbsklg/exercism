export const isIsogram = (word: string): boolean => {
    // [^a-z] means any character that is not a-z
    const letters = word.toLowerCase().replace(/[^a-z]/g, '').split('');
    const uniqueLetters = new Set(letters);
    return letters.length === uniqueLetters.size;
}

