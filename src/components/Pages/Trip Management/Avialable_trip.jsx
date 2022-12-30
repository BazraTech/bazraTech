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
import './trip_history.css';
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

            <Navigation></Navigation>

            {/* ---------------header--------------- */}

            <Header title="Avialable Trip"></Header>


            {/* ---------------contents--------------- */}

            <section className='company_register1'>

                <div className='company_individual_header'>
                    <p ><h1 className='nmn'>Avialable Trip</h1></p>
                    <p ></p>
                </div>

                <form className='form' onSubmit={handleSubmit(onSubmit)}>
                    <div className='allDiv'>
                        <div className='trip_date'> <input placeholder='Search...' className='trip_date1' type="search" /><button>Search</button></div>

                       <div className='setTrip'> 
                            <div className='avilabel_trips' >
                                <p><lable>Plate Number :</lable></p>
                                <p><lable>Assigned Driver :</lable></p>
                                <p><lable>Vehicle Name :</lable></p>
                                <p><lable>Current Location :</lable></p>
                            </div><p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Availabel</button></Link></p>
                        </div>
                        <Link to="/set_trip" style={{ textDecoration: 'none' }}><div className='setTrip'> 
                            <div className='avilabel_trips' >
                                <p><lable>Plate Number :</lable></p>
                                <p><lable>Assigned Driver :</lable></p>
                                <p><lable>Vehicle Name :</lable></p>
                                <p><lable>Current Location :</lable></p>
                                <p><button>Availabel</button></p>
                            </div>
                        </div></Link>
                        <Link to="/set_trip" style={{ textDecoration: 'none' }}><div className='setTrip'> 
                            <div className='avilabel_trips' >
                                <p><lable>Plate Number :</lable></p>
                                <p><lable>Assigned Driver :</lable></p>
                                <p><lable>Vehicle Name :</lable></p>
                                <p><lable>Current Location :</lable></p>
                                <p><button>Availabel</button></p>
                            </div>
                        </div></Link>
                        <Link to="/set_trip" style={{ textDecoration: 'none' }}><div className='setTrip'> 
                            <div className='avilabel_trips' >
                                <p><lable>Plate Number :</lable></p>
                                <p><lable>Assigned Driver :</lable></p>
                                <p><lable>Vehicle Name :</lable></p>
                                <p><lable>Current Location :</lable></p>
                                <p><button>Availabel</button></p>
                            </div>
                        </div></Link>
                        <Link to="/set_trip" style={{ textDecoration: 'none' }}><div className='setTrip'> 
                            <div className='avilabel_trips' >
                                <p><lable>Plate Number :</lable></p>
                                <p><lable>Assigned Driver :</lable></p>
                                <p><lable>Vehicle Name :</lable></p>
                                <p><lable>Current Location :</lable></p>
                                <p><button>Availabel</button></p>
                            </div>
                        </div></Link>
                        {/* <div className='company_button'>
                            <button className='add'>Add</button>
                        </div> */}
                    </div>
                </form>
            </section>


            {/* ---------------end contents--------------- */}


        </div>

    )
}
