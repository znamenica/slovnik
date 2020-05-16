import React, {useEffect, useState} from 'react';
import './App.css';
import {BrowserRouter, Route, Switch} from "react-router-dom";
import {I18nContext, setLanguageAsync} from "./lib/i18n";
import {AppNavigationBar} from "./layout/AppNavigationBar";
import {MainPage} from "./pages/MainPage";
import {LANGUAGES} from "./lib/constants";

function App() {
    const [lang, updateLang] = useState(LANGUAGES.INTERSLAVIC);
    const [dict, updateDict] = useState({});

    // If lang changed, re-request the dictionary
    useEffect(() => {
        setLanguageAsync(lang).then((res: any) => {
            updateDict(res);
        });
    }, [lang]);

  return (
      <div className="App">
        <I18nContext.Provider value={dict}>
          <BrowserRouter>
            <AppNavigationBar updateLang={updateLang} />
            <Switch>
              <Route exact path="/" component={MainPage}/>
            </Switch>
          </BrowserRouter>
        </I18nContext.Provider>
      </div>
  );
}

export default App;
