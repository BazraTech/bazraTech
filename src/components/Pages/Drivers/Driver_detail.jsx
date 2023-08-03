import React from 'react'
import styles from './driver_detail.module.css';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';

export default function (props) {


    console.log(props.id);
    let [active, setActive] = useState("total_vehicle");
    let [state, setState] = useState("false");
    const [popup, setPop] = useState(false);
    const handleClickopen = () => {
        setPop(!popup);
    }
  const [diabled, setDiabled] = useState(true);
    const handleChange = () => {
        setDiabled(!diabled);
    }
      const [selecttag, setSelectTag] = useState(false)
    const [inputtag, setinputTag] = useState(true)
    const select = () => {
        setSelectTag(!selecttag);
        setinputTag(!inputtag);
    } 

    const toggle = () => {
        setState(!state);
    };
    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const options = {

        headers: {
            'Content-Type': 'application/json',
            "Accept": "application/json",
            "Authorization": `Bearer ${jwt}`
        },
    };

    const [popup1, setPop1] = useState(true); 
    const handleClickopen1 = () => {
        setPop1(!popup1);
    }

    const [dataSource, setDataSource] = useState([])
    const url = `http://164.90.174.113:9090/Api/Admin/All/Drivers/${props.id}`;
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
            .then(data => {
                setDataSource(data)
            })
    }, [])

    const closePopup5 = () => {
        setPop1(false);
    }
    
    const [driverName,setDriverName] = useState(dataSource.driverName)
    const [licenseNumber,setlicenseNumber] =useState(dataSource.licenseNumber)
    const [licensePic, setlicensePic]= useState(dataSource.licensePic)
    const [driverPic,setdriverPic]= useState(dataSource.driverPic)
    const [OwnerPhone,setOwnerPhone]=useState(dataSource.phoneNumber)
    const [driverPhone,setdriverPhone]=useState(dataSource.phoneNumber)
    const [birthDate,setbirthDate]=useState(dataSource.birthDate)
    const [experience,setexperience]=useState(dataSource.experience)
    const [licenseGrade,setlicenseGrade]=useState(dataSource.licenseGrade)
    const [licenseIssueDate,setlicenseIssueDate]=useState(dataSource.licenseIssueDate)
    const [licenseExpireDate,setlicenseExpireDate]=useState(dataSource.licenseExpireDate)

    return (

        // <form>
        <>
       
            {popup1 ?
                <div>
                    <div className={styles.popup}>
                        <div className='animate__animated animate__slideInDown'>
                            <div className={styles.popupInner}>

                                <div className={styles.allForms1}>

                                    <button className={styles.closeBtn} onClick={() => props.changeName("false")}>X</button>
                                    <lable className={styles.addHeader}>Driver Detail</lable>

                                    <div className={styles.formDiv1}>

                                        <div className={styles.input}>
                                            <lable>First Name</lable>
                                            <input 
                                            name='driverName' type="text"
                                                value={driverName}
                                                disabled={diabled}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Gender</lable>
                                            <input value={dataSource.gender}></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>License Number</lable>
                                            <input name='licenseNumber' type="text"
                                                value={licenseNumber}
                                                disabled={diabled}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Driver Licence Picture</lable>
                                           {!select ? <a href={licensePic} target="_blank" rel="noopener noreferrer">
                                            <img src={licensePic} 
                                            alt={`${driverName}`} 
                                             />
                                             </a>:
                                             <input type='file'
                                             name='licensePic'
                                             onChange={(e)=>setlicensePic(e.target.files[0])}>
                                             </input>}
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Driver Picture</lable>
                                            {!select ? <a href={driverPic} target="_blank" rel="noopener noreferrer">
                                            <img src={driverPic} 
                                            alt={`${driverName}`} 
                                             />
                                             </a> :
                                             <input type='file'
                                            onChange={(e)=>{setdriverPic(e.target.files[0])}}>
                                                </input>}
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Date Of Birth</lable>
                                            <input name='birtDate' type="Date"
                                                value={dataSource.birthDate}
                                            ></input>
                                        </div>


                                        <div className={styles.input}>
                                            <lable>Phone Number</lable>
                                            <input name='phoneNumber' type="text"
                                                value={OwnerPhone}
                                                    disabled={diabled}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Exeperiance</lable>
                                            <input name='experience' type="text"
                                                value={experience}
                                                disabled={diabled}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>License Grade</lable>
                                            <input name='licenseGrade' type="text"
                                                value={licenseGrade}
                                                disabled={diabled}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Issue Date</lable>
                                            <input name='licenseIssueDate' type="date"
                                                value={licenseIssueDate}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Expire Date</lable>
                                            <input name='licenseExpireDate' type="date"
                                                value={licenseExpireDate}
                                                disabled={diabled}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Status</lable>
                                            <input name='Expire Date' type="text"
                                                value={dataSource.status}
                                                diabled={diabled}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Vehicle Owner</lable>
                                            <input name='status' type="text"
                                                value={dataSource.vehicleOwner}
                                                // disabled={diabled}
                                            ></input>

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
                                </div>
                            </div>
                        </div>
                    </div>
                </div> : ""}  

                 </>      
                // </form>







    )
}
