import React, { Component } from 'react'
import styles from './vehicle_detail.module.css';
import { useForm } from 'react-hook-form';
import { Link, useParams, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
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
    const url = `http://198.199.67.201:9090/Api/Vehicle/Owner/All/${id}`;
    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data)
                console.log(dataSource)
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
    const onSubmit = (e) => {
       e.preventDefualt()
    };

    return (
        <div>
            <div className="company_container">

                {/*---------------navigation---------------*/}

                <Navigation path="/Total_number_of_vehicle" title="Vehicles Detail"></Navigation>

                {/* --------------- Vehicle header --------------- */}

                {/* <Header title="Vehicles Detail"></Header> */}


                {/* ---------------Registration--------------- */}



                <section className={styles.main_content}>

                    <div className={styles.tripHeader}>
                        <p><h1 className={styles.avaliableVehicles}>Vehicle Detail</h1></p> 
                        <p ><h4>Driver Name : {dataSource.driver == null ? "Unassigned": dataSource.driver} <br /> User ID : {dataSource.plateNumber}</h4></p>
                    </div>
                    <div className={styles.allDiv}>
                    <div className={styles.addToMaintenance}>
                        <p>Add to Maintenance</p>
                    </div>

                        <form onSubmit={(onSubmit)}>

                            <div className={styles.forms}>

                                <div>
                                    <p>Vehicle Catagory </p>
                                    {inputtag ? <input Value={dataSource.vehicleCatagory} className='select' disabled={diabled}></input> : ""}
                                    {/* {selecttag ?
                                        <select className='select' placeholder='Select Vecicle Catagory'
                                            name="vehicleCatagory"

                                        >
                                            <option value="" >Select Vecicle Catagory</option>
                                            {
                                                dataSource5.map(item => {
                                                    return <option >{item.catagory}</option>
                                                })
                                            }
                                        </select>

                                        : ""} */}
                                </div>

                                <div>
                                    <p>Vehicle Name </p>
                                    <input onChange={(e) => setDataSource(e.target.value)} value={dataSource.vehicleName} type="text" disabled={diabled}></input>
                                </div>
                                <div>
                                    <p>Vehicle Condition </p>
                                    {inputtag ? <input Value={dataSource.vehicleCondition} className='select' disabled={diabled}></input> : ""}
                                    {/* {selecttag ?
                                        <select className='select' name='conditionName'

                                        >
                                            <option value="">Select Vecicle Condition</option>
                                            {
                                                dataSource4.map(item => {
                                                    return <option>{item.conditionName}</option>
                                                })
                                            }
                                        </select> : ""} */}
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
                            <div className={styles.setButton}>
                                <p className={state ? styles.button : styles.button2} onClick={() => {
                                    handleChange()
                                    toggle()
                                    select()
                                }}>{state ? "Cancle" : "Edit"}</p>
                                <button className={state ? styles.button3 : styles.button4} type='submit' disabled={diabled}>Update</button>
                            </div>
                            
                        </form>
                    </div>

                </section>

                {/* ---------------end Registaration--------------- */}
            </div>
        </div>
    )
}
