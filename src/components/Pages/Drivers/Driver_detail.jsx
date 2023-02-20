import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import { IoSettingsOutline } from "react-icons/io5";
// import './total_no_of_vehicle.css';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { Pagination } from 'antd';
import SyncLoader from "react-spinners/SyncLoader";



export default function ({data, display, changeName}) {


    let [active, setActive] = useState("total_vehicle");
    let [state, setState] = useState("false");
    // const color = () => {
    //     setState(state);
    // }
    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };


    const [popup1, setPop1] = useState(true);

    const handleClickopen1 = () => {
        setPop1(!popup1);
    }


    const [dataSource, setDataSource] = useState([])
    const url = `http://198.199.67.201:9090/Api/Admin/All/Drivers/${data}`;
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data)

            })
    }, [])

    return (

        <form >
            {popup1 ?
                <div>
                    <div className='popup3'>
                        <div className='popup-inner'>
                            <lable className="zxcc">Driver Detail </lable>
                            <div className='ewq'>
                                <div className='qwe2'>
                                    <div className='asd'>
                                        <p className='close-btn' onClick={()=> changeName("false")}>X</p>
                                        <lable>First Name</lable>
                                        <input name='driverName' type="text"
                                            value={dataSource.driverName}
                                            // {...register("driverName", { required: '*Driver Name is required' })}
                                            placeholder='Enter Vehicle Name'
                                        // onChange={(e) => setDriverName(e.target.value)} 
                                        ></input>
                                        {/* {driverName <= 0 && errors.driverName && <span className='validate_text'>{errors.driverName.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>Gender</lable>
                                        <input value={dataSource.gender}></input>
                                        {/* <select className='select' name='gender' 
                                        
                                         {...register("vehicleCondition", { required: '*Vecicle Condition is required' })}
                                         onChange={(e) => setVehicleCondition(e.target.value)} 
                                        > 
                                             <option value="">Select Gender</option>
                                            <option value="male">Male</option>
                                            <option value="femail">Femaile</option> 
                                         </select> 
                                        {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>License Number</lable>
                                        <input name='licenseNumber' type="text"
                                              value={dataSource.licenseNumber}
                                            // {...register("licenseNumber", { required: '*License Number is required' })}
                                            placeholder='Enter Vehicle Name'
                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                        ></input>
                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>Driver Licence Picture</lable>
                                        <input name='licensePic' type="text"
                                            // value={licensePic}
                                            // {...register("licensePic", { required: '*License Picture is required' })}
                                            placeholder='Enter License Picture'
                                        // onChange={FileUploadTinCertificate} 
                                        ></input>
                                        {/* {licensePic <= 0 && errors.licensePic && <span className='validate_text'>{errors.licensePic.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>Driver Picture</lable>
                                        <input name='driverPic' type="text"
                                            // value={driverPic}
                                            // {...register("driverPic", { required: '*Driver Picture is required' })}
                                            placeholder='Please Enter Driver Picture'
                                        // onChange={FileUploadTreadCertificate} 
                                        ></input>
                                        {/* {driverPic <= 0 && errors.driverPic && <span className='validate_text'>{errors.driverPic.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>Date Of Birth</lable>
                                        <input name='birtDate' type="Date"
                                        value={dataSource.birthDate}
                                        // {...register("licenseNumber", { required: '*License Number is required' })}
                                        // placeholder='Enter Date Of Birth'
                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                        ></input>
                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>


                                    <div className='asd'>
                                        <lable>Phone Number</lable>
                                        <input name='phoneNumber' type="text"
                                            value={dataSource.phoneNumber}
                                            // {...register("licenseNumber", { required: '*License Number is required' })}
                                            placeholder='Enter Phone Number'
                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                        ></input>
                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>Exeperiance</lable>
                                        <input name='Exeperiance' type="text"
                                             value={dataSource.experience}
                                            // {...register("licenseNumber", { required: '*License Number is required' })}
                                            placeholder='Enter Exeperiance '
                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                        ></input>
                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>License Grade</lable>
                                        <input name='License Grade' type="text"
                                             value={dataSource.licenseGrade}
                                            // {...register("licenseNumber", { required: '*License Number is required' })}
                                            placeholder='Enter License Grade '
                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                        ></input>
                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>Issue Date</lable>
                                        <input name='Issue Date' type="date"
                                            value={dataSource.licenseIssueDate}
                                            // {...register("licenseNumber", { required: '*License Number is required' })}
                                            placeholder='Enter Issue Date'
                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                        ></input>
                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>Expire Date</lable>
                                        <input name='Expire Date' type="date"
                                           value={dataSource.licenseExpireDate}
                                            // {...register("licenseNumber", { required: '*License Number is required' })}
                                            placeholder='Enter Expire Date'
                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                        ></input>
                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>Status</lable>
                                        <input name='Expire Date' type="text"
                                           value={dataSource.status}
                                            // {...register("licenseNumber", { required: '*License Number is required' })}
                                            placeholder='Enter Expire Date'
                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                        ></input>
                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>

                                    <div className='asd'>
                                        <lable>Vehicle Owner</lable>
                                        <input name='Expire Date' type="text"
                                           value={dataSource.vehicleOwner}
                                            // {...register("licenseNumber", { required: '*License Number is required' })}
                                            placeholder='Enter Expire Date'
                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                        ></input>
                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                    </div>


                                    {/* <div className='asdy'>
                                        <button>Register</button>
                                    </div>
                                    <div className='asdy'>
                                        <button type='reset'>Clear</button>
                                    </div> */}
                                </div>
                            </div>
                        </div>
                    </div>
                </div> : ""}
            </form> 







            )
}
