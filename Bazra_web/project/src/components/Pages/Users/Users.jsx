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
                        <Link to="/users">  <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='#00cc44'></FaUsers></p></Link>
                    </li>
                    <li>
                        <Link to="/alert"><p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p></Link>
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

            <div className="header">
                <h2 className='header_title'>Bazra Motors / <h6> Users</h6></h2>
                <p className='users_menu'><HiMenuAlt1 size="2rem" color='black'></HiMenuAlt1></p>
                <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
            </div>


            {/* --------------- users --------------- */}

            <div className='user'>
                <div className='contents'>
                    <div className='company'>
                        <h4>Total Users</h4>
                        <p><FaUsers size="2.2rem" color='black'></FaUsers><b>100</b></p>

                    </div>
                    <div className='company'>
                        <h4>Company</h4>
                        <p><FaWarehouse size="2.2rem" color='black'></FaWarehouse><b>100</b></p>

                    </div>
                    <div className='individual'>
                        <h4>Individual</h4>
                        <p><FaUserAlt size="2rem" color='black'></FaUserAlt><b>100</b></p>
                    </div>
                </div>

                {/* --------------- search --------------- */}

                <div className='users_search'>
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
                <div className='tables' id='myTable'>
                    <div className='t_table'>
                        <table class="user_table" id="myTable">

                            <thead>
                                <tr>
                                    <th>User</th>
                                    <th>Company ID</th>
                                    <th>Company Name</th>
                                    <th>Number of Vehicle</th>
                                    <th>Number of Driver</th>
                                    <th>Status</th>
                                    <th>Detail</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className='active_row'>

                                    <td>User</td>
                                    <td>BA 000002</td>
                                    <td>BBazra Motors</td>
                                    <td>40</td>
                                    <td>40</td>
                                    <td>Active</td>
                                    <td><Link to="/User_edit"><button>Detail</button></Link></td>
                                </tr>
                                <tr>
                                    <td>User</td>
                                    <td>BA 000001</td>
                                    <td>Bazra Motors</td>
                                    <td>40</td>
                                    <td>40</td>
                                    <td>Active</td>
                                    <td><Link to="/User_edit"><button>Detail</button></Link></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>User</td>
                                    <td>BA 000002</td>
                                    <td>Bazra Motors</td>
                                    <td>40</td>
                                    <td>40</td>
                                    <td>Active</td>
                                    <td><Link to="/User_edit"><button>Detail</button></Link></td>
                                </tr>
                                <tr>
                                    <td>User</td>
                                    <td>BA 000001</td>
                                    <td>Bazra Motors</td>
                                    <td>40</td>
                                    <td>40</td>
                                    <td>Active</td>
                                    <td><Link to="/User_edit"><button>Detail</button></Link></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>User</td>
                                    <td>BA 000002</td>
                                    <td>Bazra Motors</td>
                                    <td>40</td>
                                    <td>40</td>
                                    <td>Active</td>
                                    <td><Link to="/User_edit"><button>Detail</button></Link></td>
                                </tr>
                                <tr>
                                    <td>User</td>
                                    <td>BA 000001</td>
                                    <td>Bazra Motors</td>
                                    <td>40</td>
                                    <td>40</td>
                                    <td>Active</td>
                                    <td><Link to="/User_edit"><button>Detail</button></Link></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>User</td>
                                    <td>BA 000002</td>
                                    <td>Bazra Motors</td>
                                    <td>40</td>
                                    <td>40</td>
                                    <td>Active</td>
                                    <td><Link to="/User_edit"><button >Detail</button></Link></td>
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
