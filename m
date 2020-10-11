Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BE528A990
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Oct 2020 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgJKTKP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Oct 2020 15:10:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:34633 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728236AbgJKTKP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 11 Oct 2020 15:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602443357;
        bh=4tiCguk2G4daQO6UyDdSbqh3sXV+E4fT80cf7CrV5AY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZdwHoKYLT6P2T0uwwc/eglY00QK5rz5GCKVpP7P5+ihulRsEn9bdWFuMTqMyK8ujR
         qZYR5/AWRlNaDB7cRYiIVciYb1X0cfY78GPDNLyPQCP+PWMM2GbbpdqTPQ87a2jhhb
         Z2Fsp/q3mTYgVIViyodVsLYgJCyjTJl8/OPhuiic=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.214.162]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MCsU6-1kaWQG2skq-008rQY; Sun, 11
 Oct 2020 21:09:16 +0200
Date:   Sun, 11 Oct 2020 21:09:10 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        allen <allen.chen@ite.com.tw>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20201011190910.GE500800@latitude>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-6-j.neuschaefer@gmx.net>
 <20200925054424.snlr3lggnsv575wu@pengutronix.de>
 <20201004014323.GD500800@latitude>
 <20201004084209.GV2804081@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <20201004084209.GV2804081@piout.net>
X-Provags-ID: V03:K1:7K8Md1pZqbYIW8A9iut38o8lntAa5HGcKgmIuw+DcTCDMPBJz0o
 fIz/Bi/xrZp3TgfNoxDkvxWMtHjJQPAt+yjh2XCdaU2BZF1gMs8giJXBnWRLBJH8AcAAYRl
 tjzTY3jkWaRJxT3OK6Iz0IyQPFg7qdp6XhxPJ2s3FWHfLbZavY2Aq2ojl1rV7EctRjix+5a
 7/O0xwNGZXrTwEZMbS+IQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/dHCjfPzFI4=:CMeq7wIq1hmXrAFRAICDLV
 y5rqdbHWH3sowh6/OUJJtnRa1OeVF9t8q7oYQXIXkdxY/bKx/b+wkmp3Imnf1y0cLL4f/iODa
 aE8l3jj82Die7D0cQr1nFpj8PguPHziC92NAozrUsU9iXQayNW0vnurpqySA12VfRPbKcJmu0
 fuQAfkQMreV+jLJdiW9ch3BFQTx6ryqWKLS4gjNhTsiWSWkCvGkcwZRhWVeNFC0FKKmbtQfhl
 U3NNMVxJTT2dyADLDqHH/NZLNfURMyg6qrc6aN3oYIBV5UFYM8Z1+WiWYQvO0hZNL6sz4MntV
 SVN576fUw821uvSf/2cz+rkOES0u1LAcLX5TLOW32fzGhN0Y6pPA613aVtrP6NYVAf9Dy+gnx
 kaLjsFm8U/mJ3+vQFmBBKvsSW3DdGF7LIkR5ETdTAaxs6WBHVPs7zi3lU7d9w7OMNg9HXHLnQ
 TNK2luzZmrQYiCdwMR56361HR1D/uY6RWieUXK6MEg276Tct/ngOo+EKfR5tahOn6l+9xnzUA
 +q6BGEIIy/K37/IOQuWK//y73HSft0JsFYWUk9UvTPdKOwXMA2W524jA0Q2UfDsy3kHMtmxe1
 rG6K4ioxQGa9nF0jqakvQCs28qy6en8215xCsj0rIZLuBw+cE1lRsYFbV2GAl7wvQmMpMs/Xa
 JvcUshZh4jEvaaHZP1oBVNryf80LmjEkTxMLrnFfwRucxQ2DiEr4yIJTwW8BAA7gDm1hHwPa4
 vxRZHKVAQHSv6LOcx/Kp9Xe+5lCPAVC7/9qoUYOEhM1tdoO6H52KweyJ0PbW5TUMlJxFfQcAM
 62shbC9F5A5Q4ZOLXfdG9HyuuVMRjqh14bs2Dl3+SncAq7duCI4fn41uZcc9mznUKdQL5SO+H
 9JllVoDOTslRHhMe+6QSvysL3gmA9ac0viac7on0x/7ZN8roD1qfaMSrpHQ5a2E3qUcRU7Fn5
 O8O+9US2zPGSiMB9jTmREq95D69Zv9zUbMFD6YEmYGP/cVR/xiI3Z5kYCKMEV5MBFiVzaPz1+
 Y/eIHVG6NHROpdvbizPNp0IkoqTE4YY3IbgiiF6VvluZJHNKcy6ditGKXGsQ1u5O5IY3CTiw8
 Fsp277vtJq3kUY/Tpo48gUsMWfOgaSUkloUW1/ddfaWvrifNzpYUegs4oYUAc84jxGgCt2u0I
 YuyZqSvkQzo3o5d9m5LFnlTGuPOcCcICHxj4iqdh01JRCNX8WkXSZqicmKVoYpZuFDhP6jeco
 qu1422B2ijs+bGQj9WZJ8CVqZ7+WwUeStnXfThw==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 04, 2020 at 10:42:09AM +0200, Alexandre Belloni wrote:
> On 04/10/2020 03:43:23+0200, Jonathan Neusch=C3=A4fer wrote:
> > > > +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
=2E...
> > > > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, ntx=
ec_reg8(tm->tm_min));
> > > > +	if (res)
> > > > +		return res;
> > > > +
> > > > +	return regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxe=
c_reg8(tm->tm_sec));
> > >=20
> > > I wonder: Is this racy? If you write minute, does the seconds reset to
> > > zero or something like that? Or can it happen, that after writing the
> > > minute register and before writing the second register the seconds
> > > overflow and you end up with the time set to a minute later than
> > > intended? If so it might be worth to set the seconds to 0 at the start
> > > of the function (with an explaining comment).
> >=20
> > The setting the minutes does not reset the seconds, so I think this race
> > condition is possible. I'll add the workaround.
> >=20
>=20
> Are you sure this happens? Usually, the seconds are not reset but the
> internal 32768kHz counter is so you have a full second to write all the
> registers.

I just checked it, and on this RTC, the phase / sub-second part is not
reset when the time is set.

> > > .read_time has a similar race. What happens if minutes overflow betwe=
en
> > > reading NTXEC_REG_READ_DH and NTXEC_REG_READ_MS?
> >=20
> > Yes, we get read tearing in that case. It could even propagate all the
> > way to the year/month field, for example when the following time rolls
> > over:
> > 	   A   |  B  |  C
> > 	2020-10-31 23:59:59
> > 	2020-11-01 00:00:00
> >=20
> > - If the increment happens after reading C, we get         2020-10-31 2=
3:59:59
> > - If the increment happens between reading B and C, we get 2020-10-31 2=
3:00:00
> > - If the increment happens between reading A and B, we get 2020-10-01 0=
0:00:00
> > - If the increment happens before reading A, we get        2020-11-01 0=
0:00:00
> >=20
> > ... both of which are far from correct.
> >=20
> > To mitigate this issue, I think something like the following is needed:
> >=20
> > - Read year/month
> > - Read day/hour
> > - Read minute/second
> > - Read day/hour, compare with previously read value, restart on mismatch
> > - Read year/month, compare with previously read value, restart on misma=
tch
> >=20
> > The order of the last two steps doesn't matter, as far as I can see, but
> > if I remove one of them, I can't catch all cases of read tearing.
> >=20
>=20
> Are you also sure this happens?
>=20
> Only one comparison is necessary, the correct order would be:
>=20
>  - Read minute/second
>  - Read day/hour
>  - Read year/month
>  - Read minute/second, compare

With this order, every one-second increment is detected, which I
previously tried to avoid. But I suppose it's fine because it simplifies
the logic and the window from first to last read should be short enough
anyway to be relatively unlikely to hit, and thus not cause a lot of retrie=
s.

> If day/hour changes but not minute/second, it would mean that it took at
> least an hour to read all the registers. At this point, I think you have
> other problems and the exact time doesn't matter anymore.

Indeed.


Thanks,
Jonathan Neusch=C3=A4fer

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl+DWEYACgkQCDBEmo7z
X9uepA//fs6TCspmRMOe/zMk+MiAPbG25ReDry1BglGSs1eeSHmE96PH7J5nrOId
wQvmP/r+Sf3MqaIie02JZpoj3J223zgb0dfY3fUZ1FwsUpm7lbRJRSmuPEcBcdFd
6VcvgCL9/xASAYe0ShQg2Gni6Gk6zzGLRxx0C+PTDvar9pzutLZKngTAPDM6yDwO
4xlZkGWjQ0jxVhcJnUiNF3ooj/PFbkOLGkHlQfWHToDBXWKDkfDiMGFREdnN6lTI
qzMGwUUCbjEQaGlM/GDMKI+Oq9oqgizZKx+hJ+2hay94cDz/Bh+hqFe5j4TCrvVG
QCnOixWBQs80Zwoei8owdgszzKasJPFTQ08tcnYGsJvdOTHjTPWY1XUPWhZaxdHO
57Pg/t3JpU10VjkEIzdg/qLmdlK7yqZ5BPk1WCeLfobzgr72EKslIveFP+7TmqHG
j9EP5NewELC3Zt5sYvcTy6A7rxNT4TpRr0I3N9As1MNereNq2YV78ylqHDN8xj80
Meo726ga70Tr2nWQ5/VyPabbvsXsuQGjIpcFs3XjfnvpCRDolGUnjEpy3W9EFMqt
WFW5XUa9tw+snOi2VkMxmsVa3nNbpH0dLO22JN+C/Y4yEzpdQBPmLDkQDv4rIDqf
UvXNBVGffn1fxxS3UX71T/KtwxDsGT6+QopIL47DURXw8yqX14Y=
=GuMr
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
