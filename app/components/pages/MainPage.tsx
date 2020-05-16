import React, {useContext} from "react";
import {I18nContext} from "../lib/i18n";

export const MainPage = () => {
    const dict = useContext(I18nContext);
    return (
        <div>
            {dict.test}
        </div>
    );
};
