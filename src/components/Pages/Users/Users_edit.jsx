import React, { Component } from 'react'
import styles from './users_edit.module.css';
import { useState, useEffect } from 'react';
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

    const [Loading, setLoading] = useState([]);
    // const { id, role, companyID } = useParams();
    const user = JSON.parse(localStorage.getItem("user"));
    const role = user.role

    let url;
    if (role == "OWNER") {
        url = `http://198.199.67.201:9090/Api/Vehicle/Owner/Info`;
    }
    if (role == "INDIVIDUAL") {
        url = `http://198.199.67.201:9090/Api/Vehicle/Owner/Info`;
    }
    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then((response) => response.json())
            .then((json) => {
                setDataSource(json.ownerINF)
                setDataSource2(json.ownerINF.companyAddressINF)
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

                <Navigation path="/user_edit" title="Users/Edit"></Navigation>

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



                        </div>

                        {/* })}  */}

                    </form>

                </section>

                {/* ---------------end Registaration--------------- */}
            </div>
        </div>
    )
}
