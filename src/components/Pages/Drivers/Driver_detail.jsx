import React from 'react'
import styles from './driver_detail.module.css';
import { Link, NavLink } from 'react-router-dom';
import { useState, useEffect } from 'react';
import swal from "sweetalert";
import axios from "axios";

export default function (props) {


    console.log(props.id);
    let [active, setActive] = useState("total_vehicle");
    let [state, setState] = useState(false);
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
    /**********************reload page**************** */

    const [reloadKey, setReloadKey] = useState(0);

    const handleReload = () => {
    setReloadKey((prevKey) => prevKey + 1);
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
    const [licensePic, setlicensePic]= useState('')
    const [driverPic,setdriverPic]= useState('')
    const [updateDriverInfo,setUpdateDriverInfo]=useState({})
    const [error, setError] = useState(null);
    const [dataSource, setDataSource] = useState([])
    const url = `http://164.90.174.113:9090/Api/Admin/All/Drivers/${props.id}`;
    useEffect(() => {
        fetch(url, options)
            .then(respnse => respnse.json())
                .then(response => {
                    localStorage.setItem("message", JSON.stringify(response["message"])); 
                    const mess = localStorage.getItem("message");
                    console.log(response.status)
              if (response.status == 500) {
                throw new Error('Failed to get the drivers');
              }
              else {
                setDataSource(response)
                setlicensePic(response.licensePic)
                setdriverPic(response.driverPic)
                setUpdateDriverInfo({
                    driverName: response.driverName,
                    licenseNumber: response.licenseNumber,
                    licensePic: licensePic,
                    driverPic: driverPic,
                    // OwnerPhone: response.OwnerPhone,
                    driverPhone: response.phoneNumber,
                    birthDate: response.birthDate,
                    experience: response.experience,
                    licenseGrade: response.licenseGrade,
                    licenseIssueDate: response.licenseIssueDate,
                    licenseExpireDate: response.licenseExpireDate,
                })
            }})
            .catch(error => {
    
              setError(error.message);
              swal(`Failed ${error}`, "Error", "error");
            });
        }, [reloadKey]);
        console.log(dataSource)

    const closePopup5 = () => {
        setPop1(false);
    }
    
console.log(updateDriverInfo)
  
    const handleUpdateChange = (e) => {
        const { name, value } = e.target;
        console.log(name, value);
        setUpdateDriverInfo((prevData) => ({
          ...prevData,
          [name]: value || prevData[name], // Keep the existing value if the input is empty
        }));
      };
      const onSubmit = (e) => {
        e.preventDefault();
    
        update();
      };

      /*******************update Driver inf***** */

  const update = async () => {
    const formData = new FormData();
    formData.append("driverName", updateDriverInfo.driverName);
    formData.append("licenseNumber",'');
    formData.append("driverPhone", '');
    formData.append("birthDate", updateDriverInfo.birthDate);
    formData.append("experience", updateDriverInfo.experience);
    formData.append("licenseGrade", updateDriverInfo.licenseGrade);
    formData.append("licenseIssueDate", updateDriverInfo.licenseIssueDate);
    formData.append("licenseExpireDate", updateDriverInfo.licenseExpireDate);
    // formData.append("licenseFile", updateDriverInfo.licenseFile);
    // formData.append("tinFile", updateDriverInfo.tinFile);
 //Coudn't change the name  i don't know
    //formData.append("licenseFile", updateCargoInfo.licenseFile);
    //formData.append("tinFile", updateCargoInfo.tinFile);
    //    ************* just gusses those two licenseFile and tinFile doesn't satisfy the criteria to be an image file not Url but file
    // because by default you have set the licenseFile and tinFile url value which is not acceptable i think this error totaly depends
    // on the backend developer when checking to store img
    // other are working fine it seems you make //<input value for some inputs instead of //<input defaultValue defaultValue.
    //is very important when changing value and after updating do i have to refresh to see result please No!.
    //last but not least Why does the every time it says phoneNUmber is allready exist please please please !! we are updating
    //phone number could not be updated allways what is that!!
    console.log(formData); //This one doesn't work it like useState it doesn't update imidiately

    try {
      const response = await axios.put(
        `http://164.90.174.113:9090/Api/Admin/UpdateInfo/Driver/${props.id}`,
        formData,
        {
          headers: {
            "Content-Type": "auto",
            Authorization: `Bearer ${jwt}`,
          },
        }
      );
      localStorage.setItem("message", JSON.stringify(response.data["message"]));
      const mess = localStorage.getItem("message");
      console.log(response);
      swal("Successfully Updated", `${mess}`, "success", {
        button: true,
      });
    } catch (error) {
      if (error.response) {
        console.log(error);
        localStorage.setItem(
          "message",
          JSON.stringify(error.response.data["message"])
        );
        const messx = localStorage.getItem("message");
        console.log("message", messx);
        console.log(error.response.data);
        swal("Error", `${messx}`, "error", {
          button: true,
        });
        console.log(error.response.status);
        console.log(error.response.headers);
      } else if (error.request) {
        console.log(error.request);
      } else {
        console.log("Error", error.message);
      }
    }
  };

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
                                    <form className="form" onSubmit={onSubmit}>

                                    <div className={styles.formDiv1}>

                                        <div className={styles.input}>
                                            <lable>First Name</lable>
                                            <input 
                                                name='driverName'
                                                type="text"
                                                value={dataSource.driverName}
                                                disabled={diabled}
                                                onChange={handleUpdateChange}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Gender</lable>
                                            <input
                                             value={dataSource.gender}
                                             disabled
                                             ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>License Number</lable>
                                            <input 
                                            name='licenseNumber'
                                             type="text"
                                            defaultValue={dataSource.licenseNumber}
                                                disabled
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Driver Licence Picture</lable>
                                           {!selecttag ? <a href={dataSource.licensePic} target="_blank" rel="noopener noreferrer">
                                            <img src={dataSource.licensePic} 
                                            alt={`${dataSource.driverName}`} 
                                             />
                                             </a>:
                                             <input type='file'
                                             name='licensePic'
                                             onChange={(e)=>setlicensePic(e.target.files[0])}>
                                             </input>}
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Driver Picture</lable>
                                            {!selecttag ? <a href={dataSource.driverPic} target="_blank" rel="noopener noreferrer">
                                            <img src={dataSource.driverPic} 
                                            alt={`${dataSource.driverName}`} 
                                             />
                                             </a> :
                                             <input type='file'
                                            onChange={(e)=>{setdriverPic(e.target.files[0])}}>
                                                </input>}
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Date Of Birth</lable>
                                            <input 
                                            name='birthDate' 
                                            type="Date"
                                            defaultValue={dataSource.birthDate}
                                            disabled
                                            ></input>
                                        </div>


                                        <div className={styles.input}>
                                            <lable>Phone Number</lable>
                                            <input name='driverPhone' type="text"
                                                value={dataSource.phoneNumber}
                                                    disabled
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Exeperiance</lable>
                                            <input 
                                            name='experience' 
                                            type="text"
                                            defaultValue={dataSource.experience}
                                            disabled={diabled}
                                            onChange={handleUpdateChange}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>License Grade</lable>
                                            <input
                                             name='licenseGrade' 
                                             type="text"
                                             defaultValue={dataSource.licenseGrade}
                                             disabled={diabled}
                                             onChange={handleUpdateChange}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Issue Date</lable>
                                            <input 
                                            name='licenseIssueDate' 
                                            type="date"
                                            defaultValue={dataSource.licenseIssueDate}
                                            onChange={handleUpdateChange}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Expire Date</lable>
                                            <input 
                                            name='licenseExpireDate' 
                                            type="date"
                                            defaultValue={dataSource.licenseExpireDate}
                                            disabled={diabled}
                                            onChange={handleUpdateChange}
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Status</lable>
                                            <input 
                                            name='status'
                                            type="text"
                                            value={dataSource.status}
                                            diabled
                                            ></input>
                                        </div>

                                        <div className={styles.input}>
                                            <lable>Vehicle Owner</lable>
                                            <input 
                                            name='status' 
                                            type="text"
                                            value={dataSource.vehicleOwner}
                                            disabled
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
                            </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> : ""}  

                 </>      
                // </form>







    )
}
