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
import { FiLogOut } from "react-icons/fi";
import { FaWarehouse } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { AiFillCaretDown } from "react-icons/ai";
import { GrFormNext } from "react-icons/gr";
import { GrFormPrevious } from "react-icons/gr";
import { HiMenuAlt1 } from "react-icons/hi";
import { FaStarOfLife } from 'react-icons/fa';
import './users.css';
// import { useState } from 'react';
import { Link, NavLink } from 'react-router-dom';
import { total } from './Data/Data';
import { on_route } from './Data/Data';
import { parked } from './Data/Data';
import { maintenance } from './Data/Data';
import Tables from './Tables';
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import Navigation from '../Navigation/Navigation';
import SyncLoader from "react-spinners/SyncLoader";
import { useForm } from 'react-hook-form';
import swal from "sweetalert";
import { Pagination } from 'antd';
import axios from "axios";


export default function () {

    const { register, handleSubmit, watch, formState: { errors } } = useForm();

    {/*---------------- handle submit values ----------------- */ }

    function tableSearch() {

        let input, filter, table, tr, td, txtValue, errors;
        //Intialising Variables
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        for (let i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[0];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                    // swal("Successful", "Successful Added", "error", {
                    //     buttons: false,
                    //     timer: 2000,
                    //   })
                }
            }
        }
    }

    let [active, setActive] = useState("total_users");
    let [state, setState] = useState("false");
    const color = () => {
        setState(state);
    }
    const closePopup5 = () => {
        setPop1(false);
        setPop(false);
    }


    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };


    const [totalPages, setTotalPage] = useState(1);
    const [dataSource, setDataSource] = useState([])
    const [Loading, setLoading] = useState([])
    const url = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/";
    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.vehicleOwnerINF)
                setTotalPage(data.totalusers)

                console.log(dataSource)
                setLoading(false)
            })
    }, [])


    const [dataSource2, setDataSource2] = useState([])
    const [dataSource02, setDataSource02] = useState([])
    // const [Loading, setLoading] = useState([])
    const url2 = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/Role/owner";
    useEffect(() => {
        setLoading(true)
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.vehicleOwnerINF)
                setDataSource02(data.totalusers)
                // setTotalPage(data.totalusers)
                setLoading(false)
            })
    }, [])

    const [dataSource3, setDataSource3] = useState([])
    // const [Loading, setLoading] = useState([])
    const url3 = "http://198.199.67.201:9090/Api/Admin/All/VehicleOwners/Role/individual";
    useEffect(() => {
        setLoading(true)
        fetch(url3, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.totalusers)
                // setTotalPage(data.totalPages)
                setLoading(false)
            })
    }, [])


    const [popup, setPop] = useState(false);
    const [popup1, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }
    const handleClickopen1 = () => {
        setPop1(!popup1);
    }
    const [list, setList] = useState([dataSource]);
    const [total, setTotal] = useState(dataSource.length);
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(5);
    const indexOfLastPage = page * postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = dataSource2.slice(indexOfFirstPage, indexOfLastPage);

    const [vehicleName, setvehicleName] = useState("");
    const [vehicleCatagory, setVehicleCategory] = useState("");
    const [vehicleCondition, setVehicleCondition] = useState("");
    const [plateNumber, setPlateNumber] = useState("");
    const [manufactureDate, setmanufactureDate] = useState("");
    const [deviceID, setdeviceId] = useState("");
    const [ownerPhone, setOwnerPhone] = useState();

    const [error, setError] = useState(false);
    const [error1, setError1] = useState(false);
    console.log(ownerPhone);

    const handlechange = (e) => {
        console.log(e.target.files)
    }

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }

    const urlthree = "http://198.199.67.201:9090/Api/Admin/All/VehicleCatagory";
    const [dataSource5, setDataSource5] = useState([])
    useEffect(() => {
        fetch(urlthree, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource5(data.vehicleCatagories)
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

    const onSubmit = (data) => {
        console.log(data);
        Addvehicle();
    };


    // const handleClick = (e) => {
    //     Addvehicle();
    // };

    useEffect(() => {
    }, []);

    async function Addvehicle() {
        let item =
        {
            vehicleName,
            vehicleCatagory,
            vehicleCondition,
            plateNumber,
            manufactureDate,
            deviceID,
            ownerPhone,
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
        const url = "http://198.199.67.201:9090/Api/Vehicle/AddVehicle";
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
                    timer: 2000,
                });
                // companyName = ''
                setvehicleName("");
                setVehicleCategory("");
                setVehicleCondition("");
                setPlateNumber("");
                setmanufactureDate("");
                setdeviceId("")

            } else {
                console.log("failed");
                swal(`Failed To Register ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    const onSubmit2 = (data) => {
        console.log(data);
        AddDriver();
    };

    const [driverName, setDriverName] = useState("");
    const [licenseNumber, setLicenseNumber] = useState("");
    const [licensePic, SetTinCertificate] = useState("");
    const [driverPic, setTreadCertificate] = useState();
    const [imgData, setImgData] = useState(null);
    const [selectedFile, setSelectedFile] = useState();

    async function AddDriver() {
        const formData = new FormData();
        formData.append("driverName ", driverName)
        formData.append("licenseNumber", licenseNumber);
        formData.append("licensePic", licensePic);
        formData.append("driverPic", driverPic);
        formData.append("ownerPhone", ownerPhone)
        formData.append("file", selectedFile);
        console.log(formData)

        axios.post("http://198.199.67.201:9090/Api/Driver/AddDriver", formData, {
            headers: {
                'Content-Type': 'Auto',
                "Authorization": `Bearer ${jwt}`,
            }
        })
            .then((res) => {
                localStorage.setItem("message", JSON.stringify(res["message"]));
                const mess = localStorage.getItem("message");
                console.log(res);
                swal("Error", "Driver Successfuliy Registerd", "success", {
                    button: true,

                })

                setDriverName("");
                setLicenseNumber("");
                SetTinCertificate("");
                setTreadCertificate();
                setImgData(null);
                setSelectedFile();
            })
            .catch(function (error) {
                if (error.response) {
                    // Request made and server responded
                    localStorage.setItem('message', JSON.stringify(error.response.data['message']))
                    const messx = localStorage.getItem('message')
                    console.log('message', messx)
                    console.log(error.response.data);
                    swal("Error", `${messx}`, "error", {
                        button: true,

                    })
                    console.log(error.response.status);
                    console.log(error.response.headers);
                } else if (error.request) {
                    // The request was made but no response was received
                    console.log(error.request);
                } else {
                    // Something happened in setting up the request that triggered an Error
                    console.log('Error', error.message);
                }

            })
    };

    const FileUploadTinCertificate = (e) => {
        if (e.target.files[0]) {
            console.log("fileImage: ", e.target.files);
            SetTinCertificate(e.target.files[0]);
            const reader = new FileReader();
            reader.addEventListener("load", () => {
                setImgData(reader.result);
            });
            reader.readAsDataURL(e.target.files[0]);
        }
        if (e.target.files.length > 0) {
            setSelectedFile(e.target.files[0]);
        }
    };
    const FileUploadTreadCertificate = (e) => {
        if (e.target.files[0]) {
            console.log("fileID: ", e.target.files);
            setTreadCertificate(e.target.files[0]);
            const reader = new FileReader();
            reader.addEventListener("load", () => {
                setImgData(reader.result);
            });
            reader.readAsDataURL(e.target.files[0]);
        }
        if (e.target.files.length > 0) {
            setSelectedFile(e.target.files[0]);
        }
    };

    return (

        <div className="containerr">

            {/*---------------navigation---------------*/}
            <Navigation path="/users"></Navigation>

            {/* --------------- header --------------- */}

            <Header title="Users"></Header>

            {/* --------------- users --------------- */}

            <div className='user'>
                <div className='contents'>
                    <Link style={{ textDecoration: 'none' }} to="/users">
                        <div className='individual' onClick={() => setActive("total_users")}>
                            <h4>Total Users</h4>
                            <p><FaUsers size="2.2rem"></FaUsers><b>{dataSource.length}</b></p>
                        </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/company">
                        <div className='activeNav2' onClick={() => setActive("company")}>
                            <h4>Company</h4>
                            <p><FaWarehouse size="2.2rem" ></FaWarehouse><b>{dataSource02}</b></p>
                        </div>
                    </Link>
                    <Link style={{ textDecoration: 'none' }} to="/register_individual">
                        <div className='individual' onClick={() => setActive("individual")}>
                            <h4>Individual</h4>
                            <p><FaUserAlt size="2rem"></FaUserAlt><b>{dataSource3}</b></p>
                        </div>
                    </Link>
                </div>

                {/* --------------- search --------------- */}
                <div className='users_search'>
                    <p>
                        <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>

                {/* <div className='filter'>
                    <p> 
                        <AiFillFilter className='fil' size="0.8rem" color='rgb(63, 63, 63)'></AiFillFilter>
                        <h6>Filter</h6> 
                    </p>
                </div> */}

                {/* --------------------- Table ------------------- */}
                <div>
                    <>
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
                                    <p>Total</p>

                                    <table class="vehicle_table" id="myTable">
                                        <thead>
                                            <tr>
                                                <th>UserName</th>
                                                {/* <th>Company ID</th> */}
                                                <th>Role</th>
                                                <th>Total Vehicle</th>
                                                <th>Total Driver</th>
                                                <th>Status</th>
                                                <th>Detail</th>
                                                <th>Add Vehicle</th>
                                                <th>Add Driver</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {currentPage.map(item => (
                                                <tr className='active_row'>
                                                    {/* <td></td> */}
                                                    <td>{item.role == "OWNER" ? `${item.companyName}` : `${item.firstName}` + " " + `${item.lastName}`}</td>
                                                    <td>{item.role}</td>
                                                    <td>{item.totalVehicles}</td>
                                                    <td>{item.totalDrivers}</td>
                                                    <td>{item.serviceNeeded}</td>
                                                    <td><Link to={`/user_edit/${item.role}/${item.id}/${item.companyId}`}>
                                                        <button>Detail</button></Link></td>
                                                    <td><Link to="#">
                                                        <button onClick={() => {
                                                            handleClickopen()
                                                            setOwnerPhone(item.phoneNumber)
                                                        }}>Add</button></Link></td>
                                                    <td><Link to="#"><button onClick={() => {
                                                        handleClickopen1()
                                                        setOwnerPhone(item.phoneNumber)
                                                    }}>Add</button></Link></td>
                                                </tr>
                                            ))}
                                        </tbody>
                                    </table>

                                    <div className='page'>

                                        <Pagination
                                            onChange={(page) => setCurentPage(page)}
                                            pageSize={postPerPage}
                                            current={page}
                                            total={totalPages}
                                            showQuickJumper
                                            showSizeChanger
                                            onShowSizeChange={onShowSizeChange}
                                        />

                                        <form onSubmit={handleSubmit(onSubmit)}>
                                            {popup ?
                                                <div>
                                                    <div className='popup3'>
                                                        <div className='popup-inner'>
                                                            <lable className="zxc">Add Vehicle</lable>
                                                            <div className='ewq'>
                                                                <div className='qwe'>
                                                                    <div className='asd'>
                                                                        <button className='close-btn' onClick={closePopup5}>X</button>
                                                                        <lable>Vehicle Catagory <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></lable>
                                                                        <select className='select' placeholder='Select Vecicle Catagory'
                                                                            {...register("vehicleCatagory", { required: '*Vehicle catagoty  is required' })}
                                                                            name="vehicleCatagory"
                                                                            value={vehicleCatagory}
                                                                            onChange={(e) => setVehicleCategory(e.target.value)} >
                                                                            <option selected disabled value="">Select Vecicle Catagory</option>
                                                                            {
                                                                                dataSource5.map(item => {
                                                                                    return <option >{item.catagory}</option>
                                                                                })
                                                                            }
                                                                        </select>
                                                                        {vehicleCatagory <= 0 && errors.vehicleCatagory && <span className='validate_text'>{errors.vehicleCatagory.message}</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Vehicle Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></lable>
                                                                        <input name='vehicleName' type="text"
                                                                            value={vehicleName}
                                                                            {...register("vehicleName", { required: true })}
                                                                            placeholder='Enter Vehicle Name'
                                                                            onChange={(e) => setvehicleName(e.target.value)} ></input>
                                                                        {vehicleName <= 0 && errors.vehicleName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Vehicle Condition <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></lable>
                                                                        <select className='select' name='conditionName'
                                                                            value={vehicleCondition}
                                                                            {...register("vehicleCondition", { required: '*Vecicle Condition is required' })}
                                                                            onChange={(e) => setVehicleCondition(e.target.value)} >
                                                                            <option value="">Select Vecicle Condition</option>
                                                                            {
                                                                                dataSource4.map(item => {
                                                                                    return <option>{item.conditionName}</option>
                                                                                })
                                                                            }
                                                                        </select>
                                                                        {vehicleCondition <= 0 && errors.vehicleCondition && <span className='validate_text'>{errors.vehicleCondition.message}</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Plate Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></lable>
                                                                        <input placeholder='Please Enter Plate Number' name='conditionName'
                                                                            value={plateNumber}
                                                                            {...register("plateNumber", { required: '*please choose service needed' })}
                                                                            onChange={(e) => setPlateNumber(e.target.value)} >
                                                                        </input>
                                                                        {plateNumber <= 0 && errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Manufacture Date <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></lable>
                                                                        <input name='manufacture_date' type="date"
                                                                            value={manufactureDate}
                                                                            {...register("manufactureDate", { required: '*Manufacture date is required' })}
                                                                            placeholder='Enter Manufactureing Date'
                                                                            onChange={(e) => setmanufactureDate(e.target.value)} ></input>
                                                                        {manufactureDate <= 0 && errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Device ID <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></lable>
                                                                        <input name='deviceID' type="text"
                                                                            value={deviceID}
                                                                            {...register("deviceID", { required: '*Device ID is required' })}
                                                                            placeholder='Enter Device ID'
                                                                            onChange={(e) => setdeviceId(e.target.value)} ></input>
                                                                        {deviceID <= 0 && errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                                                                    </div>
                                                                    <div className='asdy'>
                                                                        {/* <button>Back</button> */}
                                                                    </div>
                                                                    <div className='asdy'>
                                                                        <button>Submit </button>
                                                                    </div>
                                                                    <div className='asdy'>
                                                                        {/* <button onClick={() => { handleClickopen2() }}>Add Vehicle</button> */}
                                                                        <button type='reset'>Clear</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> : ""}
                                        </form>

                                        <form onSubmit={handleSubmit(onSubmit2)}>
                                            {popup1 ?
                                                <div>
                                                    <div className='popup3'>
                                                        <div className='popup-inner'>
                                                            <lable className="zxc">Add Driver</lable>
                                                            <div className='ewq'>
                                                                <div className='qwe2'>
                                                                    <div className='asd'>
                                                                        <button className='close-btn' onClick={closePopup5}>X</button>
                                                                        <lable>Full Name</lable>
                                                                        <input name='driverName' type="text"
                                                                            value={driverName}
                                                                            {...register("driverName", { required: '*Driver Name is required' })}
                                                                            placeholder='Enter Vehicle Name'
                                                                            onChange={(e) => setDriverName(e.target.value)} ></input>
                                                                        {driverName <= 0 && errors.driverName && <span className='validate_text'>{errors.driverName.message}</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Gender</lable>
                                                                        <select className='select' name='gender'
                                                                            // value={vehicleCondition}
                                                                            {...register("vehicleCondition", { required: '*Vecicle Condition is required' })}
                                                                        // onChange={(e) => setVehicleCondition(e.target.value)} 
                                                                        >
                                                                            <option value="">Select Gender</option>
                                                                            <option value="male">Male</option>
                                                                            <option value="femail">Femaile</option>
                                                                        </select>
                                                                        {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>License Number</lable>
                                                                        <input name='licenseNumber' type="text"
                                                                            value={licenseNumber}
                                                                            {...register("licenseNumber", { required: '*License Number is required' })}
                                                                            placeholder='Enter Vehicle Name'
                                                                            onChange={(e) => setLicenseNumber(e.target.value)} ></input>
                                                                        {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Driver Licence Picture</lable>
                                                                        <input name='licensePic' type="file"
                                                                            // value={licensePic}
                                                                            {...register("licensePic", { required: '*License Picture is required' })}
                                                                            placeholder='Enter License Picture'
                                                                            onChange={FileUploadTinCertificate} ></input>
                                                                        {licensePic <= 0 && errors.licensePic && <span className='validate_text'>{errors.licensePic.message}</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Driver Picture</lable>
                                                                        <input name='driverPic' type="file"
                                                                            // value={driverPic}
                                                                            {...register("driverPic", { required: '*Driver Picture is required' })}
                                                                            placeholder='Please Enter Driver Picture'
                                                                            onChange={FileUploadTreadCertificate} ></input>
                                                                        {driverPic <= 0 && errors.driverPic && <span className='validate_text'>{errors.driverPic.message}</span>}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Date Of Birth</lable>
                                                                        <input name='birtDate' type="Date"
                                                                            // value={licenseNumber}
                                                                            {...register("licenseNumber", { required: '*License Number is required' })}
                                                                            placeholder='Enter Date Of Birth'
                                                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                                                        ></input>
                                                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                                                    </div>


                                                                    <div className='asd'>
                                                                        <lable>Phone Number</lable>
                                                                        <input name='phoneNumber' type="text"
                                                                            // value={licenseNumber}
                                                                            {...register("licenseNumber", { required: '*License Number is required' })}
                                                                            placeholder='Enter Phone Number'
                                                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                                                        ></input>
                                                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Exeperiance</lable>
                                                                        <input name='Exeperiance' type="text"
                                                                            // value={licenseNumber}
                                                                            {...register("licenseNumber", { required: '*License Number is required' })}
                                                                            placeholder='Enter Exeperiance '
                                                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                                                        ></input>
                                                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>License Grade</lable>
                                                                        <input name='License Grade' type="text"
                                                                            // value={licenseNumber}
                                                                            {...register("licenseNumber", { required: '*License Number is required' })}
                                                                            placeholder='Enter License Grade '
                                                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                                                        ></input>
                                                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Status</lable>
                                                                        <input name='License Grade' type="text"
                                                                            // value={licenseNumber}
                                                                            {...register("licenseNumber", { required: '*License Number is required' })}
                                                                            placeholder='Enter License Grade'
                                                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                                                        ></input>
                                                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Issue Date</lable>
                                                                        <input name='Issue Date' type="date"
                                                                            // value={licenseNumber}
                                                                            {...register("licenseNumber", { required: '*License Number is required' })}
                                                                            placeholder='Enter Issue Date'
                                                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                                                        ></input>
                                                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                                                    </div>

                                                                    <div className='asd'>
                                                                        <lable>Expire Date</lable>
                                                                        <input name='Expire Date' type="date"
                                                                            // value={licenseNumber}
                                                                            {...register("licenseNumber", { required: '*License Number is required' })}
                                                                            placeholder='Enter Expire Date'
                                                                        // onChange={(e) => setLicenseNumber(e.target.value)} 
                                                                        ></input>
                                                                        {/* {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>} */}
                                                                    </div>

                                                                    <div className='asdy'>
                                                                        <button>Register</button>
                                                                    </div>
                                                                    <div className='asdy'>
                                                                        {/* <button onClick={() => { handleClickopen2() }}>Add Vehicle</button> */}
                                                                        <button type='reset'>Clear</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div> : ""}
                                        </form>
                                    </div>
                                </div>

                        }

                    </>

                </div>

            </div>
        </div >
    )
}
