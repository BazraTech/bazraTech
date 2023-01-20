import React from 'react'
import './available.css';
import { Link } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai"; 
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import { RiGpsFill } from "react-icons/ri";
import { MdMonitor } from "react-icons/md";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import { FiLogOut } from "react-icons/fi";
import { IoSettingsOutline } from "react-icons/io5";
import { useForm } from 'react-hook-form';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { total } from './data/data';
import { IoMdArrowDropdownCircle } from "react-icons/io";
import { IoMdArrowDropupCircle } from "react-icons/io";
import { BsPlusLg } from "react-icons/bs";
import { AiOutlineMinus } from "react-icons/ai";


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
    const [state, setState] = useState("");
    const handleClickopen = () => {
        setPop(!popup);
    }
    // {
    //     total[0]
    //     .map((item) => {
    //         setState(item.assignedDriver.toLowerCase().includes(search))
    //     })}


    const [search, setSearch] = useState('');
    // if (search === state) {
    //   alert("success")
    //  }

    const [loading, setLoading] = useState(false);
    const [popup1, setPop1] = useState(true);

    const url2 = "http://198.199.67.201:9090/Api/Vehicle/All";

    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.vehicles)
                console.log(dataSource2) 
                setLoading(false); 

            })
    }, [])

    const [visiblelist, setvisiblelist] = useState(false);
    const [visible, setVisible] = useState(false);
    const displaylist = () => {
        setVisible(!visible);
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
                            <p className="hovertext" data-hover="Trip Management"><BiTrip color='00cc44' size="2rem" ></BiTrip></p>
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
                    <Link style={{ textDecoration: 'none' }} to="/avialable_trip"><p><h1 className='nmnn'>Avialable Vehicles</h1></p></Link>
                    <Link style={{ textDecoration: 'none' }} to="/trip_history"><p><h1 className='nmn'>Vehicles History</h1></p></Link>
                </div>

                <form className='form' onSubmit={handleSubmit(onSubmit)}>
                    <div className='allDiv'>

                        <div className='trip_date'>
                            <input onChange={(e) => setSearch(e.target.value)} placeholder='Search...' className='trip_date1' type="search" /><button>Search</button>
                        </div>
                        <div>
                           <h1 className='greentrip'>List of Company</h1>
                            {total[0].map(item => (
                                <>
                                    <div className='companyList' onClick={() => {
                                                displaylist()
                                                setvisiblelist(item.id)
                                            }} >
                                        <p>Company Name : <b className='green'>{item.id}</b></p>
                                        <p>Company Name : <b className='green'>Bazra</b></p>
                                        <p className='dropdownVehicle'>{visible && item.id == visiblelist ? <AiOutlineMinus top="10px" size="1rem" color='White' onClick={displaylist}></AiOutlineMinus> :
                                            <BsPlusLg size="1rem" color='White' onClick={() => {
                                                displaylist()
                                                setvisiblelist(item.id)
                                            }} ></BsPlusLg>}</p>
                                    </div>

                                    {visible && item.id == visiblelist ?
                                        <>
                                            <div className='trip_date'>
                                                <input onChange={(e) => setSearch(e.target.value)} placeholder='Search...' className='trip_date1' type="date" /><button>Search</button>
                                            </div>
                                            <div className='outer_vehicle_tables' id='myTable'>
                                                <p>Avaliable Vehicles for Trip</p>

                                                <table class="vehicle_table" id="myTable">

                                                    <thead>
                                                        <tr >
                                                            <th>Vehicle Name</th>
                                                            <th>Assigned Driver</th>
                                                            <th>Current Location</th>
                                                            <th>Vehicle Type</th>
                                                            <th>Plate Number</th>
                                                            <th>Set Trip</th>
                                                            {/* <th>History</th> */}
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        {dataSource2.map(item => (
                                                            <tr className='active_row'>

                                                                <td>{item.vehicleName}</td>
                                                                <td>{item.date}</td>
                                                                <td>{item.id}</td>
                                                                <td>{item.vehicleCatagory.catagory}</td>
                                                                <td>{item.plateNumber}</td>
                                                                <td><Link to={`/report_detail/${item.vehicleName}/${item.plateNumber}`}><button>Report</button></Link></td>
                                                                {/* <td><Link to="/trip_history"><button>History</button></Link></td> */}
                                                            </tr>
                                                        ))}
                                                    </tbody>
                                                </table>

                                            </div></> : ""}
                                </>
                            ))}

                        </div>

                    </div>
                </form>
            </section>


            {/* ---------------end contents--------------- */}


        </div>

    )
}