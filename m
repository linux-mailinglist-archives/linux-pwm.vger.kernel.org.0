Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E019213D6E
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 18:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGCQRA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 12:17:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:36325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGCQQ7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 3 Jul 2020 12:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593792961;
        bh=eqadiF6CtQU+rbRtG0zl0hM0GNO8oDiiIhsQ1OBoKpQ=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=D9SCmNdHhHvkfdjjsfpCfVRxX0RxjSfTtpErAICuk88aI8KG67g72alYFF5q30u1C
         lWAaw/NLzchvrOQjZpWRZbNq+DPcHaWglVX8FHPrSt0RgKcFhQJf4OsBb7yoQ9ED4P
         OWRUt6iEUu2033Z2J9gOd6WnBI6odcD7Gq/8Xteg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.26]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1iu2PZ0Vku-00xZbm; Fri, 03
 Jul 2020 18:16:01 +0200
Date:   Fri, 3 Jul 2020 18:15:56 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>, linux-rtc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
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
Subject: Re: [RFC PATCH 06/10] pwm: ntxec: Add driver for PWM function in
 Netronix EC
Message-ID: <20200703161556.GA2578@latitude>
References: <20200620224222.1312520-1-j.neuschaefer@gmx.net>
 <20200620224222.1312520-5-j.neuschaefer@gmx.net>
 <20200622081802.pv4xmb7vn4te5r5t@taurus.defre.kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <20200622081802.pv4xmb7vn4te5r5t@taurus.defre.kleine-koenig.org>
X-Provags-ID: V03:K1:gwpnTl/wbXQ6CtVRQZ2/poQHgxJmcBWGUDwOXRaaOlwSttTLMCE
 Hm977PBvuIYzYaHdYwKjEy0d7C1/fYmpcMzoRMhnZzzpq3ozFsXjcq/lkKFNIWGX1VLRWNU
 MQH0fIrjpIVOw5zDbqcABp5xNW0umxvHoyLJPDYo4sNEc01PMbQLar53iVHLRVWOTi2a9iI
 SP/Nb+2yWtTsb7zorvDbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3NIly32uOrs=:6Rf5/CZxbPqnDDT3OIBZ0Y
 1yOfvsUqlvuXK3DcIt3bGTc03SgD8PUaSF9SOGlwXpWA9uwlT5ez5AYHtP3BqKbRPdXCfqmIm
 yfZqIa/d7jta5Dkn40VfAOfESnbwpSNPqEkdjDb1peLdAOFdhXcebyVbm1P5Hk8fF1KEG/St9
 SbJDIUwGvKe9HrGs7cfO8AwrZGl4V2xT2rLDGDdfwWA9KCf7YC/cczp/JkIXALbPTz8zIcQxM
 gn+ZDutzhyc+GIK6QNATZqj7Tqh+waimPBnybxhc1GbitaGDar683/+RtnMpHFkyT15aj5zyR
 kM1MxR/6vGJuIZdms9CnCuepp589DWmMU6KSTkVmQh21k/bfDqs1I7V6x9yUeQ/QX8Mb+zfs7
 R6B5dVcYFjPqzo+EEtDVH38LiTuePpAmyu5MIx8psyrPLgtAfPepOaB4kHfS3VyDe4WQYj37B
 Jgtrk9g6zznSI2JyBPX8fVcFu0lRlAPxv2iCHq4Is41JWU+gHMxAPES7fhhgHGrHkECVIFc5M
 inPJ0HsOqWc5AzmARCo12znzji0XjLF3QkrVEofFCAz8FcjkV0IW68RNEv0c0iEujczb9yuxq
 xDqiR6Iq2dcNeDEuBV5o1si7qRaDvROvYzcElm4ZkMiWxy6941AG77LA5ddAupDtbzrT3Q3PQ
 pkuk1ARBOyiTTmsWAQg2eLSaGhu84brXo5g3Ocl0yBEdyMnuQLRUkKPdPgVHL8DRcP1korpD7
 0EmJ+YxHoUCLuOJGSpsh/9U2blyoltRm+ldLx7X6tdgtd6M6I2PG52Hii1Cs4Y3qSVvOm+yvL
 x7v6+DD55SOd8IMSwRYoizl4ZTsQLn9f4cLWaiiYt5HEfGS5po8bBQy17wE0nYprQgwU/tWX5
 7LDPGRL5I0zjTnDvgXqp/yhnGr8sISx9BHYfgVBpCrtQDz4q/TUBKB17aEU5M3Z2zaELXUL1N
 59NKqnGMW77Zflj0d9SKNytFkyHYEGWJ4rOz4aGv/l2gqKixA7bLDwPIYt7kVGcwb7QL87qMb
 BDos97kFICbB9IWnBXzatmKm1BhP6oLGHG9r3L6MOxF92OKYs+rykEy+H3kt6dC1cx//6T2qp
 6GuF21C1zk9kya+2Ejl3jr1CSHgPLEkrr4YByyGMOf33CxjZBhs7FuIGpvVEvGaTOuQsl8D8U
 fqst6bigszCf08GEVyB9dIVq7SCeYTx9MaRhMd/AG0PVLt27vmtg+tXNRHAcDBNhVVK9UJTdP
 0up7aQGVBxeN7YCJ9XSVbazSnaXHWCsV4LBXijw==
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2020 at 10:18:02AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Sun, Jun 21, 2020 at 12:42:17AM +0200, Jonathan Neusch=C3=A4fer wrote:
> > The Netronix EC provides a PWM output, which is used for the backlight
>=20
> s/,//
>=20
> > on ebook readers. This patches adds a driver for the PWM output.
>=20
> on *some* ebook readers

Ok, I'll fix these.

>=20
> > +#define NTXEC_UNK_A		0xa1
> > +#define NTXEC_UNK_B		0xa2
> > +#define NTXEC_ENABLE		0xa3
> > +#define NTXEC_PERIOD_LOW	0xa4
> > +#define NTXEC_PERIOD_HIGH	0xa5
> > +#define NTXEC_DUTY_LOW		0xa6
> > +#define NTXEC_DUTY_HIGH		0xa7
> > +
> > +/*
> > + * The time base used in the EC is 8MHz, or 125ns. Period and duty cyc=
le are
> > + * measured in this unit.
> > + */
> > +static int ntxec_pwm_config(struct pwm_chip *chip, struct pwm_device *=
pwm_dev,
> > +				 int duty_ns, int period_ns)
> > +{
> > +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
> > +	uint64_t duty =3D duty_ns;
> > +	uint64_t period =3D period_ns;
>=20
> As you cannot use values bigger than 8191999 anyhow, I wonder why you
> use a 64 bit type here.

No particular reason; I possibly got confused by the division API. I'll
use uint32_t instead.

> > +	int res =3D 0;
> > +
> > +	do_div(period, 125);
>=20
> Please use a define instead of plain 125.

Will do.

> > +	if (period > 0xffff) {
> > +		dev_warn(pwm->dev,
> > +			 "Period is not representable in 16 bits: %llu\n", period);
> > +		return -ERANGE;
> > +	}
> > +
> > +	do_div(duty, 125);
> > +	if (duty > 0xffff) {
> > +		dev_warn(pwm->dev, "Duty cycle is not representable in 16 bits: %llu=
\n",
> > +			duty);
> > +		return -ERANGE;
> > +	}
>=20
> This check isn't necessary as the pwm core ensures that duty <=3D period.

Ok, I'll remove it.
>=20
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_HIGH, period >> 8);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_PERIOD_LOW, period);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_HIGH, duty >> 8);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_DUTY_LOW, duty);
>=20
> Does this complete the currently running period? Can it happen that a
> new period starts between the first and the last write and so a mixed
> period can be seen at the output?

Good question. I haven't measured it, and also don't have the code
running on the EC.

>=20
> > +
> > +	return (res < 0) ? -EIO : 0;
> > +}
> > +
> > +static int ntxec_pwm_enable(struct pwm_chip *chip,
> > +				 struct pwm_device *pwm_dev)
> > +{
> > +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
> > +
> > +	return ntxec_write8(pwm->ec, NTXEC_ENABLE, 1);
> > +}
> > +
> > +static void ntxec_pwm_disable(struct pwm_chip *chip,
> > +				   struct pwm_device *pwm_dev)
> > +{
> > +	struct ntxec_pwm *pwm =3D pwmchip_to_pwm(chip);
> > +
> > +	ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
> > +}
> > +
> > +static struct pwm_ops ntxec_pwm_ops =3D {
> > +	.config		=3D ntxec_pwm_config,
> > +	.enable		=3D ntxec_pwm_enable,
> > +	.disable	=3D ntxec_pwm_disable,
> > +	.owner		=3D THIS_MODULE,
>=20
> Please don't align the =3D, just a single space before them is fine.

Ok

> More important: Please implement .apply() (and .get_state()) instead of
> the old API. Also please enable PWM_DEBUG which might save us a review
> iteration.

Will do!

>=20
> > +};
> > +
> > +static int ntxec_pwm_probe(struct platform_device *pdev)
> > +{
> > +	struct ntxec *ec =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct ntxec_pwm *pwm;
> > +	struct pwm_chip *chip;
> > +	int res;
> > +
> > +	pwm =3D devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
> > +	if (!pwm)
> > +		return -ENOMEM;
> > +
> > +	pwm->ec =3D ec;
> > +	pwm->dev =3D &pdev->dev;
> > +
> > +	chip =3D &pwm->chip;
> > +	chip->dev =3D &pdev->dev;
> > +	chip->ops =3D &ntxec_pwm_ops;
> > +	chip->base =3D -1;
> > +	chip->npwm =3D 1;
> > +
> > +	res =3D pwmchip_add(chip);
> > +	if (res < 0)
> > +		return res;
> > +
> > +	platform_set_drvdata(pdev, pwm);
> > +
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_ENABLE, 0);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_A, 0xff);
> > +	res |=3D ntxec_write8(pwm->ec, NTXEC_UNK_B, 0xff);
> > +
> > +	return (res < 0) ? -EIO : 0;
>=20
> This is broken for several reasons:
>=20
>  - You're not supposed to modify the output in .probe
>  - if ntxec_write8 results in an error you keep the pwm registered.
>  - From the moment on pwmchip_add returns the callbacks can be called.
>    The calls to ntxec_write8 probably interfere here.

Ok, I'll rework the probe function to avoid these issues.


Thanks for the review,
Jonathan Neusch=C3=A4fer

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl7/WbUACgkQCDBEmo7z
X9sA1BAAoaUXyqhLeTCR3RU7shyvr9x8b/kQ4QQahjrf7CK5jyE4aDDebspprYnq
13AftAJFOoVGhnFOqT8H8jhNO9qCRZ7udKCPABMdc4kzs5NMWQ2zK+s9890zcIZC
6UClwhRCkG+/wEY55LEW0lVCkQJtrkIXQ8OHCc9Cgb83hTQXULu/7Lxq/kOW5rkH
7mffJP46Ul5mtNYdd/EfKxHzxViPHswPKNEkQ9tI26Lc4IcQ3tg4amS480uez8Mi
EJZQaQAPYUPmxF5msepumrB5lAm9UL+Hn1EFnHhFdoWv+9TuaHTOwJM6uksOGPjr
RBcup36uhof9G80yNlFm59IgR52KWeAMWNBixBYHlkT6uObYMsY4RZOVb61lgf+v
WhVi8EJS7xIGTrT6DyYZRqhaN4SaPdQ5YOMsr+W0QqbeGv9W2Z6MtY3cZxKnyREI
EcrZ/qlbdcwhwpwknW/TyPA5qXO5M9WLnaJ4AR8bwDpX04CmtwDx0ej088ID2mwC
tWoy/bz0Ubsip1h8F5ClTGK8C/vg1PVD6qKTai1iDhVmucwL6KrU2lnvEmzY/RJX
6HYkfboXXEGAiK3TBw5rJ/x5MvhKPBUrlaI9Zfk/A/m27FlgUutWbCVcWYiOdeKo
K/nBRBQW9L8ArmDjUOpv2jXTs6wa+eMX7sxaO7uhyxZu5amuemA=
=1TeA
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
