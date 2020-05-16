import {createContext} from "react";

export const I18nContext = createContext<any>({});

export async function setLanguageAsync(language: string) {
    const newDict = await import(`../locales/${language}.json`);
    return newDict.default;
}