import React from 'react'
import './available.css';
import { Link } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { useForm } from 'react-hook-form';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { total } from './data/data';

export default function () {


    const {
        register,
        handleSubmit,
        watch,
        formState: { errors },
    } = useForm();
    const onSubmit = (data) => {
        console.log(data);
    };

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api
    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
    };

    const urlFour = "http://198.199.67.201:9090/Api/SignIn/Admin";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        fetch(urlFour, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data)
                console.log(dataSource4)
            })
    }, [])


    const [popup, setPop] = useState(false);
    const [state, setState] = useState("");
    const handleClickopen = () => {
        setPop(!popup);
    }
    // {
    //     total[0]
    //     .map((item) => {
    //         setState(item.assignedDriver.toLowerCase().includes(search))
    //     })}


        const [search, setSearch] = useState('');
        // if (search === state) {
        //   alert("success")
        //  }

       
        const [popup1, setPop1] = useState(true);



        return (

            <div className="dashboard_container">

                {/*---------------navigation---------------*/}

                <Navigation></Navigation>

                {/* ---------------header--------------- */}

                <Header title="Avialable Trip"></Header>


                {/* ---------------contents--------------- */}

                <section className='register'>

                    <div className='company_individual_header'>
                    <Link style={{ textDecoration: 'none' }} to="/avialable_trip"><p><h1 className='nmn'>Avialable Trip</h1></p></Link>
                    <Link style={{ textDecoration: 'none' }} to="/trip_history"><p><h1 className='nmnn'>Trip History</h1></p></Link>
                    </div>

                    <form className='form' onSubmit={handleSubmit(onSubmit)}>
                        <div className='allDiv'>

                            <div className='trip_date'>
                                <input onChange={(e) => setSearch(e.target.value)} placeholder='Search...' className='trip_date1' type="search" /><button>Search</button>
                            </div>

                            {popup1 ?

                                <div className='setTrip' id='myInput'>
                                    {/* <div className='result'>There is No Result</div> */}

                                    {total[0]
                                        .filter((item) => {
                                            return search.toLowerCase() === ''
                                                ? item
                                                : item.assignedDriver.toLowerCase().includes(search);
                                        })
                                        .map(item => (
                                            <>

                                                <div className='avilabel_trips' >


                                                    <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                                    <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                                    <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                                    <p><lable>Current Location : <b>{item.location}</b></lable></p>
                                                    </div>

                                                    <div className='set_history'>
                                                        <p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Set Trip</button></Link></p>
                                                        {/* <p> <Link to="/trip_history" style={{ textDecoration: 'none' }}><button>Trip History</button></Link></p> */}
                                                    </div>

                                                
                                                <div className='borderBottom'></div>

                                            </>
                                        ))}

                                </div> : ""}


                            {/* <div className='setTrip'>
                        <div className='avilabel_trips' >
                                {total[0].map(item => (
                                    <>
                                        <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                        <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                        <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                        <p><lable>Current Location : <b>{item.location}</b></lable></p>
                                    </>
                                ))}
                            </div>
                            <div className='set_history'>
                                <p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Set Trip</button></Link></p>
                                <p> <Link to="/trip_history" style={{ textDecoration: 'none' }}><button>Trip History</button></Link></p>
                            </div>
                        </div>

                        <div className='setTrip'>
                        <div className='avilabel_trips' >
                                {total[0].map(item => (
                                    <>

                                        <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                        <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                        <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                        <p><lable>Current Location : <b>{item.location}</b></lable></p>
                                    </>
                                ))}
                            </div>
                            <div className='set_history'>
                                <p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Set Trip</button></Link></p>
                                <p> <Link to="/trip_history" style={{ textDecoration: 'none' }}><button>Trip History</button></Link></p>
                            </div>
                        </div>

                        <div className='setTrip'>
                        <div className='avilabel_trips' >
                                {total[0].map(item => (
                                    <>

                                        <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                        <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                        <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                        <p><lable>Current Location : <b>{item.location}</b></lable></p>
                                    </>
                                ))}
                            </div>
                            <div className='set_history'>
                                <p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Set Trip</button></Link></p>
                                <p> <Link to="/trip_history" style={{ textDecoration: 'none' }}><button>Trip History</button></Link></p>
                            </div>
                        </div>

                        <div className='setTrip'>
                           <div className='avilabel_trips' >
                                {total[0].map(item => (
                                    <>

                                        <p><lable>Plate Number : <b>{item.planeNumber}</b></lable></p>
                                        <p><lable>Assigned Driver : <b>{item.assignedDriver}</b></lable></p>
                                        <p><lable>Vehicle Name : <b>{item.vehicleName}</b></lable></p>
                                        <p><lable>Current Location : <b>{item.location}</b></lable></p>
                                    </>
                                ))}
                            </div>
                            <div className='set_history'>
                                <p> <Link to="/set_trip" style={{ textDecoration: 'none' }}><button>Set Trip</button></Link></p>
                                <p> <Link to="/trip_history" style={{ textDecoration: 'none' }}><button>Trip History</button></Link></p>
                            </div>
                        </div> */}
                            {/* <div className='company_button'>
                            <button className='add'>Add</button>
                        </div> */}
                        </div>
                    </form>
                </section>


                {/* ---------------end contents--------------- */}


            </div>

        )
    }
