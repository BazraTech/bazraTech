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
import { Link, NavLink, useParams } from 'react-router-dom';
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
import swal from "sweetalert";
import { useForm } from 'react-hook-form';



export default function () {

    const { plateNumber } = useParams()

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

    const url = "http://198.199.67.201:9090/Api/Vehicle/Owner/Drivers/All";
    const [dataSource, setDataSource] = useState([])
    const [Loading, setLoading] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.drivers)
                console.log(dataSource)
                setLoading(false);

            })
    }, [])


    const [LicenseNumber, setLicenseNumber] = useState();

    const driver = LicenseNumber;
    console.log(LicenseNumber);

    const {
        register,
        handleSubmit,
        watch,
        formState: { errors },
    } = useForm();
    const onSubmit = (data) => {
        console.log(data);
        handleClick();
    };
    async function handleClick() {

        let item =
        {
            plateNumber,
            driver,
        };

        const options = {
            method: "POST",
            headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json",
                "Authorization": `Bearer ${jwt}`
            },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Vehicle/AssignDriver";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful", `${mess}`, "success", {
                    buttons: false,
                    timer: 3000,
                }).then((value) => { 
                    // window.location.href = "/AssignDriver";
                    setPop(!popup);
                }).finally(() => {
                    // setLoading(false) 
                });
            } else {
                // setLoading(false)
                console.log("failed");
                swal("Failed", "Wrong Password or Email Address", "error");
            }
        } catch (error) {
            console.log(error + "error");
            swal({
                title: "Something Went Wrong?",
                text: `net::ERR_INTERNET_DISCONNECTED `,
                icon: "warning",
                dangerMode: true,
            })
        }
    }

    return (

        <div className="vehicle_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/Total_Drivers"></Navigation>

            {/* --------------- header --------------- */}

            <Header title="Total Vehicles"></Header>

            {/* --------------- users --------------- */}

            <div className='user'>
                

                <div className='vehicle_search' style={{marginTop:"70px"}}>
                    <p title='search'>
                        <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>

                {/* <div className='vehicle_filter'>
                    <p>
                        <AiFillFilter className='fil' size="0.8rem" color='rgb(63, 63, 63)'></AiFillFilter>
                        <h6>Filter</h6> 
                    </p>
                </div> */}

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
                            <p>Unassigned Driver</p>

                            <table class="vehicle_table" id="myTable">

                                <thead>
                                    <tr>
                                        <th>id</th>
                                        <th>Driver Name</th>
                                        <th>Licence Number</th>
                                        <th>Driver</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {dataSource.map(item => (
                                        <tr className='active_row'>
                                            <td>{item.id}</td>
                                            <td>{item.driverName}</td>
                                            <td>{item.licenseNumber}</td>
                                            <td>
                                                <button onClick={() => {
                                                    handleClickopen()
                                                    setLicenseNumber(item.licenseNumber)
                                                }}>Select</button>
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
                                {/* <lable className="zxc">Assign</lable> */}
                                <div className='ewq'>
                                    <button className='close-btn' onClick={closePopup5}>X</button>
                                    <div>
                                        <form onSubmit={handleSubmit(onSubmit)}>
                                            <div className='assign-detiver'>
                                            <lable className="lable">Assign Driver</lable>
                                            <input value={LicenseNumber}></input>
                                            <input value={plateNumber}></input>
                                            <button>Assign</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div> : ""}

            </div>
        </div >
    )
}
