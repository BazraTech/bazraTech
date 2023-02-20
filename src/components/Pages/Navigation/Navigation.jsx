import React, { useState, useEffect } from 'react'
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
import { IoMdArrowDropdownCircle } from "react-icons/io";
import { IoMdArrowDropupCircle } from "react-icons/io";
import { BsThreeDotsVertical } from "react-icons/bs";
import "./header.css"
import './navigation.css';

export default function Navigation({ path, title }) {

    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }

    const location = useLocation();

    const getColor = () => {
        return '#00cc44'
    }
    const getColor2 = () => {
        return 'white'
    }

    const user = JSON.parse(localStorage.getItem("user"));
    const [logout, setLogout] = useState(false);
    const handleLogout = () => {
        setLogout(!logout);
        setPop3(false);
        setState1(false);
    }
    useEffect(() => {
        if (!localStorage.getItem("jwt")) {
            window.location.href = "/";
        }
    }, [])

    const [popup2, setPop2] = useState(false);
    const handleClickopen2 = () => {
        setPop2(!popup2);
    }
    const [popup3, setPop3] = useState(false);
    const handleClickopen3 = () => {
        setPop3(!popup3);
        setLogout(false);
        setState(false);
    }
    const remove = () => {
        localStorage.removeItem("jwt");
        window.location.href = "/";
    }

    const [state, setState] = useState(false);
    const [state1, setState1] = useState(false);
    const toggle = () => {
        setState(!state);
    };
    const toggle1 = () => {
        setState1(!state1);
    };

    const [action, setAction] = useState(true);

    const [toggles, setToggle] = useState("All_navigation");
    const showMenu = () => {
        setToggle("All_navigation active");
        setAction(!action)
    }
    const hideMenu = () => {
        setToggle("All_navigation");
        setAction(!action)
    }


    return (
        <>
            <div>
                <div className={toggles}>

                    <ul>

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

            <div>
                {/* ----------------- all content ------------------- */}

                <div className="dashboard_headers">

                    <div className='dashboardTitle'>
                        <h2>Bazra Motors /</h2>
                        {/* -------------- props ------------- */}
                        <h5>{title}</h5>
                    </div>
                    <div className='user_dashboard'>
                        <p className='displayUser'><FaUserAlt className='FaUserAlt' size="1.6rem" color='green'></FaUserAlt></p>
                        <p className='displayUser role'>{user.role}</p>
                        <p onClick={() => {
                            handleLogout()
                            toggle()
                        }}>{state ? <IoMdArrowDropupCircle size="1.2rem" color='green'></IoMdArrowDropupCircle> :
                            <IoMdArrowDropdownCircle size="1.2rem" color='green'></IoMdArrowDropdownCircle>}</p>

                        {logout ?
                            <div className='user_logout'>
                                <div>
                                    <Link to="#" style={{ textDecoration: 'none', color: 'white' }}><p className='logicon1'>{user.role}</p><hr className='hrr' /></Link>
                                    <Link to="#" style={{ textDecoration: 'none', color: 'white' }}><p className='logicon1'>{user.username}</p><hr className='hrr' /></Link>
                                    <p onClick={handleClickopen2}>Log Out</p>
                                </div>
                            </div> : ""}

                        {popup3 ?
                            <div className='user_logout'>
                                <div>
                                    <Link to="#" style={{ textDecoration: 'none', color: 'white' }}><p className='logicon1'></p><hr className='hrr' /></Link>
                                    <Link to="#" style={{ textDecoration: 'none', color: 'white' }}><p className='logicon1'></p><hr className='hrr' /></Link>
                                    <p onClick={handleClickopen2}>Log Out</p>
                                </div>
                            </div> : ""}
                    </div>
                    <p onClick={action ? showMenu : hideMenu} className='toggle'><BsThreeDotsVertical className='FaUserAlt' size="1.6rem" color='green'></BsThreeDotsVertical></p>

                </div>

                <div>
                    {popup2 ?
                        <div>
                            <div className='popup0'>
                                <div className='popup-innerq'>
                                    <div onClick={handleClickopen2} className='close'>X</div>

                                    <div className='fgf'>
                                        <h2 className='mnmn'>Are You Sure You want to want Log out</h2>
                                        <div className='send_button'>
                                            <button onClick={() => {
                                                remove()
                                            }} className='popup_add'>Ok</button>
                                            <button onClick={handleClickopen2} className='popup_cancle'>Cancle</button>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div> : ""}
                </div>


            </div>
        </>

    )
}
