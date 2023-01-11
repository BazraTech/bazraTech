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
import { FaWarehouse } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { AiFillCaretDown } from "react-icons/ai";
import { GrFormNext } from "react-icons/gr";
import { GrFormPrevious } from "react-icons/gr";
import { HiMenuAlt1 } from "react-icons/hi";
import './users.css';
// import { useState } from 'react';
import { Link, NavLink } from 'react-router-dom';
import { total } from './Data/Data';
import { on_route } from './Data/Data';
import { parked } from './Data/Data';
import { maintenance } from './Data/Data';
import Tables from './Tables';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';


export default function () {



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


    let [active, setActive] = useState("company");
    let [state, setState] = useState("false");
    const color = () => {
        setState(state);
    }

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };


    const url = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners";

    const [dataSource, setDataSource] = useState([])
    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.vehicleOwners)
                console.log(dataSource)

            })
    }, [])

    const [popup, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop1(!popup);
    }



    return (

        <div className="containerr">

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
                            <p className="hovertext" data-hover="Trip Management"><BiTrip color='white' size="2rem" ></BiTrip></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/users">
                            <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='#00cc44'></FaUsers></p>
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

            {/* --------------- header --------------- */}

            <Header title="Users"></Header>

            {/* --------------- users --------------- */}

            <div className='user'>
                <div className='contents'>

                    <Link style={{ textDecoration: 'none' }} to="/users">
                        <div className='company' onClick={() => setActive("total_users")}>
                            <h4>Total Users</h4>
                            <p><FaUsers size="2.2rem" color='black'></FaUsers><b>{dataSource.length}</b></p>
                        </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/company">
                        <div className='activeNav2' onClick={() => setActive("company")}>
                            <h4>Company</h4>
                            <p><FaWarehouse size="2.2rem" ></FaWarehouse><b>100</b></p>
                        </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/register_individual">
                    <div className='individual' onClick={() => setActive("individual")}>
                        <h4>Individual</h4>
                        <p><FaUserAlt size="2rem"></FaUserAlt><b>100</b></p>
                    </div>
                    </Link>
                </div>

                {/* --------------- search --------------- */}

                <div className='users_search'>
                    <p>
                        <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>

                {/* <div className='filter'>
                    <p>
                        <AiFillFilter className='fil' size="0.8rem" color='rgb(63, 63, 63)'></AiFillFilter>
                        <h6>Filter</h6>
                    </p>
                </div> */}

                {/* --------------------- Table ------------------- */}
                <div>
                    {active === "total_users" && <Tables data={total} title=" Total Users" />}
                    {active === "company" && <Tables data={on_route} title=" Company" />}
                    {active === "individual" && <Tables data={parked} title=" Individual" />}
                </div>

            </div>
        </div >
    )
}
