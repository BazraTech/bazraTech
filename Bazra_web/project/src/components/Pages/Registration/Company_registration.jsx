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
import { FaStarOfLife } from 'react-icons/fa';
import './company_registration.css';
import { useForm } from 'react-hook-form';
import { Link } from 'react-router-dom';
import { HiMenuAlt1 } from "react-icons/hi";

export default function Company_registration() {


    {/*------------------ Validation for company registration ----------------- */ }

    {/*---------------- handle events ----------------- */ }
    const { register, handleSubmit, watch, formState: { errors } } = useForm();

    {/*---------------- handle submit values ----------------- */ }
    const onSubmit = data => console.log(data);

    return (
        <div className="company_container">

            {/*--------------- Company Container ---------------*/}

            <div className="company_navigation">
                <ul>
                    <li>
                        <Link to="/dashboard">
                            <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Total_number_of_vehicle">
                            <p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/tracking">
                            <p class="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" color='white'></RiGpsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="#">
                            <p class="hovertext" data-hover="Monitor Vehicles"><MdMonitor size="2rem" color='white'></MdMonitor></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/users">
                            <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='white'></FaUsers></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/alert">
                            <p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/report">
                            <p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/Company_registration">
                            <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='00cc44'></FaRegIdCard></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/message_overview">
                            <p class="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="#">
                            <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                        </Link>
                    </li>
                    <li>
                        <Link to="/settings">
                            <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                        </Link>
                    </li>
                </ul>
            </div>


            {/* --------------- Company header --------------- */}

            <div className="company_header">
                <h2 className='header_title'>Bazra Motors / <h6>Registaration</h6></h2>
                <p className='menu_controler'><HiMenuAlt1 size="2rem" color='black'></HiMenuAlt1></p>
                <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
            </div>


            {/* --------------- Registration- -------------- */}

            <section className='company_register'>
                <form className='form' onSubmit={handleSubmit(onSubmit)}>

                    {/* --------------- Company information- -------------- */}

                    <div className='first_div'>
                        <h1>Company Information</h1>
                        <div className='company_information'>
                            <div>
                                <p>Company Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("organizationName", { required: true })} placeholder='Enter organization name'></input>
                                {errors.organizationName?.type === "required" && <span className='validate_text'>*please enter the organization name</span>}
                            </div>
                            <div>
                                <p>Company Type <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("companyType", { required: true })} placeholder='Enter Campany Type'></input>
                                {errors.companyType?.type === "required" && <span className='validate_text'>*please enter the company type</span>}
                            </div>
                            <div>
                                <p>Company Sector <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select  {...register("sectorType", { required: '*Company sector is required' })}>
                                    <option value=''>Select company sector</option>
                                    <option value='plc'>Public Llimited Company</option>
                                    <option value='plc'>Government</option>
                                    <option value='plc'>Public Llimited Company</option>
                                    <option value='plc'>Public Llimited Company</option>
                                </select>
                                {errors.sectorType && <span className='validate_text'>{errors.sectorType.message}</span>}
                            </div>
                        </div>
                    </div>

                    {/* --------------- Company Address- -------------- */}
                    <div className='second_div'>
                        <h1>Company Address</h1>
                        <div className='company_Address'>
                            <div>
                                <p>Region <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input  {...register("region", { required: '*please fill your region' })} placeholder="Please enter your region"></input>
                                {errors.region && <span className='validate_text'>{errors.region.message}</span>}
                            </div>
                            <div>
                                <p>Sub City <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input  {...register("subCity", { required: '*please fill your Sub-city' })} placeholder="Please enter your Sub-City"></input>
                                {errors.subCity && <span className='validate_text'>{errors.subCity.message}</span>}
                            </div>
                            <div>
                                <p>Specfic Location <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("specificLocation")} placeholder='Enter Specfic Location'></input>
                            </div>
                            <div>
                                <p>City <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input  {...register("city", { required: '*please fill your city' })} placeholder="Please enter your City"></input>
                                {errors.city && <span className='validate_text'>{errors.city.message}</span>}
                            </div>
                            <div>
                                <p>Woreda <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text"  {...register("Woreda", { required: "*please fill your Woreda", pattern: { value: /^[0-9]+[0-9]*$/, message: 'please enter a vaild number' } })} placeholder='Enter Your Woreda'></input>
                                {errors.Woreda && <span className='validate_text'>{errors.Woreda.message}</span>}
                            </div>
                            <div>
                                <p>House Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text"  {...register("houseNumber", { required: "*please fill your house number", pattern: { value: /^[0-9]+[0-9]*$/, message: 'please enter a vaild number' } })} placeholder='Enter House Number'></input>
                                {errors.houseNumber && <span className='validate_text'>{errors.houseNumber.message}</span>}
                            </div>
                            <div>
                                <p>Phone Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("officeNumber", { required: "*please fill your company number" })} placeholder='Enter Phone Number'></input>
                                {errors.officeNumber && <span className='validate_text'>{errors.officeNumber.message}</span>}
                            </div>
                        </div>
                    </div>

                    {/* --------------- Owner information- -------------- */}
                    <div className='Third_div'>
                        <h1>Owner Information</h1>
                        <div className='owner_information'>
                            <div>
                                <p>First Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("firstName", { required: true })} placeholder='Enter Your first name'></input>
                                {errors.firstName?.type === "required" && <span className='validate_text'>*please enter your name</span>}
                            </div>
                            <div>
                                <p>Last Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("lastName", { required: true })} placeholder='Enter Your last name'></input>
                                {errors.lastName?.type === "required" && <span className='validate_text'>*please enter your last name</span>}
                            </div>
                            <div>
                                <p>Phone Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("customerNumber", { required: "*please fill your mobile nuber" })} placeholder='Enter Phone Number'></input>
                                {errors.customerNumber && <span className='validate_text'>{errors.customerNumber.message}</span>}
                            </div>
                            <div>
                                <p>Email <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="email" {...register("emailAddress", { required: "*please enter your email address", pattern: { value: /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/, message: 'Please fill a valid Email' } })} placeholder='Enter your Email'></input>
                                {errors.emailAddress && <span className='validate_text'>{errors.emailAddress.message}</span>}
                            </div>
                        </div>
                    </div>

                    <div className='Third_div'>
                        <h1>Additional Information</h1>
                        <div className='additional_information'>
                            <div>
                                <p>Notification Pereference <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select className='select' {...register("notificationPreference", { required: '*please choose your notification preference' })}>
                                    <option value=''>Select Notification Preference</option>
                                    <option value='plc'>Select Notification Preference</option>
                                    <option value='plc'>Select Notification Preference</option>
                                    <option>Select Notification Preference</option>
                                    <option>Select Notification Preference</option>
                                </select>
                                {errors.notificationPreference && <span className='validate_text'>{errors.notificationPreference.message}</span>}
                            </div>
                            <div>
                                <p>Service Neded <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select className='select' {...register("serviceNeeded", { required: '*please choose service needed' })}>
                                    <option value=''>Select Service Neded</option>
                                    <option value='plc'>Select Service Neded</option>
                                    <option value='plc'>Select Service Neded</option>
                                    <option>Select Service Neded</option>
                                    <option>Select Service Neded</option>
                                </select>
                                {errors.serviceNeeded && <span className='validate_text'>{errors.serviceNeeded.message}</span>}
                            </div>
                        </div>
                    </div>

                    <div className='second_div'>
                        <div className='registerd_vehicle'><h1>Vehicle Information</h1> <div className='Vehicle_number'><h1>Registerd Vehicle</h1><h1 className='number' >10</h1></div></div>
                        <div className='vehicle_information'>
                            <div>
                                <p>Vehicle Catagory <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select className='select' {...register("vehicleCatagory", { required: '*Vehicle catagoty  is required' })}>
                                    <option value='' selected disabled>Select Vecicle Catagory</option>
                                    <option value=''>Select Vecicle Catagory</option>
                                    <option value=''>Select Vecicle Catagory</option>
                                    <option value=''>Select Vecicle Catagory</option>
                                    <option value=''>Select Vecicle Catagory</option>
                                </select>
                                {errors.vehicleCatagory && <span className='validate_text'>{errors.vehicleCatagory.message}</span>}
                            </div>
                            <div>
                                <p>Vehicle Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("vehicleName", { required: true })} placeholder='Enter Vehicle Name'></input>
                                {errors.organizationName?.type === "required" && <span className='validate_text'>*please enter vehicle name</span>}
                            </div>
                            <div>
                                <p>Vehicle Condition <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <select className='select' {...register("vehicleCondition", { required: '*Vecicle Condition is required' })}>
                                    <option value=''>Select Vecicle Condition</option>
                                    <option>Select Vecicle Condition</option>
                                    <option>Select Vecicle Condition</option>
                                    <option>Select Vecicle Condition</option>
                                    <option>Select Vecicle Condition</option>
                                </select>
                                {errors.vehicleCondition && <span className='validate_text'>{errors.vehicleCondition.message}</span>}
                            </div>
                            <div>
                                <p>Plate Number <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <div className='plate_number'>
                                    <select className='select' {...register("plateNumber", { required: '*plate number is required' })}>
                                        <option value=''>AD</option>
                                        <option>ET</option>
                                        <option>ORO</option>
                                        <option>AM</option>
                                        <option>TG</option>
                                    </select>
                                    <input type="number" {...register("code")} placeholder='4'></input>
                                    <input type="number" {...register("idd")} placeholder='00034'></input>
                                    {errors.plateNumber && <span className='validate_text'>{errors.plateNumber.message}</span>}
                                </div>
                            </div>

                            <div>
                                <p>Manufacture Date <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="date" {...register("manufactureDate", { required: '*Manufacture date is required' })} placeholder='Enter Manufactureing Date'></input>
                                {errors.manufactureDate && <span className='validate_text'>{errors.manufactureDate.message}</span>}
                            </div>
                            <div>
                                <p>Device ID <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                <input type="text" {...register("deviceID", { required: '*Device ID is required' })} placeholder='Enter Device ID'></input>
                                {errors.deviceID && <span className='validate_text'>{errors.deviceID.message}</span>}
                            </div>
                        </div>
                    </div>
                    <div className='company_button'>
                        <button className='add'>Add</button>
                    </div>

                </form>

            </section>


            {/* ---------------end Registaration--------------- */}
        </div>
    )
}
