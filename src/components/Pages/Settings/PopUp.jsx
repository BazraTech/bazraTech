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
        if (title === 'Create_Role') {
            Create_Role();
        }
        if (title === 'Create_Driver_Status') {
            Create_Driver_Status();
        }
        if (title === 'Create_Alert_Type') {
            Create_Alert_Type();
        }
        if (title === 'Create_Trip_Type') {
            Create_Trip_Type();
        }
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
        if (title === 'Add_Service_Needed') {
            Add_Service_Needed();
        }

    };
    
    const [notifications, setNotification] = useState("");
    const notification = notifications;
    const vehicleConditon = notifications;
    const vehicleCatagory = notifications;
    const companysector = notifications; 
    const companyType = notifications;
    const serviceNeeded = notifications;
    const rolename = notifications;
    const status = notifications;
    const alertType = notifications;
    const tripType = notifications;
    

    async function Create_Role() {
        let item =
        {
            rolename,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateRole";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPop(false);
            } else {
                console.log("failed");
                swal(`Failed To Register ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Create_Driver_Status() {
        let item =
        {
            status,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateDriverStatus";
        try {
            const response = await fetch(url, options); 
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setNotification("");
                setPop(false);
            } else {
                console.log("failed");
                swal(`Failed To Register ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Create_Alert_Type() {
        let item =
        {
            alertType,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateAlertType";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPop(false);
            } else {
                console.log("failed");
                swal(`Failed To Register ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Create_Trip_Type() {
        let item =
        {
            tripType,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateTripType";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPop(false);
            } else {
                console.log("failed");
                swal(`Failed To Register ${mess}`, "Error", "error");
            }
        } catch (error) {
            console.error(error);
        }
    }


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
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPop(false);
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
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPop(false);
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
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPop(false);
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
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPop(false);
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
            companyType,
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
        const url1 = "http://198.199.67.201:9090/Api/Admin/CreateCompanyType";
        try {
            const response = await fetch(url1, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPop(false);
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
            serviceNeeded,
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
        const url = "http://198.199.67.201:9090/Api/Admin/CreateServiceNeeded";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            console.log(result);
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            console.log(mess);
            if (response.ok) {
                console.log("Signup successful");
                swal("Successful",  `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPop(false);
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
