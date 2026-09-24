import streamlit as st
import pandas as pd
import os
import re



# PAGE CONFIGURATION


st.set_page_config(
    page_title="Nigeria Food Rescue Intelligence",
    page_icon="♻️",
    layout="wide"
)



# TITLE


st.title("♻️ Nigeria Food Rescue Intelligence")

st.markdown(
    """
    **An interactive data assistant for exploring food surplus,
    rescue activity and impact across Nigerian cities.**
    
    *Data shown is synthetic/illustrative and was created for portfolio exploration.*
    """
)



# LOAD DATA


DATA_PATH = os.path.join(
    os.path.dirname(__file__),
    "..",
    "data",
    "synthetic",
    "food_rescue_synthetic_africa_100k.csv"
)


@st.cache_data
def load_data():

    df = pd.read_csv(DATA_PATH)

    # Nigeria only
    df = df[
        df["country"]
        .astype(str)
        .str.strip()
        .str.lower()
        == "nigeria"
    ].copy()

    # Convert numerical columns
    numeric_columns = [
        "surplus_items",
        "surplus_kg",
        "meals_available",
        "meals_rescued",
        "meals_expired",
        "rescue_rate",
        "revenue_recovered_local",
        "revenue_recovered_usd",
        "co2e_avoided_kg"
    ]

    for col in numeric_columns:
        df[col] = pd.to_numeric(df[col], errors="coerce")

    return df


df = load_data()



# BASIC METRICS

total_surplus = df["surplus_kg"].sum()
total_available = df["meals_available"].sum()
total_rescued = df["meals_rescued"].sum()
total_expired = df["meals_expired"].sum()

rescue_rate = (
    total_rescued / total_available
    if total_available > 0
    else 0
)

revenue_recovered = df["revenue_recovered_usd"].sum()
co2e_avoided = df["co2e_avoided_kg"].sum()



# KPI SECTION

col1, col2, col3, col4, col5 = st.columns(5)

col1.metric(
    "Total Surplus",
    f"{total_surplus:,.0f} kg"
)

col2.metric(
    "Meals Available",
    f"{total_available:,.0f}"
)

col3.metric(
    "Meals Rescued",
    f"{total_rescued:,.0f}"
)

col4.metric(
    "Rescue Rate",
    f"{rescue_rate:.1%}"
)

col5.metric(
    "CO₂e Avoided",
    f"{co2e_avoided:,.0f} kg"
)


st.divider()



# CHAT SECTION


st.subheader("💬 Ask the Nigeria Food Rescue Intelligence Chat")

st.caption(
    "Ask questions about surplus food, cities, business types, "
    "food categories, rescue performance and impact."
)


# Example questions

example_questions = [
    "Where is food being rescued the most?",
    "Which city has the most surplus food?",
    "Which business type generates the most surplus?",
    "Which food category has the most surplus?",
    "What is the overall rescue rate?",
    "How many meals expired?",
    "How much revenue was recovered?"
]


st.markdown("**Try asking:**")

for question in example_questions:
    st.markdown(f"- {question}")



# QUESTION PROCESSOR


def answer_question(question):

    q = question.lower().strip()

    
    # OVERALL SURPLUS


    if (
        "total surplus" in q
        or "overall surplus" in q
        or "how much surplus" in q
    ):

        return (
            f"**Total synthetic surplus:** "
            f"{total_surplus:,.2f} kg."
        )


    
    # TOTAL MEALS RESCUED


    if (
        "total meals rescued" in q
        or "how many meals were rescued" in q
        or "meals rescued" in q
    ):

        return (
            f"**{total_rescued:,.0f} meals** were rescued "
            f"in the synthetic Nigeria dataset."
        )


    # TOTAL MEALS AVAILABLE

    if (
        "meals available" in q
        or "available meals" in q
    ):

        return (
            f"**{total_available:,.0f} meals** were available "
            f"for rescue in the synthetic dataset."
        )


    # --------------------------------------------------------
    # RESCUE RATE
    # --------------------------------------------------------

    if (
        "rescue rate" in q
        or "percentage rescued" in q
        or "percent rescued" in q
    ):

        return (
            f"The overall synthetic **rescue rate is "
            f"{rescue_rate:.1%}**."
        )


    # --------------------------------------------------------
    # EXPIRED / UNRESCUED
    # --------------------------------------------------------

    if (
        "expired" in q
        or "unrescued" in q
        or "not rescued" in q
    ):

        return (
            f"Approximately **{total_expired:,.0f} meals** "
            f"were recorded as expired/unrescued."
        )


    # --------------------------------------------------------
    # REVENUE
    # --------------------------------------------------------

    if (
        "revenue" in q
        or "money recovered" in q
        or "revenue recovered" in q
    ):

        return (
            f"The synthetic dataset records approximately "
            f"**${revenue_recovered:,.2f} in recovered revenue**."
        )


    # --------------------------------------------------------
    # CO2 / ENVIRONMENT
    # --------------------------------------------------------

    if (
        "co2" in q
        or "co₂" in q
        or "carbon" in q
        or "environment" in q
    ):

        return (
            f"The dataset estimates approximately "
            f"**{co2e_avoided:,.0f} kg of CO₂e avoided**."
        )


    # --------------------------------------------------------
    # CITY — MOST RESCUED MEALS
    # --------------------------------------------------------

    if (
        "city" in q
        and (
            "most rescued" in q
            or "highest rescued" in q
            or "most meals" in q
        )
    ):

        city_rescue = (
            df.groupby("city")["meals_rescued"]
            .sum()
            .sort_values(ascending=False)
        )

        city = city_rescue.index[0]
        value = city_rescue.iloc[0]

        return (
            f"**{city}** records the highest number of "
            f"rescued meals in the synthetic dataset, "
            f"with approximately **{value:,.0f} meals rescued**."
        )


   
    # CITY — MOST 
  

    if (
        "city" in q
        and (
            "most surplus" in q
            or "highest surplus" in q
            or "most food surplus" in q
        )
    ):

        city_surplus = (
            df.groupby("city")["surplus_kg"]
            .sum()
            .sort_values(ascending=False)
        )

        city = city_surplus.index[0]
        value = city_surplus.iloc[0]

        return (
            f"**{city}** records the highest synthetic "
            f"surplus volume, with approximately "
            f"**{value:,.0f} kg**."
        )


    
    # BUSINESS TYPE — MOST SURPLUS
    

    if (
        "business" in q
        and (
            "most surplus" in q
            or "highest surplus" in q
            or "generate the most" in q
        )
    ):

        business_surplus = (
            df.groupby("business_type")["surplus_kg"]
            .sum()
            .sort_values(ascending=False)
        )

        business = business_surplus.index[0]
        value = business_surplus.iloc[0]

        return (
            f"**{business}s** record the highest synthetic "
            f"surplus volume, with approximately "
            f"**{value:,.0f} kg**."
        )


  
    # FOOD CATEGORY — MOST SURPLUS
    

    if (
        "food category" in q
        or "food categories" in q
        or "category has the most surplus" in q
    ):

        category_surplus = (
            df.groupby("food_category")["surplus_kg"]
            .sum()
            .sort_values(ascending=False)
        )

        category = category_surplus.index[0]
        value = category_surplus.iloc[0]

        return (
            f"**{category}** has the highest synthetic "
            f"surplus volume, with approximately "
            f"**{value:,.0f} kg**."
        )


    # TOP BUSINESS TYPES
   

    if (
        "business types" in q
        or "business type" in q
    ):

        result = (
            df.groupby("business_type")["surplus_kg"]
            .sum()
            .sort_values(ascending=False)
            .head(5)
        )

        answer = "**Top business types by synthetic surplus:**\n\n"

        for business, value in result.items():
            answer += (
                f"- **{business}** — "
                f"{value:,.0f} kg\n"
            )

        return answer


   
    # TOP CITIES

    if (
        "cities" in q
        or "top cities" in q
    ):

        result = (
            df.groupby("city")["meals_rescued"]
            .sum()
            .sort_values(ascending=False)
            .head(5)
        )

        answer = "**Top cities by rescued meals:**\n\n"

        for city, value in result.items():
            answer += (
                f"- **{city}** — "
                f"{value:,.0f} meals\n"
            )

        return answer



    # TOP FOOD CATEGORIES
   
    if (
        "food categories" in q
        or "top food" in q
    ):

        result = (
            df.groupby("food_category")["surplus_kg"]
            .sum()
            .sort_values(ascending=False)
        )

        answer = "**Food categories by synthetic surplus:**\n\n"

        for category, value in result.items():
            answer += (
                f"- **{category}** — "
                f"{value:,.0f} kg\n"
            )

        return answer


  
    # HELP
    

    if (
        "what can i ask" in q
        or "help" in q
        or "questions" in q
    ):

        return """
You can ask questions such as:

- Where is food being rescued the most?
- Which city has the most surplus?
- Which business type generates the most surplus?
- Which food category has the most surplus?
- What is the overall rescue rate?
- How many meals were rescued?
- How many meals expired?
- How much revenue was recovered?
- How much CO₂e was avoided?
"""


    
    # DEFAULT RESPONSE

    return """
I couldn't match that question to the current Nigeria
Food Rescue dataset.

Try asking about:

- cities
- surplus
- meals rescued
- rescue rate
- business types
- food categories
- revenue
- CO₂e
- expired/unrescued meals
"""



# CHAT INPUT

question = st.chat_input(
    "Ask a question about Nigeria food rescue..."
)



# CHAT HISTORY

if "messages" not in st.session_state:
    st.session_state.messages = []


for message in st.session_state.messages:

    with st.chat_message(message["role"]):
        st.markdown(message["content"])


# PROCESS NEW QUESTION


if question:

    st.session_state.messages.append(
        {
            "role": "user",
            "content": question
        }
    )

    with st.chat_message("user"):
        st.markdown(question)

    response = answer_question(question)

    st.session_state.messages.append(
        {
            "role": "assistant",
            "content": response
        }
    )

    with st.chat_message("assistant"):
        st.markdown(response)


# FOOTER


st.divider()

st.caption(
    "Nigeria Food Rescue Intelligence | "
    "Synthetic portfolio dataset | "
    "Not Too Good To Go operational data"
)
