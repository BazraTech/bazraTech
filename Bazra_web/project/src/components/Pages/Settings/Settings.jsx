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
import { FaEdit } from "react-icons/fa";
import { HiMenuAlt1 } from "react-icons/hi";
import { MdDeleteForever } from "react-icons/md";
import './settings.css';
import { Link, NavLink } from 'react-router-dom';




export default function () {


    return (
        <div className="alert_container">

            {/*---------------navigation---------------*/}

            <div className="alert_navigation">
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
                        <Link to="#">
                            <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/settings">
                            <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='#00cc44'></AiFillSetting></p>
                        </Link>
                    </li>
                </ul>
            </div>
            {/* --------------- Settings header --------------- */}

            <div className="alert_header">
                <h2 className='header_title'>Bazra Motors / <h6> Settings</h6></h2>
                <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
            </div>

            <div className='alert_main'>

                <div className='outer_setting'>
                    <div className='setting_header'>Notification Preference</div>
                    <div className='add_notification'>Add Notification Preference</div>
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Notification Preference</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className='active_row'>
                                    <td>1</td>
                                    <td>E-mail</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>2</td>
                                    <td>SMS</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>3</td>
                                    <td>Whats Up</td>
                                    <td>Of Line</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>4</td>
                                    <td>E-mail</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                            </tbody>

                        </table>
                    </div>
                </div>



                <div className='outer_setting'>
                    <div className='setting_header'>Vehicle Condition</div>
                    <div className='add_notification'>Add Vehicle Condition</div>
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Vehicle Condition</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className='active_row'>
                                    <td>1</td>
                                    <td>Excellent</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>2</td>
                                    <td>Dood</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>3</td>
                                    <td>Fair</td>
                                    <td>Of Line</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>4</td>
                                    <td>Poor</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                            </tbody>

                        </table>
                    </div>
                </div>


                <div className='outer_setting'>
                    <div className='setting_header'>Truck Status</div>
                    <div className='add_notification'>Add Truck Status</div>
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Truck Status</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className='active_row'>
                                    <td>1</td>
                                    <td>On Route</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>2</td>
                                    <td>Maintenance</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>3</td>
                                    <td>Parked</td>
                                    <td>Of Line</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>4</td>
                                    <td>---</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                            </tbody>

                        </table>
                    </div>
                </div>


                <div className='outer_setting'>
                    <div className='setting_header'>Service Needed</div>
                    <div className='add_notification'>Add Service Needed</div>
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Service Needed</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className='active_row'>
                                    <td>1</td>
                                    <td>Tracking</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>2</td>
                                    <td>Trucking and Market</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>3</td>
                                    <td>---</td>
                                    <td>Of Line</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>4</td>
                                    <td>---</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                            </tbody>

                        </table>
                    </div>
                </div>


                <div className='outer_setting'>
                    <div className='setting_header'>User Category</div>
                    <div className='add_notification'>Add User Category</div>
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>User Category</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className='active_row'>
                                    <td>1</td>
                                    <td>Individual</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>2</td>
                                    <td>Compnay</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>3</td>
                                    <td>---</td>
                                    <td>Of Line</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>4</td>
                                    <td>---</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                            </tbody>

                        </table>
                    </div>
                </div>


                <div className='outer_setting'>
                    <div className='setting_header'>Vehicle Category</div>
                    <div className='add_notification'>Add Vehicle Category</div>
                    <div>
                        <table class="vehicle_table" id="myTable">

                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Vehicle Category</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr className='active_row'>
                                    <td>1</td>
                                    <td>---</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>2</td>
                                    <td>---</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>2</td>
                                    <td>---</td>
                                    <td>Of Line</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                                <tr className='active_row'>
                                    <td>4</td>
                                    <td>---</td>
                                    <td>Active</td>
                                    <td><p className='notification_actions'><FaEdit size="1.4rem" color='green'></FaEdit><MdDeleteForever size="1.6rem" color='red'></MdDeleteForever></p></td>
                                </tr>
                            </tbody>

                        </table>
                    </div>
                </div>


            </div>

        </div>
    )
}