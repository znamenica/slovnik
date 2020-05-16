import React, {useContext} from "react";
import {I18nContext} from "../lib/i18n";
import {Box} from "@material-ui/core";
import Paper from "@material-ui/core/Paper";
import TextField from "@material-ui/core/TextField";
import ButtonGroup from "@material-ui/core/ButtonGroup";
import Button from "@material-ui/core/Button";

const search = () => {

};

export const MainPage = () => {
    const dict = useContext(I18nContext);
    return (
        <Box m={1}>
            <Paper variant="outlined">
                <Box m={1}>
                    <form>
                        <TextField id="standard-basic" label={dict.word} />
                        <ButtonGroup variant="text" color="primary" aria-label="text primary button group">
                            <Button onClick={search}>{dict.toSearch}</Button>
                        </ButtonGroup>
                    </form>
                </Box>
            </Paper>
        </Box>
    );
};
