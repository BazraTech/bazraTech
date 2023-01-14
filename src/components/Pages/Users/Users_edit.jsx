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
import { Link, useParams } from 'react-router-dom';
import { HiMenuAlt1 } from "react-icons/hi";
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import { total } from './Data/jsonData';
import { on_route } from './Data/Data';
import { parked } from './Data/Data';

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

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };


    // const [Loading, setLoading] = useState(false)
    const [totalPages, setTotalPage] = useState(1);
    const [cc, setCc] = useState([]);
    const [dataSource, setDataSource] = useState({
        "id": '',
        "phoneNumber": "",
        "firstName": "",
        "lastName": "",
        "email": "",
        "role": ""
    })
    const [dataSource2, setDataSource2] = useState([])
    const [dataSource3, setDataSource3] = useState([])
    const [dataSource4, setDataSource4] = useState([])

    const [Loading, setLoading] = useState([]);
    const { id, companyId } = useParams();

    const url = `http://198.199.67.201:9090/Api/Admin/All/VehicleOwner/${id}`;
    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then((response) => response.json())
            .then((json) => {
                setDataSource(json)
                setDataSource2(json.companyInfo)
                setDataSource3(json.companyInfo.sector)
                setDataSource4(json.companyAddressINF)

                console.log(json)
                setLoading(false)
            });
    }, [])

    // if (dataSource.firstName === dataSource.lastName) {
    //     setIndividual(false);
    // }
    // else{
    //     setIndividual(true);
    // }
    const [selecttag, setSelectTag] = useState(false)
    const [inputtag, setinputTag] = useState(true)
    const select = () => {
        setSelectTag(!selecttag);
        setinputTag(!inputtag);
    }


    return (
        <div>
            <div className="users_edit_container">

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
                                <p className="hovertext" data-hover="Trip Management"><BiTrip color='white' size="2rem" ></BiTrip></p>
                            </Link>
                        </li>
                        <li>
                            <Link to="/users">
                                <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='#00cc44'></FaUsers></p>
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
                        {/* {dataSource.map(item => { */}

                        <div className='allDiv'>
                            {/* {dataSource.id=1 ? */}
                            {/* {dataSource.id ==39?  */}
                            <div className='first_div'>
                                <h1>Company Information</h1>
                                <div className='company_button'>
                                {/* <p className='addd' onClick={() => {
                                    handleChange()
                                    toggle()
                                    select()
                                }}>{state ? "Cancle" : "Edit"}</p>
                                <br /> */}

                            </div>
                                <div className='company_information1'>
                                    
                                    <div>
                                        <p>Company Name </p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource2.name} type="text" disabled={diabled}></input>

                                    </div>
                                    <div>
                                        <p>Company type</p>
                                        {inputtag ? <input onChange={(e) => setDataSource(e.target.value)} value={dataSource2.companyType} className='select' disabled={diabled}></input> : ""}
                                        {selecttag ? <select  className='select' disabled={diabled}>
                                            <option value='plc'>Set Company Type</option>
                                            <option value='plc'>Public Llimited Company</option>
                                            <option value='plc'>Public Llimited Company</option>
                                        </select> : ""}
                                        {/* <input onChange={(e) => setDataSource(e.target.value)} value={dataSource2.companyType} type="text" disabled={diabled}></input> */}
                                    </div>
                                    <div>
                                        <p>Company Sector </p>

                                        {inputtag ? <input Value={dataSource3.sectorName} className='select' disabled={diabled}></input> : ""}
                                        {selecttag ? <select  className='select' disabled={diabled}>
                                            <option value='plc'>Selecet Company Sector</option>
                                            <option value='plc'>Government</option>
                                            <option value='plc'>Public Llimited Company</option>
                                            <option value='plc'>Public Llimited Company</option>
                                        </select> : ""}
                                        {/* <select disabled={diabled} >
                                            <option value=''>Transport</option>
                                            <option value='plc'>Public Llimited Company</option>
                                            <option value='plc'>Government</option>
                                            <option value='plc'>Public Llimited Company</option>
                                            <option value='plc'>Public Llimited Company</option>
                                        </select> */}
                                    </div>
                                </div>
                            </div>
                            {/* :""} */}



                            <div className='second_div'>
                                <h1>Company Address</h1>
                                <div className='company_Address1'>
                                    <div>
                                        <p>Region </p>
                                        <input onChange={(e) => setDataSource4(e.target.value)} value={dataSource4.region} disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Sub City </p>
                                        <input onChange={(e) => setDataSource4(e.target.value)} value={dataSource4.subcity}  disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Specfic Location </p>
                                        <input onChange={(e) => setDataSource4(e.target.value)} value={dataSource4.specificLocation}  type="text" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>City </p>
                                        <input onChange={(e) => setDataSource4(e.target.value)} value={dataSource4.city} disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Woreda </p>
                                        <input onChange={(e) => setDataSource4(e.target.value)} value={dataSource4.woreda}  type="text" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>House Number </p>
                                        <input onChange={(e) => setDataSource4(e.target.value)} value={dataSource4.houseNum}  type="text" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Phone Number </p>
                                        <input onChange={(e) => setDataSource4(e.target.value)} value={dataSource4.phone} disabled type="text" ></input>
                                    </div>
                                </div>
                            </div>

                            <div className='Third_div'>
                                <h1>Owner Information</h1>
                                <div className='owner_information1'>
                                    <div>
                                        <p>First Name</p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.firstName} type="text" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Last Name </p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.lastName} type="text" disabled={diabled}></input>

                                    </div>
                                    <div>
                                        <p>Phone Number</p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.phoneNumber} type="text" disabled></input>
                                    </div>
                                    <div>
                                        <p>Email </p>
                                        <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.email} type="email" disabled></input>
                                    </div>
                                </div>
                            </div>

                            <div className='Third_div'>
                                <h1>Additional Information</h1>
                                <div className='additional_information1'>
                                    <div>
                                        <p>Notification Pereference</p>
                                        <select className='select' disabled>
                                            <option value=''>SMS</option>
                                            <option value='plc'>Select Notification Preference</option>
                                            <option value='plc'>Select Notification Preference</option>
                                            <option>Select Notification Preference</option>
                                            <option>Select Notification Preference</option>
                                        </select>

                                    </div>
                                    <div>
                                        <p>Service Neded</p>
                                        <select className='select' disabled>
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
                                    select()
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



                        {/* })}  */}

                    </form>

                </section>




                {/* ---------------end Registaration--------------- */}
            </div>
        </div>
    )
}
