import React, { Component } from 'react'
import styles from './users_edit.module.css';
import { useForm } from 'react-hook-form';
import { Link, useParams } from 'react-router-dom';
import { HiMenuAlt1 } from "react-icons/hi";
import { useState, useEffect } from 'react';
import { SiTripdotcom } from "react-icons/si";
import { SiGoogletagmanager } from "react-icons/si";
import { BiTrip } from "react-icons/bi";
import Header from '../../Header/Header';
import { total } from './Data/jsonData';
import { on_route } from './Data/Data';
import { parked } from './Data/Data';
import Navigation from '../Navigation/Navigation';
import { Pagination } from 'antd';
import Driver_detail from '../Drivers/Driver_detail';
import { AiFillCar } from "react-icons/ai";
import { FaRoute } from "react-icons/fa";
import { BsSearch } from "react-icons/bs";
import { AiFillFilter } from "react-icons/ai";
import { FaParking } from "react-icons/fa";
import swal from "sweetalert";
import { IoSettingsOutline } from "react-icons/io5";
import { FaUserSecret } from "react-icons/fa";
import { FaUserCheck } from "react-icons/fa";
import { FaUserTimes } from "react-icons/fa";
import { FaUserMinus } from "react-icons/fa";
import Vehicle_Table from './Vehicle_Table';
import Driver_Table from './Driver_Table';

export default function Users_edit() {

    const [state, setState] = useState(false);

    const toggle = () => {
        setState(!state);
    };

    const [diabled, setPop] = useState(true);
    const handleChange = () => {
        setPop(!diabled);
    }

    const [popup1, setPop1] = useState(false);
    const handleClickopen = () => {
        setPop1(!popup1);
    }
      
    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },

    };

    // const [Loading, setLoading] = useState(false)
    const [totalPages, setTotalPage] = useState(1);
    const [totalPages2, setTotalPage2] = useState(1);
    const [tableTitle, setTableTitle] = useState("Total Posted Market");
    // const [tableTitle2, setTableTitle2] = useState("Total Drivers");
    const [cargoOwnerInfo,setCargoOwnerInfo]=useState({})
    const [cargoBusinessInfo, setCargoBusinessInfo] =useState({})
    const [cargoAddressInfo, setCargoAddressInfo] =useState({})
    const [cargoEnabled, setCargoEnabled]= useState('')

    const [Loading, setLoading] = useState([]);
    const { id, role } = useParams();
    const [updateCargoInfo, setUpdateCargoInfo] = useState({});
    let url;

    
        url = `http://164.90.174.113:9090/Api/Admin/All/CargoOwner/${id}`;
    

    useEffect(() => {
        setLoading(true)
        fetch(url, options)
            .then((response) => response.json())
            .then((json) => {
                setCargoOwnerInfo(json.cargoOwnerINF)
                setCargoBusinessInfo(json.businessINF)
                setCargoAddressInfo(json.address)
                setCargoEnabled(json.enabled)
                console.log(cargoOwnerInfo)
                console.log(cargoAddressInfo)
                console.log(cargoBusinessInfo)
                console.log(cargoEnabled)
                setLoading(false)

 
  const   oldCargoOwnerInformation = {
    licenseNumber: json.businessINF.licenseNumber,
      tinNumber: json.businessINF.tinNumber,
      businessName: json.businessINF.businessName,
      businessType: json.businessINF.businessType,
      businessSector: json.businessINF.businessSector,
      region: json.address.region,
      subCity: json.address.subcity,
      specificLocation: json.address.specificLocation,
      city: json.address.city,
      woreda: json.address.woreda,
      houseNumber: json.address.houseNum,
      phoneNumber: json.address.phone,
      licenseFile: json.businessINF.license,
      tinFile:json.businessINF.tin,
    };

    setUpdateCargoInfo(oldCargoOwnerInformation);
 
            });
    }, [])

    const [selecttag, setSelectTag] = useState(false)
    const [inputtag, setinputTag] = useState(true)
    const select = () => {
        setSelectTag(!selecttag);
        setinputTag(!inputtag);
    } 
/*************************************** */
const BusType = "http://164.90.174.113:9090/Api/Admin/All/BusinessTypes";
const [BusinessType, setBusinessType] = useState([])
useEffect(() => {
    fetch(BusType, options)
        .then(respnse => respnse.json())
        .then(data => {
            setBusinessType(data.businessSectors)
        })
}, [])
const Bussec= "http://164.90.174.113:9090/Api/Admin/All/BusinessSectors";
const [BusinesSector, setBusinesSector] = useState([])

useEffect(() => {
    fetch(Bussec, options)
        .then(respnse => respnse.json())
        .then(data => {
            setBusinesSector(data.businessSectors)
        })
}, [])
    const notUrl = " http://164.90.174.113:9090/Api/Admin/All/NotificationMedium";
    const [notification, setNotification] = useState([])
    useEffect(() => {
        setLoading(true)
        fetch(notUrl, options)
            .then(respnse => respnse.json())
            .then(data => {
                setNotification(data.notificationMedias)
            })
    }, [])
    const serUrl = "http://164.90.174.113:9090/Api/Admin/All/Services";
    const [service, setService] = useState([])
    useEffect(() => {
        fetch(serUrl, options)
            .then(respnse => respnse.json())
            .then(data => {
                setService(data.service)
            })
    }, [])

/*********************************update vehicle owner information************* */

// console.log(updateVehicleInfo)
const handleUpdateChange = (e) => {
    console.log('handleUpdateChange')
    const { name, value } = e.target;
    setUpdateCargoInfo((prevData) => ({
      ...prevData,
      [name]: value || prevData[name],// Keep the existing value if the input is empty
    }));
  };
  const updatedData = new FormData();
  const onSubmit =(e)=>{
        
    e.preventDefault();
  console.log(updateCargoInfo)
    // updatedData.append(updateCargoInfo);
    for (const [key, value] of Object.entries(updateCargoInfo)) {
        updatedData.append(key, value);
    }
    console.log(updatedData);
    update();
}
    async function update(){



   
    const options = {
        method: "PUT",
        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
        body: JSON.stringify(updatedData),
    };
    const url = `http://164.90.174.113:9090/Api/Admin/UpdateInfo/CargOwner/${id}`;
    try {
        const response = await fetch(url, options);
        const result = await response.json();
        console.log(result);
        localStorage.setItem("message", JSON.stringify(result["message"]));
        const mess = localStorage.getItem("message");
        console.log(mess);
        if (response.ok) {
            console.log("updated successful");
            swal("Successful", `${mess}`, "success", {
                buttons: false,
                timer: 2000,
            });
           
        } else {
            console.log("failed");
            swal(`Failed To update ${mess}`, "Error", "error");
        }
    } catch (error) {
        console.error(error);
    }
}

    return (
        <div>
            <div className="users_edit_container">

                {/*---------------navigation---------------*/}

                <Navigation path="/users" title="Users/Detail"></Navigation> 

                {/* ---------------header--------------- */}

                {/* <Header title="Users/Edit"></Header> */} 

                {/* ---------------Registration--------------- */}

                <section className={styles.main_content}>

                    <div className={styles.company_individual_header}>
                        <p ><h1 className={styles.companyHeader}>Company Detail</h1></p>
                        <p ><h4 className={styles.vehicleDetail}>Name : {cargoOwnerInfo.ownerName}<br />
                         User ID : {cargoOwnerInfo.id}</h4></p>
                    </div>
                    <form className='form' onSubmit={(onSubmit)}>
                        {/* {dataSource.map(item => { */}

                        <div className={styles.allDiv}>
                            <>
                              
                                    <div className='first_div'>
                                        <h1>Cargo Owner Information</h1>
                                        <div className={styles.company_information}>
                                            <div>
                                                <p>Owner Name </p>
                                                <input 
                                                 name ='phoneNumber' 
                                                 onChange={handleUpdateChange} 
                                                defaultValue={cargoOwnerInfo.ownerName} 
                                                type="text" disabled={diabled}></input>
                                            </div>
                                            <div>
                                            <p>phone number</p>
                                                <input 
                                                 name ='companyName' 
                                                 onChange={handleUpdateChange} 
                                                defaultValue={cargoOwnerInfo.phoneNumber} 
                                                type="text" disabled={diabled}></input>
                                            </div>
                                            <div>
                                                <p>Business type</p>
                                             
                                              {  !selecttag ? (
                                                  <input
                                                    defaultValue={cargoBusinessInfo.businessType}
                                                    className='select'
                                                    disabled={diabled}
                                                  />
                                                ) : (
                                                  <select
                                                    className='select'
                                                    name='businessType'
                                                    value={cargoBusinessInfo.businessType}
                                                    onChange={handleUpdateChange}
                                                  >
                                                    <option value=''>{cargoBusinessInfo.businessType}</option>
                                                    {BusinessType.map((item) => (
                                                      <option key={item.businessType} value={item.businessType}>
                                                        {item.businessType}
                                                      </option>
                                                    ))}
                                                  </select>
                                                )
                                              }
                                              
                                            </div>
                                            <div>
                                                <p>Business Sector </p>

                                                {
                                                        !selecttag ? (
                                                            <input
                                                            defaultValue={cargoBusinessInfo.businessSector}
                                                            className='select'
                                                            disabled={diabled}
                                                            />
                                                        ) : (
                                                            <select
                                                            className='select'
                                                            name='businessSector'
                                                            defaultValue={cargoBusinessInfo.businessSector}
                                                            onChange={handleUpdateChange}
                                                            >
                                                            <option value=''>{cargoBusinessInfo.businessSector}</option>
                                                            {BusinesSector.map((item) => (
                                                                <option key={item.businessSector} value={item.businessSector}>
                                                                {item.businessSector}
                                                                </option>
                                                            ))}
                                                            </select>
                                                        )
                                                        }
                                            </div>

                                            <div>
                                                <p>Tin Number </p>
                                                <input 
                                                 name ='tinNumber' 
                                                 onChange={handleUpdateChange} 
                                                value={cargoBusinessInfo.tinNumber} 
                                                type="text" disabled={diabled}></input>
                                            </div>
                                            <div>
                                                <p>License Number </p>
                                                <input 
                                                 name ='licenseNumber' 
                                                 onChange={handleUpdateChange} 
                                                value={cargoBusinessInfo.licenseNumber} 
                                                type="text" disabled={diabled}></input>
                                            </div>
                                            <div>
                                                <p>License Pic </p>
                                                {/* {  !selecttag ?  */}
                                                  <img
                                                src={cargoBusinessInfo.license || ""}
                                                alt="licence pic"
                                                style={{
                                                border: "1px solid black",
                                                objectFit: "cover",
                                                borderRadius: "5px",
                                                display: "block",
                                                width: "100%",
                                                height: "100%",
                                                overflow: "hidden",
                                                marginBottom: "10px",
                                                }}
                                                className="img-licence"
                                            />
                                           {/* <input 
                                                  name ='licenseFile' 
                                                  onChange={handleUpdateChange} 
                                                 value={cargoBusinessInfo.license} 
                                                 type="file" disabled={diabled}>
                                        </input>} */}
                                            </div>
                                            <div>
                                            <p>Tin pic </p>
                                            {/* { !selecttag ?   */}
                                                  <img
                                                src={cargoBusinessInfo.tin|| ""}
                                                alt="tin pic"
                                                style={{
                                                border: "1px solid black",
                                                objectFit: "cover",
                                                borderRadius: "5px",
                                                display: "block",
                                                width: "50%",
                                                height: "50%",
                                                overflow: "hidden",
                                                marginBottom: "10px",
                                                }}
                                                className="img-licence"
                                            />
                                           {/* <input 
                                                  name ='licenseFile' 
                                              onChange={handleUpdateChange} 
                                             defaultValue={cargoBusinessInfo.tin} 
                                                type="file" disabled={diabled}></input>
                                                } */}
                                            </div>
                                            
                                        </div>
                                    </div>
                                
                                {/* :""} */}

                                <div className='second_div'>
                               <h1>Company Address</h1>
                                    <div className={styles.company_Address}>
                                        <div>
                                            <p>Region </p>
                                            <input 
                                            name ='region' 
                                            onChange={handleUpdateChange} 
                                            type="text"
                                            defaultValue={cargoAddressInfo.region} 
                                            disabled={diabled}>
                                            </input>
                                        </div>
                                        <div>
                                            <p>Sub City </p>
                                            <input 
                                             name ='subCity' 
                                             onChange={handleUpdateChange} 
                                             type="text"
                                             defaultValue={cargoAddressInfo.subcity} disabled={diabled}></input>
                                        </div>
                                        <div>
                                            <p>Specfic Location </p>
                                            <input 
                                            name ='specificLocation' 
                                            onChange={handleUpdateChange} 
                                            type="text"
                                            defaultValue={cargoAddressInfo.specificLocation} 
                                           disabled={diabled}></input>
                                        </div>
                                        <div>
                                            <p>City </p>
                                            <input 
                                            name ='city' 
                                            onChange={handleUpdateChange} 
                                            type="text"
                                           defaultValue={cargoAddressInfo.city} disabled={diabled}></input>
                                        </div>
                                        <div>
                                            <p>Woreda </p>
                                            <input 
                                             name ='woreda' 
                                             onChange={handleUpdateChange} 
                                             type="text"
                                            defaultValue={cargoAddressInfo.woreda} 
                                            disabled={diabled}></input>
                                        </div>
                                        <div>
                                            <p>House Number </p>
                                            <input 
                                             name ='houseNumber' 
                                             onChange={handleUpdateChange} 
                                             type="text"
                                            defaultValue={cargoAddressInfo.houseNum} disabled={diabled}></input>
                                        </div>
                                        <div>
                                            <p>Phone Number </p>
                                            <input  
                                            defaultValue={cargoAddressInfo.phone}
                                             disabled='true'
                                             name='phoneNumber'
                                             onChange={handleUpdateChange}
                                             type="text" ></input>
                                        </div>
                                        
                                        <div>
                                                <p>Enabled Status </p>
                                                <input 
                                                 name ='licenseNumber' 
                                                 onChange={handleUpdateChange} 
                                                defaultValue={cargoEnabled} 
                                                type="text" disabled={diabled}></input>
                                            </div>
                                    </div>
                                </div>

                               
                                <div className={styles.company_button}>
                                    <p className={styles.addd} onClick={() => {
                                        handleChange()
                                        toggle()
                                        select()
                                    }}>{state ? "Cancle" : "Edit"}</p>
                                    <br />
                                    <button className={styles.ad} disabled={diabled}>Update</button>
                                </div>
                            </>
                        </div>
                    </form>

                </section>

                {/* ---------------end Registaration--------------- */}
            </div >
        </div >
    )
}
