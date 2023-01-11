import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { RiGpsFill } from "react-icons/ri";
import { FaUsers } from "react-icons/fa";
import { HiBellAlert } from "react-icons/hi2";
import { HiDocumentReport } from "react-icons/hi";
import { FaRegIdCard } from 'react-icons/fa';
import { BsFillChatDotsFill } from "react-icons/bs";
import { FaUserAlt } from "react-icons/fa";
import { AiFillSetting } from "react-icons/ai";
import { FiLogOut } from "react-icons/fi";
import { FaStarOfLife } from 'react-icons/fa';
import './company_registration.css';
import { useForm } from 'react-hook-form';
import { Link, NavLink } from 'react-router-dom';
import { HiMenuAlt1 } from "react-icons/hi";
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import { useState, useEffect } from 'react';

import swal from "sweetalert";
import Header from '../../Header/Header';

export default function Individual_registration() {


    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

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


    // const [companyName, setCompanyName] = useState("");
    // const [companyType, setCompantType] = useState("");
    // const [companySector, setCompanySector] = useState("");
    const [region, setRegion] = useState("");
    const [city, setCity] = useState("");
    const [subCity, setSubCity] = useState("");
    const [woreda, setWoreda] = useState("");
    const [specificLocation, setSpecficLocation] = useState("");
    const [houseNumber, setHouseNumber] = useState("");
    const [phoneNumber, setPhonenumber] = useState("");
    const [firstName, setFirstName] = useState("");
    const [lastName, setLastname] = useState("");
    const [ownerPhoneNumber, setPhoneNumber2] = useState("");
    const [email, setEmail] = useState("");
    const [notificationmedia, setNotificationPreference] = useState("");
    const [serviceRequired, setServiceNeeded] = useState("");
    const [vehicleName, setvehicleName] = useState("");
    const [catagory, setVehicleCategory] = useState("");
    const [conditionName, setVehicleCondition] = useState("");
    const [plateNumber, setPlateNumber] = useState("");
    // const [plate_number2, setPlateNumber2] = useState("");
    // const [plate_number3, setPlateNumber3] = useState("");
    const [manufactureDate, setmanufactureDate] = useState("");
    const [deviceID, setdeviceId] = useState("");

    const handleClick = (e) => {
        signupxx();
    };

    useEffect(() => {

    }, []);



    async function signupxx() {

        let item =
        {
            // companyName,
            // companyType,
            // companySector,
            region,
            city,
            subCity,
            woreda,
            specificLocation,
            houseNumber,
            phoneNumber,
            firstName,
            lastName,
            ownerPhoneNumber,
            email,
            notificationmedia,
            serviceRequired,

            vehicles: [
                {
                    vehicleName,
                    vehicleCatagory: {
                        catagory,
                    },
                    vehicleCondition: {
                        conditionName,
                    },

                    plateNumber,
                },

            ]

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
        const url = "http://198.199.67.201:9090/Api/Company/CreateCompany";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful", "Individual Regigisterd Successfuly", "success", {
                    buttons: false,
                    timer: 2000,
                });

            } else {
                console.log("failed");
                swal(`Failed To Register ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }



    // const user = JSON.parse(   localStorage.getItem('user'));

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };

    const url = "http://198.199.67.201:9090/Api/Admin/All/CompanySector/";

    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.companySectors)
                console.log(dataSource)
            })
    }, [])

    const urlTwo = " http://198.199.67.201:9090/Api/Admin/All/NotificationMedium";
    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        fetch(urlTwo, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.notificationMedias)
                console.log(dataSource2)
            })
    }, [])

    const urlthree = "http://198.199.67.201:9090/Api/Admin/All/VehicleCatagory";
    const [dataSource3, setDataSource3] = useState([])
    useEffect(() => {
        fetch(urlthree, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.vehicleCatagories)
                console.log(dataSource3)
            })
    }, [])

    const urlFour = "http://198.199.67.201:9090/Api/Admin/All/VehicleCondition";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        fetch(urlFour, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data.vehicleConditions)
                console.log(dataSource4)
            })
    }, [])

    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }




    {/*------------------ Validation for company registration ----------------- */ }

    {/*---------------- handle events ----------------- */ }
    // const { register, handleSubmit, watch, formState: { errors } } = useForm();

    {/*---------------- handle submit values ----------------- */ }
    // const onSubmit = data => console.log(data);

    return ( 
        <div className="company_container">

            {/*--------------- Company Container ---------------*/}

            <div className="dashboard_navigation">
                <ul>
                    <li>
                        <Link to="/dashboard">
                            <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Total_number_of_vehicle">
                            <p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/tracking">
                            <p class="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" color='white'></RiGpsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/avialable_trip">
                            <p className="hovertext" data-hover="Trip Management"><BiTrip color='white' size="2rem" ></BiTrip></p>
                        </Link>
                    </li>
                    {/* <li>
                        <Link to="/users">
                            <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='white'></FaUsers></p>
                        </Link>
                    </li> */}
                    <li>
                        <Link to="/accident">
                            <p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/report">
                            <p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p>
                        </Link>
                    </li>
                    {/* <li>
                        <Link to="/Company_registration">
                            <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='#00cc44'></FaRegIdCard></p>
                        </Link>
                    </li> */}
                    <li>
                        <Link to="/message_overview">
                            <p class="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Useruser_edit">
                            <p className="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                        </Link>
                    </li>
                    {/* <li>
                        <Link to="/settings">
                            <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                        </Link>
                    </li> */}
                </ul>
            </div>


            {/* --------------- Company header --------------- */}

            <Header title="Registation"></Header>


            {/* --------------- Registration- -------------- */}

            <section className='register'>

                <div className='company_individual_header'>
                    <p className='llll'><NavLink to="/Company_registration"><h1>Company</h1></NavLink></p>
                    <p><NavLink to="/individual"><h1 className='nmn'>Individual</h1></NavLink></p>
                </div>

                <form className='form' onSubmit={handleSubmit(onSubmit)}>

                    {/* --------------- Company information- -------------- */}

                    {/* --------------- Company Address- -------------- */}
                    <div className='allDiv'>
                        <div className='first_div'>
                            <h1>Owuner Information</h1>
                            <div className='company_Address1'>
                            <div>
                                    <p>First Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='firstName' type="text" value={firstName}
                                        {...register("firstName", { required: true })}
                                        placeholder='Enter Your first name'
                                        onChange={(e) => setFirstName(e.target.value)}>
                                    </input>
                                    {firstName <= 0 && errors.firstName?.type === "required" && <span className='validate_text'>*please enter your name</span>}
                                </div>
                                <div>
                                    <p>Last Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='lastName' type="text" value={lastName}
                                        {...register("lastName", { required: true })}
                                        placeholder='Enter Your last name'
                                        onChange={(e) => setLastname(e.target.value)}>
                                    </input>
                                    {lastName <= 0 && errors.lastName?.type === "required" && <span className='validate_text'>*please enter your last name</span>}
                                </div>
                                <div>
                                    <p>Phone Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='ownerPhoneNumber' type="text" value={ownerPhoneNumber}
                                        {...register("ownerPhoneNumber", { required: "*please fill your mobile nuber" })}
                                        placeholder='Enter Phone Number'
                                        onChange={(e) => setPhoneNumber2(e.target.value)}>
                                    </input>
                                    {ownerPhoneNumber <= 0 && errors.ownerPhoneNumber && <span className='validate_text'>{errors.ownerPhoneNumber.message}</span>}
                                </div>
                                <div>
                                    <p>Email <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='email' type="email" value={email}
                                        {...register("email", {
                                            required: "*please enter your email address",
                                            pattern: { value: /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/, message: 'Please fill a valid Email' }
                                        })}
                                        placeholder='Enter your Email'
                                        onChange={(e) => setEmail(e.target.value)}>
                                    </input>
                                    {email <= 0 && errors.email && <span className='validate_text'>{errors.email.message}</span>}
                                </div>

                                <div>
                                    <p>Region <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='region' value={region}
                                        {...register("region", { required: '*please fill your Region' })}
                                        placeholder="Please enter your Region"
                                        onChange={(e) => setRegion(e.target.value)}>
                                    </input>
                                    {region <= 0 && errors.region && <span className='validate_text'>{errors.region.message}</span>}
                                </div>

                                <div>
                                    <p>Sub City <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='subCity' value={subCity}
                                        {...register("subCity", { required: '*please fill your Sub-city' })}
                                        placeholder="Please enter your Sub-city"
                                        onChange={(e) => setSubCity(e.target.value)}>
                                    </input>
                                    {subCity <= 0 && errors.subCity && <span className='validate_text'>{errors.subCity.message}</span>}
                                </div>


                                <div>
                                    <p>Specfic Location <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='specificLocation' value={specificLocation}
                                        {...register("specificLocation", { required: '*please fill your Specfic Location' })}
                                        placeholder="Please enter your Specfic Location"
                                        onChange={(e) => setSpecficLocation(e.target.value)}>
                                    </input>
                                    {specificLocation <= 0 && errors.specificLocation && <span className='validate_text'>{errors.specificLocation.message}</span>}
                                </div>

                                <div>
                                    <p>City <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='city' value={city}
                                        {...register("city", { required: '*please fill your City' })}
                                        placeholder="Please enter your City"
                                        onChange={(e) => setCity(e.target.value)}>
                                    </input>
                                    {city <= 0 && errors.city && <span className='validate_text'>{errors.city.message}</span>}
                                </div>

                                <div>
                                    <p>Woreda <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='woreda' type="text" value={woreda}
                                        {...register("woreda", {
                                            required: "*please fill your Woreda",
                                            pattern: { value: /^[0-9]+[0-9]*$/, message: 'please enter a vaild number' }
                                        })}
                                        placeholder='Enter Your Woreda'
                                        onChange={(e) => setWoreda(e.target.value)}>
                                    </input>
                                    {woreda <= 0 && errors.woreda && <span className='validate_text'>{errors.woreda.message}</span>}
                                </div>

                                <div>
                                    <p>House Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='houseNumber' type="text" value={houseNumber}
                                        {...register("houseNumber", {
                                            required: "*please fill your house number",
                                            pattern: { value: /^[0-9]+[0-9]*$/, message: 'please enter a vaild number' }
                                        })}
                                        placeholder='Enter House Number'
                                        onChange={(e) => setHouseNumber(e.target.value)}>
                                    </input>
                                    {houseNumber <= 0 && errors.houseNumber && <span className='validate_text'>{errors.houseNumber.message}</span>}
                                </div>

                            </div>
                        </div>

                        {/* --------------- Owner information- -------------- */}


                        <div className='Third_div'>
                            <h1>Additional Information</h1>
                            <div className='additional_information1'>
                                <div>
                                    <p>Notification Pereference <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <select
                                        name='notificationmedia'
                                        value={notificationmedia}
                                        {...register("notificationmedia", { required: '*please choose your notification preference' })}
                                        onChange={(e) => setNotificationPreference(e.target.value)}>
                                        <option selected disabled value="">Please Notification preference</option>
                                        {
                                            dataSource2.map(item2 => {
                                                return <option >{item2.medium}</option>
                                            })
                                        }
                                    </select>
                                    {notificationmedia <= 0 && errors.notificationmedia && <span className='validate_text'>{errors.notificationmedia.message}</span>}
                                </div>

                                <div>
                                    <p>Service Neded <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <select
                                        value={serviceRequired}
                                        name='serviceRequired'
                                        {...register("serviceRequired", { required: '*please choose service needed' })}
                                        onChange={(e) => setServiceNeeded(e.target.value)} >
                                        <option selected disabled value="j">Select Service Needed</option>
                                        <option>Trucking</option>
                                        <option>Trucking and Marketing</option>
                                    </select>
                                    {serviceRequired <= 0 && errors.serviceRequired && <span className='validate_text'>{errors.serviceRequired.message}</span>}
                                </div>
                            </div>
                        </div>

                        <div className='second_div'>
                            <div className='registerd_vehiclel'><h1>Vehicle Information</h1></div>
                            <div className='vehicle_information1'>
                                <div>
                                    <p>Vehicle Catagory <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <select
                                        {...register("catagory", { required: '*Vehicle catagoty  is required' })}
                                        name="catagory"
                                        value={catagory}
                                        onChange={(e) => setVehicleCategory(e.target.value)} >
                                        <option selected disabled value="">Select Vecicle Catagory</option>
                                        {
                                            dataSource3.map(item => {
                                                return <option >{item.catagory}</option>
                                            })
                                        }
                                    </select>
                                    {catagory <= 0 && errors.catagory && <span className='validate_text'>{errors.catagory.message}</span>}
                                </div>

                                <div>
                                    <p>Vehicle Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='vehicleName' type="text" value={vehicleName}
                                        {...register("vehicleName", { required: true })}
                                        placeholder='Enter Vehicle Name'
                                        onChange={(e) => setvehicleName(e.target.value)} ></input>
                                    {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                                </div>

                                <div>
                                    <p>Vehicle Condition <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <select className='select' value={conditionName} name='conditionName'

                                        {...register("conditionName", { required: '*Vecicle Condition is required' })}
                                        onChange={(e) => setVehicleCondition(e.target.value)} >
                                        <option selected disabled value="">Select Vecicle Condition</option>
                                        {
                                            dataSource4.map(item => {
                                                return <option>{item.conditionName}</option>
                                            })
                                        }
                                    </select>
                                    {conditionName <= 0 && errors.conditionName && <span className='validate_text'>{errors.conditionName.message}</span>}
                                </div>

                                <div>
                                    <p>Plate Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <div className='plate_numbera'>
                                        <input placeholder='Please Enter Plate Number'
                                            value={plateNumber} name='conditionName'
                                            {...register("plateNumber", { required: '*please choose service needed' })}
                                            onChange={(e) => setPlateNumber(e.target.value)} >
                                        </input>
                                        {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                                    </div>

                                </div>

                                <div>
                                    <p>Manufacture Date <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='manufacture_date' type="date" value={manufactureDate}
                                        {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                        placeholder='Enter Manufactureing Date'
                                        onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                                    {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                                </div>
                                <div>
                                    <p>Device ID <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='deviceID' type="text" value={deviceID}
                                        {...register("deviceID", { required: '*Device ID is required' })}
                                        placeholder='Enter Device ID'
                                        onChange={(e) => setdeviceId(e.target.value)} ></input>
                                    {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                                </div>
                            </div>
                        </div>
                        <div className='company_button'>
                            <button className='add'>Register</button>
                        </div>
                    </div>

                </form>

            </section>


            {/* ---------------end Registaration--------------- */}
        </div>
    )
}