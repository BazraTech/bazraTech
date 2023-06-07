import React, { Component } from 'react'
import styles from './Post_market.module.css';
import { useForm } from 'react-hook-form';
import { Link, useParams, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import axios from "axios";
import swal from "sweetalert";

export default function Market_Progress() {

    

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
    const url2 = `http://64.226.104.50:9090/Api/Admin/All/Cargos/${id}`;

    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        // setLoading(true);
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data)
                console.log(dataSource)
                // setLoading(false);
            })
    }, [])
console.log(dataSource);



    const navigate = useNavigate();
    const goBack = () => {
        navigate(-1);
    }
    const onSubmit =  (e) => {
        
        // console.log(isPost)
        e.preventDefault()

    };
   let percent = 75;

    return (

        <div>

            <Navigation path="/markating" title="Post progress"></Navigation>

            <div className={styles.main_content}>

                <div className={styles.tripHeader}>
                    <p><h1 className={styles.avaliableVehicles}>Post cargo Detail</h1></p>
                    <p ><h4>Cargo Owner Name : {dataSource.cargoOwner} <br /> Pakaging : {dataSource.packaging}</h4></p>
                </div>
                <div className={styles.allDiv}>
                   
                    <form onSubmit={onSubmit}>


                        <div className={styles.forms}>
                                <div>
                                        <p>Cargo owner </p>
                                        <input  value={dataSource.cargoOwner} type="text" disabled={diabled}></input>
                                </div> 
                                <div>
                                    <p>packaging </p>
                                        <input  value={dataSource.packaging} type="text" disabled={diabled}></input>
                                </div>
                                
                                    <div className={styles.progressBar}>
                                    <p> Progress Bar </p>
                                    <div className={styles.progressDiv}>
                                        
                                      <div></div><div className={styles.progress}style={{ width: `${percent}%`, backgroundColor: percent <= 25 ?'red' : 'green' }} >
                                        </div>
                                    </div><span>{percent}%</span>
                                 </div>
                        
                        </div>  
                        
                 </form>
                 
            </div>

            </div>

            {/* ---------------end Registaration--------------- */}
        </div>

    )
}
