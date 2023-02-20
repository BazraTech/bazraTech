import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { RiGpsFill } from "react-icons/ri";
import { MdMonitor } from "react-icons/md";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { ImUserTie } from "react-icons/im";
import { FiLogOut } from "react-icons/fi";
import { HiMenuAlt1 } from "react-icons/hi";
import { BiTrip } from "react-icons/bi";
import './setTrip.css';
import { Link, useParams } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { FaStarOfLife } from 'react-icons/fa';
import { useForm } from 'react-hook-form';
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import swal from "sweetalert";

export default function () {

    const { vehicle, driver, companyID } = useParams();
    const {
        register,
        handleSubmit,
        watch,
        formState: { errors },
    } = useForm();

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
    const handleClickopen = () => {
        setPop(!popup);
    }

    const[tripType, setTripType]=useState("");
    const[startLocation, setStartLocation]=useState("");
    const[destination, setDestination]=useState("");
    const[startDate, setStartDate]=useState("");

    const [loading, setLoading] = useState(false)
    const url10 = "http://198.199.67.201:9090/Api/Admin/TripType/All";
    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(url10, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.triptypes)
                // console.log(dataSource4)
                setLoading(false)
            })
    }, [])

    const onSubmit = (data) => {
        console.log(data);
        setTrip()
    };

    async function setTrip() {
        let item =
        {
            vehicle,
            startLocation,
            destination,
            startDate,
            tripType,
        };
        const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api
        const options = {
            method: "POST",
            headers: { 
                'Content-Type': 'application/json',
                "Accept": "application/json",
                "Authorization": `Bearer ${jwt}`
            },
            body: JSON.stringify(item),
        };

        const url = "http://198.199.67.201:9090/Api/Admin/CreateTrip";
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
                    button: true,
                    // timer: 60000,
                });
                setTripType("");
                setStartLocation("");
                setDestination("");
                setStartDate("");

            } else {
                console.log("failed");
                swal(`Failed To Register ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }


    return (
        <div className="dashboard_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/avialable_trip" title="Set Trip"></Navigation>

            {/* ---------------header--------------- */}

            {/* <Header title="Set Trip"></Header> */}

            {/* ---------------contents--------------- */}

            <section className='register'>

                <div className='setTripHeader'>
                    <p ><h1 className='nmn'>Set Trip</h1></p>
                </div>
                <form className='form' onSubmit={handleSubmit(onSubmit)}>
                    <div className='set_allDiv'>

                        <div className='vehicle_information0'>
                            <div>
                                <p>Trip Type <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select name="tripType"
                                    value={tripType}
                                    {...register("tripType", { required: '*Trip type  is required' })}
                                    onChange={(e) => setTripType(e.target.value)} 
                                    >
                                    <option selected disabled value="">Select Trip Type</option>
                                    {
                                        dataSource.map(item => {
                                            return <>
                                                <option>{item.tripType}</option>
                                            </>
                                        })
                                    }
                                </select>
                                {tripType <= 0  && errors.tripType && <span className='validate_text'>{errors.tripType.message}</span>}
                            </div>

                            <div>
                                <p>Vehicle Plate Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input name='vehicleName' type="text"
                                    {...register("vehicleName", { required: true })}
                                    placeholder='Enter Vehicle Plate Number'
                                    value={vehicle}
                                ></input>
                                  {vehicle <= 0  && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle plate number</span>}
                            </div>

                            <div>
                                <p>Driver <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input name='driver' type="text"
                                    {...register("driver", { required: true })}
                                    placeholder='Enter Deriver Name'
                                    value={driver}
                                ></input>
                                 {driver <= 0  && errors.driver?.type === "required" && <span className='validate_text'>*Deriver Is required </span>}
                            </div>

                            <div>
                                <p>Start Location <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <div className='plate_numbera'>
                                    <input placeholder='Please insert Start Location'
                                        name='startLocation'
                                        value={startLocation}
                                        {...register("startLocation", { required: '*please choose service needed' })}
                                        onChange={(e) => setStartLocation(e.target.value)} 
                                    >
                                    </input>
                                    {startLocation <= 0  && errors.startLocation && <span className='validate_text'>{errors.startLocation.message}</span>}
                                </div>

                            </div>

                            <div>
                                <p>Destination<FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <div className='plate_numbera'>
                                    <input placeholder='Please insert Sestination' type="text"
                                        name='destination'
                                        value={destination}
                                        {...register("destination", { required: '*please choose service needed' })}
                                        onChange={(e) => setDestination(e.target.value)} 
                                    >
                                    </input>
                                    {destination <= 0  &&errors.destination && <span className='validate_text'>{errors.destination.message}</span>}
                                </div>
                            </div>

                            <div>
                                <p>Start Date<FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <div className='plate_numbera'>
                                    <input placeholder='Please insert Sestination'  type="date"
                                        name='startDate'
                                        value={startDate}
                                        {...register("startDate", { required: '*please choose service needed' })}
                                        onChange={(e) => setStartDate(e.target.value)} 
                                    >
                                    </input>
                                    {startDate <= 0  && errors.startDate && <span className='validate_text'>{errors.startDate.message}</span>}
                                </div>
                            </div>
                        </div>
                        <div className='company_button'>
                            <button className='add'>Set Trip</button>
                        </div>
                    </div>
                </form>
            </section>


            {/* ---------------end contents--------------- */}


        </div>

    )
}
