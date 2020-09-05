Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE20925E87E
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgIEOsH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 10:48:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:52571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbgIEOsE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 10:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599317191;
        bh=RAHiNLnG3IuCWYe2owQpbYIJlYLYNj31Ysy4ZzQO/Kk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dMCR0RN7CYw16iUT/wIpQUPFMBlmQaKJLL1TdAphv4JsiDmmj/iYPbAI5uvW3Zh0h
         95DqEpidOhK1IFzBUY65Qysczjk0jeaLoGGMrTuIGG3QHmjEXpunhSMzdQdIZjFUOP
         VzmVHgXQDdALuSI5kwCZM0feNgt54M7xklScj6hQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1jvxiV0uAG-00PQz1; Sat, 05
 Sep 2020 16:46:31 +0200
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
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 09/10] MAINTAINERS: Add entry for Netronix embedded controller
Date:   Sat,  5 Sep 2020 16:45:01 +0200
Message-Id: <20200905144503.1067124-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/DsAtZ/PqYMgUwapHdEQ/vTEgQHX9OrG+983qc0/gY1GqdsLSyE
 C5PYbHAjRpbdE0HgY/pvNaD7H4MioM5n/jdxlXlWetPImCNmiB4Kcjw1lppFodHRxNywoT/
 5k0fx6BVM+VEi+lbYypkVXW54Mxri2GMWWGIsQQcyNPqZ7RhuorWD8WpQIuGO8WgTxx/HMN
 RPVZxXlmA48rgTjIQohvw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Pwzjcm4O2TA=:qQDZmUS0qVzZRgsOtzbiWH
 IkeFt2cyWTfeW/yKPTCwEIzZ3LgOmttrphGiHai490XS934R6N2oti1Zc1AMwX4STXfnQtEFD
 hLykF7MIvSZsjhgFONx/fNWDJ5vXK8QO4rzhLmy4p4VDKc4xEGR+fhQRBAJUOMfprq6a+VbSZ
 D2zbU9YY8/4LfGS2qyW58wLgFECsCnBAYfuOHYKy5wwoi0JnjzVzbryf0DpTjuhbEk11aMWZL
 leHxePN/q0unBkwd/sOFgjB7BKmBsAZSqea6fkWg/Wevzyq3y8ZUI1CnYtBogB0genP909U+2
 EwKLI0W1bGNXQwr6mw8/SwLP6ae0aOd9XXjLHYn1PKMP6J5/aseAQ+VHBZ8hZSF/fcdCxNjy+
 tGrK4au8kZAkEaVos/0mAFUwy9YvGsFwT/P1vH9NsEUFp2ZN6DHTaMU7+fanlAGs364rE93Ax
 6EWj2aA5e7qaPnQ4v/0Ow3GyhUPAsrO2Dsr5QwxdSLMxbIDsNd0Lfa9lyfzThyFstjefhfuEw
 sJgVYRJMC7QlUr0m6rHcqlWCuQF5Mp5JOLeeLc13jIIzm3QR97L3aEi6X5I3NuhSR9NeKHWIa
 2UVHR5V+xXpHQPTdYPevRb54ZqXlD4WQM6SOdlUmBw3oezERoUU6/btIU4RJN86RFO5izPKwZ
 93HrmWcAwY3ppZyPcszuUulJyYVZ6KBN70+1uIHhNkQJ2bVkit9aXxQkrAEp9fuPr5EH8nP4+
 hGsVv0N3NKKhPWLbj3/cvRl7kaHNMtcwmfbUejPpZ9xfO1BtPuoLlKZQDTNmOFlZTekE6boSW
 Opota3OKF626gA0blkJ2ZsL62P6808S+SFRYPDPYNf3oewvd2vD4RuCyrKRy8K6S3xbm4lhRm
 tqe+IhQiUsT4bLzqIllbEMjNLJWRwDAj7RDUCUSJGPbZOvWuuOPZdXE9IkFycn1m5Gmn5adeK
 0C4pg+HNfm5DCRiBeVDiyOfVAy3bWodXn5RkVjSi/Lf4z9UJd0Fa3bCj6aQfVfVAbj/osqh/1
 3cqITHx5n8YXBB/5gDzMHOT85U/4sR1fUDcwzf0XsAphLFAvNKWnk04uz+y5VMdj33dP+uNmZ
 N9q2KCLWNYo/gOT/VsHVWUrXsyyq5a8Z03gofm595lubGrfuIch5MFhNogo3d5OgaTg+BhhqJ
 kSNVMeTRoV+jJXDdomj5vOHj01bnLxnC4yFhIA8XeuWiLaMOAD5NKgqkuQlSlbneqQeZvo25S
 oJn4qIHpr09Fu3hzm2W+l/Zw5Ny5g747WfuM/wQ==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's make sure I'll notice when there are patches for the NTXEC
drivers.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- No changes
=2D--
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e4647c84c987e..ffe15a65bae2e 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11995,6 +11995,17 @@ F:	include/net/netrom.h
 F:	include/uapi/linux/netrom.h
 F:	net/netrom/

+NETRONIX EMBEDDED CONTROLLER
+M:	Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/netronix,ntxec.yaml
+F:	Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.yaml
+F:	Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.yaml
+F:	drivers/mfd/ntxec.c
+F:	drivers/pwm/pwm-ntxec.c
+F:	drivers/rtc/rtc-ntxec.c
+F:	include/linux/mfd/ntxec.h
+
 NETRONOME ETHERNET DRIVERS
 M:	Simon Horman <simon.horman@netronome.com>
 R:	Jakub Kicinski <kuba@kernel.org>
=2D-
2.28.0

