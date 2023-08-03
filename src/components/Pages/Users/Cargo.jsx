import React from 'react'
import { FaHome } from 'react-icons/fa';
import { FaUsers } from "react-icons/fa";
import { FaUserAlt } from "react-icons/fa";
import { FaWarehouse } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { FaStarOfLife } from 'react-icons/fa';
// import { useState } from 'react';
import styles from './users.module.css';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';
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
                }
            }
        }
    }

    let [active, setActive] = useState("total_users");
    let [state, setState] = useState("false");

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
    const url = "http://164.90.174.113:9090/Api/Admin/All/VehicleOwners/";
    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.vehicleOwnerINF)
                console.log(dataSource)
                setLoading(false)
            })
    }, [])


    const [dataSource2, setDataSource2] = useState([])
    // const [Loading, setLoading] = useState([])
    const url2 = "http://164.90.174.113:9090/Api/Admin/All/VehicleOwners/Role/owner";
    useEffect(() => {
        setLoading(true)
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.totalusers)
                setLoading(false)
            })
    }, [])

    const [individual, setIndividual] = useState([])
    // const [Loading, setLoading] = useState([])
    const url4 = "http://164.90.174.113:9090/Api/Admin/All/VehicleOwners/Role/individual";
    useEffect(() => {
        setLoading(true)
        fetch(url4, options)
            .then(respnse => respnse.json())
            .then(data => {
                setIndividual(data.totalusers)
                setLoading(false)
            })
    }, [])

    const [dataSource3, setDataSource3] = useState([])
    const [dataSource03, setDataSource03] = useState([])
    const url3 = "http://164.90.174.113:9090/Api/Admin/All/CargoOwners";
    useEffect(() => {
        setLoading(true)
        fetch(url3, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.cargoOwners)
                setDataSource03(data.cargoOwners.length)
                setTotalPage(data.cargoOwners.length)
                setLoading(false)
            })
    }, [])
console.log(dataSource3)

    const [popup, setPop] = useState(false);
    const [popup1, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }
    const handleClickopen1 = () => {
        setPop1(!popup1);
    }
    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(5);
    const indexOfLastPage = page * postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = dataSource3.slice(indexOfFirstPage, indexOfLastPage);

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

    const urlthree = "http://164.90.174.113:9090/Api/Admin/All/VehicleCatagory";
    const [dataSource5, setDataSource5] = useState([])
    useEffect(() => {
        fetch(urlthree, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource5(data.vehicleCatagories)
                console.log(dataSource3)
            })
    }, [])

    const urlFour = "http://164.90.174.113:9090/Api/Admin/All/VehicleCondition";
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
        const url = "http://164.90.174.113:9090/Api/Vehicle/AddVehicle";
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
    const [driverPic, setTreadCertificate] = useState("");
    const [gender, setGender] = useState("");
    const [birthDate, setBirthDate] = useState("");
    const [driverPhone, setDriverPhone] = useState("");
    const [experience, setExperience] = useState("");
    const [licenseGrade, setLicenseGrade] = useState("");
    const [licenseIssueDate, setLicenseIssueDate] = useState("");
    const [licenseExpireDate, setLicenseExpireDate] = useState("");
    const [imgData, setImgData] = useState(null);
    const [selectedFile, setSelectedFile] = useState();

    async function AddDriver() {
        const formData = new FormData();
        formData.append("driverName ", driverName)
        formData.append("licenseNumber", licenseNumber);
        formData.append("licensePic", licensePic);
        formData.append("driverPic", driverPic);
        formData.append("ownerPhone", ownerPhone);
        formData.append("gender", gender);
        formData.append("birthDate", birthDate)
        formData.append("driverPhone", driverPhone)
        formData.append("experience", experience)
        formData.append("licenseGrade", licenseGrade)
        formData.append("licenseIssueDate", licenseIssueDate)
        formData.append("licenseExpireDate", licenseExpireDate)
        formData.append("file", selectedFile);
        console.log(formData)

        axios.post("http://164.90.174.113:9090/Api/Driver/AddDriver", formData, {
            headers: {
                'Content-Type': 'Auto',
                "Authorization": `Bearer ${jwt}`,
            }
        })
            .then((res) => {
                localStorage.setItem("message", JSON.stringify(res.data["message"]));
                const mess = localStorage.getItem("message");
                console.log(res);
                swal("Successfully Registerd", `${mess}`, "success", {
                    button: true,
                })

                setDriverName("");
                setLicenseNumber("");
                SetTinCertificate("");
                setTreadCertificate();
                setGender("");
                setBirthDate("");
                setDriverPhone("");
                setLicenseGrade("");
                setLicenseIssueDate("");
                setLicenseExpireDate("");
                setSelectedFile("");
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
    const [color, setColor] = useState("green");
    const ApiData = JSON.parse(localStorage.getItem('ApiData'))

    const totalUser = ApiData.CargoOwner + ApiData.CompanyOwner + ApiData.IndividualOwner
console.log(totalUser)
    return (

        <div className="containerr">

            {/*---------------navigation---------------*/}
            <Navigation path="/users" title="Users"></Navigation>

            {/* --------------- header --------------- */}

            {/* <Header title="Users"></Header> */}

            {/* --------------- users --------------- */}

            <div className={styles.main_content} >

                <div className={styles.allcards}>
                    <div className={styles.vehicle}>
                        <Link style={{ textDecoration: 'none' }} to="/users">
                            <div className={styles.innerContents}>
                                <h4>Total Users</h4>
                                <div>
                                    <p><FaUsers size="2.2rem"></FaUsers><b>{totalUser}</b></p>
                                </div>
                            </div>
                        </Link>
                    </div>
                    <div className={styles.vehicle}>
                        <Link style={{ textDecoration: 'none' }} to="/company">
                            <div className={styles.innerContents}>
                                <h4>Company</h4>
                                <div>
                                    <p><FaWarehouse size="2.2rem"></FaWarehouse><b>{dataSource2}</b></p>
                                </div>
                            </div>
                        </Link>
                    </div>
                    <div className={styles.vehicle}>
                        <Link style={{ textDecoration: 'none' }} to="/register_individual">
                            <div className={styles.innerContents}>
                                <h4>Individual</h4>
                                <div>
                                    <p><FaUserAlt size="2rem"></FaUserAlt><b>{individual}</b></p>
                                </div>
                            </div>
                        </Link>
                    </div>
                    <div className={styles.activeCard}>
                        <Link style={{ textDecoration: 'none' }} to="/cargo">
                            <div className={styles.innerContents1}>
                                <h4>cargo</h4>
                                <div>
                                    <p><FaUserAlt size="2rem"></FaUserAlt><b>{dataSource03}</b></p>
                                </div>
                            </div>
                        </Link>
                    </div>


                </div>
              

                {/* --------------- search --------------- */}


                <div className={styles.vehicle_search}>
                    <p title='search'>
                        <BsSearch className={styles.icn} size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                        <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                        <button>Search</button>
                    </p>
                </div>

                {/* --------------------- Table ------------------- */}
                <div>
                    <>
                        {
                            Loading ?
                                <p className={styles.loading} >
                                    <SyncLoader
                                        loading={Loading}
                                        color={color}
                                        size={10}
                                        aria-label="Loading Spinner"
                                        data-testid="loader"
                                    /></p>
                                :
                                <>
                                    <div className={styles.outer_vehicle_table} id='myTable'>
                                        <p>Cargo OWNERS</p>

                                        <table className={styles.vehicle_table} id="myTable">
                                            <thead>
                                                <tr>
                                                <th>Id</th>
                                                    <th>Owner Name</th>
                                                    <th>Phone Number</th>
                                                    <th>enabled</th>
                                                    <th>Detail</th>
                                                    </tr>
                                            </thead>
                                            <tbody>
                                                {currentPage.map(item => (
                                                    <tr className={styles.active_row} key={item.id}>
                                                        <td>{item.id}</td>
                                                        <td>{item.ownerName}</td>
                                                        <td>{item.phoneNumber}</td>
                                                        <td>{item.enabled ? 'Enabled' : 'Disabled'}</td>
                                                        <td><Link to={`/cargo/${item.id}`}>
                                                            <button>Detail</button></Link>
                                                            </td>
                                                        
                                                    </tr>
                                                ))}
                                            </tbody>
                                        </table>
                                    </div>
                                    <div className={styles.page}>
                                        <Pagination
                                            onChange={(page) => setCurentPage(page)}
                                            pageSize={postPerPage}
                                            current={page}
                                            total={totalPages}
                                            showQuickJumper
                                            showSizeChanger
                                            onShowSizeChange={onShowSizeChange}
                                        />
                                    </div>
                                </>

                        }

                    </>

                </div>

            </div>
        </div >
    )
}
