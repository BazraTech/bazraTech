import React, { Component } from 'react'
import styles from './Post_market.module.css';
import { useForm } from 'react-hook-form';
import { Link, useParams, useNavigate } from 'react-router-dom';
import { useState, useEffect } from 'react';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import axios from "axios";
import swal from "sweetalert";
import Market_Progress from './Market_Progress'

export default function Post_market() 
{

    let isPost = false;

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
    const onSubmit = async () => {
        
        const options = {
            method: "POST",
            headers: {
                'Content-Type': 'application/json',
                // "Accept": "application/json",
                "Authorization": `Bearer ${jwt}`
            },
           
        };
        const url = "http://64.226.104.50:9090/Api/Admin/PostCargo"; 
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"])); 
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Posted successful");
                swal("Successfully Posted", `${mess}`, "success", {
                    button: true,
                    // timer: 60000,
                });
                <Market_Progress />

            } else {
                console.log("failed");
                swal(`Failed To Post ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

        
    
   

    return (

        <div>

            <Navigation path="/markating" title="Post markate"></Navigation>

            <div className={styles.main_content}>

                <div className={styles.tripHeader}>
                    <p><h1 className={styles.avaliableVehicles}>Post cargo Detail</h1></p>
                    <p ><h4>Cargo Owner Name : {dataSource.cargoOwner} <br /> Pakaging : {dataSource.packaging}</h4></p>
                </div>
                <div className={styles.allDiv}>
                    
                    <form onSubmit={onSubmit}>

                        <div div className={styles.forms}>
                            <div>
                                    <p>Cargo owner </p>
                                    <input  value={dataSource.cargoOwner} type="text" disabled={diabled}></input>
                                </div> 
                            <div>
                                <p>Pick up </p>
                                    <input  value={dataSource.pickUp} type="text" disabled={diabled}></input>
                                </div>

                                <div>
                                    <p>Drop of </p>
                                    <input  value={dataSource.dropOff} type="text" disabled={diabled}></input>
                                </div>
                                <div>
                                    <p>Cargo type </p>
                                    <input  value={dataSource.cargoType} type="text" disabled={diabled}></input>
                                </div>
                                <div>
                                    <p>packaging</p>
                                    <input  value={dataSource.packaging} type="text" disabled={diabled}></input>
                                </div>
                                <div>
                                    <p>weight</p>
                                    <input  value={dataSource.weight} type="text" disabled={diabled}></input>
                                </div>
                                <div>
                                    <p>price</p>
                                    <input  value={dataSource.price} type="text" disabled={diabled}></input>
                                </div>

                            <div className={styles.setButton}>
                            
                            {/* <button className= {styles.button3 }  >Post</button> */}
                            <Link  className= {styles.button3 } to={`/Market_Progress/${id}`}> Post </Link>
                        </div>
                     </div>

                    </form>
             </div>

            </div>

            {/* ---------------end Registaration--------------- */}
        </div>

    )
}
