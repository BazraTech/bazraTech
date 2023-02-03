import React from 'react'
import './available.css';
import { Link } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { useForm } from 'react-hook-form';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import { total } from './data/data';
import { BsPlusLg } from "react-icons/bs";
import { AiOutlineMinus } from "react-icons/ai";


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

    const [popup, setPop] = useState(false);
    const [state, setState] = useState("");
    const handleClickopen = () => {
        setPop(!popup);
    }

    const [search, setSearch] = useState('');
    const [popup1, setPop1] = useState(true);

    const url = "http://198.199.67.201:9090/Api/Vehicle/Owner/All";
    const [dataSource, setDataSource] = useState([])
    const [Loading, setLoading] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.vehicles)
                console.log(dataSource)
                setLoading(false);

            })
    }, [])

    const [visiblelist, setvisiblelist] = useState(false);
    const [visible, setVisible] = useState(true);

    // let url2;

    const displaylist = () => {

        setVisible2();
    }
    const setVisible2 = () => {
        setVisible(!visible);
    }


    return (

        <div className="dashboard_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/avialable_trip"></Navigation>

            {/* ---------------header--------------- */}

            <Header title="Avialable Cars"></Header>


            {/* ---------------contents--------------- */}

            <section className='register'>

                <div className='company_individual_header'>
                    <Link style={{ textDecoration: 'none' }} to="/avialable_trip"><p><h1 className='nmn'>Avialable Vehicles</h1></p></Link>
                    <Link style={{ textDecoration: 'none' }} to="/trip_history"><p><h1 className='nmnn'>Vehicles History</h1></p></Link>
                </div>

                <form className='form' onSubmit={handleSubmit(onSubmit)}>
                    <div className='allDiv'>
                        <div>
                            <>
                                <div className='companyList'>
                                    <p>Company Name : <b className='green'>Bazra</b></p>
                                    <p>Number of Vehicles : <b className='green'>18</b></p>
                                    <p className='dropdownVehicle'> <AiOutlineMinus top="10px" size="1rem" color='White'></AiOutlineMinus></p>

                                </div>
                                <>
                                    <div className='trip_date'>
                                        <input onChange={(e) => setSearch(e.target.value)} placeholder='Search...' className='trip_date1' type="search" /><button>Search</button>
                                    </div>
                                    <div className='outer_vehicle_tables' id='myTable'>
                                        <p>Avaliable Vehicles for Trip</p>

                                        <table class="vehicle_table" id="myTable">

                                            <thead>
                                                <tr>
                                                    <th>Vehicle Name</th>
                                                    <th>Assigned Driver</th>
                                                    <th>Current Location</th>
                                                    <th>Vehicle Type</th>
                                                    <th>Plate Number</th>
                                                    <th>Set Trip</th>
                                                    <th>Available</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {dataSource.map(item => (
                                                    <tr className='active_row'>

                                                        <td>{item.vehicleName}</td>
                                                        <td>{item.driver == null ? "unassignd" : `${item.driver.driverName}`}</td>
                                                        <td>{item.id}</td>
                                                        <td>{item.vehicleCatagory.catagory}</td>
                                                        <td>{item.plateNumber}</td>
                                                        <td><Link to={`/set_trip/${item.plateNumber}/${item.driver == null ? "unassignd" : `${item.driver.driverName}`}`}><button>Set Trip</button></Link></td>
                                                        <td onClick={() => {
                                                            displaylist()
                                                            setvisiblelist(item.id)
                                                        }}><lable className={visible && item.id == visiblelist ? "mangProfileButton2" : "mangProfileButton"}>{visible && item.id == visiblelist ? "Cancle" : "Available"}</lable></td>
                                                    </tr>
                                                ))}
                                            </tbody>
                                        </table>

                                    </div></>
                            </>

                        </div>
                    </div>
                </form>
            </section>


            {/* ---------------end contents--------------- */}


        </div>

    )
}
