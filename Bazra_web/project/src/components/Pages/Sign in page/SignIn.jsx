import React, { Component } from 'react'
import { useForm } from 'react-hook-form';
import { Routes, Route, Link, useNavigate, Navigate, Router } from "react-router-dom";
import './signin.css';
import Dashboard from '../Dashboard/Dashboard';
import Users from '../Users/Users';
import { useState } from 'react';

export default function SignIn() {

	const [name, setName] = React.useState("")
	const [password, setPasword] = React.useState("")
	const { register, handleSubmit, watch, formState: { errors } } = useForm();

	const onSubmit = () => {

		if (name && password) {
			window.location.href = "/dashboard"
		}
		else window.location.href = "/"
	}
	return (
		<>

			{/* Login page Form */}

			<div className="container">
				<div className="contact-box">
					<div className="left">
					</div>
					<div className="right">
						<form className="right" onSubmit={handleSubmit(onSubmit)}>
							<h2>Welcome To Bazra</h2>
							<lable><b>User Name</b></lable>
							<input type="text" className="field" {...register("name", { required: true })} placeholder="Username" onChange={(e) => setName(e.target.value)} name="name"></input>
							{errors.name?.type === "required" && <span className='validate_text' >please enter your username</span>}

							<lable><p><b>Password</b></p></lable>
							<input type="password" className="field" {...register("password", { required: true })} placeholder="Password" onChange={(e) => setPasword(e.target.value)} name="password"></input>
							{errors.password?.type === "required" && <span className='validate_text' >please enter your password </span>}
							<div className='for'>
								<b><a href='#' className='forget'>Forget Password?</a></b>
							</div>
							<nav>
								<button className="btn" onSubmit={onSubmit}>Sign In</button>
							</nav>
						</form>
					</div>
				</div>
			</div>
		</>

	)
}


