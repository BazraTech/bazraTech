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
import { Link, useParams, useNavigate  } from 'react-router-dom';
import { total } from './data/jsonData';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';

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
    const url2 = `http://198.199.67.201:9090/Api/Admin/All/Vehicles/${id}`;

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

    const urlthree = "http://198.199.67.201:9090/Api/Admin/All/VehicleCatagory";
    const [dataSource5, setDataSource5] = useState([])
    useEffect(() => {
        fetch(urlthree, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource5(data.vehicleCatagories)
                // console.log(dataSource3)
            })
    }, [])

    const urlFour = "http://198.199.67.201:9090/Api/Admin/All/VehicleCondition";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        fetch(urlFour, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data.vehicleConditions)
                console.log(dataSource4)
            })
    }, [])

    const navigate = useNavigate();
	const goBack = () => {
		navigate(-1);
	}

    return (
        <div>
            <div className="company_container">

                {/*---------------navigation---------------*/}

                <Navigation path="/Total_number_of_vehicle"></Navigation>

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

                    <button className='navigateBack' onClick={goBack}>Back</button>

                    <div className='company_individual_header'> 
                        <p ><h1 className='nmn'>Vehicle Detail</h1></p> 
                        <p ><h4 className='vehicleDetail'>Driver Name : {dataSource.driver == null ? "Unassigned": dataSource.driver} <br /> User ID : {dataSource.plateNumber}</h4></p>
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
                                        {selecttag ?
                                            <select className='select' placeholder='Select Vecicle Catagory'
                                                // {...register("vehicleCatagory", { required: '*Vehicle catagoty  is required' })}
                                                name="vehicleCatagory"
                                            // value={vehicleCatagory}
                                            // onChange={(e) => setVehicleCategory(e.target.value)} 
                                            >
                                                <option value="" >Select Vecicle Catagory</option>
                                                {
                                                    dataSource5.map(item => {
                                                        return <option >{item.catagory}</option>
                                                    })
                                                }
                                            </select>

                                            : ""}
                                    </div>

                                    <div>
                                        <p>Vehicle Name </p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.vehicleName} type="text" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Vehicle Condition </p>
                                        {inputtag ? <input Value={dataSource.vehicleCondition} className='select' disabled={diabled}></input> : ""}
                                        {selecttag ?
                                            <select className='select' name='conditionName'
                                            // value={vehicleCondition}
                                            // {...register("vehicleCondition", { required: '*Vecicle Condition is required' })}
                                            // onChange={(e) => setVehicleCondition(e.target.value)} 
                                            >
                                                <option value="">Select Vecicle Condition</option>
                                                {
                                                    dataSource4.map(item => {
                                                        return <option>{item.conditionName}</option>
                                                    })
                                                }
                                            </select> : ""}
                                    </div>
                                    <div>
                                        <p>Plate Number </p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.plateNumber} type="text" disabled={diabled}></input>
                                    </div>

                                    <div>
                                        <p>Manufacture Date </p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.manufactureDate} type="Date" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Device ID</p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.deviceID} type="text" disabled={diabled}></input>
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
