#!/bin/bash

# Docker की उपस्थिति जांचें
if ! command -v docker &>/dev/null; then
    echo "Docker इंस्टॉल नहीं है। इंस्टॉल कर रहे हैं..."

    # आवश्यक पैकेज इंस्टॉल करें
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

    # Docker GPG कुंजी जोड़ें
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/trusted.gpg.d/docker.asc

    # Docker रिपॉजिटरी जोड़ें
    sudo add-apt-repository \
      "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/docker.asc] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"

    # पैकेज सूची अपडेट करें
    sudo apt update

    # Docker इंस्टॉल करें
    sudo apt install -y docker-ce

    # Docker सेवा शुरू करें और सक्षम करें
    sudo systemctl start docker
    sudo systemctl enable docker

    # Docker इंस्टॉलेशन सत्यापित करें
    sudo docker run hello-world

    # उपयोगकर्ता को Docker समूह में जोड़ें (यदि आवश्यक हो)
    sudo usermod -aG docker $USER
    echo "कृपया लॉगआउट करें और फिर से लॉगिन करें ताकि Docker कमांड्स बिना sudo के काम करें।"
else
    # Docker संस्करण दिखाएं
    echo "Docker पहले से इंस्टॉल है। संस्करण:"
    docker --version
fi

