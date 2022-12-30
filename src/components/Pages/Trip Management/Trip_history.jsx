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

            <Header title="Trip History"></Header>


            {/* ---------------contents--------------- */}

            <section className='company_register1'>

                <div className='company_individual_header'>
                    <p ><h1 className='nmn'>Trip History</h1></p>
                    <p ><input className='search' type="search" placeholder='search...'></input></p>
                </div>
                
                <form className='form' onSubmit={handleSubmit(onSubmit)}>
                    <div className='allDiv'>
                       <div className='trip_date'> <input className='trip_date1'type="date" /><button>Search</button></div>

                        <div className='setTrip'>
                            <div className='vehicle_information1'>
        
                            <p><lable>First Trip</lable></p>
                            <p><lable>First Trip</lable></p>
                            <p><lable>First Trip</lable></p>
                            <p><lable>First Trip</lable></p>
                            <p><lable>First Trip</lable></p>
                            <p><lable>First Trip</lable></p>
                            </div>
                            
                        </div>
                        <div className='setTrip'>
                            <div className='vehicle_information1'>
        
                            <p><lable>Second Trip</lable></p>
                            <p><lable>Second Trip</lable></p>
                            <p><lable>Second Trip</lable></p>
                            <p><lable>Second Trip</lable></p>
                            <p><lable>Second Trip</lable></p>
                            <p><lable>Second Trip</lable></p>
                            </div>
                            
                        </div>
                        <div className='setTrip'>
                            <div className='vehicle_information1'>
        
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            </div>
                            
                        </div>
                        <div className='setTrip'>
                            <div className='vehicle_information1'>
        
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            </div>
                            
                        </div>
                        <div className='setTrip'>
                            <div className='vehicle_information1'>
        
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            <p><lable>Third Trip</lable></p>
                            </div>
                            
                        </div>
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
