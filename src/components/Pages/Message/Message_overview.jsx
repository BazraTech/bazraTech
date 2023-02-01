import React, { useState, useEffect } from 'react'
import './Message_overview.css';

import { users } from './data/data';
import Checkbox from './checkbox';
import { CKEditor } from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';

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

    return (
        <div className="messageOverview_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/message_overview"></Navigation>


            {/* ---------------header--------------- */}
            <Header title="Message"></Header>

            <div className='main_content' >

                <div className="messageOverview-search">
                    {/* --------- Class for the search bar from the table   ------------ */}
                    <p>
                        <input type="text" id="nameInput" placeholder="Search" onChange={(e) => {
                            setsearchTerm(e.target.value);
                        }} />
                    </p>
                </div>

                <div className='outer_vehicle_tables' id='myTable'>
                    <p>Message</p>

                    <table className="vehicle_table" id="myTable">
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
                <div className='messageOverview-button'>

                    <button onClick={handleClickopen} className='messageOverview-text'>Text</button></div>
                <div>

                    {popup ?
                        <div className='main-popup'>
                            {/*------- className - main-popup - a class for the popup display part----------*/}
                            <div className="holding-for-message">
                                <div className='x-button'>
                                    {/*------ className - x-button - a button to close the popup page----------*/}
                                    <button className='x-press' onClick={closePopup}>X</button>
                                </div>
                                <div className="message-boxs">
                                    {/*------ className - message-boxs------- a message writing part--------*/}
                                    <CKEditor
                                        editor={ClassicEditor}
                                        className="CKcustom"
                                    />
                                </div>

                                <div className='send-button'>
                                    <button className='edit-send'>Send</button>
                                </div>
                            </div>
                        </div> : ""}

                </div>
            </div>
        </div>
    )
}
