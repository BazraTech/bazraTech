import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { RiGpsFill } from "react-icons/ri";
import { MdMonitor } from "react-icons/md";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BiTrip } from "react-icons/bi";
import { BsFillChatDotsFill } from "react-icons/bs";
import { ImUserTie } from "react-icons/im";
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { useState, useEffect } from 'react';
import './dashboard.css';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';

export default function Dashboard() {
    const userlogin = localStorage.getItem("username");
    const user = JSON.parse(localStorage.getItem("user"));

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api
    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
    };


    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }
    const [popup1, setPop1] = useState(false);
    const handleClickopen1 = () => {
        setPop1(!popup1);
    }

    const url1 = "http://198.199.67.201:9090/Api/Admin/All/Vehicles";
    const [dataSource1, setDataSource1] = useState([])
    useEffect(() => {
        // setLoading(true);
        fetch(url1, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource1(data.totalVehicles)

                // console.log(dataSource2)
                // setLoading(false);

            })
    }, [])

    const url2 = "http://198.199.67.201:9090/Api/Admin/All/Drivers";
    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.totalDrivers)

            })
    }, [])

    const url = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/";
    const [dataSource3, setDataSource3] = useState([])
    useEffect(() => {
        // setLoading(true)
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.vehicleOwnerINF)
                // setTotalPage(data.totalusers)

            })
    }, [])


    return (
        <div>

            <Navigation path="/dashboard"></Navigation>

            {/* ---------------header--------------- */}
            <Header title="Dashboard"></Header>

            {/* ---------------contents--------------- */}

            <div className='main_content' onClick={handleClickopen1}>
                <div className='dashboard_contents'>

                    <div><Link to="/Total_number_of_vehicle" >
                        <div className='vehicle'>
                            <h4>Total Vehicles </h4>
                            <div className='vehicleTotal'>
                                <AiFillCar size="2.8rem" ></AiFillCar>
                                <p>{dataSource1}</p>
                            </div>
                        </div>
                    </Link> </div>

                    <div><Link to="/Total_Drivers" >
                        <div className='vehicle'>
                            <h4>Total Drivers</h4>
                            <div className='vehicleTotal'>
                            <ImUserTie size="2.8rem"></ImUserTie>
                            <p>{dataSource2}</p>
                            </div>
                        </div>
                    </Link> </div>

                    <div><Link to="/message_overview">
                        <div className='comunication'>
                            <h4>Comunication</h4>
                            <BsFillChatDotsFill size="2.7rem" ></BsFillChatDotsFill>
                        </div>
                    </Link></div>

                    <div><Link to="/users">
                        <div className='users'>
                            <h4>List of users</h4>
                            <div className='vehicleTotal'>
                            <FaUsers size="3rem"></FaUsers>
                            <p>{dataSource3.length}</p>
                            </div>
                        </div>
                    </Link> </div>

                    <div><Link to="/Company_registration">
                        <div className='registration'>
                            <h4>Registration</h4>
                            <FaRegIdCard size="3rem" ></FaRegIdCard>
                        </div>
                    </Link> </div>

                    <div><Link to="/avialable_trip">
                        <div className='monitor_vehicle'>
                            <h4>Trip Management</h4>
                            <BiTrip size="3rem" ></BiTrip>
                        </div>
                    </Link> </div>

                    <div><Link to="/report">
                        <div className='report'>
                            <h4>Report</h4>
                            <HiDocumentReport size="3rem" ></HiDocumentReport>
                        </div>
                    </Link> </div>

                    <div><Link to="/accident">
                        <div className='alert'>
                            <h4>Alert</h4>
                            <div className='vehicleTotal'>
                            <HiBellAlert size="3rem" ></HiBellAlert>
                            <p>{dataSource3.length}</p>
                            </div>
                        </div>
                    </Link></div>

                    <div><Link to="/tracking">
                        <div className='tracking'>
                            <h4>Real Time Tracking</h4>
                            <RiGpsFill size="3rem" ></RiGpsFill>
                        </div>
                    </Link></div>
                </div>
            </div>

            {/* ---------------end contents--------------- */}



        </div>

    )
}
