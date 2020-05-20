import React, {ChangeEvent, useContext, useState} from "react";
import {I18nContext} from "../lib/i18n";
import {Box} from "@material-ui/core";
import Paper from "@material-ui/core/Paper";
import TextField from "@material-ui/core/TextField";
import ButtonGroup from "@material-ui/core/ButtonGroup";
import Button from "@material-ui/core/Button";
import {searchWord, Word} from "../controllers/word";

export const MainPage = () => {
    const dict = useContext(I18nContext);
    const [searchValue, setSearchValue] = useState('');
    const handleChange = (event: ChangeEvent<HTMLInputElement>) => {
        setSearchValue(event.target.value);
    };
    const [words, setWords] = useState<Word[]>([]);
    const search = async () => {
        const w = await searchWord(searchValue);
        setWords(w);
    };
    return (
        <Box m={1}>
            <Paper variant="outlined">
                <Box m={1}>
                    <form>
                        <TextField
                            id="standard-basic"
                            label={dict.word}
                            value={searchValue}
                            onChange={handleChange}
                        />
                        <ButtonGroup variant="text" color="primary" aria-label="text primary button group">
                            <Button onClick={search}>{dict.toSearch}</Button>
                        </ButtonGroup>
                    </form>
                </Box>
            </Paper>
        </Box>
    );
};
