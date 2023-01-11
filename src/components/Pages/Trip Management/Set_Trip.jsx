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
import { HiMenuAlt1 } from "react-icons/hi";
import { BiTrip } from "react-icons/bi";
import './setTrip.css';
import { Link } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { FaStarOfLife } from 'react-icons/fa';
import { useForm } from 'react-hook-form';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';

export default function () {


    const {
        register,
        handleSubmit,
        watch,
        formState: { errors },
    } = useForm();
    const onSubmit = (data) => {
        console.log(data);
    };

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api
    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
    };

    const urlFour = "http://198.199.67.201:9090/Api/SignIn/Admin";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        fetch(urlFour, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data)
                console.log(dataSource4)
            })
    }, [])


    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }

    return (
        <div className="dashboard_container">

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
                            <p className="hovertext" data-hover="Trip Management"><BiTrip color='#00cc44' size="2rem" ></BiTrip></p>
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


            {/* ---------------header--------------- */}

            <Header title="Set Trip"></Header>

            {/* ---------------contents--------------- */}

            <section className='register'>

                <div className='setTripHeader'>
                    <p ><h1 className='nmn'>Set Trip</h1></p>
                </div>
                <form className='form' onSubmit={handleSubmit(onSubmit)}>
                    <div className='set_allDiv'>

                        <div className='vehicle_information0'>
                            <div>
                                <p>Trip Type <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select name="catagory"
                                    {...register("vehicleCatagory", { required: '*Trip type  is required' })}
                                >
                                    <option value="">Select Trip Type</option>
                                    <option value="w">Select Trip Type</option>
                                    <option value="w">Select Trip Type</option>
                                    <option value="w">Select Trip Type</option>
                                </select>
                                {errors.vehicleCatagory && <span className='validate_text'>{errors.vehicleCatagory.message}</span>}
                            </div>

                            <div>
                                <p>Vehicle Plate Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input name='vehicleName' type="text"
                                    {...register("vehicleName", { required: true })}
                                    placeholder='Enter Vehicle Plate Number'
                                ></input>
                                {errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle plate number</span>}
                            </div>

                            <div>
                                <p>Driver <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input name='vehicleName' type="text"
                                    {...register("vehicleName", { required: true })}
                                    placeholder='Enter Deriver Name'
                                ></input>
                                {errors.vehicleName?.type === "required" && <span className='validate_text'>*Deriver Is required </span>}
                            </div>

                            <div>
                                <p>Start Location <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <div className='plate_numbera'>
                                    <input placeholder='Please Enter Plate Number'
                                        name='conditionName'
                                        {...register("serviceNeeded", { required: '*please choose service needed' })}
                                    >
                                    </input>
                                    {errors.serviceNeeded && <span className='validate_text'>{errors.serviceNeeded.message}</span>}
                                </div>

                            </div>

                            <div>
                                <p>End Location <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input name='manufacture_date' type="text"
                                    {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                    placeholder='Enter Manufactureing Date'
                                ></input>
                                {errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>
                            <div>
                                <p>Start Date <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input name='device_id' type="date"
                                    {...register("deviceID", { required: '*Device ID is required' })}
                                    placeholder='Enter Device ID'
                                ></input>
                                {errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                        </div>
                        <div className='company_button'>
                            <button className='add'>Set Trip</button>
                        </div>
                    </div>
                </form>
            </section>


            {/* ---------------end contents--------------- */}


        </div>

    )
}