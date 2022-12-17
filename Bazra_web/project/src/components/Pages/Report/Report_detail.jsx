import React, { useState } from 'react'
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
import './Report_detail.css';
import { Link } from 'react-router-dom'; 


import DonutChart from "./donutChart"
import ChartLine from "./lineChart";



export default function () {



    {/*-------------- For the popup message part  ----------------*/ }
    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }

    const closePopup = () => {
        setPop(false);
    }

    return (
        <div className="dashboard_container" id="navLinks" >

            {/*---------------navigation---------------*/}

            <div className="dashboard_navigation" id="nandu">
                <ul>
                    <li>
                        <Link to="/dashboard"> <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p></Link>
                    </li>
                    <li>
                        <Link to="/Total_number_of_vehicle"><p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p></Link>
                    </li>
                    <li>
                        <Link to="/tracking"><p class="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" color='white'></RiGpsFill></p></Link>
                    </li>
                    <li>
                        <Link to="#"> <p class="hovertext" data-hover="Monitor Vehicles"><MdMonitor size="2rem" color='white'></MdMonitor></p></Link>
                    </li>
                    <li>
                        <Link to="/users">  <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='white'></FaUsers></p></Link>
                    </li>
                    <li>
                        <Link to="/alert"><p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p></Link>
                    </li>
                    <li>
                        <Link to="/report"><p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='#00cc44'></HiDocumentReport></p></Link>
                    </li>
                    <li>
                        <Link to="/Company_registration"> <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='white'></FaRegIdCard></p></Link>
                    </li>
                    <li>
                        <Link to="/message_overview"><p class="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p></Link>
                    </li>
                    <li>
                        <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                    </li>
                    <li>
                        <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                    </li>
                </ul>
            </div>


            {/* ---------------header--------------- */}

            <div className="dashboard_header">
                <h2 className='header_title'>Bazra Motors / <h6> Report</h6></h2>
                <p className='menu_controler'><HiMenuAlt1 size="2rem" color='black'></HiMenuAlt1></p>
                <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
            </div>

            <div className="Report-main">
                <div className="vehicle-detail">
                    <div className="vehicle-name">
                        <table class="table-report" >
                            <tbody>
                                <tr className='row-table'>
                                    <td><b>Vehicle Name</b></td>
                                    <td>Sino</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div className="plate-number">
                        <table class="table-report" >
                            <tbody>
                                <tr>
                                    <td><b>Plate Number</b></td>
                                    <td>ET 000345</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div className="row-two">
                    <div className="report-status">
                        <table class="table-report-status" >
                            <tbody>
                                <tr>
                                    <td><b>Current Status</b></td>
                                    <td className='colors-report'><b>On route</b></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div className='report-date'>
                        <p><input type="date" placeholder='Select date'></input></p>
                    </div>
                </div>

                <div className='trip-tables' >
                    <div className='t-table'>
                        <table class="vehicle-trip-table">
                            <thead>
                                <tr>
                                    <th>Trip</th>
                                    <th>Total Travel Time</th>
                                    <th>Average Speed</th>
                                    <th>Start Date/Time</th>
                                    <th>End Date/Time</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className='active_row' onClick={handleClickopen}>
                                    <td>Addi Ababa To Jima</td>
                                    <td>100hour</td>
                                    <td>60Km/hr</td>
                                    <td>20/05/2015 04:30</td>
                                    <td>22/05/2015 10:30</td>
                                </tr>
                                <tr className='active_row' onClick={handleClickopen}>
                                    <td>Addi Ababa To Jima</td>
                                    <td>100hour</td>
                                    <td>60Km/hr</td>
                                    <td>20/05/2015 04:30</td>
                                    <td>22/05/2015 10:30</td>
                                </tr>
                                <tr className='active_row' onClick={handleClickopen}>
                                    <td>Addi Ababa To Jima</td>
                                    <td>100hour</td>
                                    <td>60Km/hr</td>
                                    <td>20/05/2015 04:30</td>
                                    <td>22/05/2015 10:30</td>
                                </tr>
                                <tr className='active_row' onClick={handleClickopen}>
                                    <td>Addi Ababa To Jima</td>
                                    <td>100hour</td>
                                    <td>60Km/hr</td>
                                    <td>20/05/2015 04:30</td>
                                    <td>22/05/2015 10:30</td>
                                </tr>
                                <tr className='active_row' onClick={handleClickopen}>
                                    <td>Addi Ababa To Jima</td>
                                    <td>100hour</td>
                                    <td>60Km/hr</td>
                                    <td>20/05/2015 04:30</td>
                                    <td>22/05/2015 10:30</td>
                                </tr>

                            </tbody>

                        </table>
                    </div>
                </div>
                {popup ?
                    <div className='report-popup'>
                        <div className='x-button-report'>
                            <button className='x-press-report' onClick={closePopup}>X</button>
                        </div>

                        <div className="item-report">
                            <div className="report-status-popup">
                                <table class="table-report-popup" >
                                    <tbody>
                                        <tr className='ind-report'>
                                            <td><b className='ind-report'>Addis Ababa to Jima</b></td>
                                            <td><b className='ind-report'>20/05/2015 04:30</b></td>
                                            <td><b className='ind-report'>22/05/2015 10:30</b></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div className="Status-report">
                                <div className="donut-chart">
                                    <DonutChart />
                                </div>

                                <div className="line-chart">
                                    <ChartLine />

                                </div>
                            </div>
                        </div>



                    </div> : ""}

            </div>

        </div>

    )
}
