from setuptools import setup

install_requires = [
    "djangorestframework>=3.11.0",
]

setup(
    name="python_fielder_models",
    version="0.0.1",
    description="Django serializer models for Fielder",
    url="git@github.com:asomas/fielder-models",
    author="Sarmad Gulzar",
    author_email="sarmad@asomas.ai",
    license="MIT",
    packages=["python_fielder_models"],
    install_requires=install_requires,
    zip_safe=False,
)
