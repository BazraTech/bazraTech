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
    const url2 = `http://64.226.104.50:9090/Api/Admin/All/CargosBy/ACCEPT`;

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
 const url1 = `http://64.226.104.50:9090/Api/Admin/All/Cargos/${id}`;

 const [dataSource1, setDataSource1] = useState([])
 useEffect(() => {
     // setLoading(true);
     fetch(url1, options)
         .then(respnse => respnse.json())
         .then(data => {
             setDataSource1(data)
             console.log(dataSource1)
             // setLoading(false);
         })
 }, [])
console.log(dataSource1);


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

          {dataSource.status ='ACTIVE' ?<Navigation path="/marketing" title="Post progress" link="/marketing" past="marketing"></Navigation>:
           <Navigation path="/marketing" title="Post progress" link={`/Post_market/${id}`} past="post marketing"></Navigation>}

            <div className={styles.main_content}>

                <div className={styles.tripHeader}>
                    <p><h1 className={styles.avaliableVehicles}>Post cargo Detail</h1></p>
                    <p ><h4>Cargo Owner Name : {dataSource1.cargoOwner} <br /> Pakaging : {dataSource1.packaging}</h4></p>
                </div>
                <div className={styles.allDiv}>
                   
                    <form onSubmit={onSubmit}>


                        <div className={styles.forms}>
                                <div>
                                        <p>20 ton </p>
                                        <input  value={dataSource1.cargoOwner} type="text" disabled={diabled}></input>
                                </div> 
                                <div>
                                    <p>40 ton </p>
                                        <input  value={dataSource1.packaging} type="text" disabled={diabled}></input>
                                </div>
                                
                                    <div className={styles.progressBar}>
                                    <p> Progress Bar </p>
                                    <div className={styles.progressDiv}>
                                        
                                      <div></div><div className={styles.progress}style={{ width: `${percent}%`, backgroundColor: percent <= 25 ?'red' : 'green' }} >
                                        </div>
                                    </div><span>{percent}%</span>
                                 </div>
                                                      
                        </div>  
                        <button className={styles.button3}>Send to Cargo Owner</button>
                    </form>
                 </div>

                        
            {/*---------------- table ------------------- */}

            <div className={styles.outer_vehicle_table} id='myTable'>
              <p>Vihecles list</p>
              <table className={styles.vehicle_table} id="myTable">
                                            <thead>
                                                <tr>
                                                <th>Id</th>
                                                    <th>vihicle owner Name</th>
                                                    <th>driver</th>
                                                    <th>price</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                              
                                                    <tr className={styles.active_row}>
                                                        <td>{dataSource.id}</td>
                                                        <td>{dataSource.cargoOwner}</td>
                                                        <td>{dataSource.packaging}</td>
                                                        <td>{dataSource.weight}</td>
                                                                                                             
                                                    </tr>
                                              
                                            </tbody>
                                        </table>
            </div>
            <div className={styles.page}>
              {/* <Pagination */}
                {/* // onChange={(page) => setCurentPage(page)}
                // pageSize={postPerPage}
                // current={page}
                // total={totalPages}
              // showQuickJumper
              // showSizeChanger
              // onShowSizeChange={onShowSizeChange} */}
              {/* /> */}
           
                 
            </div>

            

            {/* ---------------end Registaration--------------- */}
        </div>
 </div>
    )
}
