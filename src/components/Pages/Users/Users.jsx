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
import swal from "sweetalert";


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
                    // swal("Successful", "Successful Added", "error", {
                    //     buttons: false,
                    //     timer: 2000,
                    //   })
                }
            }
        }
    }


    let [active, setActive] = useState("total_users");
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
            <Navigation></Navigation>

            {/* --------------- header --------------- */} 

            <Header title="Users"></Header>

            {/* --------------- users --------------- */}

            <div className='user'>
                <div className='contents'>
                    <Link style={{ textDecoration: 'none' }} to="/users">
                    <div className='activeNav2' onClick={() => setActive("total_users")}>
                        <h4>Total Users</h4>
                        <p><FaUsers size="2.2rem"></FaUsers><b>{dataSource.length}</b></p>
                    </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/company">
                    <div className='company' onClick={() => setActive("company")}>
                        <h4>Company</h4>
                        <p><FaWarehouse size="2.2rem" color='black'></FaWarehouse><b>100</b></p>
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
