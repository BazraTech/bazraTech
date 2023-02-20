import React, { Component } from 'react'
import styles from './users_edit.module.css';
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
import Navigation from '../Navigation/Navigation';

export default function Users_edit() {

    const [state, setState] = useState(false);

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
    const [dataSource, setDataSource] = useState([])
    const [dataSource2, setDataSource2] = useState([])
    const [dataSource3, setDataSource3] = useState([])
    const [dataSource5, setDataSource5] = useState([])

    const [Loading, setLoading] = useState([]);
    const { id, role, companyID } = useParams();

    let url;

    if (role === "OWNER") {
        url = `http://198.199.67.201:9090/Api/Admin/All/CompanyVehicleOwner/${id}`;
    }
    if (role === "INDIVIDUAL") {
        url = `http://198.199.67.201:9090/Api/Admin/All/IndividualVehicleOwner/${id}`;
    }

    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then((response) => response.json())
            .then((json) => {
                setDataSource(json.ownerINF)
                setDataSource2(json.ownerINF.companyAddressINF)
                setDataSource3(json.ownerINF.drivers)
                setDataSource5(json.ownerINF.vehicles)
                console.log(json)
                setLoading(false)
            });
    }, [])






    // const [dataSource4, setDataSource4] = useState([])
    // const url2 = `http://198.199.67.201:9090/Api/Admin/Company/Vehicles/All/${companyID}`;
    // useEffect(() => {
    //     setLoading(true)
    //     fetch(url2, options)
    //         .then((response) => response.json())
    //         .then((json) => {
    //             setDataSource4(json.vehicles)
    //             console.log(json)
    //             setLoading(false)
    //         });
    // }, [])

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

                <Navigation path="/users" title="Users/Edit"></Navigation>

                {/* ---------------header--------------- */}

                {/* <Header title="Users/Edit"></Header> */}

                {/* ---------------Registration--------------- */}

                <section className={styles.main_content}>

                    <div className={styles.company_individual_header}>
                        <p ><h1 className={styles.companyHeader}>Company Detail</h1></p>
                        <p ><h4 className={styles.vehicleDetail}>Name : {dataSource.role} <br /> User ID : {dataSource.id}</h4></p>
                    </div>
                    <form className='form'>
                        {/* {dataSource.map(item => { */}

                        <div className={styles.allDiv}>
                            {role === "INDIVIDUAL" ? "" :
                                <div className='first_div'>
                                    <h1>Company Information</h1>
                                    <div className={styles.company_information}>
                                        <div>
                                            <p>Company Name </p>
                                            <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.companyName} type="text" disabled={diabled}></input>
                                        </div>
                                        <div>
                                            <p>Company type</p>
                                            {inputtag ? <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.companyType} className='select' disabled={diabled}></input> : ""}
                                            {selecttag ? <select className='select' disabled={diabled}>
                                                <option value='plc'>Set Company Type</option>
                                                <option value='plc'>Public Llimited Company</option>
                                                <option value='plc'>Public Llimited Company</option>
                                            </select> : ""}
                                            {/* <input onChange={(e) => setDataSource(e.target.value)} value={dataSource2.companyType} type="text" disabled={diabled}></input> */}
                                        </div>
                                        <div>
                                            <p>Company Sector </p>

                                            {inputtag ? <input Value={dataSource.companySector} className='select' disabled={diabled}></input> : ""}
                                            {selecttag ? <select className='select' disabled={diabled}>
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
                            }
                            {/* :""} */}

                            <div className='second_div'>
                                {role === "INDIVIDUAL" ? <h1>Owner Address</h1> : <h1>Company Address</h1>}
                                <div className={styles.company_Address}>
                                    <div>
                                        <p>Region </p>
                                        <input onChange={(e) => setDataSource2(e.target.value)} value={dataSource2.region} disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Sub City </p>
                                        <input onChange={(e) => setDataSource2(e.target.value)} value={dataSource2.subcity} disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Specfic Location </p>
                                        <input onChange={(e) => setDataSource2(e.target.value)} value={dataSource2.specificLocation} type="text" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>City </p>
                                        <input onChange={(e) => setDataSource2(e.target.value)} value={dataSource2.city} disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Woreda </p>
                                        <input onChange={(e) => setDataSource2(e.target.value)} value={dataSource2.woreda} type="text" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>House Number </p>
                                        <input onChange={(e) => setDataSource2(e.target.value)} value={dataSource2.houseNum} type="text" disabled={diabled}></input>
                                    </div>
                                    <div>
                                        <p>Phone Number </p>
                                        <input onChange={(e) => setDataSource2(e.target.value)} value={dataSource2.phone} disabled type="text" ></input>
                                    </div>
                                </div>
                            </div>

                            <div className='Third_div'>
                                <h1>Owner Information</h1>
                                <div className={styles.owner_information}>
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
                                <div className={styles.additional_information}>
                                    <div>
                                        <p>Notification Pereference</p>
                                        <input className='select' value={dataSource.notificationMedium} disabled>
                                            {/* <option value=''>SMS</option>
                                            <option value='plc'>Select Notification Preference</option>
                                            <option value='plc'>Select Notification Preference</option>
                                            <option>Select Notification Preference</option>
                                            <option>Select Notification Preference</option> */}
                                        </input>
                                    </div>
                                    <div>
                                        <p>Service Neded </p>
                                        <input value={dataSource.serviceNeeded} className='select' disabled>
                                            {/* <option value=''>Tracking</option>
                                            <option value='plc'>Select Service Neded</option>
                                            <option value='plc'>Select Service Neded</option>
                                            <option>Select Service Neded</option>
                                            <option>Select Service Neded</option> */}
                                        </input>
                                    </div>
                                </div>
                            </div>
                            <div className={styles.company_button}>
                                <p className={styles.addd} onClick={() => {
                                    handleChange()
                                    toggle()
                                    select()
                                }}>{state ? "Cancle" : "Edit"}</p>
                                <br />
                                <button className={styles.ad} disabled={diabled}>Update</button>

                            </div>

                            <div className='outer_vehicle_tables0' id='myTable'>

                                <div className={styles.second_div}>
                                    <div className={styles.Vehicle_number}>
                                        <label>Total Number Of Vehicle</label>
                                        <p className={styles.number} >{dataSource5.length}</p>
                                    </div>
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
                                        {dataSource5.map(item => (
                                            <tr className='active_row'>

                                                <td>{item.vehicleName}</td>
                                                {/* <td>{item.driver == null ? "unassignd" :`${dataSource3.map(item2 =>( item2.driverName ))}`}</td> */}
                                                <td>{item.driverName == "null" ? "unassignd" : `${item.driverName}`}</td>
                                                <td>{item.id}</td>
                                                <td>{item.vehicleCatagory}</td>
                                                <td>{item.plateNumber}</td>
                                                <td><Link to={`/vehicle_detail/${item.id}`}><button>Detail</button></Link></td>
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

                            <div className='outer_vehicle_tables0' id='myTable'>

                                <div className={styles.second_div}>
                                    <div className={styles.Vehicle_number}>
                                        <label>Total Number Of Driver</label>
                                        <p className={styles.number} >{dataSource3.length}</p>
                                    </div>
                                </div>

                                <p>Registerd Drivers</p>

                                <table class="vehicle_table" id="myTable">

                                    <thead>
                                        <tr>
                                            <th>Driver ID</th>
                                            <th>Driver Name</th>
                                            <th>License Number</th>
                                            <th>Detail</th>
                                            <th>Tracking</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        {dataSource3.map(item => (
                                            <tr className='active_row'>

                                                <td>{item.id}</td>
                                                {/* <td>{item.driver == null ? "unassignd" :`${dataSource3.map(item2 =>( item2.driverName ))}`}</td> */}
                                                {/* <td>{item.driver == null ? "unassignd" : `${item.driver.driverName}`}</td> */}
                                                <td>{item.driverName}</td>
                                                <td>{item.licenseNumber}</td>
                                                {/* <td>{item.plateNumber}</td> */}
                                                <td><Link to={`/vehicle_detail/${item.id}`}><button>Detail</button></Link></td>
                                                <td><Link to="/tracking"><button>Tracking</button></Link></td>
                                            </tr>
                                        ))}
                                    </tbody>
                                </table>
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
