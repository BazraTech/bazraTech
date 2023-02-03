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
import { Pagination } from 'antd';
import SyncLoader from "react-spinners/SyncLoader";
import Driver_detail from './Driver_detail';
import { useForm } from 'react-hook-form';

export default function () {

    const { register, handleSubmit, watch, formState: { errors } } = useForm();

    function tableSearch() {

        let input, filter, table, tr, td, txtValue, errors;

        //Intialising Variables
        input = document.getElementById("myInput");
        filter = input.value.toUpperCase();
        table = document.getElementById("myTable");
        tr = table.getElementsByTagName("tr");

        for (let i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[2];
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

    const url = "http://198.199.67.201:9090/Api/Vehicle/Status/inroute";
    const [dataSource, setDataSource] = useState([])
    const [Loading, setLoading] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.inRoutelist)
                // console.log(dataSource)
                setLoading(false);

            })
    }, [])

    const url2 = "http://198.199.67.201:9090/Api/Vehicle/Owner/Drivers/All";
    const [dataSource2, setDataSource2] = useState([])
    // const [Loading, setLoading] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.drivers)
                console.log(dataSource)
                setLoading(false);

            })
    }, [])

    const url3 = "http://198.199.67.201:9090/Api/Vehicle/Status/stocked";
    const [dataSource3, setDataSource3] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url3, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.stockedList)
                console.log(dataSource3)
                setLoading(false);

            })
    }, [])

    const url4 = "http://198.199.67.201:9090/Api/Vehicle/Status/maintaining";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url4, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data.maintainingList)
                console.log(dataSource4)
                setLoading(false);

            })
    }, [])

    const [list, setList] = useState(dataSource2);
    const [total, setTotal] = useState(dataSource2.length);
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(10);

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }

    useEffect(() => {
        setTotal([dataSource2.length])
    }, []);

    const indexOfLastPage = page + postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = dataSource2.slice(indexOfFirstPage, indexOfLastPage);
    const [color, setColor] = useState("green");
    const [margin, setMargin] = useState("");

    const [popup1, setPop1] = useState(false);

    const [id, setId] = useState();
    console.log(id)


    const [edit, setEdit] = useState("");
    let [active, setActive] = useState(false);
    let [name, setName] = useState("false");

    const closePopup5 = () => {
        setPop1(false);
        // setPop(false);
    }

    const handleClickopen1 = () => {
        setPop1(!popup1);
    }

    function changeName(name) {
        setName(name);
    }

    const onSubmit2 = (data) => {
        console.log(data);
        // AddDriver();
    };

    const [driverName, setDriverName] = useState(""); 
    const [licenseNumber, setLicenseNumber] = useState("");
    const [licensePic, SetTinCertificate] = useState("");
    const [driverPic, setTreadCertificate] = useState();
    const [imgData, setImgData] = useState(null);
    const [selectedFile, setSelectedFile] = useState();

    // async function AddDriver() {
    //     const formData = new FormData();
    //     formData.append("driverName ", driverName)
    //     formData.append("licenseNumber", licenseNumber);
    //     formData.append("licensePic", licensePic);
    //     formData.append("driverPic", driverPic);
    //     // formData.append("ownerPhone", ownerPhone)
    //     formData.append("file", selectedFile);
    //     console.log(formData)

    //     axios.post("http://198.199.67.201:9090/Api/Driver/AddDriver", formData, {
    //             headers: {
    //                 'Content-Type': 'Auto',
    //                 "Authorization": `Bearer ${jwt}`,
    //             }
    //         })
    //         .then((res) => {
    //             localStorage.setItem("message", JSON.stringify(res["message"]));
    //             const mess = localStorage.getItem("message");
    //             console.log(res);
    //             swal("Error","Driver Successfuliy Registerd", "success", {
    //                 button: true,
                    
    //             })
    //         })
    //         .catch(function (error) {
    //             if (error.response) {
    //                 // Request made and server responded
    //                 localStorage.setItem('message', JSON.stringify(error.response.data['message']))
    //                 const messx = localStorage.getItem('message')
    //                 console.log('message', messx)
    //                 console.log(error.response.data);
    //                 swal("Error", `${messx}`, "error", {
    //                     button: true,
                        
    //                 })
    //                 console.log(error.response.status);
    //                 console.log(error.response.headers);
    //             } else if (error.request) {
    //                 // The request was made but no response was received
    //                 console.log(error.request);
    //             } else {
    //                 // Something happened in setting up the request that triggered an Error
    //                 console.log('Error', error.message);
    //             }

    //         })
    // };

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

        <div className="vehicle_container">

            {/*---------------navigation---------------*/}

            <Navigation path="/Total_Drivers"></Navigation>

            {/* --------------- header --------------- */}

            <Header title="Assigned Derivers"></Header>

            {/* --------------- users --------------- */}

            <div className='user'>
                <div className='vehicle_contents0'>
                    <Link to="/Total_Drivers" style={{ textDecoration: 'none' }}> <div className='parked1'>
                        <h4>Total Drivers</h4>
                        <p><AiFillCar size="2.2rem"></AiFillCar><b>{dataSource2.length}</b></p>

                    </div></Link>

                    <Link style={{ textDecoration: 'none' }} to="/Driver_OnRoute"><div className='parked1'>
                        <h4>On Route</h4>
                        <p><FaRoute size="2rem" ></FaRoute><b>{dataSource.length}</b></p>
                    </div></Link>

                    <Link style={{ textDecoration: 'none' }} to="/Assigned_Driver">
                        <div className='activeNav'>
                            <h4>Assigned</h4>
                            <p><FaParking size="2rem" ></FaParking><b>{dataSource3.length}</b></p>
                        </div>
                    </Link>

                    <Link style={{ textDecoration: 'none' }} to="/UnAssigned_Driver">
                        <div className='maintenance1'>
                            <h4>Un Assigned</h4>
                            <p><IoSettingsOutline size="2rem" ></IoSettingsOutline><b>{dataSource4.length}</b></p>
                        </div>
                    </Link>
                    <Link style={{ textDecoration: 'none' }} to="/Permit">
                        <div className='maintenance1'>
                            <h4>Permit</h4>
                            <p><IoSettingsOutline size="2rem" ></IoSettingsOutline><b>{dataSource4.length}</b></p>
                        </div>
                    </Link>
                </div>

                {/* --------------- search --------------- */}

                <div className='vehicle_search'>
                    <p title='search'>
                        <BsSearch className='icn' size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>
                {Loading ?
                    <p className='loading'><SyncLoader
                        color={color}
                        Left={margin}
                        loading={Loading}
                        size={10}
                        aria-label="Loading Spinner"
                        data-testid="loader"
                    /></p>
                    :
                    <>
                        <div className='outer_vehicle_tables' id='myTable'>
                            <p>Assigned Derivers</p>

                            <table className="vehicle_table" id="myTable">

                                <thead>
                                    <tr>
                                        <th>Driver ID</th>
                                        <th>Driver Name</th>
                                        <th>License Number</th>
                                        <th>Detail</th>
                                        <th>Tracking</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {dataSource2.map(item => (
                                        <tr className='active_row'>

                                            <td>{item.id}</td>
                                            {/* <td>{item.driver == null ? "unassignd" :`${dataSource3.map(item2 =>( item2.driverName ))}`}</td> */}
                                            {/* <td>{item.driver == null ? "unassignd" : `${item.driver.driverName}`}</td> */}
                                            <td>{item.driverName}</td>
                                            <td>{item.licenseNumber}</td>
                                            {/* <td>{item.plateNumber}</td> */}
                                            <td><button
                                                onClick={() => {
                                                    setEdit(item.id)
                                                    setName("true")
                                                }}
                                            >Detail</button></td>
                                            <td><Link to="/tracking"><button>Tracking</button></Link></td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                        <div className='page'>
                            <Pagination
                                onChange={(page) => setCurentPage(page)}
                                pageSize={postPerPage}
                                current={page}
                                total={total}
                                showQuickJumper
                                showSizeChanger
                                onShowSizeChange={onShowSizeChange}
                            />
                        </div>
                        <div className='addMangeAssign' style={{ marginBottom: "50px" }}>
                            <button onClick={() => {
                                 handleClickopen1()
                                // setOwnerPhone(item.phoneNumber)
                            }}> Add Driver</button>
                            <button> Manage Driver</button>
                            <Link to="/AssignVehivle"><button onClick={() => { handleClickopen() }}> Assigne Driver</button></Link>
                        </div>
                    </>

                }

                {name === "true" && <Driver_detail data={edit} changeName={changeName} />}


                <form onSubmit={handleSubmit(onSubmit2)}>
                    {popup1 ?
                        <div>
                            <div className='popup3'>
                                <div className='popup-inner'>
                                    <lable className="zxcc">Add Driver</lable>
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

        </div >
    )
}
