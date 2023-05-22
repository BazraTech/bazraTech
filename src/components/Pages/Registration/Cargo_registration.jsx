import React from 'react'
import { FaStarOfLife } from 'react-icons/fa';
import styles from './company_registration.module.css';
import { useForm } from 'react-hook-form';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';
import swal from "sweetalert";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation'; 

// import { TbChevronsUpLeft } from 'react-icons/tb';

export default function Cargo_registration() {
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
    // const history = useNavigate();
    const [companyName, setCompanyName] = useState("");
    const [companyType, setCompantType] = useState("");
    const [companySector, setCompanySector] = useState("");
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
    const [manufactureDate, setmanufactureDate] = useState("");
    const [deviceID, setdeviceId] = useState("");

    const [mess, setMEesaa] = useState("");
    const handleClick = (e) => {
        registerCompany();
    };

    useEffect(() => {
    }, []);

    async function registerCompany() { 
        let item =
        {
            companyName,
            companyType,
            companySector,
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
                    manufactureDate,
                    deviceID,
                },

            ]

        };
        console.log(manufactureDate)

        const options = {
            method: "POST",
            headers: {
                'Content-Type': 'application/json',
                "Accept": "application/json",
                "Authorization": `Bearer ${jwt}`
            },
            body: JSON.stringify(item),
        };
        const url = "http://64.226.104.50:9090/Api/Company/"; 
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"])); 
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successfully Registerd", `${mess}`, "success", {
                    button: true,
                    // timer: 60000,
                });
                setCompanyName("");
                setCompantType("");
                setCompanySector("");
                setRegion("");
                setCity("");
                setSubCity("");
                setWoreda("");
                setSpecficLocation("");
                setHouseNumber("");
                setPhonenumber("");
                setFirstName("");
                setLastname("");
                setPhoneNumber2("");
                setEmail("");
                setNotificationPreference("");
                setServiceNeeded("");
                setvehicleName("");
                setVehicleCategory("");
                setVehicleCondition("");
                setPlateNumber("");
                setmanufactureDate("");
                setdeviceId("");

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

    const url = "http://64.226.104.50:9090/Api/Admin/All/CompanySector/";
    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.companySectors)
                console.log(dataSource)
            })
    }, [])

    const urlTwo = " http://64.226.104.50:9090/Api/Admin/All/NotificationMedium";
    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        fetch(urlTwo, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.notificationMedias)
                console.log(dataSource2)
            })
    }, [])

    const urlthree = "http://64.226.104.50:9090/Api/Admin/All/VehicleCatagory";
    const [dataSource3, setDataSource3] = useState([])
    useEffect(() => {
        fetch(urlthree, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.vehicleCatagories)
                console.log(dataSource3)
            })
    }, [])

    const urlFour = "http://64.226.104.50:9090/Api/Admin/All/VehicleCondition";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        fetch(urlFour, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data.vehicleConditions)
                console.log(dataSource4)
            })
    }, [])

    const urlFive = "http://64.226.104.50:9090/Api/Admin/All/Services";
    const [dataSource5, setDataSource5] = useState([])
    useEffect(() => {
        fetch(urlFive, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource5(data.service)
                console.log(dataSource4)
            })
    }, [])

    const url5 = "http://64.226.104.50:9090/Api/Admin/All/CompanyType/";
    const [dataSourc6, setDataSource6] = useState([])
    useEffect(() => {
        fetch(url5, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource6(data.companyTypes)
                console.log(dataSource)
            })
    }, [])

    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }

    const user = JSON.parse(localStorage.getItem("user"));
    const [logout, setLogout] = useState(false);
    const handleLogout = () => {
        setLogout(!logout);
    }
    useEffect(() => {
        if (!localStorage.getItem("jwt")) {
            window.location.href = "/";
        }
    }, [])


    return (
        <div className="company_container">

            {/*--------------- Company Container ---------------*/}

            <Navigation path="/Cargo_registration" title="Registation"></Navigation>

            {/* --------------- Registration- -------------- */}

            <section className={styles.main_content}>

                <div className={styles.company_individual_header}>
                    <p ><Link style={{ textDecoration: 'none' }} to="/Company_registration"><h1 >Company</h1></Link></p>
                    <p><Link style={{ textDecoration: 'none' }} to="/individual"><h1>Individual</h1></Link></p>
                    <p ><Link style={{ textDecoration: 'none' }} to="/Cargo_registration"><h1 className={styles.companyHeader}>Cargo</h1></Link></p>
                </div>

                <form className={styles.form} onSubmit={handleSubmit(onSubmit)}>

                    {/* --------------- Company information- -------------- */}
                    <div className={styles.allDiv}>
                        <div className={styles.first_div}>
                            <h1>Owner Information</h1> 
                            <div className={styles.company_information}>

                                <div>
                                    <p>Name <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input
                                        name='companyName'
                                        value={companyName}
                                        type="text"
                                        {...register("organizationName", { required: true })}
                                        placeholder='Enter organization name'
                                        onChange={(e) => setCompanyName(e.target.value)}>
                                    </input>
                                    {companyName <= 0 && errors.organizationName?.type === "required" && <span className={styles.validate_text}>*please enter the organization name</span>}
                                </div>
                                <div>
                                    <p>Phone <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input
                                        name='companyName'
                                        value={companyName}
                                        type="text"
                                        {...register("organizationName", { required: true })}
                                        placeholder='Enter organization name'
                                        onChange={(e) => setCompanyName(e.target.value)}>
                                    </input>
                                    {companyName <= 0 && errors.organizationName?.type === "required" && <span className={styles.validate_text}>*please enter the organization name</span>}
                                </div>
                                
                            </div>
                        </div>

                        {/* --------------- Company Address- -------------- */}
                        <div className='second_div'> 
                            <h1>Business information</h1>
                            <div className={styles.company_Address}>
                               <div>
                                    <p>Business name <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input
                                        name='companyName'
                                        value={companyName}
                                        type="text"
                                        {...register("organizationName", { required: true })}
                                        placeholder='Enter organization name'
                                        onChange={(e) => setCompanyName(e.target.value)}>
                                    </input>
                                    {companyName <= 0 && errors.organizationName?.type === "required" && <span className={styles.validate_text}>*please enter the organization name</span>}
                                </div>
                                <div>
                                    <p>Sub city <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='specificLocation'
                                        value={specificLocation}
                                        {...register("specificLocation", { required: '*please fill your Specfic Location' })}
                                        placeholder="Please enter your Specfic Location"
                                        onChange={(e) => setSpecficLocation(e.target.value)}>
                                    </input>
                                    {specificLocation <= 0 && errors.specificLocation && <span className={styles.validate_text}>{errors.specificLocation.message}</span>}
                                </div>

                                <div>
                                    <p>Woreda <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='woreda' type="text"
                                        value={woreda}
                                        {...register("woreda", {
                                            required: "*please fill your Woreda",
                                            pattern: { value: /^[0-9]+[0-9]*$/, message: 'please enter a vaild number' }
                                        })}
                                        placeholder='Enter Your Woreda'
                                        onChange={(e) => setWoreda(e.target.value)}>
                                    </input>
                                    {woreda <= 0 && errors.woreda && <span className={styles.validate_text}>{errors.woreda.message}</span>}
                                </div>

                                <div>
                                    <p>House Number <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='houseNumber' type="text"
                                        value={houseNumber}
                                        {...register("houseNumber", {
                                            required: "*please fill your house number",
                                            pattern: { value: /^[0-9]+[0-9]*$/, message: 'please enter a vaild number' }
                                        })}
                                        placeholder='Enter House Number'
                                        onChange={(e) => setHouseNumber(e.target.value)}>
                                    </input>
                                    {houseNumber <= 0 && errors.houseNumber && <span className={styles.validate_text}>{errors.houseNumber.message}</span>}
                                </div>
                                
                            <div>
                                    <p>Specfic Location <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='specificLocation'
                                        value={specificLocation}
                                        {...register("specificLocation", { required: '*please fill your Specfic Location' })}
                                        placeholder="Please enter your Specfic Location"
                                        onChange={(e) => setSpecficLocation(e.target.value)}>
                                    </input>
                                    {specificLocation <= 0 && errors.specificLocation && <span className={styles.validate_text}>{errors.specificLocation.message}</span>}
                            </div>
                            </div>
                            
                           
                        </div>

                        {/* --------------- Owner information- -------------- */}

                        <div className='Third_div'>
                            <h1>Business sector</h1>
                            <div className={styles.owner_information}>
                                <div>
                                    <p>Business  Type <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <select
                                        value={companyType}
                                        name='serviceRequired'
                                        {...register("companyType", { required: '*please choose company type' })}
                                        onChange={(e) => setCompantType(e.target.value)} >
                                        <option selected disabled value="">Select Conmpany Type</option>
                                        {
                                            dataSourc6.map(item => {
                                                return <>
                                                    <option>{item.companyType}</option>
                                                </>
                                            })
                                        }
                                    </select>
                                    {companyType <= 0 && errors.companyType && <span className={styles.validate_text}>{errors.companyType.message}</span>}
                                </div>

                                <div>
                                    <p>Business  Sector <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <select
                                        {...register("companySector", { required: '*Company sector is required' })} name='companySector'
                                        value={companySector}
                                        onChange={(e) => setCompanySector(e.target.value)}>
                                        <option selected disabled value="">Please Select Company Sector Type</option>
                                        {
                                            dataSource.map(item => {
                                                return <>
                                                    <option>{item.sectorName}</option>
                                                </>
                                            })
                                        }
                                    </select>
                                    {companySector <= 0 && errors.companySector && <span className={styles.validate_text}>{errors.companySector.message}</span>}
                                </div>
                                <div>
                                    <p>Business license number  <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='ownerPhoneNumber' type="text"
                                        value={ownerPhoneNumber}
                                        {...register("ownerPhoneNumber", { required: "*please fill your mobile nuber" })}
                                        placeholder='Enter Business license number'
                                        onChange={(e) => setPhoneNumber2(e.target.value)}>
                                    </input>
                                    {ownerPhoneNumber <= 0 && errors.ownerPhoneNumber && <span className={styles.validate_text}>{errors.ownerPhoneNumber.message}</span>}
                                </div>
                                <div>
                                    <p>Tin Number <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='ownerPhoneNumber' type="text"
                                        value={ownerPhoneNumber}
                                        {...register("ownerPhoneNumber", { required: "*please fill your mobile nuber" })}
                                        placeholder='Tin Number '
                                        onChange={(e) => setPhoneNumber2(e.target.value)}>
                                    </input>
                                    {ownerPhoneNumber <= 0 && errors.ownerPhoneNumber && <span className={styles.validate_text}>{errors.ownerPhoneNumber.message}</span>}
                                </div>
                            </div>
                        </div>

                        {/* --------------- aditional information- -------------- */}

                        <div className='Third_div'>
                            <h1>Documents</h1>
                            <div className={styles.additional_information}>
                            <div>
                                    <p>Scanned Tin  <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='ownerPhoneNumber' type="file"
                                        value={ownerPhoneNumber}
                                        {...register("ownerPhoneNumber", { required: "*please fill your mobile nuber" })}
                                        placeholder='Enter Scanned Tin'
                                        onChange={(e) => setPhoneNumber2(e.target.value)}>
                                    </input>
                                    {ownerPhoneNumber <= 0 && errors.ownerPhoneNumber && <span className={styles.validate_text}>{errors.ownerPhoneNumber.message}</span>}
                                </div>

                                <div>
                                    <p>Scanned business license <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='ownerPhoneNumber' type="file"
                                        value={ownerPhoneNumber}
                                        {...register("ownerPhoneNumber", { required: "*please fill your mobile nuber" })}
                                        placeholder='Enter Scanned business license'
                                        onChange={(e) => setPhoneNumber2(e.target.value)}>
                                    </input>
                                    {ownerPhoneNumber <= 0 && errors.ownerPhoneNumber && <span className={styles.validate_text}>{errors.ownerPhoneNumber.message}</span>}
                                </div>
                            </div>
                        </div>


                        {/* --------------- vehicle information- -------------- */}

                        <div className='second_div'>
                            <h1>Agreement</h1>
                            <div className={styles.vehicle_information}>
                                

                                <div>
                                    <p>Agreement scanned document<FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <input name='vehicleName' type="file"
                                        value={vehicleName}
                                        {...register("vehicleName", { required: true })}
                                        placeholder='Enter Vehicle Name'
                                        onChange={(e) => setvehicleName(e.target.value)} ></input>
                                    {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className={styles.validate_text}>*please enter vehicle name</span>}
                                </div>

                                <div>
                                    <p>Payment information <FaStarOfLife style={{marginBottom:"2px"}} className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                    <div className='plate_numbera'>
                                        <input placeholder='Please Enter Plate Number' name='conditionName'
                                            value={plateNumber}
                                            {...register("plateNumber", { required: '*please choose service needed' })}
                                            onChange={(e) => setPlateNumber(e.target.value)} >
                                        </input>
                                        {plateNumber <= 0 && errors.plateNumber && <span className={styles.validate_text}>{errors.plateNumber.message}</span>}
                                    </div>

                                </div>

                               
                            </div>

                        </div>

                        <div className={styles.company_button}>
                            <button className={styles.add}>Register</button>
                        </div>

                    </div>

                </form>

            </section>

            {/* ---------------end Registaration--------------- */}
        </div>
    )
}
