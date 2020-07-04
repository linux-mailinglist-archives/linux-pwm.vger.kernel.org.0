Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3DE2148C7
	for <lists+linux-pwm@lfdr.de>; Sat,  4 Jul 2020 22:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgGDU7H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 4 Jul 2020 16:59:07 -0400
Received: from mout.gmx.net ([212.227.15.19]:59715 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbgGDU7H (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 4 Jul 2020 16:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593896291;
        bh=2oIii+dEa/rMktNI0QfrGboAftGZ7VgeERC+pMMVvCE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ByrU0MPgzX7+FsB601UMpEA8PlbebAisHyU5yAukxRrqU+PS2Kha9xu89nXXvmhDk
         FEsvGG9hanZlY4xWNVi0P+XqW8lqcWtp7/swGM//2UwkOwAdUx1jlgm1p+27rJdYw7
         i3trPvNW+wUq2JZU/4r7A68uM6Gk2YndeQioCe1E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.26]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1jwW4Q2HFx-004mOY; Sat, 04
 Jul 2020 22:58:11 +0200
Date:   Sat, 4 Jul 2020 22:58:08 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
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
        Josua Mayer <josua.mayer@jm0.eu>
Subject: Re: [RFC PATCH 00/10] Netronix embedded controller driver for Kobo
 and Tolino ebook readers
Message-ID: <20200704205808.GD2578@latitude>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
 <20200630084051.66feadea@aktux>
 <20200630071523.GA2983@latitude>
 <20200630221447.3e03ae28@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline
In-Reply-To: <20200630221447.3e03ae28@aktux>
X-Provags-ID: V03:K1:55puWQ+2GGyp7xcFFLkgMg7nkitQvyCSK5CCeExXNQutjzBzOIO
 vOWLHCUn89dwzlDLbv07iW8fG/Rzs6Y6iEj6IFAtgcy/ImnrcMnMPhm5BVSsrqc8fOv5zgU
 JLB+V6JL3G03CFL+MN9xGbxb3NBHFJ9S8wudrcml8m642V0u7SCEaLsS0IKObqSwkePjNsy
 VYCWd9xclZmIdnQaLD0FQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fSQkFQE/W9w=:ZWejvBXNg5xft6J5wnpJac
 VDhhL9IJ7Pin6I4EPyt1gURfyfbptpVJcGfHJdfws3PP2Jyccm94PKShpQgBIwjA/NBsu54xt
 YhBfVDRbdEWqsZs5tmiErelLJP9qmL9ZztVuTqUTpQy8BnnCohzL3KWpi7MDzhbWVSG9+RuQN
 PqFI1LvbbLgBXw54JBBkskfzvsqD9n2Svw4nzgUWNboHVwu30bPfHLW29eYWP430GNcf08xa3
 yKc7wwlwC2fzrQsa64dVYznbSfmFCUixkRnpsDAQ6GXVWW/8pbwlMlvKEoCxvmfgvCIzDrEQ5
 MZtKaO2FI87Xw4lxcX0y4/zbelglRjnsAZGMz8ImCuzgx9dNZ41PHUOm7ynay1mTpCJpLgzeZ
 NzFxZKapgWrUwZTqxfzrjEeSbgypVs44w7/bGujRrfbZFVSrqP8PQDqiSNIpN0HWYmudRY7z/
 HYhXKB8xx1OZQCl97TOpiDMzZhrTRk5UBT8oa/cWDQzWl38H8ZsAZ/fAtUgAhc/Cm2nR4Mlf0
 Hl1EUC4NYow2uUIO5lvFKmb3TJWlO+I0dATzjQJZ7yLjkic03hPMfhpZyMcISV7deBEBfatNf
 ly3ZPhdBs4LuNy0ZStO99FfBUnG0eUVBRRE1v3VBVnyC+HOsoU4rpXJR1qCTLTovicbHIT3nK
 U1/fwQxeka6vC39P5mHyQ6Z3kyhQBX3KQBZgogo9LEy+mvn+POmft4eUR/IX1vsCWvp6m0BlO
 pCso8pYTXi345NvykPwFu6BEEQ38ocXGaIRJ1Ou/1S430YBJl3OZ1Ts8YA5LRyRxIBxIgBIGn
 TOdlDpd2+jFChmJMrdj0MnGv0O7t8vzyohXpoUDnyiono1VDCB7yiGMsMCAkROdjO6H5j5tHL
 d/09xbzcBFKarDu0v0xeThRaaHDaUAuW+f3qnwqp5ecMaE30qOAbphcFyeOld6/aMI8TkAvNq
 ezZGGFofFUfaZ0amT0QnPnvT5RUvKZCGa7d9z4TbANXbGaM1Y6kcRnTpLgLbE9/FHMKBkL6en
 oLtdPfWDI6Xc6ofxpZoix6HK70UsmIe9mbLJeaTM5P3Ssy/+9hed5nBHkqGm4ajl65k8zZRoZ
 2HMNo9iiloTmMj9GDRSoaMDfFxzyklcnwHaOVlk/6jL2h1p0ZMXreDrtDZlbqJzdkDaC5n5S4
 wOxfH5GDXLTFbHvJOF8waKgRVEAjVfFwjI+hodgmQyWB5orZtQNIDL3jYNiWC6eGe3uX8qz2A
 6YY4cm2NYj+kA23uL
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 10:14:47PM +0200, Andreas Kemnade wrote:
> On Tue, 30 Jun 2020 09:15:23 +0200
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
>=20
> > On Tue, Jun 30, 2020 at 08:40:51AM +0200, Andreas Kemnade wrote:
> > [...]
> > > got a chance to test it on a Tolino Shine 2 HD.
> > > It uses the RTC from the RC5T619 but backlight seems to go via MSP430
> > > EC.
> > >=20
> > > I got this.
> > >=20
> > > [    1.453603] ntxec 0-0043: Netronix embedded controller version f11=
0 detected.
> > > [   10.723638] ntxec-rtc 21a0000.i2c:embedded-controller@43:rtc: regi=
stered as rtc0
> > > [   10.775276] ntxec-pwm: probe of 21a0000.i2c:embedded-controller@43=
:pwm failed with error -5 =20
> >=20
> > Hmm, -EIO from the PWM driver.
> >=20
> turing debugging on:

(edited for compactness:)
> [  330.332971] i2c i2c-0: write slave address: addr=3D0x86   ACK received
> [  330.334420] i2c i2c-0: write byte: B0=3D0xA3              ACK received
> [  330.334790] i2c i2c-0: write byte: B1=3D0x0               No ACK

> [  330.352339] i2c i2c-0: write slave address: addr=3D0x86   ACK received
> [  330.362208] i2c i2c-0: write byte: B0=3D0xA1              ACK received
> [  330.362479] i2c i2c-0: write byte: B1=3D0xFF              No ACK

> [  330.363112] i2c i2c-0: write slave address: addr=3D0x86   ACK received
> [  330.363362] i2c i2c-0: write byte: B0=3D0xA2              ACK received
> [  330.363608] i2c i2c-0: write byte: B1=3D0xFF              No ACK

Hmm, it doesn't ack the writes to 0xA3, 0xA1 and 0xA2, which should
disable the PWM output and then disable the auto-off timer (according to
the vendor kernel).

And you said in your other mail that you can actually toggle the light
with writes to 0xA3, so I suspect a bug in the EC firmware here (which
may have gone unnoticed because the vendor kernel doesn't check if the
i2c transfers succeed). :/

IMHO we should get this driver merged first, and perhaps add a quirk to
deal with the missing ACKs later (unless a better solution is found).


Jonathan

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl8A7VcACgkQCDBEmo7z
X9vtUBAApZaMG6edUQzNMvP9gVMXHNm96Rk1KQowxkW4xF6zOnil/x4PcUwgqfKV
tA1xaZMavflayrHqj1wKuLPWnrJ1xdulK/PnULdnXalCJSVqGHjwyKf3/+onibzr
o6rS+U9ToxbkTeTdV8DjcGz2qmNeJjpaExuZTlvXHQxH7a6SUwK23JVuiChwe2M3
ycD3RQp/jvAOEW4+e/y6iGat1skMV+dUglcitX6pYBoYu8u4FoSfZ3v/O6JTqqS3
IeLfBc0IMjGuYbEn+RRkHbnLTNidHt+ptsNl6Q+p7eaRGCeGXIaCeeFPbBp1LXMf
C559niYKdWD+MQV6diLUHGMO5s4WrQiQ/qP4K+R9qQHKXyD84XYPXJX+QO+up2qb
jDyutjtILNt5YFUKNbvimcWy/rlDa1sdVaFK8Dt9o0zdkT25FATE8SU0eRFwf396
vqwWeGF2b9mNRPzWzbpQYhEDvIR+OCuDfi085F0sYtBuPBY1vcy4mbVDjDGU0ulT
T90dH/DU7C7DJwA7w6sxeb+8MZ5VGTHLsGZ+tB84pMaKJOlvTdRLD7J1+aUpqBmh
BiSTJlIZeiiR04ip4vNYgsuHM79LlEapJuhJbYLMk3oBWtRAkrToyZEjWTDfp3Ik
JzLHmXz38TYOeGG7A2vWQTIQb1eAw9Alh4Gu2OdzWW0fmR8NWCI=
=5RFu
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
