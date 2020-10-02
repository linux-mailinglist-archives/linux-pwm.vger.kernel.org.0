Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA43281F40
	for <lists+linux-pwm@lfdr.de>; Sat,  3 Oct 2020 01:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBXmZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Oct 2020 19:42:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:53817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBXmZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Oct 2020 19:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601682102;
        bh=VNujkSGNnOSx/6/sHGhh06/Hui10zfu6uh++iEFG0SM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=j4bw0TWZ4xJQUZBozQsgnkXNLny1bVRPjI3Cda9DOrjS69unzu5To3meLbU2lAfml
         XPy8OuHOj3lZkUEcBFQMKS4wZPbXFxlbh+Fze2y9cwIMpEMiZmrHVlwsbIqONADQ5e
         Trw1u4ydkdXgBXsLOXW2rcWfF+m4PHs4H9le1F4Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1kXSXp08qt-013yYG; Sat, 03
 Oct 2020 01:41:42 +0200
Date:   Sat, 3 Oct 2020 01:41:38 +0200
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
        Josua Mayer <josua.mayer@jm0.eu>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 5/7] rtc: New driver for RTC in Netronix embedded
 controller
Message-ID: <20201002234138.GC500800@latitude>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-6-j.neuschaefer@gmx.net>
 <20200924224011.074d7a19@aktux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oTHb8nViIGeoXxdp"
Content-Disposition: inline
In-Reply-To: <20200924224011.074d7a19@aktux>
X-Provags-ID: V03:K1:AzcDyHylrjhUXbJHdAF8zMDxVluMRz/oVoYjGgrWYfV/OKBSy3b
 5UVjgQoAb65bH98Oathf5hc/SDRKiO7z7miquCWLla84qfLZNc3kv5shCBgytzAuvlnIAtp
 KcsxpnkJ42GNhSSjUmATMpx418p76T1b9AJhlPf9YvY3W+MR9rx++YbhRfnDeMNG5KZKJMv
 C/+XFUvJ7lM0DpY/jmS1A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eB5wRF8j3Rk=:FhbKDY0AAAWOIhQD0g/wnV
 6NIBYlzx9LABBZp76BcbsjGjNAT6PN1FgW8LrgCGUXQgDZ6GPJcIci51niyLL7Qzv8bqABK9p
 2muG1t0R7GQKdN43zpPM6P0YrDjnxAdiQuJMQjDlKaQPsZpPcfx7KhDj/7qnpcSRRgZPtmZYH
 twpn6jA+Sn/3VCyMg/aL1B6GqrDQdxXrgbr7eZm6Ub7r+dq81sEpI2HObM7Rphyj+V724FCPl
 CzsMet642kH15fCa/M7Ga9zzw/SbpwL0llratnGC+7K6usp4AHGV5me3GUcjcwG+B1x23tofI
 QpoYucBTKPt6GChCbnE9eTKgZ+torD0E7pcW51DJHqZ8FBK45nv3+iyYT/XNWrXd0NLkdKLsj
 IumOFEaa/Dmk0ZNLbtnWIK9F1cAmUMh2PdhvHkVOYMMLbemvn5/cz9ThwjKRbECQqbsf74OHA
 /ayxUsTxy5LMEynTh07hu3QBgTvCvtUtMwxl0yNThSvRkJRICMdDMamABPoFvl5wz16s8vHhi
 CJMkYlcUUH5U4XZednxZ8JJbYmorH03ayGzI4HMZOw05Jp0dGSIppMe+/WDevb1J2Sn/4k+Y+
 D0pIgOtPwfIysyMFMub/SkDRukdNtxeYcnjGFdFTolPr62e65kP6hYcEVbkEnwUMFl7RgbjDc
 cZ89rAkh/4fk2h/MJb6yqO/ElkwzZRMUD2CB0hyiBG1eneUxng3lLxeFxLK8kNWFBJ3RHElu/
 9LQ3zs4aG0S4WWemAlS3A3M7O87URemKA+JLqGXhQAoDp6POjVONKOQSv2kxUqfM5ngVK5FMk
 CNeg1s7yRdubJoaATAZBLzO5/dDGM70KPHj8vycjI5GI6JbYytc/PdDwzmR+gUuLsLm61YsAe
 sg7Nt4VsBLkemE5KPkuCQWfaUcw7vWtfCdU9TJ0FKcTKLAFh7RWF7dzqUZX2UM671IyMH5zDY
 zDPGpD3Wzh+6R+Q0XLJChxlE3Jg259EFtHjiuF4Z28YTzM1Bbq5DrJFTDD5fY6hq2ZcgXIWSB
 DKyimnSid00Tpu+sQJ04GbZHrJB0jMVeZ124lAZMIFGz7WnPqn2tmir70eerOg+pNANj6AzTK
 9hycswnijTEpbZW96mQvpGc1iXCs/K32jPINg8uTZcEfm33EQIotft4ja+f5PaqND/zlicGff
 3/lvejJD+8Q3ODDTcVGYHaKO12QsCSCGQBQhyfisA7+lASWipDoaW15xFC5vSS9Z5nXNrlJ9z
 ZJTdcQMfThV9cfQdOD5Z7PT7kUqcstMNIoWkZVQ==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oTHb8nViIGeoXxdp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 10:40:11PM +0200, Andreas Kemnade wrote:
> On Thu, 24 Sep 2020 21:24:53 +0200
> Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> wrote:
[...]
> > +static struct platform_driver ntxec_rtc_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "ntxec-rtc",
> > +	},
> > +	.probe =3D ntxec_rtc_probe,
> > +};
> > +module_platform_driver(ntxec_rtc_driver);
> > +
> I think module autoloading will not work without
>=20
> MODULE_ALIAS("platform:ntxec-rtc");
>=20
> Same for the pwm device.

Right, I forgot that. Thanks for the reminder!

Jonathan

--oTHb8nViIGeoXxdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl93urEACgkQCDBEmo7z
X9uAZA//R06Ut3lIkpMNMYvlJnWWtMoiVmDJztFgPS7od/cNOH0yHTQ4BUVnXuBD
yBgcw+RE85KtNSAVepgvzfRAq3oa2fnTnmWc5WiWAm/v5BKKmplMSaQo6h2fCFv0
q2/CJgnPk8vliF0g+mo42kGs7Zcq2GSDS8uqTjzFcc+xMHl7jdwcLjkK1qfUhsEJ
PdsB94VV7NmY6ogfjTkp29+LditcKzaDYrW2Gzso+Y0Y+RenTboIumAKglYm8dHJ
x1brklhr2nJ7uap2uepnrvb61EVuK8BAQrComJD0nUyXGGemK18fKYWSmC4b7uu0
rSEOfe4y+VuL2aP6OCb/g2szj+/NuQt1JeL10eNth72Xb66/JAn1hUbocv6kyPqM
z2TmRWEOMOwN9bj94lSWJwgaXajL/azIVR98eXAwThjg0/1kVlcWZpYU8XC93m9m
I2l235QKsGmbXQKQJp2/dQOfRDAwJqI2FpBzSlvGvYiuPsgPiH0wqq7BzFRIfXp8
267cdLriVZfdCGWFspBpwqUcjFTnRhkiejjhFJUlR1EQyZqBqG+BcxY995AXlIcI
xtEATGvudnxzbi3jRhoVHIHFqTx8xFHrH+qR/ic1K9dVwF1xweIgp7e3kld0/n+x
cy8V0GklLy9ih8JutZ64kpnMH+W0oiQF+DUxOBRyIM2kTB8LaRY=
=CJfd
-----END PGP SIGNATURE-----

--oTHb8nViIGeoXxdp--
