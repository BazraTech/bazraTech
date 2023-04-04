import React, { useState, useEffect } from 'react';
import { useForm } from 'react-hook-form';
import swal from "sweetalert";
import Swal from 'sweetalert2'

export default function PopUp(props) {

    const nandu2 = () => {

        Swal.fire({
            title: title,
            html: `<input type="text" id="login"  class="swallpop" placeholder=${title}>`,
            confirmButtonText: 'Add',
            confirmButtonColor: '#00cc44',
            // focusConfirm: false,
            showCloseButton: true,
            width: "580px",
            showClass: {
                popup: 'animate__animated animate__fadeInDown'
            },
            hideClass: {
                popup: 'animate__animated animate__fadeOutUp'
            },
            preConfirm: () => {
                const login = Swal.getPopup().querySelector('#login').value
                if (!login) {
                    Swal.showValidationMessage(`Please enter data`)
                }
                return { login: login }
            }
        }).then((result) => {
            setPopupAdd(false);
            if (result.isConfirmed) {
                onSubmit(result.value.login)
            }
            else{
                setPopupAdd(false);
            }
        })
    }

    const [popupadd, setPopupAdd] = useState(false);

    const handleClickopen = () => {
        setPopupAdd(!popupadd);
    }

    const title = props.title

    const jwt = JSON.parse(localStorage.getItem('jwt'));// Getting the token from login api

    const { register, handleSubmit, watch, formState: { errors },
    } = useForm();

    // const dddd =() => { 
    //     onSubmit()
    // }
    const [notification, setNotification] = useState("");
    console.log(notification)

    const onSubmit = (inputData) => {

        if (title === 'Create_Role') {
            Create_Role(inputData);
        }
        if (title === 'Create_Driver_Status') {
            Create_Driver_Status(inputData);
        }
        if (title === 'Create_Alert_Type') {
            Create_Alert_Type(inputData);
        }
        if (title === 'Create_Trip_Type') {
            Create_Trip_Type(inputData);
        }
        if (title === 'Add_Notification') {
            Add_Notification(inputData);
        }
        if (title === 'Add_Vehicle_Condition') {
            Add_Vehicle_Condition(inputData);
        }
        if (title === 'Add_vehicle_category') {
            Add_vehicle_category(inputData);
        }
        if (title === 'Add_company_sector') {
            Add_company_sector(inputData);
        }
        if (title === 'Add_company_type') {
            Add_company_type(inputData);
        }
        if (title === 'Add_Service_Needed') {
            Add_Service_Needed(inputData);
        }

    };


    const [notifications, setNotifications] = useState("");


    // const notification = notifications;
    // const vehicleConditon = notifications;
    // const vehicleCatagory = notifications; 
    // const companysector = notifications;
    // const companyType = notifications;
    // const serviceNeeded = notifications;
    // const rolename = notifications;
    // const status = notifications;
    // const alertType = notifications;
    // const tripType = notifications;


    async function Create_Role(rolename) {
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
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal(`${mess}`, "success", {
                    buttons: false, timer: 2000,
                });
                setPopupAdd(false);
            } else {
                swal(`Failed To Register ${mess}`, "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Create_Driver_Status(status) {
        let item =
        {
            status,
        };
        const options = {
            method: "POST",
            headers: {
                'Content-Type': 'application/json', "Accept": "application/json", "Authorization": `Bearer ${jwt}`
            },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Admin/CreateDriverStatus";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal("Successful", `${mess}`, "success", { buttons: false, timer: 2000, });
                setPopupAdd(false);
            } else {
                swal(`Failed To Register ${mess}`, "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Create_Alert_Type(alertType) {
        let item =
        {
            alertType,
        };
        const options = {
            method: "POST",
            headers: {
                'Content-Type': 'application/json', "Accept": "application/json", "Authorization": `Bearer ${jwt}`
            },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Admin/CreateAlertType";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal("Successful", `${mess}`, "success", { buttons: false, timer: 2000, });
                setPopupAdd(false);
            } else {
                swal(`Failed To Register ${mess}`, "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Create_Trip_Type(tripType) {
        let item =
        {
            tripType,
        };
        const options = {
            method: "POST",
            headers: { 'Content-Type': 'application/json', "Accept": "application/json", "Authorization": `Bearer ${jwt}` },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Admin/CreateTripType";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal("Successful", `${mess}`, "success", { buttons: false, timer: 2000, });
                setPopupAdd(false);
            } else {
                console.log("failed");
                swal(`Failed To Register ${mess}`, "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Add_company_sector(companysector) {
        let item =
        {
            companysector,
        };
        const options = {
            method: "POST",
            headers: { 'Content-Type': 'application/json', "Accept": "application/json", "Authorization": `Bearer ${jwt}` },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Admin/CreateCompanySector";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal("Successful", `${mess}`, "success", { buttons: false, timer: 2000, });
                setPopupAdd(false);
            } else {
                swal(`Failed To Register ${mess}`, "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Add_Notification(notification) {
        let item =
        {
            notification,
        };
        const options = {
            method: "POST",
            headers: {
                'Content-Type': 'application/json', "Accept": "application/json", "Authorization": `Bearer ${jwt}`
            },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Admin/CreateNotificationMedium";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal("Successful", `${mess}`, "success", { buttons: false, timer: 2000, });
                setPopupAdd(false);
            } else {
                swal(`Failed To Register ${mess}`, "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Add_Vehicle_Condition(vehicleConditon) {
        let item =
        {
            vehicleConditon,
        };
        const options = {
            method: "POST",
            headers: { 'Content-Type': 'application/json', "Accept": "application/json", "Authorization": `Bearer ${jwt}` },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Admin/CreateVehicleCondition";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal("Successful", `${mess}`, "success", { buttons: false, timer: 2000, });
                setPopupAdd(false);
            } else {
                swal(`Failed To Register ${mess}`, "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Add_vehicle_category(vehicleCatagory) {
        let item =
        {
            vehicleCatagory,
        };
        const options = {
            method: "POST",
            headers: { 'Content-Type': 'application/json', "Accept": "application/json", "Authorization": `Bearer ${jwt}` },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Admin/CreateVehicleCatagory";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal("Successful", `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPopupAdd(false);
            } else {
                swal(`Failed To Register ${mess}`, "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Add_company_type(companyType) {
        let item =
        {
            companyType,
        };
        const options = {
            method: "POST",
            headers: {
                'Content-Type': 'application/json', "Accept": "application/json", "Authorization": `Bearer ${jwt}`
            },
            body: JSON.stringify(item),
        };
        const url1 = "http://198.199.67.201:9090/Api/Admin/CreateCompanyType";
        try {
            const response = await fetch(url1, options);
            const result = await response.json();
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal("Successful", `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPopupAdd(false);
            } else {
                swal(`Failed To Register ${mess}`, "error");
            }
        } catch (error) {
            console.error(error);
        }
    }

    async function Add_Service_Needed(serviceNeeded) {
        let item =
        {
            serviceNeeded,
        };
        const options = {
            method: "POST",
            headers: { 'Content-Type': 'application/json', "Accept": "application/json", "Authorization": `Bearer ${jwt}` },
            body: JSON.stringify(item),
        };
        const url = "http://198.199.67.201:9090/Api/Admin/CreateServiceNeeded";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            localStorage.setItem("message", JSON.stringify(result["message"]));
            const mess = localStorage.getItem("message");
            if (response.ok) {
                swal("Successful", `${mess}`, "success", {
                    buttons: false,
                    timer: 2000,
                });
                setPopupAdd(false);
            } else {
                swal(`Failed To Register ${mess}`, "Error");
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
                {popupadd ?
                    <div>
                        {nandu2()}
                    </div> : ""}
            </div>
        </>

    )
}
