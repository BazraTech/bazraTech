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
import { Link, useParams } from 'react-router-dom';
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

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };
    const { id } = useParams()
    const url2 = `http://198.199.67.201:9090/Api/Vehicle/All/${id}`;

    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        // setLoading(true);
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data)
                console.log(dataSource)
                // setLoading(false);

            })
    }, [])

    const [selecttag, setSelectTag] = useState(false)
    const [inputtag, setinputTag] = useState(true)
    const select = () => {
        setSelectTag(!selecttag);
        setinputTag(!inputtag);
    }



    return (
        <div>
            <div className="company_container">

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
                                <p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='#00cc44'></AiFillCar></p>
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


                {/* --------------- Vehicle header --------------- */}

                <Header title="Vehicles Detail"></Header>


                {/* ---------------Registration--------------- */}



                <section className='vehicle_register'>
                    {/* <div className='user_header'>
                        <p>User ID</p>
                        <p>BA 00001</p>
                        <p>Name</p>
                        <p>Abebe</p>
                    </div> */}

                    <div className='company_individual_header'>
                        <p ><h1 className='nmn'>Vehicle Detail</h1></p>
                        <p ><h4 className='vehicleDetail'>Name : Abebe Alemu <br /> User ID : BA 00001</h4></p>
                    </div>
                    <form className='form'>

                        <div className='allDiv'>
                            <button className='addToMaintenace'>Add To Maintenance</button>
                            <div className='second_div1'>
                                <div className='registerd_vehicle'><h1></h1></div>
                                {/* <h1>Company Information</h1> */}
                                <div className='vehicle_information1'>

                                    <div>
                                        <p>Vehicle Catagory </p>
                                        {inputtag ? <input Value={dataSource.vehicleCatagory} className='select' disabled={diabled}></input> : ""}
                                        {selecttag ? <select Value={dataSource.vehicleCatagory} className='select' disabled={diabled}>
                                            <option>Select Vehicle Category</option>
                                            <option>qqqqqqqqqqq</option>
                                        </select> : ""}
                                    </div>

                                    <div>
                                        <p>Vehicle Name </p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.vehicleName} type="text" placeholder='Lada' disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Vehicle Condition </p>
                                        {inputtag ? <input Value={dataSource.vehicleCondition} className='select' disabled={diabled}></input> : ""}
                                        {selecttag ? <select className='select' disabled={diabled}>
                                            <option>Select Vehicle Condition</option>
                                            <option>qqqqqqqqqqq</option>
                                        </select> : ""}
                                    </div>
                                    <div>
                                        <p>Plate Number </p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.plateNumber} type="text" placeholder='Lada' disabled={diabled}></input>
                                    </div>

                                    <div>
                                        <p>Manufacture Date </p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.manufactureDate} type="Date" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Device ID</p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.manufactureDate} type="text" disabled={diabled}></input>
                                    </div>
                                </div>
                            </div>

                            <div className='company_button'>
                                <p className='addd' onClick={() => {
                                    handleChange()
                                    toggle()
                                    select()
                                }}>{state ? "Cancle" : "Edit"}</p>
                                <br />
                                <button type='submit' className='ad' disabled={diabled}>Update</button>

                            </div>
                        </div>
                        {/* <p className='addd' onClick={() => {
                            // handleChange()
                        }}>Back</p>
                        <br /> */}

                    </form>




                </section>


                {/* ---------------end Registaration--------------- */}
            </div>
        </div>
    )
}
