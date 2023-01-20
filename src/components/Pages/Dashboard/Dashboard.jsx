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

    // const url = "http://198.199.67.201:9090/Api/SignIn/Admin";
    // const [dataSource, setDataSource] = useState([])
    // useEffect(() => {
    //     fetch(url, options)
    //         .then(respnse => respnse.json())
    //         .then(data => {
    //             setDataSource(data.user)
    //             console.log(dataSource)
    //         })
    // }, [])


    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }
    const [popup1, setPop1] = useState(false);
    const handleClickopen1 = () => {
        setPop1(!popup1);
    }
   

    // const [data, setdata] = useState("");  
    // const zz = localStorage.getItem("tuser");
    // const [username, setUsername] = useState(""); 
    // data = zz;

    useEffect(() => {
        if (!localStorage.getItem("jwt")) {
            window.location.href = "/";
        }
    }, [])

   
    return (
        <div>

            <Navigation></Navigation>

            {/* ---------------header--------------- */}
            <Header title="Dashboard"></Header>

            {/* ---------------contents--------------- */}

            <div className='main_content' onClick={handleClickopen1}>
                <div className='dashboard_contents'>
                    <div><Link to="/Total_number_of_vehicle" >
                        <div className='vehicle'>
                            <h4>Total Number of Vehicles</h4>
                            <AiFillCar size="2.8rem" color="#006666"></AiFillCar>
                        </div>
                    </Link> </div>
                    <div><Link to="/message_overview">
                        <div className='comunication'>
                            <h4>Comunication</h4>
                            <BsFillChatDotsFill size="3rem" color='#b35900'></BsFillChatDotsFill>
                        </div>
                    </Link></div>
                    <div><Link to="/users">
                        <div className='users'>
                            <h4>List of users</h4>
                            <FaUsers size="3rem" color='#002e4d'></FaUsers>
                        </div>
                    </Link> </div>
                    <div><Link to="/Company_registration">
                        <div className='registration'>
                            <h4>Registration</h4>
                            <FaRegIdCard size="3rem" color='#00802b'></FaRegIdCard>
                        </div>
                    </Link> </div>
                    <div><Link to="/avialable_trip">
                        <div className='monitor_vehicle'>
                            <h4>Trip Management</h4>
                            <BiTrip size="3rem" color='#009999'></BiTrip>
                        </div>
                    </Link> </div>
                    <div><Link to="/report">
                        <div className='report'>
                            <h4>Report</h4>
                            <HiDocumentReport size="3rem" color='#005c99'></HiDocumentReport> 
                        </div>
                    </Link> </div>
                    <div><Link to="/accident">
                        <div className='alert'>
                            <h4>Alert</h4>
                            <HiBellAlert size="3rem" color='#F80404'></HiBellAlert> 
                        </div>
                    </Link></div>
                    <div><Link to="/tracking">
                        <div className='tracking'>
                            <h4>Real Time Tracking</h4>
                            <RiGpsFill size="3rem" color='#404040'></RiGpsFill> 
                        </div>
                    </Link></div>
                </div>
            </div>

            {/* ---------------end contents--------------- */}

           

        </div>

    )
}
