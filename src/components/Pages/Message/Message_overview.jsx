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
import swal from "sweetalert";
import { useForm } from 'react-hook-form';
import { Pagination } from 'antd';
// import { useForm } from 'react-hook-form';

{/*---------

import checkbox - a function to select item individual or select all
import CKEditor - to make a custom message when the popup appear (bold, italic)

-----------*/}
export default function () {

    const { register, handleSubmit, watch, formState: { errors } } = useForm();

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
                // setTotalPage(data.totalPages)
                setLoading(false)
            })
    }, [])
    const [dataSource2, setDataSource2] = useState([])
    const url2 = "http://198.199.67.201:9090/Api/Message/All";
    useEffect(() => {
        setLoading(true)
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.messages)
                setTotalPage(data.messages.length)
                setLoading(false)
            })
    }, [])

    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(5);
    const indexOfLastPage = page * postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = dataSource2.slice(indexOfFirstPage, indexOfLastPage);

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }

    const [color, setColor] = useState("green");
    const [margin, setMargin] = useState("");


    const [list, setList] = useState([]);
    const [allChecked, setAllChecked] = useState(false);

    const [message, setMessage] = useState("");
    const [receipientPhone, setReceipientPhone] = useState([]);
    console.log(receipientPhone);


    {/*---------------To list element from data.jsx ----------------*/ }
    useEffect(() => {
        setList([...users])
    }, []);

    {/*---------------Selecting item from the table ----------------*/ }
    const handleCheck = (id, phoneNumbers) => {
        if (id == 'selectall') {
            dataSource.map(item => !allChecked ? item.checked = true : item.checked = false);
            setAllChecked(!allChecked);
            setReceipientPhone([dataSource.map(item => item.phoneNumber)]);
        } else {

            console.log(id);
            console.log(phoneNumbers);
            dataSource.map(item => item.id == id ? item.checked = !item.checked : null);
            // dataSource.map(item => item.id == id ?setReceipientPhone(item.phoneNumber) : null);
            setList([...dataSource]);
            dataSource.filter(item => item.checked).length == dataSource.length ? setAllChecked(true) : setAllChecked(false);
            // dataSource.filter(item => item.checked).length == dataSource.length ?  dataSource.map(item => setReceipientPhone(item.phoneNumber)) : setAllChecked(false)
            if (dataSource.filter(item => item.checked).length == dataSource.length) {
                dataSource.map(item => setReceipientPhone([item.phoneNumber]))
            }
            if (phoneNumbers == true) {
                dataSource.map(item => item.id == id ? setReceipientPhone([
                    ...receipientPhone,
                    item.phoneNumber
                ]) : null);
            }
            else {
                dataSource.map(item => item.id == id ? setReceipientPhone("") : null);
            }
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

    const onSubmit = (data) => {
        console.log(data);
        Addvehicle();
    };

    useEffect(() => {
    }, []);

    const handleCheck12 = () => {

    };

    async function Addvehicle() {
        let item =
        {
            message,
            receipientPhone,
        };

        const options = {
            method: "POST",
            headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json",
                "Authorization": `Bearer ${jwt}`
            },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Message/CreateMessage";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful", `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setMessage("");
                setReceipientPhone("");

            } else {
                console.log("failed");
                swal(`Failed To Send ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    return (
        <div className="messageOverview_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/message_overview" title="Message"></Navigation>


            {/* ---------------header--------------- */}
            {/* <Header title="Message"></Header> */}

            <div className={styles.main_content} >

                <div className={styles.outer_vehicle_table} id='myTable'>
                    <div className={styles.vehicle_search}>
                        <p title='search'>
                            <BsSearch className={styles.icn} size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                            <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                            <button>Search</button>
                        </p>
                    </div>

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
                                <th>User Catagory</th>
                                <th>Owner Name</th>

                            </tr>
                        </thead>
                        <tbody>
                            {

                                dataSource.map(item => {
                                    return <tr>

                                        <td><Checkbox
                                            // onClick={setReceipientPhone(item.phoneNumber)}
                                            id={item.id}
                                            phoneNumbers={item.phoneNumber}
                                            checked={item.checked}
                                            handleCheck={handleCheck}
                                        /></td>
                                        <td>{item.firstName}</td>
                                        <td>{item.role}</td>
                                        <td>{item.phoneNumber}</td>

                                    </tr>
                                })
                            }
                        </tbody>
                    </table>
                </div>
                {/*----------className- messageOverview-button is a button which redirect to the popup menu---------*/}
                <div className={styles.messageOverviewbBtton}>
                    <button onClick={handleClickopen} className={styles.messageOverviewText}>Text</button>
                </div>



                <div className={styles.outer_vehicle_table} id='myTable' style={{ marginTop: '100px ' }}>
                    <div className={styles.vehicle_search}>
                        <p title='search'>
                            <BsSearch className={styles.icn} size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                            <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                            <button>Search</button>
                        </p>
                    </div>
                    <p>Sent Messages</p>

                    <table className={styles.vehicle_table} id="myTable">
                        <thead>
                            <tr>
                                <th>From</th>
                                <th>to</th>
                                <th>message</th>
                                <th>status</th>

                            </tr>
                        </thead>
                        <tbody>
                            {

                                currentPage.map(item => {
                                    return <tr>

                                        <td>{item.from}</td>
                                        <td>{item.to}</td>
                                        <td>{item.message}</td>
                                        <td>{item.status}</td>

                                    </tr>
                                })
                            }
                        </tbody>
                    </table>
                </div>
                <div className={styles.page}>
                    <Pagination
                        onChange={(page) => setCurentPage(page)}
                        pageSize={postPerPage}
                        current={page}
                        total={totalPages}
                        showQuickJumper
                        showSizeChanger
                        onShowSizeChange={onShowSizeChange}
                    />
                </div>

                <div>

                    {popup ?

                        <div className={styles.mainPopup}>
                            <form onSubmit={handleSubmit(onSubmit)}>
                                {/*------- className - main-popup - a class for the popup display part----------*/}
                                <div className={styles.holdingForMssage}>

                                    <div className='animate__animated animate__slideInDown'>
                                        <div className={styles.xButton}>
                                            <button className={styles.xPress} onClick={closePopup}>X</button>
                                        </div>
                                        <div className={styles.messageBoxs}>

                                            {/*------ className - message-boxs------- a message writing part--------*/}
                                            <CKEditor
                                                editor={ClassicEditor}
                                                // data={"Send Message here...."}
                                                className={styles.CKcustom}
                                                value={message}
                                                onChange={(event, editor) => {
                                                    setMessage(editor.getData());
                                                    console.log(message)
                                                }}
                                            />
                                        </div>
                                    </div>

                                    <div className={styles.sendButton}>
                                        <button className={styles.editSend}>Send</button>
                                    </div>
                                </div>
                            </form>

                        </div> : ""}

                </div>
            </div>
        </div>
    )
}
