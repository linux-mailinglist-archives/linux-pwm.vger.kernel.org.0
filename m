Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7CB25E833
	for <lists+linux-pwm@lfdr.de>; Sat,  5 Sep 2020 15:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgIENxh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 5 Sep 2020 09:53:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:44717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbgIENgZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 5 Sep 2020 09:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599312926;
        bh=5W5bgNq9LYqoutaDK2rdA3mh9k/FJm8P+tiRpaZx/oU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QE1RAvNcsKuOzWHvtSCwY8f+5D7QfHAziYrgkJQoekPhVEFjQDihltHUXpSnjw5nM
         tZVqTltohz0fuTEHEuaFTDRDd7SwJLI+tz6f0wOCBwNJg63/ARJuX9WDDAeSNh4zfC
         EbWa0/1oJLt/Hyvzn5xbJIjNappCqbZDLyFrbfMw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgesG-1kmV7K1v7E-00h63K; Sat, 05
 Sep 2020 15:35:26 +0200
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
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 07/10] rtc: Introduce RTC_TIMESTAMP_END_2255
Date:   Sat,  5 Sep 2020 15:32:27 +0200
Message-Id: <20200905133230.1014581-8-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gdbZilmswnyaFo9HLwRIhQfH6ZnJNWEaZw34e8xYCo5CcoTu6Vj
 f4r7gD746AQYDN3lxm1zljlQC1wQzBfzwb31hL0i8/XNRcXOX+1dLuuh2TAmZYO7Qkh1245
 8iXnpFze3eZKkxM4Qvekt7VthPmkb5HFVShC3zPEHqKTebboy8NyKLexLtjw/h6PYd66bWq
 y7rTxCB8v+jALVbVAUY3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z9SeE1U8x8Q=:TvnLuwG5M3R4SehEmJ79gq
 MLS1kXDrpEa7OI5/hCdMRBzmpZOzktum0GSMQjgXpzhNLGEO7JHVu/i9PVWvAJu4K7T3wzetI
 2Bd8wVPlgSnqXgnZgtj6scpIIee35IBd6n7n2LNIKUuYTzC6xq+EsZoMweRnoI5SuKRG0bVc7
 GmMlBRqkFGSZBoRUPZX0v4G8XNi8RGuZoGQ/fYdK/V9T/EexxXJRQX58qJ+c0smribAr6yfqy
 MrTNNIWVF2OUwJGFfHBaDS7PDmRYIhoJPXDUQG2jauijomVVqs1jQfrafIW5sXzhIQjuDu1QQ
 p9fpKhIjWl31FrA6no0UqmCOPjQX6ZeFirQdw2ADmKnQzYtVtCcmcb+Buo1ha4P/LB9hfriGF
 kfaih2s6AV9hc2hipPnuY1Oi3t324vCWASwY1wzUttx4WietR+fodWoqSl/UC6/XIfV3j2lSG
 SrPp8COmooDcZsZExP0zWMMGXyVRE7wZUcli+R+PproKwSZDUz2uVYNxPsAC93AeyrU95eaj/
 Ev/z6afzlqpSdn6EdCwj25+zrcMwyjVk00Wrcs7tdZnlb2BVuoxLekSjiIH+yCsmz+insZz58
 nYgYdFbYslffgecFRzfEAFlMgNlBg0NrzRRckr7RIHmYONfUsRAhHcQN92rAj/tyLPQAwjMk+
 bJrgFZIkoMB0fpPLVd5VnYYefb8KFFZX6+pT/BxH/MC90kC94/SV94nqV+B/PenJ03iSrs9aZ
 9ySr6SZhQh9boXOg3p6PP+hf/hc+j/TUl+NwSN9TXoqwAqkPBUxiGoj9Hxq0fqwq16wQ6hH6c
 FKuAoG1J1EKc8+o2HLuH2WzIUhQQAJvUmdmrbZWyk7eqHV72hw7VLfwkYtQziMJzPdYLJHM7W
 1kTvmaLL3AXRL13M+LP7rzIOD76bY+h11DMIaIZjkO7WL5ZTnQaX0H6LumQ4tnYS+hPuBVtfk
 clDU3xrzpxDoNjq076e33DcSqfgKDlosBSieWiAs/xWu87w9HKOMqteqhTJE4xH3XLUTvL8mU
 E2FTGqK7bzbevSD/+rm+nMOFGKgS6sEBvpXQrIrCaL1hx4EmU0je6dfjoVOn3Cs0BtKxITiHY
 fb9sTGbWlreupiGybAVeE7CRfr/NJrDtUw5KVYv+VThHePt4Bqankm8UYvzpUZ+/sL+gVgmo9
 gD//aqkpcS4zYljM0auiePsqYBTIcnu/LxAaY/J3dE8U7SH3BjJGELqJrcriO8KmE20PkQQSZ
 xCcnWx7Ab9DuNLppmxShuYb3rHkUta3tggBSIkA==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Some RTCs store the year as an 8-bit number relative to the year 2000.
This results in a maximum timestamp of 2255-12-31 23:59:59.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- New patch
=2D--
 include/linux/rtc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/rtc.h b/include/linux/rtc.h
index 22d1575e4991b..fcc086084a603 100644
=2D-- a/include/linux/rtc.h
+++ b/include/linux/rtc.h
@@ -154,6 +154,7 @@ struct rtc_device {
 #define RTC_TIMESTAMP_END_2079		3471292799LL /* 2079-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_2099		4102444799LL /* 2099-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_2199		7258118399LL /* 2199-12-31 23:59:59 */
+#define RTC_TIMESTAMP_END_2255		9025257599LL /* 2255-12-31 23:59:59 */
 #define RTC_TIMESTAMP_END_9999		253402300799LL /* 9999-12-31 23:59:59 */

 extern struct rtc_device *devm_rtc_device_register(struct device *dev,
=2D-
2.28.0

