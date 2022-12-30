import React, { useState, useEffect } from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { RiGpsFill } from "react-icons/ri";
import { MdMonitor } from "react-icons/md";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { FiLogOut } from "react-icons/fi";
import { HiMenuAlt1 } from "react-icons/hi";
import './Message_overview.css';
import { Link } from 'react-router-dom';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import { users } from './data/data';
import Checkbox from './checkbox';
import { CKEditor } from '@ckeditor/ckeditor5-react';
import ClassicEditor from '@ckeditor/ckeditor5-build-classic';
import { IoIosArrowDropdownCircle } from "react-icons/io";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';

{/*---------

import users - to fil the table from data.jsx file
import checkbox - a function to select item individual or select all
import CKEditor - to make a custom message when the popup appear (bold, italic)

-----------*/}
export default function () {



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
            list.map(item => !allChecked ? item.checked = true : item.checked = false);
            setAllChecked(!allChecked);
        } else {
            list.map(item => item.id == id ? item.checked = !item.checked : null);
            setList([...list]);
            list.filter(item => item.checked).length == list.length ? setAllChecked(true) : setAllChecked(false)
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

           <Navigation></Navigation>
                 

            {/* ---------------header--------------- */}
            <Header title="Message"></Header>

            <div className='dashboard_main' >

                <div className="messageOverview-search">
                    {/* --------- Class for the search bar from the table   ------------ */}
                    <p>
                        <input type="text" id="nameInput" placeholder="Search" onChange={(e) => {
                            setsearchTerm(e.target.value);
                        }} />
                    </p>
                </div>

                <div className='message-table'>

                    {/*-------------- ClassName for the whole-table ---------------*/}

                    <table class="table">
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

                                list.map(item => {
                                    return <tr>

                                        <td><Checkbox
                                            id={item.id}
                                            checked={item.checked}
                                            handleCheck={handleCheck}
                                        /></td>
                                        <td>{item.user}</td>
                                        <td>{item.ownerName}</td>
                                        <td>{item.userCatagory}</td>

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
