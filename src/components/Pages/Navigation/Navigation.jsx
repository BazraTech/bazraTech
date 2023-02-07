import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { RiGpsFill } from "react-icons/ri";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { BiTrip } from "react-icons/bi";
import { ImUserTie } from "react-icons/im";
import { Link, useLocation } from 'react-router-dom';
import { useState } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import './navigation.css';

export default function Navigation({ path }) {

    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }

    const location = useLocation();
    // console.log(location.pathname);

    const getColor = () => {
        return '#00cc44'
    }
    const getColor2 = () => {
        return 'white'
    }
    return (
        <div>
            <div className="All_navigation"> 


                {/* <p className="headerBazraName" data-hover="Home">B</p><hr className='hrHeader'></hr> */}

                <ul>

                    {/* <br></br> */}
                    <li>
                        <Link to="/dashboard" style={path == "/dashboard" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Home"><FaHome size="1.8rem" ></FaHome></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Total_number_of_vehicle" style={path == "/Total_number_of_vehicle" ? { color: getColor() } : { color: getColor2(path) }}>
                            <p className="hovertext" data-hover="Vehicle"><AiFillCar size="1.8rem"></AiFillCar></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Total_Drivers" style={path == "/Total_Drivers" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Driver"><ImUserTie size="1.8rem"></ImUserTie></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/tracking" style={path == "/tracking" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Tracking"><RiGpsFill size="1.8rem" ></RiGpsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/avialable_trip" style={path == "/avialable_trip" ? { color: getColor() } : { color: getColor2() }}>
                            <p onClick={handleClickopen} className="hovertext" data-hover="Trip Management"><BiTrip size="1.8rem" ></BiTrip></p>
                        </Link>

                    </li>
                    <li>
                        <Link to="/users" style={path == "/users" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Users"><FaUsers size="1.8rem" ></FaUsers></p>
                        </Link>
                    </li>
                    <li> 
                        <Link to="/Company_registration" style={path == "/Company_registration" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Registration"><FaRegIdCard size="1.7rem" ></FaRegIdCard></p>
                        </Link>
                        {/* <Link to="/individual"  style={{ color: getColor('/individual') }}><p>gg</p></Link> */}
                    </li> 
                    <li>
                        <Link to="/accident" style={path == "/accident" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Alert"><HiBellAlert size="1.8rem" ></HiBellAlert></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/report" style={path == "/report" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Report"><HiDocumentReport size="1.8rem" ></HiDocumentReport>
                            </p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/message_overview" style={path == "/message_overview" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.6rem" ></BsFillChatDotsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Manage_profile" style={path == "/Manage_profile" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Manage profile"><FaUserAlt size="1.7rem"></FaUserAlt></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/settings" style={path == "/settings" ? { color: getColor() } : { color: getColor2() }}>
                            <p className="hovertext" data-hover="Setting"><AiFillSetting size="1.8rem" ></AiFillSetting></p>
                        </Link>
                    </li>
                </ul>
            </div>
        </div>
    )
}
