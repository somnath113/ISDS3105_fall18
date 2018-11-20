Final Project
================

### Deadlines

  - October, 25: Upload a README on your GitHub repo with your research
    question and type of output (pdf, HTML page, dashboard, etc.).

  - November, 20: Schedule your presentation

  - November, 26-30: Presentation

## What is Open Data

source: [Open Data BR - about](https://data.brla.gov/about)

The concept of open data is quite simple – to “open up” access to public
information of all types, thereby letting the public consume and
interact with data in a variety of ways. This data may be used to
facilitate decision making; encourage innovation through the development
of tools or applications to further support public data consumption;
hold government departments and agencies accountable and promote
transparency; and much more.

Open Data BR is an initiative that exists as part of a broader
commitment to the residents of Baton Rouge focused on creating a more
efficient, effective and responsive City-Parish government while
developing Baton Rouge into a hub for digital growth and technological
innovation.

More specifically, Open Data BR is focused on providing access to data
and information, which can be utilized to create efficiencies and
improve coordination among City-Parish departments, streamline citizen
engagement, encourage economic development and business innovation, and
support a more effective, responsive, transparent and connected
City-Parish government. At the City-Parish level, department heads and
staff can utilize this kind of data to identify trends and gaps in
services, and efficiently allocate resources. Meanwhile, residents and
businesses can use the same data to better understand government and
build solutions to improve the services provided by local, public-sector
agencies.

## Your Goal

Your goal is to leverage open data to analyze a relevant issue for the
city of Baton Rouge. Ideally, you want to summarise the goal of your
project in one main research question that your presentation will
address (see [Developing a (non-trivial) Research Question](#RQ)).

There are no restrictions regarding the final output of your work.
Although an HTML page is arguably the most portable output, often a
printable PDF-document might help to present your story more linearly.
Every format has peculiar strengths and challenges, so do not feel like
something interactive will necessarily be superior: it all depends on
how it is implemented.

Your final presentation (25-30mins) should cover:

1.  What is your research question/the problem you are trying to solve?

2.  What is the design and of your artifact? For instance, if you use
    different data sources, how do you aggregate them?

3.  Presenting your results and limitations. What did you find? Any
    technical aspect that you are particularly proud of? Any issues with
    the data (e.g., missing values, suspicious patterns)

4.  Present your work

There are no specific guidelines regarding the presentation format. You
can directly present the dashboard you created, HTML markdown, pdf or
powerpoint.

You will present in the conference room 2240. Please discuss within your
group your availabilities and let me know by **November, 20** when you
can present - I will reserve the conference room for you.

# Getting Started with the Project

## Developing a (non-trivial) Research Question

Picking a research question that is **relevant** to the community is
crucial, but it also needs to be non-trivial. For instance, “how many
committed crimes occur each month?” is relevant for assessing crime
rates, but you want to target a higher level of sophistication. For
instance, “does crime rate increase during natural disasters?”.
Addressing this question require you do isolate crisis events that
constitute natural disasters (e.g., 2016 Flood), understand if there is
an increase during that time period (“increase” compared to what? Is it
just seasonal of due to the flood?), and maybe understand whether the
increase is due to specific disaster-related crimes (e.g., looting).

You can add layers of complexity by zooming-in to look at neighborhoods
instead of the whole city, or zoom-out to compare Baton Rouge with [New
Olreans](https://datadriven.nola.gov/home/).

## Integrating External Datasource

Aggregating external data sources can be beneficial to enhance the
informativeness of the analysis. If you get lucky, the dataset you are
looking for might be available online on platforms such as
[statista](https://www.statista.com/) or [kaggle](www.kaggle.com/),
other times you may need a scraper.

## Organize your Project Repository

Keep your project on a GitHub repo (public or private). You want to use
the README file on the first page as an “abstract” of your project. For
instance, you can add the research question, and explanation of your
output, the major findings, screenshots of your dashboard, or anything
that would motivate the reader to take a look at what your code does.

To make your repository more accessible, try to manage the structure of
your folder effectively, for
    instance:

    \R          #sometimes it is useful to split your code in multiple R scripts
    \figure     #ggplot charts, logos, figures, and general visual static content
    \data       #the dataset you are using (consider whether you want them in .csv/.tvs or .RDta)
    \Rmd        #.Rmd files for your report(s)
    index.html  #the HTML version of your presentation if needed
    README      #this is your "abstract""

## Reproducibility

When working with real data, you may need some preliminary data
wrangling, cleaning, etc. Records may come from open text fields, which
means misspellings, missing values, and oddities due to actual users
typing-in records. Make sure the code you write for fixing those issues
can always take you from the raw data (as accessed through the API) to
the dataset formatted as you need it for the analysis. Thus, you want
your code to be as robust and reproducible as possible. For instance,
what if we new rows or new columns are added to a table you are
querying? Would your code still run smoothly?

## Grading criteria

This project is the chance for you to explore the magnificent world of
R. The main goal is to build on what you have learned so far and to
independently explore new tools for investigating of a research question
of your choice. Some of the aspects that would make a good project are:

1.  Picking a research question that is **relevant** and non-trivial:
    you may not reach an ultimate answer, but do it are you best.

2.  **Explore new tools**, for instance: using new libraries for
    plotting, creating a template for your pdf reports, use statistical
    modeling, add interactivity to ggplot charts.

3.  **Integrate external resources**. Looking at the bigger picture is
    sometimes critical to fully understand what the data might tell us.
    Variables such as crime rates might be more meaningful when combined
    with income data. However, that information may not be available
    from Open Data BR.

4.  What did you find? Do not overreach with when presenting your
    **findings** and be aware of your **limitations**.

5.  Make sure that your analysis is **reproducible**. Ideally, anyone
    should be able to run your code an replicate the results.

6.  Make your code **readable code**: it will be faster for your team to
    recall what your code does. This means not only formatting and
    commenting your code if needed, but also keep it concise.

Grades will virtually be the same for every member of the team unless
evidence of severe misconduct arises. Every team will have members who
are stronger in coding than others, but coding is not the only skill in
play. Make sure you organize your project such that each member can
productively contribute to the final output.

## Seeking help from the R Community

If you need help with your code, you should consider searching/posting
on [Stackoverflow](https://stackoverflow.com/). Before you post, make
sure you reduce your problem into a [reproducible
example](https://stackoverflow.com/questions/5963269/how-to-make-a-great-r-reproducible-example).
Issues that are not reproducible are unlikely to receive any responses
at all.

Also, you can tag [me](https://github.com/DarioBoh) in your GitHub
issues and feel free to message me a reminder if I do not respond within
24hours. I will not provide a fully working solution, but I will do my
best to help you troubleshoot or to point you to a resource that might
help you solve the problem.

Our Slack group. Others may be dealing with a similar issue, although
they are investigating a different research question. Do not be too
jealous of your code, which is only a tool and not the ultimate goal of
the project. Sharing your code is a good way to receive feedback on it.

## Final checklist

  - Introduce the project using a README file containting the research
    question and a 1-2 paragraph description of what you did. Add images
    if you think they help clarifying.

  - Make sure that the code is reproducible - e.g., use the `here`
    package for filepaths, and restart your R session to male sure there
    are no dependencies to the elements in your environemnt. Unless
    strickly necessary, I would prefer that you save and load the data
    you retrieve from the APIs as R objects (e.g., tibbles). You may
    still keep the script for querying the API in a separate script.

  - Arrange your scripts and output files meaningfully in your project
    folder (e.g., dataset and images in separate subfolders)
