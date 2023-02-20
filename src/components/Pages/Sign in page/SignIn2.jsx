import React, { Component } from 'react'
import { useForm } from 'react-hook-form';
import { Routes, Route, Link, Navigate, Router } from "react-router-dom";
import styles from './signin2.module.css';
import { useState, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import swal from "sweetalert";

export default function () {

    // const history = useNavigate(); 
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");
    const [data, setdata] = useState("");
    const [error, setError] = useState(false);

    const validation = (e) => {
        e.preventDefault();

        if (username.length == 0 || password.length == 0) {
            setError(true);
        }

        if (username && password) {
            login();
        }
    }

    useEffect(() => {
    }, []);

    async function login() {

        const users = { username, password };
        localStorage.setItem("username", username)
        console.log(username)
        let item = { username, password };
        const options = {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                Accept: "application/json",
                Authorization: `Bearer`,
            },
            body: JSON.stringify(item),
        };

        const url = "http://198.199.67.201:9090/Api/SignIn/Admin";
        try {
            const response = await fetch(url, options);
            const result = await response.json();
            localStorage.setItem("user", JSON.stringify(result["user"]));

            const user = localStorage.getItem("user");
            localStorage.setItem("user", JSON.stringify(users));

            if (response.ok) {
                // setLoading(true)

                console.log("Login successful");
                const zz = localStorage.getItem("tuser");
                setdata(zz);
                swal("Successful", "Welcome To Admin DashBoard", "success", {
                    buttons: false,
                    timer: 2000,
                }).then((value) => {
                    localStorage.setItem("user", JSON.stringify(result["user"]));
                    localStorage.getItem("user");
                    localStorage.setItem("jwt", JSON.stringify(result["jwt"]));
                    localStorage.getItem("jwt");
                    window.location.href = "/dashboard";
                }).finally(() => {

                });
            } else {
                console.log("failed");
                swal("Failed To Login", "Wrong Password or Username", "error");
            }
        } catch (error) {
            console.log(error + "error");
            swal({
                title: "Something Went Wrong?",
                text: `net::ERR_INTERNET_DISCONNECTED `,
                icon: "warning",
                dangerMode: true,
            })
        }
    }

    return (
        <>

            {/*-------------- Login page Form ---------------*/}

            <div className={styles.signin}>

                {/*-------------- Left side ---------------*/}

                <div className={styles.left_login}>
                    {/* <img src="./img/location" alt="John" />
                    <img src="./img/loction.png" alt="" /> */}
                </div>

                {/*-------------- Right side ---------------*/}
                <div className={styles.right_login}>
                    <form className={styles.signup_right} onSubmit={validation}>
                        <div className={styles.signForm}>
                            <p className={styles.loginHeader}>Welcome To Bazra</p>
                            <label>User Name</label>
                            <input type="username" placeholder="Username" onChange={e => setUsername(e.target.value)} name="username"></input>
                            {error && username.length <= 0 ? <span className={styles.validateText}>please enter your username</span> : ""}
                            <label>Password</label>
                            <input type="password" placeholder="Password" onChange={e => setPassword(e.target.value)} name="password"></input>
                            {error && password.length <= 0 ? <span className={styles.validateText}>please enter your password</span> : ""}
                            <p>Forget Password?</p>
                            <button className=''>Sign In</button>
                        </div>
                    </form>

                    {/* <form className="signup_right" onSubmit={validation}>
								<h2>Welcome To Bazra</h2>
								<label><b>User Name</b></label>
								<input type="username" className="signup_input_field" placeholder="Username" onChange={e => setUsername(e.target.value)} name="username"></input>
								{error&&username.length<=0 ? <span className='validateText' >please enter your username</span> :""}

								<label><p><b>Password</b></p></label>
								<input type="password" className="signup_input_field"  placeholder="Password" onChange={e => setPassword(e.target.value)} name="password"></input>
								{error&&password.length<=0 ? <span className='validateText' >please enter your password</span> :""}
								<div className='for'>
									<b><a href='#' className='signup_forget'>Forget Password?</a></b>
								</div>
								<nav>
									<button className="signup_button">Sign In</button>
								</nav>
							</form> */}


                </div>
            </div>
        </>

    )
}


