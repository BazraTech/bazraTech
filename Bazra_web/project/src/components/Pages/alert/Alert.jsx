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
import { FaCarCrash } from "react-icons/fa";
import { TbTriangleOff } from "react-icons/tb";
import { FaUserSecret } from "react-icons/fa";
import { HiMenuAlt1 } from "react-icons/hi";
import './alert.css';
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

        <div className="alert_container">

            {/*---------------navigation---------------*/}

            <div className="alert_navigation">
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
                        <Link to="/alert"><p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='#00cc44'></HiBellAlert></p></Link>
                    </li>
                    <li>
                        <Link to="#"><p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p></Link>
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


            {/* --------------- header --------------- */}

            <div className="alert_header">
                <h2 className='header_title'>Bazra Motors / <h6> Alert</h6></h2>
                <p className='alert_menu'><HiMenuAlt1 size="2rem" color='black'></HiMenuAlt1></p>
                <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
            </div>


            {/* --------------- users --------------- */}

            <div className='alert_main'>
                <div className='alert_contents'>
                    <div className='alert_accident'>
                        <h4>Accident</h4>
                        <p>< FaCarCrash size="2.2rem" color='black'></ FaCarCrash><b>100</b></p>
                    </div>
                    <div className='alert_accident'>
                        <h4>Off Road</h4>
                        <p><TbTriangleOff size="2.2rem" color='black'></TbTriangleOff><b>100</b></p>
                    </div>
                    <div className='alert_accident'>
                        <h4>Driver</h4>
                        <p><FaUserSecret size="2rem" color='black'></FaUserSecret><b>100</b></p>
                    </div>
                </div>

                {/* --------------- search --------------- */}


                {/* --------------------- Table ------------------- */}
                <div className='outer_alert_table' id='myTable'>
                    <div className='t_table'>
                        <table class="alert_table" id="myTable">

                            <thead>
                                <tr>
                                    <th>Profile</th>
                                    <th>Driver</th>
                                    <th>Vehicle Plate Number</th>
                                    <th>Alert Location</th>
                                    <th>Alert Type</th>
                                    <th>Owner</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className='active_row'>

                                    <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                    <td>Anduamlak alehegne</td>
                                    <td>Et A123443</td>
                                    <td>Addis Ababa</td>
                                    <td>Accident</td>
                                    <td>Bazra Motors</td>
                                </tr>
                                <tr>
                                    <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                    <td>Anduamlak alehegne</td>
                                    <td>Et A123443</td>
                                    <td>Addis Ababa</td>
                                    <td>Accident</td>
                                    <td>Bazra Motors</td>
                                </tr>
                                <tr className='active_row'>
                                    <td><FaUserAlt size="1.5rem" color='#404040'></FaUserAlt></td>
                                    <td>Anduamlak alehegne</td>
                                    <td>Et A123443</td>
                                    <td>Addis Ababa</td>
                                    <td>Accident</td>
                                    <td>Bazra Motors</td>
                                </tr>

                            </tbody>

                        </table>
                    </div>
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
