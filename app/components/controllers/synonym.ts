import {Word} from "./word";
import {format} from "url";

export async function getSynonymsByWordId(id: number): Promise<Word[]> {
    const url = format({
        pathname: '/synonyms',
        query: {
          wordId: id,
        },
    });
    const response = await fetch(url);
    const words: Word[] = await response.json();
    return words;
}