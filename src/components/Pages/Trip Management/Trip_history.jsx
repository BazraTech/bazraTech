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
import './available.css';
import { Link } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { FaStarOfLife } from 'react-icons/fa';
import { useForm } from 'react-hook-form';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { total } from './data/data';
import swal from "sweetalert";

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
    const [search, setSearch] = useState('');
    const [result, setResult] = useState('');
    console.log(search)

    console.log(result)

    const nandu = () => {
        if (search === result) {
            // swal("error", "Ther Is no Such File", "error", {
            //     buttons: false,
            //     timer: 2000,
            //   })
        }
        else {
            swal("error", "Ther Is no Such File", "error", {
                // buttons: false,
                // timer: 2000,
            })


        }
    }

    const [trip, setTrip] = useState("nandu"); 
    const [popup1, setPop1] = useState(true);
    const [loading, setLoading] = useState(false); 
 
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

            <Header title="Avialable Trip"></Header>


            {/* ---------------contents--------------- */}

            <section className='register'>

                <div className='company_individual_header'>
                    <Link style={{ textDecoration: 'none' }} to="/avialable_trip"><p><h1 className='nmnn'>Avialable Trip</h1></p></Link>
                    <Link style={{ textDecoration: 'none' }} to="/trip_history"><p><h1 className='nmn'>Trip History</h1></p></Link>
                </div>

                <form className='form' onSubmit={handleSubmit(onSubmit)}>
                    <div className='allDiv'>
                        <div className='trip_date'>

                            <>
                                <input onChange={(e) => {
                                    setSearch(e.target.value)
                                    // nandu()

                                }} placeholder='Search...' className='trip_date1' type="date" /><button>Search</button>
                            </>

                        </div>
                        {loading ? 
                        <p>jjjj</p>
                      
                        : <div className='setTrip' id='myInput'>
                                 
                                {
                                total[0]
                                
                                
                                    .filter((item) => {
                                        return search.toLowerCase() === ''
                                            ? item
                                            : item.date.toLowerCase().includes(search);
                                         
                                    }) 
                                    .map(item => (
                                        <>
                                            <div className='avilabel_trips' >

                                                <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                                <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                                <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                                <p><lable>Current Location : <b>{item.date} </b></lable></p>
                                                {/* { setResult(item.id)} */}

                                            </div>
                                            <div className='borderBottom'></div>

                                        </>

                                    ))}

                            </div> 
                             }


                        {/* <div className='setTrip'>
                        <div className='avilabel_trips' >
                                {total[0].map(item => (
                                    <>
                                        <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                        <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                        <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                        <p><lable>Current Location : <b>{item.location}</b></lable></p>
                                    </>
                                ))}
                            </div>
                            <div className='set_history'>
                                <p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Set Trip</button></Link></p>
                                <p> <Link to="/trip_history" style={{ textDecoration: 'none' }}><button>Trip History</button></Link></p>
                            </div>
                        </div>

                        <div className='setTrip'>
                        <div className='avilabel_trips' >
                                {total[0].map(item => (
                                    <>

                                        <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                        <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                        <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                        <p><lable>Current Location : <b>{item.location}</b></lable></p>
                                    </>
                                ))}
                            </div>
                            <div className='set_history'>
                                <p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Set Trip</button></Link></p>
                                <p> <Link to="/trip_history" style={{ textDecoration: 'none' }}><button>Trip History</button></Link></p>
                            </div>
                        </div>

                        <div className='setTrip'>
                        <div className='avilabel_trips' >
                                {total[0].map(item => (
                                    <>

                                        <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                        <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                        <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                        <p><lable>Current Location : <b>{item.location}</b></lable></p>
                                    </>
                                ))}
                            </div>
                            <div className='set_history'>
                                <p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Set Trip</button></Link></p>
                                <p> <Link to="/trip_history" style={{ textDecoration: 'none' }}><button>Trip History</button></Link></p>
                            </div>
                        </div>

                        <div className='setTrip'>
                           <div className='avilabel_trips' >
                                {total[0].map(item => (
                                    <>

                                        <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                        <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                        <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                        <p><lable>Current Location : <b>{item.location}</b></lable></p>
                                    </>
                                ))}
                            </div>
                            <div className='set_history'>
                                <p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Set Trip</button></Link></p>
                                <p> <Link to="/trip_history" style={{ textDecoration: 'none' }}><button>Trip History</button></Link></p>
                            </div>
                        </div> */}
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
