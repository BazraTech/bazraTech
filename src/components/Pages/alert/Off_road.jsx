import React from 'react'
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
import { FaCarCrash } from "react-icons/fa";
import { TbTriangleOff } from "react-icons/tb";
import { FaUserSecret } from "react-icons/fa";
import { HiMenuAlt1 } from "react-icons/hi";
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import './alert.css';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { Accident } from './Data/Data';
import { off_road } from './Data/Data';
import { driver } from './Data/Data';
import Tables from './Tables';
import { IoIosArrowDropdownCircle } from "react-icons/io";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';

export default function () {

    {/*--------------- Declaring variables for calling active table ---------------*/ }



    let [active, setActive] = useState("off_road");
    let [state, setState] = useState("false");
    const color = () => {
        setState(state);
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
        <div className="alert_container">

            {/*---------------navigation---------------*/}
            <Navigation></Navigation>

            {/* --------------- Alert header --------------- */}

            <Header title="Alert"></Header>

            {/* --------------- Alert --------------- */}

            <div className='alert_main'>
                <div className='alert_contents'>
                    <Link style={{ textDecoration: 'none' }} to="/accident">
                        <div className='parked' onClick={() => setActive("accident")}>
                            <h4>Accident</h4>
                            <p>< FaCarCrash size="2.2rem" ></ FaCarCrash><b>100</b></p>
                        </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/off_road">
                        <div className='activeNav' onClick={() => setActive("off_road")}>
                            <h4>Off Road</h4>
                            <p><TbTriangleOff size="2.2rem" ></TbTriangleOff><b>100</b></p>
                        </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/driver">
                        <div className='parked' onClick={() => setActive("driver")}>
                            <h4>Driver</h4>
                            <p><FaUserSecret size="2rem"></FaUserSecret><b>100</b></p>
                        </div>
                    </Link>

                </div>

                {/* --------------------- Alert Tables ------------------- */}
                <div>
                    {active === "accident" && <Tables datas={Accident} title="Accident" />}
                    {active === "off_road" && <Tables datas={off_road} title=" Off Road" />}
                    {active === "driver" && <Tables datas={driver} title=" Driver" />}

                </div>


            </div>
        </div >
    )
}
