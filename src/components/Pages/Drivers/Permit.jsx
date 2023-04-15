import React from 'react'
import { FaHome } from 'react-icons/fa';
import { AiFillCar } from "react-icons/ai";
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import styles from './total_driver.module.css';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';
import Navigation from '../Navigation/Navigation';
import swal from "sweetalert";
import { Pagination } from 'antd';
import axios from "axios";
import SyncLoader from "react-spinners/SyncLoader";
import Driver_detail from './Driver_detail';
import { FaUserSecret } from "react-icons/fa";
import { FaUserCheck } from "react-icons/fa";
import { FaUserTimes } from "react-icons/fa";
import { FaUserMinus } from "react-icons/fa";
import { useForm } from 'react-hook-form';

export default function () {

    const ownerPhone = JSON.parse(localStorage.getItem("user"));
    const { register, handleSubmit, watch, formState: { errors } } = useForm();

    function tableSearch() {
        //Intialising Variables
        let input, filter, table, tr, td, txtValue, errors;
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

    const [Loading, setLoading] = useState([]);
    const url = "http://198.199.67.201:9090/Api/Vehicle/Owner/Drivers/All";
    const [dataSource, setDataSource] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data.drivers)
                setLoading(false);
            })
    }, [])

    const [totalPages, setTotalPage] = useState(1);
    const url2 = "http://198.199.67.201:9090/Api/Vehicle/Owner/Drivers/ONROUTE";
    const [dataSource2, setDataSource2] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url2, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource2(data.drivers);
                setLoading(false);
            })
    }, [])

    const url3 = "http://198.199.67.201:9090/Api/Vehicle/Owner/Drivers/ASSIGNED";
    const [dataSource3, setDataSource3] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url3, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource3(data.drivers)
                setLoading(false);
            })
    }, [])

    const url4 = "http://198.199.67.201:9090/Api/Vehicle/Owner/Drivers/UNASSIGNED";
    const [dataSource4, setDataSource4] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url4, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource4(data.drivers)
                setLoading(false);
            })
    }, [])

    const url5 = "http://198.199.67.201:9090/Api/Vehicle/Owner/Drivers/PERMIT";
    const [dataSource5, setDataSource5] = useState([])
    useEffect(() => {
        setLoading(true);
        fetch(url5, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource5(data.drivers)
                setTotalPage(data.totalDrivers);
                setLoading(false);
            })
    }, [])


    const [page, setCurentPage] = useState(1);
    const [postPerPage, setpostPerPage] = useState(5);
    const indexOfLastPage = page * postPerPage;
    const indexOfFirstPage = indexOfLastPage - postPerPage;
    const currentPage = dataSource5.slice(indexOfFirstPage, indexOfLastPage);

    const onShowSizeChange = (current, pageSize) => {
        setpostPerPage(pageSize);
    }

    const [color, setColor] = useState("green");
    const [margin, setMargin] = useState("");

    const [popup1, setPop1] = useState(false);

    const [id, setId] = useState();
    console.log(id)


    const [edit, setEdit] = useState("");
    let [active, setActive] = useState(false);
    let [name, setName] = useState("false");

    function changeName(name) {
        setName(name);
    }
    const handleClickopen1 = () => {
        setPop1(!popup1);
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

        axios.post("http://198.199.67.201:9090/Api/Driver/AddDriver", formData, {
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

    const closePopup5 = () => {
        setPop1(false);
    }

    return (

        <div className="vehicle_container">

            {/*---------------navigation---------------*/}

            {/* <Navigation path="/Total_Drivers"></Navigation> */}
            <Navigation path="/Total_Drivers" title="Assigned Drivers"></Navigation>


            {/* --------------- header --------------- */}

            {/* <Header title="Total Drivers"></Header> */}

            {/* --------------- users --------------- */}

            <div className={styles.main_content}>
                <div className={styles.allcards}>

                    <div className={styles.vehicle}>
                        <Link to="/Total_Drivers" style={{ textDecoration: 'none' }}>
                            <div className={styles.innerContents}>
                                <h4>Total Drivers</h4>
                                <p><FaUserSecret size="2.2rem"></FaUserSecret><b>{dataSource.length}</b></p>
                            </div>
                        </Link>
                    </div>

                    <div className={styles.vehicle}>
                        <Link to="/Driver_OnRoute" style={{ textDecoration: 'none' }}>
                            <div className={styles.innerContents}>
                                <h4>On Route</h4>
                                <p><FaRoute size="2rem" ></FaRoute><b>{dataSource2.length}</b></p>
                            </div>
                        </Link>
                    </div>

                    <div className={styles.vehicle}>
                        <Link to="/Assigned_Driver" style={{ textDecoration: 'none' }}>
                            <div className={styles.innerContents}>
                                <h4>Assigned</h4>
                                <p><FaUserCheck size="2rem" ></FaUserCheck><b>{dataSource3.length}</b></p>
                            </div>
                        </Link>
                    </div>

                    <div className={styles.vehicle}>
                        <Link to="/UnAssigned_Driver" style={{ textDecoration: 'none' }}>
                            <div className={styles.innerContents}>
                                <h4>Un Assigned</h4>
                                <p><FaUserTimes size="2rem" ></FaUserTimes><b>{dataSource4.length}</b></p>
                            </div>
                        </Link>
                    </div>

                    <div className={styles.activeCard}>
                        <Link to="/Permit" style={{ textDecoration: 'none' }}>
                            <div className={styles.innerContents1}>
                                <h4>Permit</h4>
                                <p><FaUserMinus size="2rem" ></FaUserMinus><b>{dataSource5.length}</b></p>
                            </div>
                        </Link>
                    </div>

                </div>

                {/* --------------- search --------------- */}

                {Loading ?
                    <p className={styles.loading}>
                        <SyncLoader
                            color={color}
                            Left={margin}
                            loading={Loading}
                            size={10}
                            aria-label="Loading Spinner"
                            data-testid="loader"
                        /></p>
                    :

                    <>
                        <div className={styles.outer_table} id='myTable'>

                            <div className={styles.vehicle_search}>
                                <p title='search'>
                                    <BsSearch className={styles.icn} size="1.5rem" color='rgb(63, 63, 63)'></BsSearch>
                                    <input type="text" id="myInput" onKeyUp={tableSearch} placeholder="Search"></input>
                                    <button>Search</button>
                                </p>
                            </div>
                            <p>PERMIT DRIVERS</p>

                            <table className={styles.vehicle_table} id="myTable">

                                <thead>
                                    <tr>
                                        <th>Driver Name</th>
                                        <th>License Number</th>
                                        <th>Experience</th>
                                        <th>LicenseGrade</th>
                                        <th>Gender</th>
                                        <th>VehicleOwner</th>
                                        <th>Detail</th>
                                        <th>Tracking</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    {currentPage.map(item => (
                                        <tr className={styles.active_row}>

                                            <td>{item.driverName}</td>
                                            <td>{item.licenseNumber}</td>
                                            <td>{item.experience}</td>
                                            <td>{item.licenseGrade}</td>
                                            <td>{item.gender}</td>
                                            <td>{item.vehicleOwner}</td>
                                            <td><button onClick={() => {
                                                setEdit(item.id)
                                                setName("true")
                                            }}>Detail</button></td>
                                            <td><button>Manage</button></td>
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

                        <div className={styles.addMangeAssign} style={{ marginBottom: "50px" }}>
                            <button onClick={() => {
                                handleClickopen1()
                            }}> Add Driver</button>
                            <button> Manage Driver</button>
                            <Link to=""><button onClick={() => { handleClickopen() }}> Assigne Driver</button></Link>
                        </div>
                    </>


                }
                {name === "true" && <Driver_detail data={edit} changeName={changeName} />}

                <form onSubmit={handleSubmit(onSubmit2)}>

                    {popup1 ?
                        <div>
                            <div className={styles.popup}>

                            <div className='animate__animated animate__slideInDown'>
                                <div className={styles.popupInner}>

                                    <div className={styles.allForms1}>

                                        <button className={styles.closeBtn} onClick={closePopup5}>X</button>
                                        <lable className={styles.addHeader}>Add Driver</lable>

                                        <div className={styles.formDiv1}>

                                            <div className={styles.input}>
                                                <lable>Full Name</lable>
                                                <input name='driverName' type="text"
                                                    value={driverName}
                                                    {...register("driverName", { required: '*Driver Name is required' })}
                                                    placeholder='Enter Vehicle Name'
                                                    onChange={(e) => setDriverName(e.target.value)} ></input>
                                                {driverName <= 0 && errors.driverName && <span className='validate_text'>{errors.driverName.message}</span>}
                                            </div>

                                            <div className={styles.input}>
                                                <lable>Gender</lable>
                                                <select className='select' name='gender'
                                                    value={gender}
                                                    {...register("gender", { required: '*gender is required' })}
                                                    onChange={(e) => setGender(e.target.value)} >
                                                    <option value="">Select Gender</option>
                                                    <option value="MALE">Male</option>
                                                    <option value="FEMAIL">Femaile</option>
                                                </select>
                                                {gender <= 0 && errors.gender && <span className='validate_text'>{errors.gender.message}</span>}
                                            </div>

                                            <div className={styles.input}>
                                                <lable>License Number</lable>
                                                <input name='licenseNumber' type="text"
                                                    value={licenseNumber}
                                                    {...register("licenseNumber", { required: '*License Number is required' })}
                                                    placeholder='Enter Vehicle Name'
                                                    onChange={(e) => setLicenseNumber(e.target.value)} ></input>
                                                {licenseNumber <= 0 && errors.licenseNumber && <span className='validate_text'>{errors.licenseNumber.message}</span>}
                                            </div>

                                            <div className={styles.input}>
                                                <lable>Driver Licence Picture</lable>
                                                <input name='licensePic' type="file"
                                                    // value={licensePic}
                                                    {...register("licensePic", { required: '*License Picture is required' })}
                                                    placeholder='Enter License Picture'
                                                    onChange={FileUploadTinCertificate} ></input>
                                                {licensePic <= 0 && errors.licensePic && <span className='validate_text'>{errors.licensePic.message}</span>}
                                            </div>

                                            <div className={styles.input}>
                                                <lable>Driver Picture</lable>
                                                <input name='driverPic' type="file"
                                                    // value={driverPic}
                                                    {...register("driverPic", { required: '*Driver Picture is required' })}
                                                    placeholder='Please Enter Driver Picture'
                                                    onChange={FileUploadTreadCertificate} ></input>
                                                {driverPic <= 0 && errors.driverPic && <span className='validate_text'>{errors.driverPic.message}</span>}
                                            </div>

                                            <div className={styles.input}>
                                                <lable>Date Of Birth</lable>
                                                <input name='birthDate' type="date"
                                                    value={birthDate}
                                                    {...register("birthDate", { required: '*Gender is required' })}
                                                    placeholder='Enter Vehicle Name'
                                                    onChange={(e) => setBirthDate(e.target.value)} ></input>
                                                {birthDate <= 0 && errors.birthDate && <span className='validate_text'>{errors.birthDate.message}</span>}
                                            </div>

                                            <div className={styles.input}>
                                                <lable>Phone Number</lable>
                                                <input name='driverPhone' type="text"
                                                    value={driverPhone}
                                                    {...register("driverPhone", { required: '*driver Phone is required' })}
                                                    placeholder='Enter Phone Number'
                                                    onChange={(e) => setDriverPhone(e.target.value)}
                                                ></input>
                                                {driverPhone <= 0 && errors.driverPhone && <span className='validate_text'>{errors.driverPhone.message}</span>}
                                            </div>

                                            <div className={styles.input}>
                                                <lable>Exeperiance</lable>
                                                <input name='experience' type="text"
                                                    value={experience}
                                                    {...register("experience", { required: '*experience is required' })}
                                                    placeholder='Enter Exeperiance '
                                                    onChange={(e) => setExperience(e.target.value)}
                                                ></input>
                                                {experience <= 0 && errors.experience && <span className='validate_text'>{errors.experience.message}</span>}
                                            </div>

                                            <div className={styles.input}>
                                                <lable>License Grade</lable>
                                                <input name='licenseGrade' type="text"
                                                    value={licenseGrade}
                                                    {...register("licenseGrade", { required: '*license Grade is required' })}
                                                    placeholder='Enter License Grade '
                                                    onChange={(e) => setLicenseGrade(e.target.value)}
                                                ></input>
                                                {licenseGrade <= 0 && errors.licenseGrade && <span className='validate_text'>{errors.licenseGrade.message}</span>}
                                            </div>

                                            {/*  */}

                                            <div className={styles.input}>
                                                <lable>Issue Date</lable>
                                                <input name='Issue Date' type="date"
                                                    value={licenseIssueDate}
                                                    {...register("licenseIssueDate", { required: '*license IssueDate is required' })}
                                                    placeholder='Enter Issue Date'
                                                    onChange={(e) => setLicenseIssueDate(e.target.value)}
                                                ></input>
                                                {licenseIssueDate <= 0 && errors.licenseIssueDate && <span className='validate_text'>{errors.licenseIssueDate.message}</span>}
                                            </div>

                                            <div className={styles.input}>
                                                <lable>Expire Date</lable>
                                                <input name='Expire Date' type="date"
                                                    value={licenseExpireDate}
                                                    {...register("licenseExpireDate", { required: '*license ExpireDate is required' })}
                                                    placeholder='Enter Expire Date'
                                                    onChange={(e) => setLicenseExpireDate(e.target.value)}
                                                ></input>
                                                {licenseExpireDate <= 0 && errors.licenseExpireDate && <span className='validate_text'>{errors.licenseExpireDate.message}</span>}
                                            </div>

                                        </div>
                                        <div className={styles.addButton}>
                                            <button>Submit </button>
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
