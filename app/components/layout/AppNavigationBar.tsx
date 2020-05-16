import {LANGUAGES} from "../lib/constants";
import {createStyles, ListItemIcon, Theme} from "@material-ui/core";
import Typography from "@material-ui/core/Typography";
import ListItemText from "@material-ui/core/ListItemText";
import ListItem from "@material-ui/core/ListItem";
import Divider from "@material-ui/core/Divider";
import ListSubheader from "@material-ui/core/ListSubheader";
import List from "@material-ui/core/List";
import Drawer from "@material-ui/core/Drawer";
import AppBar from "@material-ui/core/AppBar";
import IconButton from "@material-ui/core/IconButton";
import React, {useContext, useState} from "react";
import Toolbar from "@material-ui/core/Toolbar";
import {RouteChildrenProps, RouteComponentProps, withRouter, WithRouterProps} from "react-router";
import makeStyles from "@material-ui/core/styles/makeStyles";
import MenuIcon from "@material-ui/icons/Menu";
import {I18nContext} from "../lib/i18n";

export interface IAppNavigationBar extends RouteComponentProps {
    updateLang: (lang: LANGUAGES) => void;
}

const useStyles = makeStyles((theme: Theme) =>
    createStyles({
        root: {
            flexGrow: 1,
        },
        menuButton: {
            marginRight: theme.spacing(2),
        },
        title: {
            flexGrow: 1,
        },
    }),
);

const NavBar = ({ updateLang, history }: IAppNavigationBar) => {
    const classes = useStyles();
    const dict = useContext(I18nContext);

    const [barIsOpen, changeBarOpen] = useState<boolean>(false);
    const toggleDrawer = (open: boolean) => (
        event: React.KeyboardEvent | React.MouseEvent,
    ) => {
        if (
            event &&
            event.type === 'keydown' &&
            ((event as React.KeyboardEvent).key === 'Tab' ||
                (event as React.KeyboardEvent).key === 'Shift')
        ) {
            return;
        }
        changeBarOpen(open);
        return true;
    };
    return (
        <AppBar position="static">
            <Toolbar>
                <IconButton
                    edge="start"
                    className={classes.menuButton}
                    onClick={toggleDrawer(true)}
                    color="inherit"
                    aria-label="menu"
                >
                    <MenuIcon/>
                </IconButton>
                <Drawer
                    open={barIsOpen}
                    onClose={toggleDrawer(false)}
                >
                    <List
                        subheader={<ListSubheader>{dict.mainMenu}</ListSubheader>}
                    >
                        {/*<ListItem button onClick={() => history.push('/words')}>*/}
                        {/*    <ListItemIcon><AccountBoxIcon/></ListItemIcon>*/}
                        {/*    <ListItemText primary="Карточка"/>*/}
                        {/*</ListItem>*/}
                    </List>
                </Drawer>
                <Typography variant="h5">
                    {dict.title}
                </Typography>
            </Toolbar>
        </AppBar>
    );
};

export const AppNavigationBar = withRouter(NavBar);
