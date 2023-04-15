import React from 'react'
import styles from './driver_detail.module.css';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';

export default function ({ data, display, changeName }) {


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
                    <div className={styles.popup}>
                        <div className={styles.popupInner}>
                            <lable className={styles.zxcc}>Driver Detail </lable>
                            <div className={styles.ewq}>
                                <div className={styles.qwe2}>
                                    <div className={styles.asd}>
                                        <p className={styles.closeBtn} onClick={() => changeName("false")}>X</p>
                                        <lable>First Name</lable>
                                        <input name='driverName' type="text"
                                            value={dataSource.driverName}
                                        ></input>
                                    </div>

                                    <div className={styles.asd}>
                                        <lable>Gender</lable>
                                        <input value={dataSource.gender}></input>
                                    </div>

                                    <div className={styles.asd}> 
                                        <lable>License Number</lable>
                                        <input name='licenseNumber' type="text"
                                            value={dataSource.licenseNumber}
                                        ></input>
                                    </div>

                                    {/* <div className={styles.asd}>
                                        <lable>Driver Licence Picture</lable>
                                        <input name='licensePic' type="text"
                                        ></input>
                                    </div>

                                    <div className={styles.asd}>
                                        <lable>Driver Picture</lable>
                                        <input name='driverPic' type="text"
                                        ></input>
                                    </div> */}

                                    <div className={styles.asd}>
                                        <lable>Date Of Birth</lable>
                                        <input name='birtDate' type="Date"
                                            value={dataSource.birthDate}
                                        ></input>
                                    </div>


                                    <div className={styles.asd}>
                                        <lable>Phone Number</lable>
                                        <input name='phoneNumber' type="text"
                                            value={dataSource.phoneNumber}
                                        ></input>
                                    </div>

                                    <div className={styles.asd}>
                                        <lable>Exeperiance</lable>
                                        <input name='Exeperiance' type="text"
                                            value={dataSource.experience}
                                        ></input>
                                    </div>

                                    <div className={styles.asd}>
                                        <lable>License Grade</lable>
                                        <input name='License Grade' type="text"
                                            value={dataSource.licenseGrade}
                                        ></input>
                                    </div>

                                    <div className={styles.asd}>
                                        <lable>Issue Date</lable>
                                        <input name='Issue Date' type="date"
                                            value={dataSource.licenseIssueDate}
                                        ></input>
                                    </div>

                                    <div className={styles.asd}>
                                        <lable>Expire Date</lable>
                                        <input name='Expire Date' type="date"
                                            value={dataSource.licenseExpireDate}
                                        ></input>
                                    </div>

                                    <div className={styles.asd}>
                                        <lable>Status</lable>
                                        <input name='Expire Date' type="text"
                                            value={dataSource.status}
                                        ></input>
                                    </div>

                                    <div className={styles.asd}>
                                        <lable>Vehicle Owner</lable>
                                        <input name='Expire Date' type="text"
                                            value={dataSource.vehicleOwner}
                                        ></input>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div> : ""}
        </form>







    )
}
