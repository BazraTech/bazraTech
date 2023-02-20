import React, { useState, useEffect } from 'react'
import styles from './message.module.css';
import './height.css';
import { users } from './data/data';
import Checkbox from './checkbox';
import { CKEditor } from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { BsSearch } from "react-icons/bs";

{/*---------

import users - to fil the table from data.jsx file
import checkbox - a function to select item individual or select all
import CKEditor - to make a custom message when the popup appear (bold, italic)

-----------*/}
export default function () {

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };

    const [totalPages, setTotalPage] = useState(1);
    const [dataSource, setDataSource] = useState([])
    const [Loading, setLoading] = useState([])
    const url = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/";
    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.vehicleOwnerINF)
                setTotalPage(data.totalPages)

                console.log(dataSource)
                setLoading(false)
            })
    }, [])



    {/*---------------Initializing variable ----------------*/ }

    const [searchTerm, setsearchTerm] = useState("");

    const [list, setList] = useState([]);
    const [allChecked, setAllChecked] = useState(false);

    {/*---------------To list element from data.jsx ----------------*/ }
    useEffect(() => {
        setList([...users])
    }, []);

    {/*---------------Selecting item from the table ----------------*/ }
    const handleCheck = (id) => {
        if (id == 'selectall') {
            dataSource.map(item => !allChecked ? item.checked = true : item.checked = false);
            setAllChecked(!allChecked);
        } else {
            dataSource.map(item => item.id == id ? item.checked = !item.checked : null);
            setList([...dataSource]);
            dataSource.filter(item => item.checked).length == dataSource.length ? setAllChecked(true) : setAllChecked(false)
        }
    }

    {/*-------------- For the popup message part  ----------------*/ }
    const [popup1, setPop1] = useState(false);
    const handleClickopen1 = () => {
        setPop1(!popup1);
    }

    const closePopup = () => {
        setPop(false);
    }
    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }
    const user = JSON.parse(localStorage.getItem("user"));
    const [logout, setLogout] = useState(false);
    const handleLogout = () => {
        setLogout(!logout);
    }
    useEffect(() => {
        if (!localStorage.getItem("jwt")) {
            window.location.href = "/";
        }
    }, [])

    function tableSearch() {

        let input, filter, table, tr, td, txtValue, errors;

        //Intialising Variables for search bar
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        for (let i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[4];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }

    return (
        <div className="messageOverview_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/message_overview" title="Message"></Navigation>


            {/* ---------------header--------------- */}
            {/* <Header title="Message"></Header> */}

            <div className={styles.main_content} >

                <div className={styles.vehicle_search}>
                    <p title='search'>
                        <BsSearch className={styles.icn} size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>

                <div className={styles.outer_vehicle_table} id='myTable'>
                    <p>Message</p>

                    <table className={styles.vehicle_table} id="myTable">
                        <thead>
                            <tr>
                                <th>Select All
                                    <Checkbox
                                        id={'selectall'}
                                        checked={allChecked}
                                        handleCheck={handleCheck}
                                    />
                                </th>
                                <th>User</th>
                                <th>Owner Name</th>
                                <th>User Catagory</th>

                            </tr>
                        </thead>
                        <tbody>
                            {

                                dataSource.map(item => {
                                    return <tr>

                                        <td><Checkbox
                                            id={item.id}
                                            checked={item.checked}
                                            handleCheck={handleCheck}
                                        /></td>
                                        <td>{item.firstName}</td>
                                        <td>{item.firstName}</td>
                                        <td>{item.role}</td>

                                    </tr>
                                })
                            }


                        </tbody>
                    </table>
                </div>


                {/*----------className- messageOverview-button is a button which redirect to the popup menu---------*/}
                <div className={styles.messageOverviewbBtton}>

                    <button onClick={handleClickopen} className={styles.messageOverviewText}>Text</button></div>
                <div>

                    {popup ?
                        <div className={styles.mainPopup}>
                            {/*------- className - main-popup - a class for the popup display part----------*/}
                            <div className={styles.holdingForMssage}>
                                <div className={styles.xButton}>
                                    {/*------ className - x-button - a button to close the popup page----------*/}
                                    <button className={styles.xPress} onClick={closePopup}>X</button>
                                </div>
                                <div className={styles.messageBoxs}>
                                    {/*------ className - message-boxs------- a message writing part--------*/}
                                    <CKEditor
                                        editor={ClassicEditor}
                                        className={styles.CKcustom}
                                    />
                                </div>

                                <div className={styles.sendButton}>
                                    <button className={styles.editSend}>Send</button>
                                </div>
                            </div>
                        </div> : ""}

                </div>
            </div>
        </div>
    )
}
