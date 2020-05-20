import {format} from "url";

export interface Word {

}

export async function searchWord(search: string): Promise<Word[]> {
    const url = format({
        pathname: '/words',
        query: {
            search,
        },
    });
    const response = await fetch(url);
    const words: Word[] = await response.json();
    return words;
}

export async function addWord(word: Partial<Word>): Promise<void> {
    const options = {
        url: `words`,
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(word),
    } as unknown as Request;
    await fetch(options);
}