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
import { Link , useParams} from 'react-router-dom';
import { Report_Data } from "./data/jsonData"
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";

import DonutChart from "./donutChart"
import ChartLine from "./lineChart";
import Header from '../../Header/Header';



export default function () {



    {/*-------------- For the popup message part  ----------------*/ }
    const [popup, setPop] = useState(false);
    const [popup1, setPop1] = useState(false);

    const handleClickopen = () => {
        setPop({ popup: false });
    }
    const handleClickopen1 = () => {
        setPop1(!popup1);
    }

    const closePopup = () => {
        setPop(false);
    }
    const closePopup1 = () => {
        setPop1(false);
    }

    const [Avarage_speed, setAvargeSpeed] = useState("");

    const AvargeSpeed = (average_speed) => {
        Report_Data.map(item => {
            return setAvargeSpeed(`${average_speed}`)
        })
    }
    const [search, setSearch] = useState('');

    const { id , platenumber} = useParams();


    return (
        <div className="dashboard_container">

            {/*---------------navigation---------------*/}

            <div className="dashboard_navigation">
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
                        <Link to="/avialable_trip">
                            <p className="hovertext" data-hover="Trip Management"><BiTrip color='00cc44' size="2rem" ></BiTrip></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/users">
                            <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='white'></FaUsers></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/accident">
                            <p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/report">
                            <p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p>
                        </Link>
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
                        <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                    </li>
                    <li>
                        <Link to="/settings">
                            <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                        </Link>
                    </li>
                </ul>
            </div>

            {/* ---------------header--------------- */}

            <Header title="Report Detail"></Header>

            <div className='main_content2'>
                <div className="Report-main">
                    <div className="vehicle-detail">
                        <div className="vehicle-name">
                            <table class="table-report" >
                                <tbody>
                                    <tr className='row-table'>
                                        <td><b>Vehicle Name</b></td>
                                        <td>{id}</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div className="plate-number">
                            <table class="table-report" >
                                <tbody>
                                    <tr>
                                        <td><b>Plate Number</b></td>
                                        <td>{platenumber}</td>
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
                            <p><input onChange={(e) => {
                                setSearch(e.target.value)
                                // nandu()

                            }} type="date" placeholder='Select date'></input></p>
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
                                        <th>Detail</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    {
                                    Report_Data
                                    .filter((item) => {
                                            return search.toLowerCase() === ''
                                                ? item
                                                : item.start_date.toLowerCase().includes(search);
                                        })
                                    .map(item => {
                                        return <tr className='active_row'>

                                        <td>{item.trip}</td>
                                        <td>{item.total_travel_time}</td>
                                        <td>{item.average_speed}</td>
                                        <td>{item.start_date}</td>
                                        <td>{item.end_date}</td>
                                        <td>
                                            <h4 className='notification_actions0'>
                                                <button onClick={() => {
                                                    handleClickopen()
                                                    AvargeSpeed(item.average_speed)
                                                }}>Detail</button>

                                            </h4>
                                        </td>
                                    </tr>

                                    })
                                }
                                </tbody>

                            </table>
                        </div>
                    </div>

                    {popup ?
                        <div>
                            <div className='popup'>
                                <div className='popup-inner0'>
                                    <button className='close-btn' onClick={closePopup}>X</button>
                                    <div className='startEndPoint'>
                                        <p>Addis Ababa To Jimma</p>
                                        <p>Addis Ababa To Jimma</p>
                                        <p>Addis Ababa To Jimma</p>
                                    </div>
                                    <div className='chart-donat'>
                                        <div className='travelTime'>
                                            <DonutChart />
                                        </div>
                                        <div className='speedHistory'>
                                            Average Speed : <b className='green'>{Avarage_speed}/hr</b>
                                            <ChartLine></ChartLine>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div> : ""}

                </div>
            </div>


        </div>

    )
}
