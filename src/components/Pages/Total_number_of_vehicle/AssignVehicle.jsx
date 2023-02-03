import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { FaParking } from "react-icons/fa";
import { GrSettingsOption } from "react-icons/gr";
import { IoSettingsOutline } from "react-icons/io5";
import './total_no_of_vehicle.css';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import { total } from './data/jsonData';
import { on_route } from './data/jsonData';
import { parked } from './data/jsonData';
import { maintenance } from './data/jsonData';
import Header from '../../Header/Header'; 
import Navigation from '../Navigation/Navigation';
import SyncLoader from "react-spinners/SyncLoader";
import { FaStarOfLife } from 'react-icons/fa';
import { setSelectionRange } from '@testing-library/user-event/dist/utils';



export default function () {

    function tableSearch() {

        let input, filter, table, tr, td, txtValue, errors;

        //Intialising Variables
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        for (let i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[1];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }

    const closePopup5 = () => {
        // setPop1(false);
        setPop(false);
    }

    let [active, setActive] = useState("total_vehicle");
    let [state, setState] = useState("false");
    // const color = () => {
    //     setState(state);
    // }
    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }

    const location = useLocation();
    console.log(location.pathname);
    const [color, setColor] = useState("");
    const getColor = (curr) => {
        if (location.pathname === curr) {
            return 'green'
        }
        else {
            return 'white'
        }

    }

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };


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

    // const url2 = "http://198.199.67.201:9090/Api/Vehicle/Owner/Status/maintaining";
    // const [dataSource2, setDataSource2] = useState([])
    // useEffect(() => {
    //     setLoading(true);
    //     fetch(url2, options)
    //         .then(respnse => respnse.json())
    //         .then(data => {
    //             setDataSource2(data.maintainingList)
    //             console.log(dataSource2)
    //             setLoading(false);

    //         })
    // }, [])

    // const url3 = "http://198.199.67.201:9090/Api/Vehicle/Owner/Status/inroute";
    // const [dataSource3, setDataSource3] = useState([])setLicenseNumber
    // useEffect(() => {
    //     setLoading(true);
    //     fetch(url3, options)
    //         .then(respnse => respnse.json())
    //         .then(data => {
    //             setDataSource3(data.inRoutelist)
    //             console.log(dataSource3)
    //             setLoading(false);

    //         })
    // }, [])

    // const url4 = "http://198.199.67.201:9090/Api/Vehicle/Owner/Status/stocked";
    // const [dataSource4, setDataSource4] = useState([])
    // useEffect(() => {
    //     setLoading(true);
    //     fetch(url4, options)
    //         .then(respnse => respnse.json())
    //         .then(data => {
    //             setDataSource4(data.stockedList)
    //             console.log(dataSource4)
    //             setLoading(false);

    //         })
    // }, [])
    const [LicenseNumber, setLicenseNumber] = useState();

    return (

        <div className="vehicle_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/Total_number_of_vehicle"></Navigation>

            {/* --------------- header --------------- */}

            <Header title="Total Vehicles"></Header>

            {/* --------------- users --------------- */}

            <div className='main_content'>
                {/* <div className='vehicle_contents'>
                    <Link to="/UserTotal_number_of_vehicle" style={{ textDecoration: 'none' }}> <div className='activeNav '>
                        <h4>Total Vehicle</h4>
                        <p><AiFillCar size="2.3rem"></AiFillCar><b>{dataSource.length}</b></p>

                    </div></Link>

                    <Link style={{ textDecoration: 'none' }} to="/Useron_route"><div className='on_route'>
                        <h4>On Route</h4>
                        <p><FaRoute size="2.2rem" ></FaRoute><b>{dataSource.length}</b></p>
                    </div></Link>

                    <Link style={{ textDecoration: 'none' }} to="/Useron_stock">
                        <div className='parked'>
                            <h4>On Stock</h4>
                            <p><FaParking size="2rem" ></FaParking><b>{dataSource.length}</b></p>
                        </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/Usermaintenance">
                        <div className='maintenance'>
                            <h4>Maintenance</h4>
                            <p><IoSettingsOutline size="2rem" ></IoSettingsOutline><b>{dataSource.length}</b></p>
                        </div>

                    </Link>
                </div> */}

                {/* --------------- search --------------- */}

                <div className='vehicle_search1'style={{marginTop:"70px"}}>
                    <p title='search'>
                        <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>

                {/* --------------------- Table ------------------- */}

                {
                    Loading ?
                        <p className='loading'><SyncLoader
                            // color={color}
                            // Left={margin}
                            loading={Loading}
                            // cssOverride={override}
                            size={10}
                            // margin= "100px 0px 0px 0px"
                            // padding= "200px" 
                            aria-label="Loading Spinner"
                            data-testid="loader"
                        /></p>

                        :

                        <div className='outer_vehicle_tables' id='myTable'>
                            <p>Unassigned Vehicles</p>

                            <table class="vehicle_table" id="myTable">

                                <thead>
                                    <tr>
                                        <th>Profile</th>
                                        <th>Assigned Driver</th>
                                        <th>Vehicle ID</th>
                                        <th>Vehicle Type</th>
                                        <th>Plate Number</th>
                                        <th>Detail</th>
                                        {/* <th>Status</th> */}
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
                                            <td>
                                            <Link to={`/AssignDriver/${item.plateNumber}`}><button>Assaign</button></Link>

                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                }
                {/* <div className='addMangeAssign'>
                    <button> Add Driver</button>
                    <button> Manage Driver</button>
                    <button onClick={() => { handleClickopen() }}> Assigne Driver</button>
                </div> */}

                {popup ?
                    <div>
                        <div className='popup3'>
                            <div className='popup-inner'>
                                <lable className="zxc">Add Vehicle</lable>
                                <div className='ewq'>
                                    <button className='close-btn' onClick={closePopup5}>X</button>
                                    {/* <div className='vehicle_search2'>
                                        <p title='search'>
                                            <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                                            <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                                            <button>Search</button>
                                        </p>
                                    </div> */}


                                    <div className='outer_vehicle_tables' id='myTable'>
                                        <lable>Add Vehicle</lable>
                                        <input value={LicenseNumber}></input>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div> : ""}

            </div>
        </div >
    )
}
