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
import { FaEdit } from "react-icons/fa";
import { MdDeleteForever } from "react-icons/md";
import './settings.css';
import { Link, NavLink } from 'react-router-dom';
import PopUp from './PopUp';
import { Notification_preference } from "./data/Data"
import { motion } from 'framer-motion'
import { Vehicle_condition } from "./data/Data"
import { Truck_status } from "./data/Data"
import { service_needed } from "./data/Data"
import { user_catagory } from "./data/Data"
import { vehicle_category } from "./data/Data"
import { company_sector } from "./data/Data"
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';

export default function () {

    const [popup, setPop] = useState(false);
    const [popup1, setPop1] = useState(false);
    const [active, setTitle] = useState("");
    const handleClickEdit = () => {
        setPop(!popup);
    }

    const closePopup = () => {
        setPop(false);
    }
    const [popupx, setPopx] = useState(false);
    const handleClickopenx = () => {
        setPopx(!popupx);
    }


    const handleClickEdit1 = () => {
        setPop1(!popup1);
    }

    const closePopup1 = () => {
        setPop1(false);
    }
    const [edit, setEdit] = useState("");

    const setVehicleValue = (variable) => {
        setEdit(`${variable}`)
    }

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api
    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };

    const urlTwo = " http://198.199.67.201:9090/Api/Admin/All/NotificationMedium";
    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        fetch(urlTwo, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.notificationMedias)
                console.log(dataSource2)
            })
    }, [])

    const urlthree = "http://198.199.67.201:9090/Api/Admin/All/VehicleCatagory";
    const [dataSource3, setDataSource3] = useState([])
    useEffect(() => {
        fetch(urlthree, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.vehicleCatagories)
                console.log(dataSource3)
            })
    }, [])

    const urlFour = "http://198.199.67.201:9090/Api/Admin/All/VehicleCondition";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        fetch(urlFour, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data.vehicleConditions)
                console.log(dataSource4)
            })
    }, [])

    const url = "http://198.199.67.201:9090/Api/Admin/All/CompanySector/";

    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.companySectors)
                console.log(dataSource)
            })
    }, [])




    return (
        <div className="alert_container">

            {/*---------------navigation---------------*/}
            <Navigation></Navigation>

            {/* --------------- Settings header --------------- */}

            <Header title="Settings"></Header>
            <div className='alert_main'>

                <div className='outer_setting'>
                    <div className='setting_header'>Notification Preference</div>
                    <PopUp title="Add_Notification" />
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Notification Preference</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    dataSource2.map(item => {
                                        return <tr className='active_row'>

                                            <td>{item.id}</td>
                                            <td>{item.medium}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Notification Preference")
                                                            setVehicleValue(item.medium)
                                                        }}></FaEdit>
                                                    <MdDeleteForever className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>

                                        </tr>

                                    })
                                }
                            </tbody>

                        </table>
                    </div>
                </div>



                <div className='outer_setting'>
                    <div className='setting_header'>Vehicle Condition</div>
                    <PopUp title="Add_Vehicle_Condition" />
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Vehicle Condition</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    dataSource4.map(item => {
                                        return <tr className='active_row'>

                                            <td>{item.id}</td>
                                            <td>{item.conditionName}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Vehicle Condition")
                                                            setVehicleValue(item.conditionName)
                                                        }}></FaEdit>
                                                    <MdDeleteForever className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>

                                        </tr>

                                    })
                                }
                            </tbody>

                        </table>
                    </div>
                </div>


                <div className='outer_setting'>
                    <div className='setting_header'>Truck Status</div>
                    <PopUp title="Add Truck Status " />
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Truck Status</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    Truck_status.map(item => {
                                        return <tr className='active_row'>

                                            <td>{item.id}</td>
                                            <td>{item.truck_status}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Truck Status")
                                                            setVehicleValue(item.truck_status)
                                                        }}></FaEdit>
                                                    <MdDeleteForever className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>

                                        </tr>

                                    })
                                }
                            </tbody>

                        </table>
                    </div>
                </div>


                <div className='outer_setting'>
                    <div className='setting_header'>Service Needed</div>
                    <PopUp title="Add Service Needed " />
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Service Needed</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    service_needed.map(item => {
                                        return <tr className='active_row'>

                                            <td>{item.id}</td>
                                            <td>{item.service_neended}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Service Needed")
                                                            setVehicleValue(item.service_neended)
                                                        }}></FaEdit>
                                                    <MdDeleteForever className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>

                                        </tr>

                                    })
                                }
                            </tbody>

                        </table>
                    </div>
                </div>


                <div className='outer_setting'>
                    <div className='setting_header'>User Category</div>
                    <PopUp title="Add_user_category" />
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>User Category</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    user_catagory.map(item => {
                                        return <tr className='active_row'>

                                            <td>{item.id}</td>
                                            <td>{item.catagory}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit User Category")
                                                            setVehicleValue(item.notification_preference)
                                                        }}></FaEdit>
                                                    <MdDeleteForever className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>

                                        </tr>

                                    })
                                }
                            </tbody>

                        </table>
                    </div>
                </div>

                <div className='outer_setting'>
                    <div className='setting_header'>Vehicle Category</div>
                    <PopUp title="Add_vehicle_category" />
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Vehicle Category</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    dataSource3.map(item => {
                                        return <tr className='active_row'>

                                            <td>{item.id}</td>
                                            <td>{item.catagory}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Vehicle Category")
                                                            setVehicleValue(item.catagory)
                                                        }}></FaEdit>
                                                    <MdDeleteForever className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>

                                        </tr>

                                    })
                                }
                            </tbody>
                        </table>

                    </div>
                </div>


                <div className='outer_setting'>
                    <div className='setting_header'>Company Sector</div>
                    <PopUp title="Add_company_sector" />
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Company Sector</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {
                                    dataSource.map(item => {
                                        return <tr className='active_row'>

                                            <td>{item.id}</td>
                                            <td>{item.sectorName}</td>
                                            <td>{item.status}</td>
                                            <td>
                                                <p className='notification_actions'>
                                                    <FaEdit className='action_edit' size="1.4rem" color='green'
                                                        onClick={() => {
                                                            handleClickEdit()
                                                            setTitle("Edit Company Sector")
                                                            setVehicleValue(item.sectorName)
                                                        }}></FaEdit>
                                                    <MdDeleteForever className='action_edit' size="1.6rem" color='red' onClick={handleClickEdit1}></MdDeleteForever>
                                                </p>
                                            </td>

                                        </tr>

                                    })
                                }
                            </tbody>
                        </table>

                    </div>
                </div>



                <div>
                    {popup ?
                        <div className='popup_modal_edit'>
                            <div className='popup_close_button'>
                                <button className='x-press-report' onClick={closePopup}>X</button>
                            </div>

                            <div className="item-report">
                                <motion.div className="report-status-popup">
                                    <div class="popup_main" >
                                        <h2>{active}</h2>
                                        <input placeholder={edit}></input>
                                        <div className='send_button'>
                                            <button className='popup_add'>Save</button>
                                            <button onClick={closePopup} className='popup_cancle'>Cancle</button>
                                        </div>
                                    </div>

                                </motion.div>
                            </div>



                        </div> : ""}

                </div>

                <div>
                    {popup1 ?
                        <div className='popup_modal_delete'>
                            <div className='popup_close_button'>
                                <button className='x-press-report' onClick={closePopup1}>X</button>
                            </div>

                            <div className="item-report">
                                <div className="report-status-popup">
                                    <div class="popup_main_delete" >
                                        <h3>Are you sure you want to delete ?</h3>
                                        <div className='send_button'>
                                            <button className='popup_add'>Ok</button>
                                            <button onClick={closePopup1} className='popup_cancle'>Cancle</button>
                                        </div>
                                    </div>

                                </div>
                            </div>



                        </div> : ""}

                </div>


            </div>

        </div>
    )
}