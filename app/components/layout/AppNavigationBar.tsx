import {LANGUAGES} from "../lib/constants";

export interface IAppNavigationBar {
    updateLang: (lang: LANGUAGES) => void;
}

export const AppNavigationBar = ({ updateLang }: IAppNavigationBar) => null;
