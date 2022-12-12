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
import './users_edit.css';
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
                <div className="users_edit_container">

                    {/*---------------navigation---------------*/}

                    <div className="users_edit_navigation">
                        <ul>
                            <li>
                                <Link to="/dashboard"> <p class="hovertext" data-hover="Home"><FaHome size="2rem" color='white'></FaHome><p></p></p></Link>
                            </li>
                            <li>
                                <Link to="/Total_number_of_vehicle"><p class="hovertext" data-hover="Vehicle"><AiFillCar className='sty' size="2rem" color='white'></AiFillCar></p></Link>
                            </li>
                            <li>
                                <Link to="/tracking"><p class="hovertext" data-hover="Tracking"><RiGpsFill size="2rem" color='white'></RiGpsFill></p></Link>
                            </li>
                            <li>
                                <Link to="#"> <p class="hovertext" data-hover="Monitor Vehicles"><MdMonitor size="2rem" color='white'></MdMonitor></p></Link>
                            </li>
                            <li>
                                <Link to="/users">  <p class="hovertext" data-hover="Users"><FaUsers size="2rem" color='#00cc44'></FaUsers></p></Link>
                            </li>
                            <li>
                                <Link to="/alert"><p class="hovertext" data-hover="Alert"><HiBellAlert size="2rem" color='white'></HiBellAlert></p></Link>
                            </li>
                            <li>
                                <Link to="#"><p class="hovertext" data-hover="Report"><HiDocumentReport size="2rem" color='white'></HiDocumentReport></p></Link>
                            </li>
                            <li>
                                <Link to="/Company_registration"> <p class="hovertext" data-hover="Registration"><FaRegIdCard size="1.8rem" color='white'></FaRegIdCard></p></Link>
                            </li>
                            <li>
                                <Link to="/message_overview"><p class="hovertext" data-hover="Communication"><BsFillChatDotsFill size="1.8rem" color='white'></BsFillChatDotsFill></p></Link>
                            </li>
                            <li>
                                <p class="hovertext" data-hover="Profile"><FaUserAlt size="1.8rem" color='white'></FaUserAlt></p>
                            </li>
                            <li>
                                <p class="hovertext" data-hover="Setting"><AiFillSetting size="2rem" color='white'></AiFillSetting></p>
                            </li>
                        </ul>
                    </div>


                    {/* ---------------header--------------- */}

                    <div className="company_header">
                        <h2 className='header_title'>Bazra Motors / <h6> Details/Edit</h6></h2>
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

                            <div className='first_div'>
                                <h1>Company Information</h1>
                                <div className='company_information'>
                                    <div>
                                        <p>Company Name <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                        <input type="text" placeholder='Bazra Motors' disabled={this.state.diabled}></input>

                                    </div>
                                    <div>
                                        <p>Company Sector <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                        <input type="text" placeholder='Motors' disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>Company Type <FaStarOfLife className='icon' size="0.5rem" color='red'></FaStarOfLife></p>
                                        <select disabled={this.state.diabled}>
                                            <option value=''>Transport</option>
                                            <option value='plc'>Public Llimited Company</option>
                                            <option value='plc'>Government</option>
                                            <option value='plc'>Public Llimited Company</option>
                                            <option value='plc'>Public Llimited Company</option>
                                        </select>
                                    </div>
                                </div>
                            </div>


                            <div className='second_div'>
                                <h1>Company Address</h1>
                                <div className='company_Address'>
                                    <div>
                                        <p>Region </p>
                                        <input placeholder="Addis Ababa" disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>Sub City </p>
                                        <input placeholder="Bole" disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>Specfic Location </p>
                                        <input type="text" placeholder='Friendship' disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>City </p>
                                        <input placeholder="Addis Ababa" disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>Woreda </p>
                                        <input type="text" placeholder='18' disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>House Number </p>
                                        <input type="text" placeholder='21/122' disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>Phone Number </p>
                                        <input type="text" placeholder='0911893462' disabled={this.state.diabled}></input>
                                    </div>
                                </div>
                            </div>

                            <div className='Third_div'>
                                <h1>Owner Information</h1>
                                <div className='owner_information'>
                                    <div>
                                        <p>First Name</p>
                                        <input type="text" placeholder='Abebe' disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>Last Name </p>
                                        <input type="text" placeholder='Abebe' disabled={this.state.diabled}></input>

                                    </div>
                                    <div>
                                        <p>Phone Number</p>
                                        <input type="text" placeholder='0911893462' disabled={this.state.diabled}></input>
                                    </div>
                                    <div>
                                        <p>Email </p>
                                        <input type="email" placeholder='xyz@gmail.com' disabled={this.state.diabled}></input>
                                    </div>
                                </div>
                            </div>

                            <div className='Third_div'>
                                <h1>Additional Information</h1>
                                <div className='additional_information'>
                                    <div>
                                        <p>Notification Pereference</p>
                                        <select className='select' disabled={this.state.diabled}>
                                            <option value=''>SMS</option>
                                            <option value='plc'>Select Notification Preference</option>
                                            <option value='plc'>Select Notification Preference</option>
                                            <option>Select Notification Preference</option>
                                            <option>Select Notification Preference</option>
                                        </select>

                                    </div>
                                    <div>
                                        <p>Service Neded</p>
                                        <select className='select' disabled={this.state.diabled}>
                                            <option value=''>Tracking</option>
                                            <option value='plc'>Select Service Neded</option>
                                            <option value='plc'>Select Service Neded</option>
                                            <option>Select Service Neded</option>
                                            <option>Select Service Neded</option>
                                        </select>
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