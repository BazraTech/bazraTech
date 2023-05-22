import React, { Component } from 'react'
import styles from './cargo.module.css';
import { useForm } from 'react-hook-form';
import { Link, useParams, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import axios from "axios";
import swal from "sweetalert";

export default function Cargo_detail() {

    const [state, setState] = useState(false);

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
    
    const url2 = `http://64.226.104.50:9090/Api/Admin/All/CargoOwner/${id}`;

    const [dataSource, setDataSource] = useState({})
    useEffect(() => {
        // setLoading(true);
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data)
                console.log(data)
                // setLoading(false);
            })
    }, [])
console.log(dataSource.id);
    const [selecttag, setSelectTag] = useState(false)
    const [inputtag, setinputTag] = useState(true)
    const select = () => {
        setSelectTag(!selecttag);
        setinputTag(!inputtag);
    }

    const urlthree = "http://64.226.104.50:9090/Api/Admin/All/VehicleCatagory";
    const [dataSource5, setDataSource5] = useState([])
    useEffect(() => {
        fetch(urlthree, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource5(data.vehicleCatagories)
                // console.log(dataSource3)
            })
    }, [])

    const urlFour = "http://64.226.104.50:9090/Api/Admin/All/VehicleCondition";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        fetch(urlFour, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data.vehicleConditions)
                console.log(dataSource4)
            })
    }, [])

    const statusUrl = "http://64.226.104.50:9090/Api/Admin/DriverStatus/All"
    const [status, setStatus] = useState([])
    useEffect(() => {
        fetch(statusUrl, options)
        .then(response => response.json())
        .then(data =>{
            setStatus(data.driverStatus)
            console.log(status)
        })
    },[])


    const navigate = useNavigate();
    const goBack = () => {
        navigate(-1);
    }
    const onSubmit = (e) => {
        e.preventDefault()
    };
    

 
    return (

        <div>

            <Navigation path="/Total_number_of_vehicle" title="Cargo Detail"></Navigation>

            <div className={styles.main_content}>

                <div className={styles.tripHeader}>
                    <p><h1 className={styles.avaliableVehicles}>Cargo owner Detail</h1></p>
                    <p ><h4>Driver Name : {dataSource.companyName} <br /> cargo owner ID : {dataSource.id}</h4></p>
                </div>
                <div className={styles.allDiv}>
                   
                    <form onSubmit={(onSubmit)}>

                        <div className={styles.forms}> 
                            <div className={styles.form}>

                            <div>
                                <p>Company Name </p>
                                <input  value={dataSource.companyName} type="text" disabled={diabled}></input>
                            </div>
                          
                            <div>
                                <p>Phone Number </p>
                                <input  value={dataSource.phoneNumber} type="text" disabled={diabled}></input>
                            </div>

                            <div>
                                <p>Enabled</p>
                                <input  value={dataSource.enabled} type="text" disabled={diabled}></input>
                            </div>
                            <div>
                                <p>cargo owner ID</p>
                                <input  value={dataSource.id} type="text" disabled={diabled}></input>
                            </div>
                            </div>
                        </div>
                    </form>
                </div>

            </div>

            {/* ---------------end Registaration--------------- */}
        </div>

    )
}
