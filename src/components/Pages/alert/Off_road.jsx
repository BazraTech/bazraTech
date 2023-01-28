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
import { BsSearch } from "react-icons/bs";
import { useState, useEffect } from 'react';
import { Accident } from './Data/Data';
import { off_road } from './Data/Data';
import { driver } from './Data/Data';
import Tables from './Tables';
import { IoIosArrowDropdownCircle } from "react-icons/io";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { Pagination } from 'antd';

export default function () {

    {/*--------------- Declaring variables for calling active table ---------------*/ }



    let [active, setActive] = useState("accident");
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

    const [list, setList] = useState([Accident[0]]);
    const [total, setTotal] = useState(Accident[0].length);
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(10);

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }

    useEffect(() => {
        setTotal([Accident[0].length])
    }, []);


    const indexOfLastPage = page + postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = list[0].slice(indexOfFirstPage, indexOfLastPage);

    function tableSearch() {

        let input, filter, table, tr, td, txtValue, errors;

        //Intialising Variables
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        for (let i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[1];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }

    return (
        <div className="alert_container">

            {/*---------------navigation---------------*/}
            <Navigation></Navigation>

            {/* --------------- Alert header --------------- */}

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
                            <p className="hovertext" data-hover="Trip Management"><BiTrip color='white' size="2rem" ></BiTrip></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/users">
                            <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='white'></FaUsers></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/accident">
                            <p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='00cc44'></HiBellAlert></p>
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

            {/* --------------- Alert --------------- */}
            <Header title="Alert"></Header>

            <div className='alert_main2'>
                <div className='currentHistory'>
                    <Link style={{ textDecoration: 'none' }} to="/accident">
                        <p className='sd'>Current Alerts</p></Link>
                    <Link style={{ textDecoration: 'none' }} to="/AccidentHistory">
                        <p className='sdd'> Alert History</p></Link>
                </div>
                <div className='allDivalert'>

                    <div className='alert_contents'>


                        <Link style={{ textDecoration: 'none' }} to="/accident">
                            <div className='parked' onClick={() => setActive("accident")}>
                                <h4>Accident</h4>
                                <p>< FaCarCrash size="2.2rem" ></ FaCarCrash><b>100</b></p>
                            </div>
                        </Link>

                        <Link style={{ textDecoration: 'none' }} to="/off_road">
                            <div className='activeNav1' onClick={() => setActive("off_road")}>
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
                        {/* <div className='vehicle_search'>
                        <p title='search'>
                            <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                            <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                            <button>Search</button>
                        </p>
                    </div> */}
                        <div className='alert_vehicle_tables' id='myTable'>
                            <p>Off Road Alert</p>

                            <table class="vehicle_table" id="myTable">

                                <thead>
                                    <tr>
                                        <th>Profile</th>
                                        <th>Driver</th>
                                        <th>Plate Number</th>
                                        <th>Alert Location</th>
                                        <th>Alert Type</th>
                                        <th>Owner</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {currentPage.map(item => (
                                        <tr className='active_row'>

                                            <td><FaUserAlt className='next' size="1.5rem" color='rgb(63, 63, 63)'></FaUserAlt></td>
                                            <td>{item.Driver}</td>
                                            <td>{item.Plate_number}</td>
                                            <td>{item.Alert_location}</td>
                                            <td>{item.Alert_type}</td>
                                            <td>{item.Owner}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                        <div className='page'>
                            <Pagination
                                onChange={(page) => setCurentPage(page)}
                                pageSize={postPerPage}
                                current={page}
                                total={total}
                                showQuickJumper
                                showSizeChanger
                                onShowSizeChange={onShowSizeChange}

                            />
                        </div>
                        {/* {active === "accident" && <Tables datas={Accident} title="Accident" />} */}
                        {/* {active === "off_road" && <Tables datas={off_road} title=" Off Road" />}
                    {active === "driver" && <Tables datas={driver} title=" Driver" />} */}

                    </div>

                </div>
            </div>
        </div >
    )
}
