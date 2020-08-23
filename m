Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE4824F058
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 00:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHWWnm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Aug 2020 18:43:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:36209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgHWWnk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 23 Aug 2020 18:43:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598222569;
        bh=PsnvQWRJcVbk0Axnfi67UKu0/qjaghfgJFgY4j2br1w=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DU452jkKeR5UCthv13t86GkUF10DJgBTmZ4JepR2iUsiEU4rTbBJPiTJGEbI7CNN9
         xy6khBALrH+zC44v9jtmEgn1r/4DdLnVaBoK7/Ndw+wsTCo6JTsASLs/xSFjCzdkfo
         x5XZ4zbf4ZSGjbVNFNSse+sEAxPbIJ70JliKtnhU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1k5jYG2jz7-00V9WX; Mon, 24
 Aug 2020 00:42:49 +0200
Date:   Mon, 24 Aug 2020 00:42:36 +0200
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
Subject: Re: [RFC PATCH 05/10] dt-bindings: pwm: Add bindings for PWM
 function in Netronix EC
Message-ID: <20200823224236.GD103070@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-4-j.neuschaefer@gmx.net>
 <20200621204123.6c761d98@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tMbDGjvJuJijemkf"
Content-Disposition: inline
In-Reply-To: <20200621204123.6c761d98@aktux>
X-Provags-ID: V03:K1:4M6N+P9avUy8KbKKUlA8iMg5xpQTk3JdbRV/3nYUHIHJQBaJETO
 TBsuuYAjXbbo+/cdiGz2wwz18Qv0FhZfI7KDNyURQq3W3pganq6EmBi/PeCOBUCvSPRZAMQ
 uFyrvJMALvK2ho5SQ3GBVDRF560iGPO610MjMc5CBjNfUPnAlTo2nba6lzuSnRhZgBuP/55
 hwcmfjazvY/R6fdtBy7hQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CgZxIGWDXDA=:KJ1ztIQ8AjxuZUI0CT/wbV
 m1LOvjWkbI778+vtBMAheTqU6EVwjLWnsKK29jm1Qu6ngFa4WbTSVfTK7zJAyYvLY2Xqwwkt3
 Pedk21HEbRRrP0zDSuFSWd3ver5/2Cvg29VLJjK1DVMrY3ymHVCYUmPlWYI7lfSoL7ge+tD6/
 E6vnKja/wj8yVzX8GpELkWNrEb7AWRh2xdz5yHOhG+t9TFMiOou8PaBna1eSv36/j/hGREGUH
 82ELJstkT45SN43t93N3F1sgjgvahDcqkj2pK7XCEl+MIg+i9JsDP8kDla1Ihsin8/3eRLY9z
 rqExUmGVTnqRBps8Ml1pXa5C77YBrvSyk/1ORItz4H6fFPPIkzKXA96CYkKGrHXz9SaMgJO+4
 1xb+AyCB7daqS71Q8lmaoxtwmfkZ4cTrTWGNMjCktEP6v5r5r5ZSCag3XOR2DUmhcrob8NOe6
 hjykLlmJZBvidWIXHVuTZQLqay72yEuPxrG5LY3bJlghNmJbwIgdHxHyA2izx+jfFgyKxDFcU
 Z+VQ2+0lsXUIo+9OJmW5dDBtDLTDd9qqb5XQEtMbZK1g74JWYcv5hPyO4OHpXN/uih/6V1rHS
 2OPPMJ3e0dBNasW/a9aXx5Jo3d0tGu4Okhy8PbkzCQxMCtzkmUxWlWt5b8SQt4512vfQO/Jkp
 6a73ul3b6qveTZvgfiFSFsNtSOrnSbkgL76CiXjD4FKx+zqxwl5TkMmHzb1Qkd8mbGod1vROL
 XP2EE7TmkANXqD9hUq/voa8yPuxra/qC6DsCfAe5vjiYD6/ThZsBD/bf+oSEtgjSRve4M9aof
 Lv2FkKTWgAdji5+1Maak7GFoTLVp11HLtO8Z9fCsXMlYuJQM2DfyGZGjRK9jyH6af21s/Q1NL
 YuTEKmoUyxCBRsd4EPF78VsyS70yljk0Q4u7OHj0M0LQCPPKyvxnjo3GmUX37oCiKhbzmsg+X
 YQR1XlZ1nC2CmrVPboKbeUM8M/6Rbi553J/fcp4W4i1qC2+odIUezVg4DDNi9R3tUoMnwGBxi
 L6BLc+2BcbN6rmYC20P9RLz4UkUdSfZYmUD/kD/ih03lnN+FfMOY9KmmW2nYQq7/8y+nCmZdF
 nEGj4sdqulcMoltI6uAvx02t8aYk2KBIbrTy1cx2Df5IzikP3BpcK3C4Xr50FJZMsH9YpsRVw
 k8V+EIPRCwwK8+FXbOOHbWVX2d6v4hzQgIwRj2TUkG1HpJtHnCLuvKcX8oIF7EXCDjIZnyZVE
 sQd1DKZik2FETabcrD7k3NzsWPKI63QeH3e+5UQLyFYmI6NdX75pYHvJ8zWzN9ZI2jrmaTpuE
 55VhR7yqLB4VCjV4bjmjZf6ktj81JDrihgW+30Tedj20Fs5/rex46LGkbrOA3FLv45Cfu8zi7
 Pu1hm0XkYHt1AVX7qdG01PHcEhATxrq1YjbJOKweAvvuFCTI9xZsa5AMD5ILpDsIPyDFN03YS
 9OS4xYDDisPXPKkyEgbujSvBgwLtWUjXJDl8sQ+V9szqIVFmwjsziEtWroGdLhdQ5qJwz/Cwq
 UbeDOs1Wd6HHJSKpErW5PtJVaD9OaXlg1rL1MyfMKsJ71oJ9YKkXqXdKXx3doN1lrSccT0x+i
 AzOpVK9lwTvv+pWSkpCZuKasGQ9Ip3H0LFTmkuPAbMXwFl7CAjT1JnVPnw==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tMbDGjvJuJijemkf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2020 at 08:41:23PM +0200, Andreas Kemnade wrote:
> On Sun, 21 Jun 2020 00:42:16 +0200
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
>=20
> > The Netronix embedded controller as found in Kobo Aura and Tolino Shine
> > supports one PWM channel, which is used to control the frontlight
> > brightness on these devices.
> >=20
> > Known problems:
> > - `make dt_binding_check` shows the following warnings:
> >   Documentation/devicetree/bindings/mfd/netronix,ntxec.example.dts:49.1=
7-42:
> >   Warning (pwms_property): /example-0/backlight:pwms: cell 2 is not a
> >   phandle reference
> >   Documentation/devicetree/bindings/mfd/netronix,ntxec.example.dts:49.1=
7-42:
> >   Warning (pwms_property): /example-0/backlight:pwms: Could not get
> >   phandle node for (cell 2)
> >=20
> In the tolino sources in ./drivers/misc/ntx-misc.c I find this line
>=20
>         if(4=3D=3DgptHWCFG->m_val.bFL_PWM) {
>=20
> No idea what it does but I would expect to have a kind of translation to
> a dt property?

As far as I understand it, FL_PWM=3D4 means that there is a second PWM
channel, in order to provide different backlight colors.

I think it should be possible to simply extend the binding to list
another available PWM channel, once we add support for such hardware.

> > +                    ec_pwm: pwm {
> > +                            compatible =3D "netronix,ntxec-pwm";
> > +                            #pwm-cells =3D <1>;
> shouldn't that be 2?
> > +                    };
> >              };
> >      };
> > +
> > +    backlight {
> > +            compatible =3D "pwm-backlight";
> > +            pwms =3D <&ec_pwm 0 50000>;
> since you have 2 values after the &ec_pwm=20
[...]
> > +properties:
> > +  compatible:
> > +    const: netronix,ntxec-pwm
> > +
> > +  "#pwm-cells":
> > +    const: 1
>=20
> shouln't that be 2?

Right, I'll fix that.


Thanks,
Jonathan

--tMbDGjvJuJijemkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl9C8NQACgkQCDBEmo7z
X9uNgRAAypyatRejZgWsIlkujRwQt4g+wZ9cH+A+BTje8tzoHEE5uOLhHZQrFOLU
zA7FbHiGlovtkrA0ca1E8N7kuS9k4bfk7cQwyZmDDbuf6f8vTKgqlCS2TFuWgHWu
lnTLO42WiM/G0eS0AUmqTuh445AH0xBw7KuQBq6/O39rW1In8qYg/9qdO4GsZRS1
uSE95Rn7nbmd1Nj0r0wrQy2O6E+a2JDv9koToSEszeuRMQPxBmHUx7YmS6EYe7+X
AN/YKeQNtOmTQb6n6U46y/qH2KIp4+Ebnc0Ae5SiIrANkG6LEa5RJ0s++r4j1z4Y
UMUiXKAeQL3XOX7GyNBIRK0ByX6BgPcO+ywO7Q7U3PW8mCHa3jnbTONkBT0mUwZe
+xiu9mwz2u9vV6wTDiHZL0wSZ2GIcWqXNHjlxn1AkzPgAaA1Qg4BGCYBvTkkbivb
fuCSusLSJHr4GHxK9Tk/nPJF/63j629ILcwp3h7ulwqc5ro+roDiMq4ADEnBTI2S
GtmBnzSfvxOcN2emKrGTHqjY6MTPPXxLT5CS4z1ufASrExDu7hQ0RzDP4x4hDfCI
8FVkDFNyaUh2KhhT+0SkVqQ+Y6fdaIVVQIGfilpFiKZmeKrTZqwoYkp8tIhXePfK
lx/HZuodLRdOJFh46yqADuYWZQlrYT1l+fBtdCO8fwa9L0r7bwM=
=zbaI
-----END PGP SIGNATURE-----

--tMbDGjvJuJijemkf--
