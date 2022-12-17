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
import './alert.css';
import { Link, NavLink } from 'react-router-dom';
import { useState } from 'react';
import { Accident } from './Data/Data';
import { off_road } from './Data/Data';
import { driver } from './Data/Data';
import Tables from './Tables';



export default function () {

    {/*--------------- Declaring variables for calling active table ---------------*/ }

    let [active, setActive] = useState("accident");
    let [state, setState] = useState("false");
    const color = () => {
        setState(state);
    }

    return (
        <div className="alert_container">

            {/*---------------navigation---------------*/}

            <div className="alert_navigation">
                <ul>
                    <li>
                        <Link to="/dashboard">
                            <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Total_number_of_vehicle">
                            <p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/tracking">
                            <p class="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" color='white'></RiGpsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="#">
                            <p class="hovertext" data-hover="Monitor Vehicles"><MdMonitor size="2rem" color='white'></MdMonitor></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/users">
                            <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='white'></FaUsers></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/alert">
                            <p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='#00cc44'></HiBellAlert>
                            </p></Link>
                    </li>
                    <li>
                        <Link to="/report">
                            <p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport>
                            </p></Link>
                    </li>
                    <li>
                        <Link to="/Company_registration">
                            <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='white'></FaRegIdCard></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/message_overview">
                            <p class="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p></Link>
                    </li>
                    <li>
                        <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                    </li>
                    <Link to="/settings">
                        <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                    </Link>
                </ul>
            </div>


            {/* --------------- Alert header --------------- */}

            <div className="alert_header">
                <h2 className='header_title'>Bazra Motors / <h6> Alert</h6></h2>
                <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
            </div>


            {/* --------------- Alert --------------- */}

            <div className='alert_main'>
                <div className='alert_contents'>

                    <div className='alert_accident' onClick={() => setActive("accident")}>
                        <h4>Accident</h4>
                        <p>< FaCarCrash size="2.2rem" color='black'></ FaCarCrash><b>100</b></p>
                    </div>
                    <div className='alert_accident' onClick={() => setActive("off_road")}>
                        <h4>Off Road</h4>
                        <p><TbTriangleOff size="2.2rem" color='black'></TbTriangleOff><b>100</b></p>
                    </div>
                    <div className='alert_accident' onClick={() => setActive("driver")}>
                        <h4>Driver</h4>
                        <p><FaUserSecret size="2rem" color='black'></FaUserSecret><b>100</b></p>
                    </div>

                </div>

                {/* --------------------- Alert Tables ------------------- */}
                <div>
                    {active === "accident" && <Tables datas={Accident} title=" Accident" />}
                    {active === "off_road" && <Tables datas={off_road} title=" Off Road" />}
                    {active === "driver" && <Tables datas={driver} title=" Driver" />}
                </div>


            </div>
        </div >
    )
}
