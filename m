Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB03F20270B
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jun 2020 00:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgFTWkr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 20 Jun 2020 18:40:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:46327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728113AbgFTWkq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 20 Jun 2020 18:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592692783;
        bh=NZlIIwqNdtz2a/BsgVin34fzBdteKCXfPTKpkZ94mWM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=awKouNNwZMnHe+LNy5Fvm541bwzFIrAoC2hgnZRHv/nFQLCNiAdi0yLG0jsS3KAPk
         aB53eq2b2qyxnDUVNATlm92w2BI3lMLGm3KHSAm8xhuTHaO3ooIs/Pg1kIyFCUa5Sa
         B1FMipma3UFGm++S9ENNNb81EISkSizfJTPpv+u4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.186]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYc0-1j0qCP0n3m-00m4hJ; Sun, 21
 Jun 2020 00:39:43 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: [RFC PATCH 01/10] DT bindings in plain text format
Date:   Sun, 21 Jun 2020 00:39:05 +0200
Message-Id: <20200620223915.1311485-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VxdfrjWO/u5MhkFEjp5KExUHat+e9KDgtmLJLE7SRngqgjYq/nQ
 XlCaZO+wvW9aA+9ez71mbfpUjzFYsLA9lmNlF0ivaZt7Kw4hU0gOLdIkC8vrsjk0V0tjKeL
 N+H6ek0QzT0wUo/mpzycW2uq+H6ea3gq1IxR2hMazCh4waMRq/8riIJ3oR5z/oTaCbMVs9k
 1Il3/109DVkACWeH46L2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lUU5143vyWI=:+OoGUROgFSFjWmEqEhkIO6
 uJ11onjQTWCwldpTO6uSpYgMMW7JxtuxzAWkf7NFKnJ29sfmf3S06CKvlVPEVmcimDlNGmqs/
 rpLKJkqLHNkKzMaORiGyE0ygchcRQe+wLNIkrKUOaYNLxMcPoEEPJ31HHKFj6I2AyOhLpawWa
 ZXTWnqMQaQC1P4iJI2eGygAeh+Ro/1vkuouaGTuChHg2JpZNmmCD6YrZAbucBjJUDZ1BxPU2V
 ffFfFdogRmHKVNRueV1Qf0wMoL1kRalzF/fyHKtzqvkPS7pKAd08dU3Ml5vHxUq8j3h2kZmC7
 dzgmG9ZVDXCp6Ob2tNph2INShQhSyf3OrfruYB/sfJRT+i9fqRyPieg01maiwdTI4dYOHdpnw
 9RHaejksKs1v+rcn+4fgD9wt/Pw4oGmakCg4nbRzxqIOG5tRtx+VlJhdNaJBu5Jz+tWFgtvrM
 tlprNSREQSvLil/OeuJ+Bs0cgDW5TvOWUKTEZ1Fc599CpAEXa5aPMCn4G0PBuhIJFyfCid1o+
 D7+lmktz5x201/iEJjk4NEYlNe6dcRKI6Vs3RWgqOxc/NmAf6K/p8YuVb95jFdZw6NWug9HJx
 zcQ8k4rqE7xvz13MdaRVU0wvZOkcpcbOlZRUi+9cvJnggzySlncTXJgsZN31ryL8ZVIzD9y7k
 eWLokiWVF2FJfXtEqKIy7hB2JcYiHW0ffp7cpHEBPlkgz+xAQBXvhaICoaPD73AOkFn6aV6vL
 R+qG8eGBuZdol6tjBqNBedJsqTC+hs/cpp/Xqom+rulP4yZhk9aUT2hqNKCSROwsGGcgPEoKF
 RJM1V8TauRypS5/1uRJIAp3Rz57wCacOI1YyNmlvaM7EhrdIFm+i8jIRef6UHm7w/A0WE77GS
 ILU952UhuKOwcW65DcSLvbQv9U98qHq/2a/lXcK1BfwX+qHoDnSR36CnZFf1pQ9ruPduBruhZ
 Y/IsjKR4FyPlJME3cKfB2AJM5cuxkQZIFvSQI2iOpttC89fH7Cs4pnBV/47KuWy0wcCg+LWKa
 3JI6WltFNPxyzsMkDAQG9dGhqCcBBgEJIMV8ckhjeY7fS91G6d7CI8KhmwYbaf3mDctmGmnlp
 bnozlZRtbdNk9Ojd7vGvpzJtPf60nWhOjCDP2HHCyLBdgyz9wkRT3b+v54Kpxs5OTOVzBc+Xo
 BOCpg2QYPWjOIwo3Gd8vcKdxkzLfTTxPzzHn7R/SyBPmDKnTiYZpEDgwPZYWaVwZpVsIrDwJy
 nrNkjPs5LKdUJMSv9
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For reference, here are the devicetree bindings in plaintext format.
(Not for merge.)

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 .../bindings/mfd/netronix,ntxec.txt           | 58 +++++++++++++++++++
 .../bindings/pwm/netronix,ntxec-pwm.txt       | 27 +++++++++
 .../bindings/rtc/netronix,ntxec-rtc.txt       | 17 ++++++
 3 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.t=
xt
 create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-p=
wm.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-r=
tc.txt

diff --git a/Documentation/devicetree/bindings/mfd/netronix,ntxec.txt b/Do=
cumentation/devicetree/bindings/mfd/netronix,ntxec.txt
new file mode 100644
index 0000000000000..e303932657999
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/netronix,ntxec.txt
@@ -0,0 +1,58 @@
+Netronix Embedded Controller
+
+This EC is found in e-book readers of multiple brands (e.g. Kobo, Tolino)=
, and
+is typically implemented as a TI MSP430 microcontroller.
+
+
+Required properties:
+- compatible: should be "netronix,ntxec"
+- reg: The I2C address of the EC
+
+Optional properties:
+- system-power-controller:
+  See Documentation/devicetree/bindings/power/power-controller.txt
+- interrupts or interrupts-extended
+- interrupt-controller
+- #interrupt-cells: Should be 1
+
+Optional subnodes:
+
+Sub-nodes are identified by their compatible string.
+
+ compatible string              | description
+--------------------------------|--------------------------------------
+ netronix,ntxec-pwm             | PWM (used for backlight)
+ netronix,ntxec-rtc             | real time clock
+
+
+Example:
+
+&i2c3 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c3>;
+	status =3D "okay";
+
+	ec: embedded-controller@43 {
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&pinctrl_ntxec>;
+
+		compatible =3D "netronix,ntxec";
+		reg =3D <0x43>;
+		system-power-controller;
+		interrupt-parent =3D <&gpio4>;
+		interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-controller;
+		#interrupt-cells =3D <1>;
+
+		pwm {
+			compatible =3D "netronix,ntxec-pwm";
+			#pwm-cells =3D <1>;
+		};
+
+		rtc {
+			compatible =3D "netronix,ntxec-rtc";
+			interrupts-extended =3D <&ec 15>;
+			interrupt-names =3D "alarm";
+		};
+	};
+};
diff --git a/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.txt =
b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.txt
new file mode 100644
index 0000000000000..50be27f82559e
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.txt
@@ -0,0 +1,27 @@
+PWM functionality in Netronix Embedded Controller
+
+Required properties:
+- compatible: should be "netronix,ntxec-pwm"
+- #pwm-cells: should be 1.
+
+Available PWM channels:
+- 0: The PWM channel controlled by registers 0xa1-0xa7
+
+Example:
+
+	embedded-controller@43 {
+		compatible =3D "netronix,ntxec";
+		...
+
+		ec_pwm: pwm {
+			compatible =3D "netronix,ntxec-pwm";
+			#pwm-cells =3D <1>;
+		};
+	};
+
+	...
+
+	backlight {
+		compatible =3D "pwm-backlight";
+		pwms =3D <&ec_pwm 0 50000>;
+	};
diff --git a/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.txt =
b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.txt
new file mode 100644
index 0000000000000..0ef9e791b6a36
=2D-- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.txt
@@ -0,0 +1,17 @@
+Netronix embedded controller RTC
+
+Required properties:
+
+- compatible: should be "netronix,ntxec-rtc"
+
+
+Example:
+
+	embedded-controller@43 {
+		compatible =3D "netronix,ntxec";
+		...
+
+		rtc {
+			compatible =3D "netronix,ntxec-rtc";
+		};
+	}
=2D-
2.27.0

