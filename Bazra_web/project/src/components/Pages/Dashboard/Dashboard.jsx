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
import { HiMenuAlt1 } from "react-icons/hi";
import './dashboard.css';
import { Link } from 'react-router-dom';

export default function () {

    return (
        <div className="dashboard_container">

            {/*---------------navigation---------------*/}

            <div className="dashboard_navigation">
                <ul>
                    <li>
                        <Link to="/dashboard">
                            <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='#00cc44'></FaHome><p></p></p>
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
                            <p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/report"><p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p></Link>
                    </li>
                    <li>
                        <Link to="/Company_registration">
                            <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='white'></FaRegIdCard></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/message_overview">
                            <p class="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="#">
                            <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/settings">
                            <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                        </Link>
                    </li>
                </ul>
            </div>


            {/* ---------------header--------------- */}

            <div className="dashboard_header">
                <h2 className='header_title'>Bazra Motors / <h6> Dashboard</h6></h2>
                <p className='menu_controler'><HiMenuAlt1 size="2rem" color='black'></HiMenuAlt1></p>
                <h4 className='user_profile'><FaUserAlt size="1.8rem" color=' rgb(36, 114, 43);'></FaUserAlt> Anduamlak Alehegne</h4>
                <p title='Log Out' className='log_out'><b><FiLogOut size="2rem" color='black'></FiLogOut></b></p>
            </div>


            {/* ---------------contents--------------- */}

            <div className='dashboard_main'>
                <div className='dashboard_contents'>
                    <p><Link to="/Total_number_of_vehicle" >
                        <div className='vehicle'>
                            <h4>Total Number of Vehicles</h4>
                            <AiFillCar size="2.8rem" color="#006666"></AiFillCar>
                        </div>
                    </Link> </p>
                    <p><Link to="/message_overview">
                        <div className='comunication'>
                            <h4>Comunication</h4>
                            <BsFillChatDotsFill size="3rem" color='#b35900'></BsFillChatDotsFill>
                        </div>
                    </Link></p>
                    <p><Link to="/users">
                        <div className='users'>
                            <h4>List of users</h4>
                            <FaUsers size="3rem" color='#002e4d'></FaUsers>
                        </div>
                    </Link> </p>
                    <p><Link to="/Company_registration">
                        <div className='registration'>
                            <h4>Registration</h4>
                            <FaRegIdCard size="3rem" color='#00802b'></FaRegIdCard>
                        </div>
                    </Link> </p>
                    <p><Link to="/Vehicle_reg">
                        <div className='monitor_vehicle'>
                            <h4>Monitor Vehicles</h4>
                            <MdMonitor size="3rem" color='#009999'></MdMonitor>
                        </div>
                    </Link> </p>
                    <p><Link to="/report">
                        <div className='report'>
                            <h4>Report</h4>
                            <HiDocumentReport size="3rem" color='#005c99'></HiDocumentReport>
                        </div>
                    </Link> </p>
                    <p><Link to="/alert">
                        <div className='alert'>
                            <h4>Alert</h4>
                            <HiBellAlert size="3rem" color='#ff0000'></HiBellAlert>
                        </div>
                    </Link> </p>
                    <p><Link to="/tracking">
                        <div className='tracking'>
                            <h4>Real Time Tracking</h4>
                            <RiGpsFill size="3rem" color='#404040'></RiGpsFill>
                        </div>
                    </Link></p>
                </div>
            </div>

            {/* ---------------end contents--------------- */}


        </div>

    )
}
