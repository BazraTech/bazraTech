import React, { Component } from 'react'
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
import { FaStarOfLife } from 'react-icons/fa';
import './users_edit.css';
import { useForm } from 'react-hook-form';
import { Link } from 'react-router-dom';
import { HiMenuAlt1 } from "react-icons/hi";
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import { total } from './Data/jsonData';
import { on_route } from './Data/Data';
import { parked } from './Data/Data';
import Tables from './Tables';
import Navigation from '../Navigation/UserNavigation';

export default function Users_edit() {

    const [state, setState] = useState(false);
    //const [companyType, setCompantType] = useState("");

    // state = {
    //     diabled: true
    // }

    const toggle = () => {
        setState(!state);
    };

    const [diabled, setPop] = useState(true);
    const handleChange = () => {
        setPop(!diabled);
    }

    const [popup1, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop1(!popup1);
    }

    let [active, setActive] = useState("total_users");
    let [state2, setState2] = useState("false");
    const color = () => {
        setState(state);
    }



    return (
        <div>
            <div className="users_edit_container">

                {/*---------------navigation---------------*/}

                <Navigation></Navigation>

                {/* ---------------header--------------- */}

                <Header title="Users/Edit"></Header>

                {/* ---------------Registration--------------- */}

                <section className='register'>
                    {/* <div className='user_header'>
                        <p>User ID</p>
                        <p>BA 00001</p>
                        <p>Name</p>
                        <p>Abebe</p>
                    </div> */}

                    <div className='company_individual_header'>
                        <p ><h1 className='nmn'>Company Detail</h1></p>
                        <p ><h4 className='vehicleDetail'>Name : Abebe Alemu <br /> User ID : BA 00001</h4></p>
                    </div>
                    <form className='form'>

                        <div className='allDiv'>
                            <div className='first_div'>
                                <h1>Company Information</h1>
                                <div className='company_information1'>
                                    <div>
                                        <p>Company Name </p>
                                        <input type="text" placeholder='Bazra Motors' disabled={diabled}></input>

                                    </div>
                                    <div>
                                        <p>Company Sector </p>
                                        <input type="text" placeholder='Motors' disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Company Type </p>
                                        <select disabled={diabled}>
                                            <option value=''>Transport</option>
                                            <option value='plc'>Public Llimited Company</option>
                                            <option value='plc'>Government</option>
                                            <option value='plc'>Public Llimited Company</option>
                                            <option value='plc'>Public Llimited Company</option>
                                        </select>
                                    </div>
                                </div>
                            </div>


                            <div className='second_div'>
                                <h1>Company Address</h1>
                                <div className='company_Address1'>
                                    <div>
                                        <p>Region </p>
                                        <input placeholder="Addis Ababa" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Sub City </p>
                                        <input placeholder="Bole" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Specfic Location </p>
                                        <input type="text" placeholder='Friendship' disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>City </p>
                                        <input placeholder="Addis Ababa" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Woreda </p>
                                        <input type="text" placeholder='18' disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>House Number </p>
                                        <input type="text" placeholder='21/122' disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Phone Number </p>
                                        <input type="text" placeholder='0911893462' disabled={diabled}></input>
                                    </div>
                                </div>
                            </div>

                            <div className='Third_div'>
                                <h1>Owner Information</h1>
                                <div className='owner_information1'>
                                    <div>
                                        <p>First Name</p>
                                        <input type="text" placeholder='Abebe' disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Last Name </p>
                                        <input type="text" placeholder='Abebe' disabled={diabled}></input>

                                    </div>
                                    <div>
                                        <p>Phone Number</p>
                                        <input type="text" placeholder='0911893462' disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Email </p>
                                        <input type="email" placeholder='xyz@gmail.com' disabled={diabled}></input>
                                    </div>
                                </div>
                            </div>

                            <div className='Third_div'>
                                <h1>Additional Information</h1>
                                <div className='additional_information1'>
                                    <div>
                                        <p>Notification Pereference</p>
                                        <select className='select' disabled={diabled}>
                                            <option value=''>SMS</option>
                                            <option value='plc'>Select Notification Preference</option>
                                            <option value='plc'>Select Notification Preference</option>
                                            <option>Select Notification Preference</option>
                                            <option>Select Notification Preference</option>
                                        </select>

                                    </div>
                                    <div>
                                        <p>Service Neded</p>
                                        <select className='select' disabled={diabled}>
                                            <option value=''>Tracking</option>
                                            <option value='plc'>Select Service Neded</option>
                                            <option value='plc'>Select Service Neded</option>
                                            <option>Select Service Neded</option>
                                            <option>Select Service Neded</option>
                                        </select>
                                    </div>

                                </div>
                            </div>

                            <div className='company_button'>
                                <p className='addd' onClick={() => {
                                    handleChange()
                                    toggle()
                                }}>{state ? "Cancle" : "Edit"}</p>
                                <br />
                                <button className='ad' disabled={diabled}>Update</button>

                            </div>
                            {/* <div className='outer_vehicle_tables' id='myTable'> */}

                            {/* {total[0].map(item => (
                                <>
                                    <p>{item.id}</p>
                                    <p>{item.firstname}</p>
                                </>
                            ))} */}

                            <div className='outer_vehicle_tables0' id='myTable'>
                                <div className='second_div'>
                                    <div className='registerd_vehicle_no'> <div className='Vehicle_number'><h1>Registerd Vehicle</h1><h1 className='number' >10</h1></div></div>
                                </div>
                                <p>Registerd Vehicles</p>

                                <table class="vehicle_table" id="myTable">

                                    <thead>
                                        <tr>
                                            <th>Profile</th>
                                            <th>Assigned Driver</th>
                                            <th>Vehicle ID</th>
                                            <th>Vehicle Type</th>
                                            <th>Plate Number</th>
                                            <th>Detail</th>
                                            <th>Tracking</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {total[0]
                                            .map(item => (
                                                <tr className='active_row'>

                                                    <td>{item.user}</td>
                                                    <td>{item.assignedDriver}</td>
                                                    <td>{item.vehicleId}</td>
                                                    <td>{item.vehicleType}</td>
                                                    <td>{item.planeNumber}</td>
                                                    <td><Link to="/vehicle_detail"><button>Detail</button></Link></td>
                                                    <td><Link to="/tracking"><button>Tracking</button></Link></td>
                                                </tr>
                                            ))}
                                    </tbody>
                                </table>
                            </div>

                            <div className='page'>


                                {/* <Pagination
                                        onChange={(page) => setCurentPage(page)}
                                        pageSize={postPerPage}
                                        current={page}
                                        total={total}
                                        showQuickJumper
                                        showSizeChanger
                                        onShowSizeChange={onShowSizeChange}

                                    /> */}
                            </div>
                        </div>

                        {/* </div> */}

                    </form>

                </section>




                {/* ---------------end Registaration--------------- */}
            </div>
        </div>
    )
}
