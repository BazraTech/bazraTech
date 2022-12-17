import React, { Component } from 'react'
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
import './vehicle_detail.css';
import { useForm } from 'react-hook-form';
import { Link } from 'react-router-dom';
import { HiMenuAlt1 } from "react-icons/hi";

class Users_edit extends Component {

    state = {
        diabled: true
    }

    handleChange = () => {

        this.setState({
            diabled: false
        });
    }


    render() {
        return (
            <div>
                <div className="company_container">

                    {/*---------------navigation---------------*/}

                    <div className="company_navigation">
                        <ul>
                            <li>
                                <Link to="/dashboard">
                                    <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p>
                                </Link>
                            </li>
                            <li>
                                <Link to="/Total_number_of_vehicle">
                                    <p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='00cc44'></AiFillCar></p>
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
                                    <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='white'></FaRegIdCard></p>
                                </Link>
                            </li>
                            <li>
                                <Link to="/message_overview">
                                    <p class="hovertext" data-hover="Communication">
                                        <BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p>
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


                    {/* --------------- Vehicle header --------------- */}

                    <div className="company_header">
                        <h2 className='header_title'>Bazra Motors / <h6> Details</h6></h2>
                        <p className='menu_controler'><HiMenuAlt1 size="2rem" color='black'></HiMenuAlt1></p>
                        <p><FiLogOut size="2rem" color='black'></FiLogOut></p>
                    </div>


                    {/* ---------------Registration--------------- */}



                    <section className='company_register'>
                        <div className='user_header'>
                            <p>User ID</p>
                            <p>BA 00001</p>
                            <p>Name</p>
                            <p>Abebe</p>
                        </div>
                        <form className='form'>

                            <div className='second_div'>
                                <div className='registerd_vehicle'><h1>Vehicle Information</h1> <div className='Vehicle_number'><h1>Registerd Vehicle</h1><h1 className='number' >10</h1></div></div>
                                <div className='vehicle_information'>
                                    <div>
                                        <p>Vehicle Catagory </p>
                                        <select className='select' disabled={this.state.diabled}>
                                            <option selected disabled>Long</option>
                                            <option>Select Vecicle Catagory</option>
                                            <option>Select Vecicle Catagory</option>
                                            <option>Select Vecicle Catagory</option>
                                            <option>Select Vecicle Catagory</option>
                                        </select>
                                    </div>
                                    <div>
                                        <p>Vehicle Name </p>
                                        <input type="text" placeholder='Lada' disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>Vehicle Condition <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                        <select className='select' disabled={this.state.diabled}>
                                            <option selected disabled>New</option>
                                            <option>Select Vecicle Condition</option>
                                            <option>Select Vecicle Condition</option>
                                            <option>Select Vecicle Condition</option>
                                            <option>Select Vecicle Condition</option>
                                        </select>
                                    </div>
                                    <div>
                                        <p>Plate Number</p>
                                        <div className='plate_number'>
                                            <input type="text" placeholder='ET' disabled={this.state.diabled}></input>
                                            <input type="number" placeholder='4' disabled={this.state.diabled}></input>
                                            <input type="text" placeholder='00078' disabled={this.state.diabled}></input>
                                        </div>
                                    </div>

                                    <div>
                                        <p>Manufacture Date </p>
                                        <input type="Date" disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>Device ID</p>
                                        <input type="text" placeholder='100002' disabled={this.state.diabled}></input>
                                    </div>
                                </div>
                            </div>

                        </form>
                        <div className='company_button'>
                            <button className='addd' onClick={this.handleChange}>Edit</button>
                            <br />
                            <button className='ad' disabled={this.state.diabled}>Update</button>

                        </div>


                    </section>


                    {/* ---------------end Registaration--------------- */}
                </div>
            </div>
        )
    }
}

export default Users_edit