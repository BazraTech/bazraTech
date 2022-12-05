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
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { AiFillCaretDown } from "react-icons/ai";
import { GrFormNext } from "react-icons/gr";
import { GrFormPrevious } from "react-icons/gr";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import './detail.css';
import { Link } from 'react-router-dom';


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

    return (

        <div className="containerr">

            {/*---------------navigation---------------*/}

            <div className="navigation">
                <ul>
                    <li>
                        <Link to="/dashboard"> <p><FaHome size="2rem" color='white'></FaHome></p></Link>
                    </li>
                    <li>
                        <Link to="/Vehicle_reg"><p><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p></Link>
                    </li>
                    <li>
                        <p><RiGpsFill size="2rem" color='white'></RiGpsFill></p>
                    </li>
                    <li>
                        <p><MdMonitor size="2rem" color='white'></MdMonitor></p>
                    </li>
                    <li>
                        <Link to="/users">  <p><FaUsers size="2rem" color='#00cc44'></FaUsers></p></Link>
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


            {/* --------------- header --------------- */}

            <div className="header">
                <h2>Bazra Motors</h2>
                <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
            </div>


            {/* --------------- users --------------- */}

            <div className='user'>
                <div className='detail'>
                    <div className='tootal_vehicle'>
                        <h4>Total Vehicle</h4>
                        <p><AiFillCar size="2.3rem" color='black'></AiFillCar><b>10</b></p>
                    </div>
                    <div className='company'>
                        <h4>On Route</h4>
                        <p><FaRoute size="2.2rem" color='black'></FaRoute><b>10</b></p>

                    </div>
                    <div className='individual'>
                        <h4>Parked</h4>
                        <p><FaParking size="2rem" color='black'></FaParking><b>10</b></p>
                    </div>
                    <div className='maintenance'>
                        <h4>Maintenance</h4>
                        <p><GrSettingsOption size="2rem" color='black'></GrSettingsOption><b>10</b></p>
                    </div>
                </div>

                {/* --------------- search --------------- */}

                <div className='search'>
                    <p>
                        <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>

                <div className='filter'>
                    <p>
                        <AiFillFilter className='fil' size="0.8rem" color='rgb(63, 63, 63)'></AiFillFilter>
                        <h6>Filter</h6>
                    </p>
                </div>

                {/* --------------------- Table ------------------- */}
                <div className='table' id='myTable'>
                    <h2>On Route</h2>
                    <table class="table" id="myTable" data-filter-control="true" data-show-search-clear-button="true">

                        <thead>
                            <tr>
                                <th>Profile</th>
                                <th>Assigned Deriver</th>
                                <th>Vehicle ID</th>
                                <th>Vehicle Type</th>
                                <th>Plate Number</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr className='active_row'>
                                <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                <td>Abebe Alemu</td>
                                <td>BA 000002</td>
                                <td>Long Carrier</td>
                                <td>Et 3 B23476</td>
                            </tr>
                            <tr>
                                <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                <td>Abebe Alemu</td>
                                <td>BA 000002</td>
                                <td>Long Carrier</td>
                                <td>Et 3 B23476</td>

                            </tr>
                            <tr className='active_row'>
                                <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                <td>Abebe Alemu</td>
                                <td>BA 000002</td>
                                <td>Long Carrier</td>
                                <td>Et 3 B23476</td>

                            </tr>
                        </tbody>

                    </table>
                    <h2>Parked</h2>
                    <table class="table" id="myTable" data-filter-control="true" data-show-search-clear-button="true">

                        <thead>
                            <tr>
                                <th>Profile</th>
                                <th>Assigned Deriver</th>
                                <th>Vehicle ID</th>
                                <th>Vehicle Type</th>
                                <th>Plate Number</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr className='active_row'>
                                <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                <td>Abebe Alemu</td>
                                <td>BA 000002</td>
                                <td>Long Carrier</td>
                                <td>Et 3 B23476</td>
                            </tr>
                            <tr>
                                <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                <td>Abebe Alemu</td>
                                <td>BA 000002</td>
                                <td>Long Carrier</td>
                                <td>Et 3 B23476</td>

                            </tr>
                        </tbody>

                    </table>
                    <h2 className='topic'>Maintenace</h2>
                    <table class="table" id="myTable" data-filter-control="true" data-show-search-clear-button="true">

                        <thead>
                            <tr>
                                <th>Profile</th>
                                <th>Assigned Deriver</th>
                                <th>Vehicle ID</th>
                                <th>Vehicle Type</th>
                                <th>Plate Number</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr className='active_row'>
                                <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                <td>Abebe Alemu</td>
                                <td>BA 000002</td>
                                <td>Long Carrier</td>
                                <td>Et 3 B23476</td>
                            </tr>
                            <tr>
                                <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                <td>Abebe Alemu</td>
                                <td>BA 000002</td>
                                <td>Long Carrier</td>
                                <td>Et 3 B23476</td>

                            </tr>
                        </tbody>
                    </table>
                </div>
                <div className='page'>
                    <p>Row per page</p><p className='num'>3</p>
                    <p><AiFillCaretDown className='sel' size="0.8rem" color='rgb(63, 63, 63)'></AiFillCaretDown></p>
                    <p>1-8 of 12</p>
                    <p><GrFormPrevious className='next' size="1rem" color='rgb(63, 63, 63)'></GrFormPrevious></p>
                    <p><GrFormNext className='next' size="1rem" color='rgb(63, 63, 63)'></GrFormNext></p>
                </div>
            </div>
        </div >
    )
}
