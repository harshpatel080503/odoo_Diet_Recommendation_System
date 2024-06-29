import streamlit as st
import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier  # Replace with your model or method
import pickle

def predict_food(calories, food_type, model):


    input_features = np.array([[calories,food_type]])  

 
    prediction = model.predict(input_features) 

    return prediction
def calculate_bmi(weight_kg, height_m):
    return weight_kg / (height_m ** 2)

def interpret_bmi(bmi):
    if bmi < 18.5:
        return "Underweight"
    elif bmi < 25:
        return "Normal weight"
    elif bmi < 30:
        return "Overweight"
    else:
        return "Obesity"

def calculate_bmr(weight_kg, height_cm, age, gender):
    if gender == 'Male':
        return 88.362 + (13.397 * weight_kg) + (4.799 * height_cm) - (5.677 * age)
    elif gender == 'Female':
        return 447.593 + (9.247 * weight_kg) + (3.098 * height_cm) - (4.330 * age)
    else:
        return None

def main():

    st.title('Food Name Prediction App')

    with open('Diet.pkl', 'rb') as f:
        model = pickle.load(f)
        
    st.header("Receipe Recommnender")
    st.write('Enter the calories and type to predict the food name.')

    calories = st.number_input('Calories', min_value=0.0, max_value=10000.0, step=1.0)
    food_type = st.selectbox('Type', [0, 1])
    st.write('0 - "Non Vegetarian"')
    st.write('1 - "Vegetarian "')


    if st.button('Predict'):

        prediction = predict_food(calories, food_type, model)
        st.success(f'Predicted Food Name: {prediction}')
        
    st.header("BMI Calculator")
    weight_kg = st.number_input("Enter your weight in kilograms (kg):", min_value=0.0, step=0.1)
    height_cm = st.number_input("Enter your height in centimeters (cm):", min_value=0.0, step=0.1)
    height_m = height_cm / 100 
    if st.button("Calculate BMI"):
        if weight_kg > 0 and height_cm > 0:
            bmi = calculate_bmi(weight_kg, height_m)
            bmi_category = interpret_bmi(bmi)
            st.success(f"Your BMI is: {bmi:.2f}")
            st.info(f"You are categorized as: {bmi_category}")
        else:
            st.error("Please enter valid weight and height.")

    st.header("BMR Calculator")
    age = st.number_input("Enter your age:", min_value=0, step=1)
    gender = st.selectbox("Select your gender:", ("Male", "Female"))

    if st.button("Calculate BMR"):
        if weight_kg > 0 and height_cm > 0 and age > 0:
            bmr = calculate_bmr(weight_kg, height_cm, age, gender)
            st.success(f"Your BMR is: {bmr:.2f} calories/day")
        else:
            st.error("Please enter valid weight, height, and age.")


if __name__ == '__main__':
    main()
