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
import { RiSearchLine } from "react-icons/ri";
import './dashboard.css';
import { Link } from 'react-router-dom';

export default function () {
    return (
        <div className="containerr">

            {/*---------------navigation---------------*/}

            <div className="navigation">
                <ul>
                    <li>
                        <Link to="/dashboard"> <p><FaHome size="2rem" color='#00cc44'></FaHome></p></Link>
                    </li>
                    <li>
                        <p><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p>
                    </li>
                    <li>
                        <p><RiGpsFill size="2rem" color='white'></RiGpsFill></p>
                    </li>
                    <li>
                        <p><MdMonitor size="2rem" color='white'></MdMonitor></p>
                    </li>
                    <li>
                        <Link to="/users">  <p><FaUsers size="2rem" color='white'></FaUsers></p></Link>
                    </li>
                    <li>
                        <p><HiBellAlert size="2rem" color='white'></HiBellAlert></p>
                    </li>
                    <li>
                        <p><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p>
                    </li>
                    <li>
                    <Link to="/Company_registration"> <p><FaRegIdCard size="1.8rem" color='white'></FaRegIdCard></p></Link>
                    </li>
                    <li>
                        <p><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p>
                    </li>
                    <li>
                        <p><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                    </li>
                    <li>
                        <p><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                    </li>
                </ul>
            </div>


            {/* ---------------header--------------- */}

            <div className="header">
                <h2>Bazra Motors</h2>
                <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
            </div>


            {/* ---------------contents--------------- */}

            <div className='main'>
                <div className='contentss'>
                    <div className='vehicle'>
                        <h4>Total Number of Vehicles</h4>
                        <AiFillCar size="3rem" color="#006666"></AiFillCar>
                    </div>
                    <div className='users'>
                        <h4>Comunication</h4>
                        <BsFillChatDotsFill size="3rem" color='#b35900'></BsFillChatDotsFill>
                    </div>
                    <div className='monitor-vehicle'>
                        <h4>List of users</h4>
                        <FaUsers size="3rem" color='#002e4d'></FaUsers>
                    </div>
                    <div className='alert'>
                        <h4>Registration</h4>
                        <FaRegIdCard size="3rem" color='#00802b'></FaRegIdCard>
                    </div>
                    <div className='registration'>
                        <h4>Monitor Vehicles</h4>
                        <MdMonitor size="3rem" color='#009999'></MdMonitor>
                    </div>
                    <div className='communication'>
                        <h4>Report</h4>
                        <HiDocumentReport size="3rem" color='#005c99'></HiDocumentReport>
                    </div>
                    <div className='report'>
                        <h4>Alert</h4>
                        <HiBellAlert size="3rem" color='#ff0000'></HiBellAlert>
                    </div>
                    <div className='tracking'>
                        <h4>Real Time Tracking</h4>
                        <RiGpsFill size="3rem" color='#404040'></RiGpsFill>
                    </div>
                </div>

            </div>

            {/* ---------------end contents--------------- */}


        </div>

    )
}
