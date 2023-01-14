import React, { useState, useEffect } from 'react';
import { useForm } from 'react-hook-form';
import swal from "sweetalert";

export default function PopUp(props) {

    const [popup, setPop] = useState(false);

    const handleClickopen = () => {
        setPop(!popup);
    }

    const closePopup = () => {
        setPop(false);
    }
    const title = props.title

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const { register, handleSubmit, watch, formState: { errors },
    } = useForm();
    const onSubmit = (data) => {
        console.log(data);
        if (title === 'Add_Notification') {
            Add_Notification();
        }
        if (title === 'Add_Vehicle_Condition') {
            Add_Vehicle_Condition();
        }
        if (title === 'Add_vehicle_category') {
            Add_vehicle_category();
        }
        if (title === 'Add_company_sector') {
            Add_company_sector();
        }
        if (title === 'Add_company_type') {
            Add_company_type();
        }
        if (title === 'Add_company_type') {
            Add_Service_Needed();
        }

    };
    const [notifications, setNotification] = useState("");
    const notification = notifications;
    const vehicleConditon = notifications;
    const vehicleCatagory = notifications;
    const companysector = notifications;
    const companyTypes = notifications;
    const service = notifications;
    // const handleClick = (e) => {
    //     signupxx();
    // };

    async function Add_company_sector() {
        let item =
        {
            companysector,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateCompanySector";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful", "Notification Preference Registerd Successfuly", "success", {
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

    async function Add_Notification() {
        let item =
        {
            notification,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateNotificationMedium";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful", "Notification Preference Registerd Successfuly", "success", {
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


    async function Add_Vehicle_Condition() {
        let item =
        {
            vehicleConditon,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateVehicleCondition";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful", "Vehicle Condition Registered Successfuly", "success", {
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


    async function Add_vehicle_category() {
        let item =
        {
            vehicleCatagory,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateVehicleCatagory";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful", "Vehicle Category Registered Successfuly", "success", {
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

    async function Add_company_type() {
        let item =
        {
            companyTypes,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateCompanyType";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful", "Notification Preference Registerd Successfuly", "success", {
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

    async function Add_Service_Needed() {
        let item =
        {
            service,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateCompanyType";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful", "Notification Preference Registerd Successfuly", "success", {
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


    return ( 

        <>
            <div>
                <div className='add_notification' onClick={handleClickopen}>{title}</div>
            </div>
            {/* <div>
                {popup ?
                    <div className='popup_modal'>
                        <div className='popup_close_button'>
                            <button className='x-press-report' onClick={closePopup}>X</button>
                        </div>

                        <div className="item-report">
                            <div className="report-status-popup">
                                <div class="popup_main" >
                                    <h2>{title}</h2>
                                    <form className='form'  onSubmit={handleSubmit(onSubmit)}>
                                    <input  value={notifications}  placeholder={title}  onChange={(e) => setNotification(e.target.value)}></input>
                                  
                                    <div className='send_button'>
                                        <button className='popup_add'>Add</button>
                                        <button onClick={closePopup} className='popup_cancle'>Cancle</button>
                                    </div>
                                    </form>
                                </div>

                            </div>
                        </div>



                    </div> : ""}

            </div> */}
            <div>
                {popup ?
                    <div>
                        <div className='popup0'> 
                            <div className='popup-innerq'>
                                <div onClick={closePopup} className='close'>X</div>
                                <div className='fgf'>
                                    <h2 className='mnm'>{title}</h2>
                                    <form className='form'  onSubmit={handleSubmit(onSubmit)}>
                                    <input value={notifications}  placeholder={title}  onChange={(e) => setNotification(e.target.value)}></input>
                                    <div className='send_button'>
                                        <button className='popup_add'>Add</button>
                                        <button onClick={closePopup} className='popup_cancle'>Cancle</button>
                                    </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                    </div> : ""}
            </div>
        </>

    )
}
