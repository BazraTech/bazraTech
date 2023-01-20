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
import { Link, useLocation } from 'react-router-dom';
import { useState } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import './navigation.css';

export default function Navigation() {

    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }

    const location = useLocation();
    // console.log(location.pathname);

    const getColor = (curr) => {
        if (location.pathname === curr ) {
            return '#00cc44'
        }

        else {
            return 'white'
        }
    }
    return (
        <div>
            <div className="All_navigation">

                {/* <Link to="/dashboard" style={{ color: getColor('/dashboard') }}>
                    <p className="hovertext" data-hover="Home"><FaHome size="2rem" ></FaHome></p>
                </Link> */}
                <ul>

                    {/* <br></br> */}
                    <li>
                        <Link to="/dashboard" style={{ color: getColor('/dashboard') }}>
                            <p className="hovertext" data-hover="Home"><FaHome size="2rem" ></FaHome></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Total_number_of_vehicle" style={{ color: getColor('/Total_number_of_vehicle') }}>
                            <p className="hovertext" data-hover="Vehicle"><AiFillCar size="2rem"></AiFillCar></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/tracking" style={{ color: getColor('/tracking') }}>
                            <p className="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" ></RiGpsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/avialable_trip" style={{ color: getColor('/avialable_trip') }}>
                            <p onClick={handleClickopen} className="hovertext" data-hover="Trip Management"><BiTrip size="2rem" ></BiTrip></p>
                        </Link>

                    </li>
                    <li>
                        <Link to="/users" style={{ color: getColor('/users') }}>
                            <p className="hovertext" data-hover="Users"><FaUsers size="2rem" ></FaUsers></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/accident" style={{ color: getColor('/accident') }}>
                            <p className="hovertext" data-hover="Alert"><HiBellAlert size="2rem" ></HiBellAlert></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/report" style={{ color: getColor('/report') }}>
                            <p className="hovertext" data-hover="Report"><HiDocumentReport size="2rem" ></HiDocumentReport>
                            </p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Company_registration" style={{ color: getColor('/Company_registration') }}>
                            <p className="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" ></FaRegIdCard></p>
                        </Link>
                        {/* <Link to="/individual"  style={{ color: getColor('/individual') }}><p>gg</p></Link> */}
                    </li>
                    <li>
                        <Link to="/message_overview" style={{ color: getColor('/message_overview') }}>
                            <p className="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" ></BsFillChatDotsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="#">
                            <p className="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/settings" style={{ color: getColor('/settings') }}>
                            <p className="hovertext" data-hover="Setting"><AiFillSetting size="2rem" ></AiFillSetting></p>
                        </Link>
                    </li>
                </ul>
            </div>
        </div>
    )
}
