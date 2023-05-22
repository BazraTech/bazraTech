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
import { Pagination } from 'antd';
import Driver_detail from '../Drivers/Driver_detail';
import { AiFillCar } from "react-icons/ai";
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import { IoSettingsOutline } from "react-icons/io5";
import { FaUserSecret } from "react-icons/fa";
import { FaUserCheck } from "react-icons/fa";
import { FaUserTimes } from "react-icons/fa";
import { FaUserMinus } from "react-icons/fa";
import Vehicle_Table from './Vehicle_Table';
import Driver_Table from './Driver_Table';

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
    const [totalPages2, setTotalPage2] = useState(1);
    const [dataSource, setDataSource] = useState([])
    const [dataSource2, setDataSource2] = useState([])
    const [dataSource3, setDataSource3] = useState([])
    const [dataSource5, setDataSource5] = useState([])
    const [dataSource6, setDataSource6] = useState([])
    const [dataSource7, setDataSource7] = useState([])
    const [dataSource8, setDataSource8] = useState([])
    const [dataSource9, setDataSource9] = useState([])
    const [dataSource10, setDataSource10] = useState([])
    const [dataSource11, setDataSource11] = useState([])
    const [dataSource12, setDataSource12] = useState([])
    const [dataSource13, setDataSource13] = useState([])
    const [tableTitle, setTableTitle] = useState("Total Vehicles");
    const [tableTitle2, setTableTitle2] = useState("Total Drivers");

    const [Loading, setLoading] = useState([]);
    const { id, role, companyID } = useParams();

    let url;

    if (role === "OWNER") {
        url = `http://64.226.104.50:9090/Api/Admin/All/CompanyVehicleOwner/${id}`;
    }
    if (role === "INDIVIDUAL") {
        url = `http://64.226.104.50:9090/Api/Admin/All/IndividualVehicleOwner/${id}`;
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
                setDataSource6(json.ownerINF.inStockVehicles)
                setDataSource7(json.ownerINF.onRouteVehicles)
                setDataSource8(json.ownerINF.parkedVehicles)
                setDataSource9(json.ownerINF.maintainingVehicles)
                setDataSource10(json.ownerINF.assignedDriverINFs)
                setDataSource11(json.ownerINF.unassignedDriverINFs)
                setDataSource12(json.ownerINF.permitDriverINFs)
                setDataSource13(json.ownerINF.onRouteDriverINFs)

                setTotalPage2(json.ownerINF.drivers.length);
                setLoading(false)
            });
    }, [])

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

                <Navigation path="/users" title="Users/Detail"></Navigation> 

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
                            <>
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
                                            <input className='select' value={dataSource.notificationMedium} disabled></input>
                                        </div>
                                        <div>
                                            <p>Service Neded </p>
                                            <input value={dataSource.serviceNeeded} className='select' disabled>
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
                            </>
                        </div>
                    </form>

                    <div className={styles.allcards}>

                        <div className={styles.vehicle} onClick={() => { setTableTitle("Total Vehicles") }}>
                            <div className={styles.innerContents}>
                                <h4>Total Vehicle</h4>
                                <div className={styles.icon}>
                                    <p><AiFillCar size="2.2rem"></AiFillCar><b>{dataSource5.length}</b></p>
                                </div>
                            </div>
                        </div>

                        <div className={styles.vehicle} onClick={() => { setTableTitle("On Route Vehicles") }}>
                            <div className={styles.innerContents}>
                                <h4>On Route</h4>
                                <p><FaRoute size="2rem" ></FaRoute><b>{dataSource7.length}</b></p>
                            </div>
                        </div>

                        <div className={styles.vehicle} onClick={() => { setTableTitle("On Stock Vehicles") }}>
                            <div className={styles.innerContents}>
                                <h4>In Stock</h4>
                                <p><FaParking size="2rem" ></FaParking><b>{dataSource6.length}</b></p>
                            </div>
                        </div>

                        <div className={styles.vehicle} onClick={() => { setTableTitle("Parked Vehicles") }}>
                            <div className={styles.innerContents}>
                                <h4>Parked</h4>
                                <p><IoSettingsOutline size="2rem" ></IoSettingsOutline><b>{dataSource8.length}</b></p>
                            </div>
                        </div>

                        <div className={styles.vehicle} onClick={() => { setTableTitle("Maintenance Vehicles") }}>
                            <div className={styles.innerContents}>
                                <h4>Maintenance</h4>
                                <p><IoSettingsOutline size="2rem" ></IoSettingsOutline><b>{dataSource9.length}</b></p>
                            </div>
                        </div>
                    </div>

                    <div>
                        {tableTitle === "Total Vehicles" && <Vehicle_Table id={id} role={role} title={tableTitle} />}
                        {tableTitle === "On Route Vehicles" && <Vehicle_Table id={id} role={role} title={tableTitle} />}
                        {tableTitle === "On Stock Vehicles" && <Vehicle_Table id={id} role={role} title={tableTitle} />}
                        {tableTitle === "Parked Vehicles" && <Vehicle_Table id={id} role={role} title={tableTitle} />}
                        {tableTitle === "Maintenance Vehicles" && <Vehicle_Table id={id} role={role} title={tableTitle} />}
                    </div>

                    <div className={styles.allcards}>

                        <div className={styles.vehicle} onClick={() => { setTableTitle2("Total Drivers") }}>
                            <div className={styles.innerContents}>
                                <h4>Total Drivers</h4>
                                <div className={styles.icon}>
                                <p><FaUserSecret size="2.2rem"></FaUserSecret><b>{dataSource3.length}</b></p>
                                </div>
                            </div>
                        </div>

                        <div className={styles.vehicle} onClick={() => { setTableTitle2("On Route Drivers") }}>
                            <div className={styles.innerContents}>
                                <h4>On Route</h4>
                                <p><FaRoute size="2rem" ></FaRoute><b>{dataSource13.length}</b></p>
                            </div>
                        </div>

                        <div className={styles.vehicle} onClick={() => { setTableTitle2("Assigned Drivers") }}>
                            <div className={styles.innerContents}>
                                <h4>Assigned</h4>
                                <p><FaUserCheck size="2rem" ></FaUserCheck><b>{dataSource10.length}</b></p>
                            </div> 
                        </div>

                        <div className={styles.vehicle} onClick={() => { setTableTitle2("Unassigned Drivers") }}>
                            <div className={styles.innerContents}>
                                <h4>Unassigned</h4>
                                <p><FaUserTimes size="2rem" ></FaUserTimes><b>{dataSource11.length}</b></p>
                            </div>
                        </div>

                        <div className={styles.vehicle} onClick={() => { setTableTitle2("Permit Vehicles") }}>
                            <div className={styles.innerContents}>
                                <h4>Permit</h4>
                                <p><FaUserMinus size="2rem" ></FaUserMinus><b>{dataSource12.length}</b></p>
                            </div>
                        </div>
                    </div>

                    <div>
                        {tableTitle2 === "Total Drivers" && <Driver_Table id={id} role={role} title={tableTitle2} />}
                        {tableTitle2 === "On Route Drivers" && <Driver_Table id={id} role={role} title={tableTitle2} />}
                        {tableTitle2 === "Assigned Drivers" && <Driver_Table id={id} role={role} title={tableTitle2} />}
                        {tableTitle2 === "Unassigned Drivers" && <Driver_Table id={id} role={role} title={tableTitle2} />}
                        {tableTitle2 === "Permit Vehicles" && <Driver_Table id={id} role={role} title={tableTitle2} />}
                    </div>





                    {/* <div className={styles.outer_vehicle_table} id='myTable'> 

                        <label>{tableTitle}</label> 

                        <table class={styles.vehicle_table} id="myTable"> 

                            <thead> 
                                <tr> 
                                    <th>Vehicle Name</th> 
                                    <th>Assigned Driver</th> 
                                    <th>Vehicle ID</th> 
                                    <th>Vehicle Type</th> 
                                    <th>Plate Number</th>  
                                    <th>Status</th> 
                                    <th>Detail</th> 
                                    <th>Tracking</th> 
                                </tr> 
                            </thead> 
                            <tbody> 
                                {currentPage.map(item => (
                                    <tr className={styles.active_row}> 

                                        <td>{item.vehicleName}</td> 
                                        <td>{item.driverName == "null" ? "unassignd" : `${item.driverName}`}</td> 
                                        <td>{item.id}</td> 
                                        <td>{item.vehicleCatagory}</td> 
                                        <td>{item.plateNumber}</td> 
                                        <td>{item.status}</td>
                                        <td><Link to={`/vehicle_detail/${item.id}`}><button>Detail</button></Link></td> 
                                        <td><Link to="/tracking"><button>Tracking</button></Link></td> 
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>

                    <div className={styles.page}>
                        <Pagination
                            onChange={(page) => setCurentPage(page)}
                            pageSize={postPerPage}
                            current={page}
                            total={totalPages}
                            showQuickJumper
                            showSizeChanger
                            onShowSizeChange={onShowSizeChange}
                        />
                    </div> */}

                    {/* <div className={styles.outer_vehicle_table} id='myTable'>

                                    <div className={styles.second_div}>
                                        <div className={styles.Vehicle_number}>
                                            <p>Total Number Of Drivers</p>
                                            <p className={styles.number} >{dataSource3.length}</p>
                                        </div>
                                    </div>

                                    <label>Registerd Drivers</label>

                                    <table class={styles.vehicle_table} id="myTable">

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
                                            {currentPage2.map(item => (
                                                <tr className={styles.active_row}>

                                                    <td>{item.id}</td>
                                                    <td>{item.driverName}</td>
                                                    <td>{item.licenseNumber}</td>
                                                    <td><p onClick={() => {
                                                        setEdit(item.id)
                                                        setName("true")
                                                    }}>Detail</p></td>
                                                    <td><Link to=""><button>Manage</button></Link></td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>
                                </div>
                                <div className={styles.page}>
                                    <Pagination
                                        onChange={(page2) => setCurentPage2(page2)}
                                        pageSize={postPerPage2}
                                        current={page2}
                                        total={totalPages2}
                                        showQuickJumper
                                        showSizeChanger
                                        onShowSizeChange={onShowSizeChange2}
                                    />
                                </div> */}

                </section>

                {/* ---------------end Registaration--------------- */}
            </div >
        </div >
    )
}