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
import './vehicle_detail.css';
import { useForm } from 'react-hook-form';
import { Link } from 'react-router-dom';
import { total } from './data/jsonData';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';

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

    const [popup, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop1(!popup);
    }



    return (
        <div>
            <div className="company_container">

                {/*---------------navigation---------------*/}

                <div className="company_navigation">
                    <ul>
                        <li>
                            <Link to="/dashboard">
                                <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p>
                            </Link>
                        </li>
                        <li>
                            <Link to="/Total_number_of_vehicle">
                                <p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='00cc44'></AiFillCar></p>
                            </Link>
                        </li>
                        <li>
                            <Link to="/tracking">
                                <p class="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" color='white'></RiGpsFill></p>
                            </Link>
                        </li>
                        <li>
                            <Link to="#">
                                <p onClick={handleClickopen} class="hovertext" data-hover="Trip Management"><SiGoogletagmanager size="1.8rem" color='white'></SiGoogletagmanager></p>
                            </Link>
                            <Link to="/set_trip">
                                {popup ? <p class="hovertext trip" data-hover="Set Trip"><SiTripdotcom size="2rem" margin-left='20px' color='00cc44'></SiTripdotcom></p> : ""}
                            </Link>
                            <Link to="/trip_history">
                                {popup ? <p class="hovertext trip" data-hover="Trip History"><BiTrip size="2rem" color='#00cc44'></BiTrip></p> : ""}
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
                                <p class="hovertext" data-hover="Communication">
                                    <BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p>
                            </Link>
                        </li>
                        <li>
                            <Link to="#">
                                <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                            </Link>
                        </li>
                        <li>
                            <Link to="/settings">
                                <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                            </Link>
                        </li>
                    </ul>
                </div>


                {/* --------------- Vehicle header --------------- */}

                <Header title="Vehicles Detail"></Header>


                {/* ---------------Registration--------------- */}



                <section className='company_register1'>
                    {/* <div className='user_header'>
                        <p>User ID</p>
                        <p>BA 00001</p>
                        <p>Name</p>
                        <p>Abebe</p>
                    </div> */}

                    <div className='company_individual_header'>
                        <p ><h1 className='nmn'>Vehicle Detail</h1></p>
                        <p ><h4 className='vehicleDetail'>Name : Abebe Alemu <br/> User ID : BA 00001</h4></p>
                    </div>
                    <form className='form'>

                    <div className='allDiv'>
                        <div className='second_div'>
                            <div className='registerd_vehicle'><h1></h1></div>
                            {/* <h1>Company Information</h1> */}
                            <div className='vehicle_information1'>
                            
                                <div>
                                    <p>Vehicle Catagory </p>
                                    <select className='select' disabled={diabled}>
                                        <option selected disabled>Long</option>
                                        <option>Select Vecicle Catagory</option>
                                        <option>Select Vecicle Catagory</option>
                                        <option>Select Vecicle Catagory</option>
                                        <option>Select Vecicle Catagory</option>
                                    </select>
                                </div>
                                <div>
                                    <p>Vehicle Name </p>
                                    <input type="text" placeholder='Lada' disabled={diabled}></input>
                                </div>
                                <div>
                                    <p>Vehicle Condition <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <select className='select' disabled={diabled}>
                                        <option selected disabled>New</option>
                                        <option>Select Vecicle Condition</option>
                                        <option>Select Vecicle Condition</option>
                                        <option>Select Vecicle Condition</option>
                                        <option>Select Vecicle Condition</option>
                                    </select>
                                </div>
                                <div>
                                    <p>Plate Number</p>
                                    <div className='plate_number'>
                                        <input type="text" placeholder='ET' disabled={diabled}></input>
                                        <input type="number" placeholder='4' disabled={diabled}></input>
                                        <input type="text" placeholder='00078' disabled={diabled}></input>
                                    </div>
                                </div>

                                <div>
                                    <p>Manufacture Date </p>
                                    <input type="Date" disabled={diabled}></input>
                                </div>
                                <div>
                                    <p>Device ID</p>
                                    <input type="text" placeholder='100002' disabled={diabled}></input>
                                </div>
                            </div>
                        </div>

                        <div className='company_button'>
                        <p className='addd' onClick={() => {
                            handleChange()
                            toggle()
                        }}>{state ? "Cancle" : "Edit"}</p>
                        <br />
                        <button type='submit' className='ad' disabled={diabled}>Update</button>

                    </div>
                        </div>

                    </form>
                    


                </section>


                {/* ---------------end Registaration--------------- */}
            </div>
        </div>
    )
}
