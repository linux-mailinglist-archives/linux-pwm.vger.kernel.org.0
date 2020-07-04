Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A81214859
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Jul 2020 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGDTYZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Jul 2020 15:24:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:32847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbgGDTYZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 4 Jul 2020 15:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593890611;
        bh=WAD5QQlP0LCkmso8s+gKUS7M0lXvNdxkqPNyUPummWA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Hudxi7lVx6oLzZwzuX2yubzy4m0dv217JY7GzTM9Dqbb2BEzYtC/6cUs+6tUEy6Kk
         CcNSwucrKEXJooD1rf39qLnXKqxqGGzPokbCPJAqBPN1bVCrcIVCJpkryahKUQSc2h
         2nLFmBYSIXgxXbf07YjRAeL/ix3Quwc+W8Azs3s4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.26]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1kOkyA3Zvs-00X0R7; Sat, 04
 Jul 2020 21:23:31 +0200
Date:   Sat, 4 Jul 2020 21:23:23 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
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
Subject: Re: [RFC PATCH 08/10] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20200704192323.GC2578@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-7-j.neuschaefer@gmx.net>
 <20200621001106.GC131826@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <20200621001106.GC131826@piout.net>
X-Provags-ID: V03:K1:DMqWrUZO9WvfwP5GHEh60ZFeADf5FrliknlidT+JUvSoso7C0AO
 7MW0Tsc9rRZy85HRmMyausOcHHg5ACqV3x2iHCabh8I85A6vvvw+nQZNqTwQ8KwSFyvd3DY
 qADu0PJkUy9H+ni38N2KVI3fhPnR6KEBZ9eTOiyHnsujTpSxcrQpTa6UayqX+6ezHFvxPy1
 ceSsoyvzbC3cSZqkmvszA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QK83j4q2tNY=:+A0whngEeVTzV/tycO7gcI
 bI5ICj/isg0sLLNIvbg3VNB8/JY8pD1LY6qjM1djcWYsE9AzhDA9mvM0WhVbxqceofDwrMMfi
 8XL1iwuq7ThouwscRhBxeQ2bS8QTqBdllaskx7ZSi7kXSe38XMnjIqQtu8Egk8S7AaS9BkG++
 jF+7DlEMXsATRtEMrask0IqgP1vMfaBnGVAycYQDA3/f7oLZwS+U7wU6tu31oFvEkP1QKCWqZ
 mqEnpIzwVYyVjbGG2J+o8kW8yIq9DWiuHih0xF/4mLWXvV8jmERpDifnoYdr1KrOHqBFy3RSC
 tk5Y8IS2+UMyaK9q2jgfSPQynu8SGRAxzvlH6a9quT1odKzNsxbIJZ4K05wBIIVB3Gk6zvl2V
 XU5roBWYrAR7zw5xAzZxo+LlHPKL8+I+sxg09R0KDlWFlWPTOTwCfuGgcvd9li1w72E8pO2D9
 h5AoTym78JKPCS/XBattrKrXDNxWUsNhhJ0uiPkMuVafPel2oxD+lghGTc6GE+T32a71yIXiA
 YtC53K5Tm2uR5j0dmqXUi9nvIOtKhQRl9OEL/WhFvaluCc2NF7IAcw3KogMEcGWuFEvJJ4qcR
 Pl+haqEKHh708fbZyRQfPu8yDJZTxPheSDmOZkgflGF6hRklJ25bvvxQmFGAa9vID0vvX6ij4
 VxVCJJe5Ns5VptVwbbbIJy5ZfcptsMK1j7BtvT0VDwOn/8RgntYPByHsMsc6lPZuAwyA3x+Cn
 ixvQUZUCId6tBJCBlhaakvhcGVergkOOSVn+dsQcZbFkbMM+QRh3U2uldv/mKKkH4djVwRQpp
 JD8EHu7UGyItm0iN1cRRCJtn/cdanQscBwQRzuO26qVOp27Guq7AIn8LCPEhOLsjCweVHRQCG
 niJ6QiUfjuc3y5+egOzgOSOWxBktK7zB19QoDle81LjRz4njn7U9dS6AvOo+13u2gu7TOQ760
 zSZjPiEIBP7m02IusqJMD622oH7F8TjBwNQxc0UKoppdEQsqd8F+bv32+fR8l8575h1YbEuNS
 Q4DoCfjrOwvEuVZDou/1b5b1aEgWuK9gQ9gBQVP7Tc9S0qo7cQcUSOGVzyfjyjDaFPq/kOFhL
 PgegdZDvPtt2s+bnkVyqVwVMOvz5lPg0ccPRu96unD5Mlm8odgTUrBGX3LCX7bqOD50TXDc1R
 c6O2P7aiCxAlcX9FmqMaYVbWUBhiMuNWjT4mm3nxo0NB3Nl2DoH5RmdilUzLhItHJ1/+0lQcE
 +wmd9s/cZ/ItJZFW1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 21, 2020 at 02:11:06AM +0200, Alexandre Belloni wrote:
> On 21/06/2020 00:42:19+0200, Jonathan Neusch=C3=A4fer wrote:
> > With this driver, mainline Linux can keep its time and date in sync with
> > the vendor kernel.
> >=20
> > Advanced functionality like alarm and automatic power-on is not yet
> > supported.
> >=20
>=20
> Please report the results of rtctest (from the kernel tree) [...]

  # ./rtctest
  [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] Running 7 tests from 2 test cases.
  [ RUN      ] rtc.date_read
  ../../tools/testing/selftests/rtc/rtctest.c:49:date_read:Current RTC date=
/time is 11/04/2006 23:11:23.
  [       OK ] rtc.date_read
  [ RUN      ] rtc.uie_read
  [  180.651355] random: crng init done
  uie_read: Test terminated by timeout
  [     FAIL ] rtc.uie_read
  [ RUN      ] rtc.uie_select
  ../../tools/testing/selftests/rtc/rtctest.c:98:uie_select:Expected 0 (0) =
!=3D rc (0)
  uie_select: Test terminated by assertion
  [     FAIL ] rtc.uie_select
  [ RUN      ] rtc.alarm_alm_set
  ../../tools/testing/selftests/rtc/rtctest.c:129:alarm_alm_set:skip alarms=
 are not supported.
  [       OK ] rtc.alarm_alm_set
  [ RUN      ] rtc.alarm_wkalm_set
  ../../tools/testing/selftests/rtc/rtctest.c:185:alarm_wkalm_set:skip alar=
ms are not supported.
  [       OK ] rtc.alarm_wkalm_set
  [ RUN      ] rtc.alarm_alm_set_minute
  ../../tools/testing/selftests/rtc/rtctest.c:231:alarm_alm_set_minute:skip=
 alarms are not supported.
  [       OK ] rtc.alarm_alm_set_minute
  [ RUN      ] rtc.alarm_wkalm_set_minute
  ../../tools/testing/selftests/rtc/rtctest.c:287:alarm_wkalm_set_minute:sk=
ip alarms are not supported.
  [       OK ] rtc.alarm_wkalm_set_minute
  [=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D] 5 / 7 tests passed.
  [  FAILED  ]

> [...] and rtc-range
> (https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/t=
ree/rtc-range.c)

  # ./rtc-range
 =20
  Testing 1970-01-01 00:00:00.
  KO  Read back 2226-01-01 00:01:00.
 =20
  Testing 2000-02-28 23:59:59.
  KO  Read back 2000-02-28 23:28:23.
 =20
  Testing 2020-02-28 23:59:59.
  KO  Read back 2020-02-28 23:28:23.
 =20
  Testing 2038-01-19 03:14:07.
  KO  Read back 2038-01-19 03:19:03.
 =20
  Testing 2069-12-31 23:59:59.
  KO  Read back 2069-12-31 23:31:23.
 =20
  Testing 2079-12-31 23:59:59.
  KO  Read back 2079-12-31 23:31:23.
 =20
  Testing 2099-12-31 23:59:59.
  KO  Read back 2099-12-31 23:31:23.
 =20
  Testing 2255-12-31 23:59:59.
  KO  Read back 2255-12-31 23:31:23.
 =20
  Testing 2100-02-28 23:59:59.
  KO  Read back 2100-02-28 23:28:23.
 =20
  Testing 2106-02-07 06:28:15.
  KO  Read back 2106-02-07 06:07:06.
 =20
  Testing 2262-04-11 23:47:16.
  KO  Read back 2006-04-11 23:11:23.


Something is very wrong here.

I'll try to fix the failures in rtctest and the problems in rtc-range
before version 2 of the patchset.

(The 2255 date was my addition, because I suspect this to be the upper
limit of the RTC's range.)


[...]
> > +config RTC_DRV_NTXEC
> > +	tristate "Netronix embedded controller RTC driver"
> > +	depends on MFD_NTXEC
> > +
>=20
> This should get an help section.

Ok, I'll add one.


[...]
> > +#include <linux/rtc.h>
> > +#include <linux/mfd/ntxec.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
>=20
> Please sort the includes.

Will do.


[...]
> > +	rtcdev =3D devm_rtc_device_register(&pdev->dev, "ntxec-rtc",
> > +					  &ntxec_rtc_ops, THIS_MODULE);
>=20
> Please use devm_rtc_allocate_device and rtc_register_device. Also, set
> the supported range (->range_min and ->range_max).

Ok, will do.


Thanks for the review and the testing tips.
Jonathan Neusch=C3=A4fer

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl8A1yAACgkQCDBEmo7z
X9tNnA/9H+BT9wwk5LCwgYRQGaCp/1zm7d962UhBAu5F59rAP2Ho8ioQNoJcCc0/
xwAaeJYaRm7iOWjVdlL0wfnv8kJRDjYs4ml0arpTPFW4dmz4+zvFoZfIVIlUHy+1
t/cY1k/KCTXqAXUmyVMMZ6b3Q7/mwjKYLQV2nRgW3sHiBoQI2q6cV69XQZM1JVo0
NV+m7HGvL5AmPZGjLmbSC8PiOMlS35Tm6v0IKrYXHt3ASOF7ukMqTMT3+1aRCrzs
zqtZHJdUfGA3DpkZTiLK+m8t5L4t6qsiyd+QX9jFg1KaSXapVF5nV+wNYgdebcqQ
UqeA5ylgENA6WaYv5N8xl1MO6UZhYiH5Qw/mJZ0rG4pyf0Ad6nZJxd+l8eWseMFX
LCOtTqRIKC6Oa2sKPUI/TN56GafA1cK+ZHljn/FjpI5CUQfHlcAz/QEkACPIs1S8
WtMdsBfP3cjqGPapGbknlBi8KGnyL/qFj42PCOApXdNOczJAXMRfvvXYHfdnVxUx
9pw9oAc06PijFOB72FUMYA3U2aiNz5Qk+zMmmsTFDAnRJmsnFc8hhooewHn4Ha3I
AiJVhLvGrzVlSS8Yq7O2jm1SsRYKAO93YctBIxMfRJvd2a+72++4X7oPc1qKxCkQ
U5YIMEbe4JyTCq0Bj6rbOd1k4+36LVMRT/jyGg7DK66PUgfB2dI=
=jCx0
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
