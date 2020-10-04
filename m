Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB672827FD
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Oct 2020 03:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgJDBoa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 3 Oct 2020 21:44:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:57833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgJDBoa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 3 Oct 2020 21:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601775810;
        bh=uk/zgEMcmh53hyYJsD9rVSTVCXFi5qhVJPo/Njr0ULU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lkVvKEahe14N+6mVJ1eaYHHPhjRQiG9auUhIv7H8IJiWALY3R/rkdNiUDO8OJ6LBr
         7BOkd2Kd5l4W12pGgsTC+Swuh6QxWpeli8OrqS2r/9xA44LRuFXI/9eDm9sUs52+sm
         bfezvwaCEoVlEyf6S5y3lpMUC0323GBJmP1YKWAE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.151]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIdiZ-1kCV8e3OGD-00Efw6; Sun, 04
 Oct 2020 03:43:29 +0200
Date:   Sun, 4 Oct 2020 03:43:23 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
Message-ID: <20201004014323.GD500800@latitude>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-6-j.neuschaefer@gmx.net>
 <20200925054424.snlr3lggnsv575wu@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline
In-Reply-To: <20200925054424.snlr3lggnsv575wu@pengutronix.de>
X-Provags-ID: V03:K1:3QmB/hlTSK7COVsSvQUbFXyPQLlzF/h6TMiid01Z4Clm5Arc98v
 uler7ylH8j9QBxD0tykisMycm+wD9UERrrd+ewA2/OjwuUspDeo2xtT/2Qnkl8U5/H4az8y
 4tGKFKCvQ7SDiOJTQPqyHUPXztu5tbDBN2qCAnWjwF5YxsmxGkAAaxXhyN3ZVDti5n96UBi
 6gO033n3MxkAvTUF1Iyzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H2fI1p3h7x0=:BARqSUnfP4EPxkdAyzJvu5
 /BptNpO1FFEQ3z3DD/a6KohfY+3CLL6GdWbNRyd6TrTIvd68+OTtOxN0IVBuTYBKlxJwaQ8Wt
 gzKLRlZjM7kUKwnrsqpmUJYhr/InP3V2a72YN5XImyB3yUNDL7WXwsEDabU4EZL1+I+IiRYYa
 NNZgMf6DPftbNeP6iKtNsi/+vusWOrNB3FhY78TF0UlOf3FuPF3/KovQHlJfuOD37XGxldg3p
 Q+u8MacnMYuBL6sF1RmEoEpPD76rGD1Y3CXXdEO7tCTqnx7C7tGiVdZXGyyognnzD827MyEXU
 b1frg2Nn07i1ePForHRLRZzVROLm7hUsqoLWNpobmNqSay/xDFp6+xcrsSc8jKxPoPnoxcl6Y
 5RjtK3DPXX7y6OltqdaFh/TBMCizXFkaFQeSh1Fy+a/miTSSEYMfsTDW/oqT90SkaC3eWCjyM
 X6cCvKvHqycnPRNN3uTqSaOgHAvqYQMxUhQHgww6KjtmXTUrBArbqbCjeEObFQHtbpW1/RGrK
 ZN63KHHbGO31mrtIMkjgNmyxZ7L8n0ARxcBNTDvc6NaS/TOyWVZzdl9vFJmSEi9bmIl5C3nD4
 6H4pcW82JJ16WrlufWd3Sgy2R4F8ipDvWKchqDiagKHlBtv8O6WZAm/eA3Tj+iB11+FS8tPrn
 YlUjvsPtwjgXx03PK5r0GZ5Amx7Tr++VQHK2EIIkeQuRgtHhsjZWexbt11gOZ5/CgSniOHyni
 TgLZZ/Mn6OrDvz9cychA1SkaP+caKyI1gw2L++7dD6PVlfu2mxPuVdAo0Txyv9kCwBl1yeDRL
 zlikNsvv2tqERa3sn+C4y82HVfRLAQxaE7gJYSBi27foIJbQayOekgBskt+TxwCYN1yiEuzB4
 uC4/BWb68qCR8KcH8nuc4vnD8bxDc1yh+WAw5xkWYCCXeuFHrcYVZDg8b4j7JlGQHhvyRnlpD
 9icHQe1LmAph3YuJ4mvHQ8Z9I0IDvErkMU6TfPdryqTTnjovTGjdYrQqM2V7ziDy9W3zpP2C5
 19GCHCZVjPvA00/++eoR2fg7OGGCzyHTnv72g9mNyhAB9/kFrZZ03piPpQz1TB8B7s9/8Y1D6
 xR7iVeJXa6RSupP2lJ5hpMgHuPJ3Swm1j25cP0jS0gSY82mhy06uRwgz3QNwRrhp7J6oVzJSv
 3KHnV5sze8908B9gVk3QW0975cwmRxmWr7DW9vrAlxWuP+uNAqR0BCOXDOX+ovsQZrGLXwkY4
 6MjryYJHzKT9VnFRpG2yIaRbLukcSBHkXKyvGaA==
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2020 at 07:44:24AM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Jonathan,
>=20
> On Thu, Sep 24, 2020 at 09:24:53PM +0200, Jonathan Neusch=C3=A4fer wrote:
> > +#define NTXEC_REG_WRITE_YEAR	0x10
> > +#define NTXEC_REG_WRITE_MONTH	0x11
> > +#define NTXEC_REG_WRITE_DAY	0x12
> > +#define NTXEC_REG_WRITE_HOUR	0x13
> > +#define NTXEC_REG_WRITE_MINUTE	0x14
> > +#define NTXEC_REG_WRITE_SECOND	0x15
> > +
> > +#define NTXEC_REG_READ_YM	0x20
> > +#define NTXEC_REG_READ_DH	0x21
> > +#define NTXEC_REG_READ_MS	0x23
>=20
> Is this an official naming? I think at least ..._MS is a poor name.
> Maybe consider ..._MINSEC instead and make the other two names a bit long=
er
> for consistency?

It's inofficial (the vendor kernel uses 0x10 etc. directly).
I'll pick longer names.

> > +static int ntxec_read_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> > +	unsigned int value;
> > +	int res;
> > +
> > +	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_YM, &value);
> > +	if (res < 0)
> > +		return res;
> > +
> > +	tm->tm_year =3D (value >> 8) + 100;
> > +	tm->tm_mon =3D (value & 0xff) - 1;
> > +
> > +	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_DH, &value);
> > +	if (res < 0)
> > +		return res;
> > +
> > +	tm->tm_mday =3D value >> 8;
> > +	tm->tm_hour =3D value & 0xff;
> > +
> > +	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_MS, &value);
> > +	if (res < 0)
> > +		return res;
> > +
> > +	tm->tm_min =3D value >> 8;
> > +	tm->tm_sec =3D value & 0xff;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> > +{
> > +	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> > +	int res =3D 0;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR, ntxec_reg=
8(tm->tm_year - 100));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH, ntxec_re=
g8(tm->tm_mon + 1));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY, ntxec_reg8=
(tm->tm_mday));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR, ntxec_reg=
8(tm->tm_hour));
> > +	if (res)
> > +		return res;
> > +
> > +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, ntxec_r=
eg8(tm->tm_min));
> > +	if (res)
> > +		return res;
> > +
> > +	return regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_re=
g8(tm->tm_sec));
>=20
> I wonder: Is this racy? If you write minute, does the seconds reset to
> zero or something like that? Or can it happen, that after writing the
> minute register and before writing the second register the seconds
> overflow and you end up with the time set to a minute later than
> intended? If so it might be worth to set the seconds to 0 at the start
> of the function (with an explaining comment).

The setting the minutes does not reset the seconds, so I think this race
condition is possible. I'll add the workaround.

> .read_time has a similar race. What happens if minutes overflow between
> reading NTXEC_REG_READ_DH and NTXEC_REG_READ_MS?

Yes, we get read tearing in that case. It could even propagate all the
way to the year/month field, for example when the following time rolls
over:
	   A   |  B  |  C
	2020-10-31 23:59:59
	2020-11-01 00:00:00

- If the increment happens after reading C, we get         2020-10-31 23:59=
:59
- If the increment happens between reading B and C, we get 2020-10-31 23:00=
:00
- If the increment happens between reading A and B, we get 2020-10-01 00:00=
:00
- If the increment happens before reading A, we get        2020-11-01 00:00=
:00

=2E.. both of which are far from correct.

To mitigate this issue, I think something like the following is needed:

- Read year/month
- Read day/hour
- Read minute/second
- Read day/hour, compare with previously read value, restart on mismatch
- Read year/month, compare with previously read value, restart on mismatch

The order of the last two steps doesn't matter, as far as I can see, but
if I remove one of them, I can't catch all cases of read tearing.

> > +static struct platform_driver ntxec_rtc_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "ntxec-rtc",
> > +	},
> > +	.probe =3D ntxec_rtc_probe,
>=20
> No .remove function?

I don't think it would serve a purpose in this driver. There are no
device-specific resources to release (no clocks to unprepare, for
example).


Thanks,
Jonathan Neusch=C3=A4fer

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl95KK0ACgkQCDBEmo7z
X9uoww/+PcGp5yYzOom8eUs+afA4KaQWFu+aRNt6DhICWM5RH1t+rEHK5NAqQyFA
LsJK0aMFJ3SMrE2IWNiOSH65ihoD9ZO0+npMwue9kiDrNAAk64Brk/jm0mAtYsOE
LbtFOeDTtGd1UcUV8/5TFUzfo3BlkaScGAYfG/RBoJ6Celw3cjwo/OT8klmh0Aaj
Q0kPMwQhgfdLMpd+NfB249ONuPTp0jWXevpGNJv+oAjwM12RxMJSJw9K+Yeld32h
Zx2ZeI8wbsR3KfxRlATXuK/CZZPvLJmKUJZO3/dWdV1QwX3bMbCWo62xaiyaDft5
wBSbSDgKwnvjXp4FT8aGzvVExhNfuhfHdGKYGWB5Lx+PQNGk7rvnAPrWIVikq9Sj
IqPUFmHUN/LGyPr8OtKNjOUubjkiuv0GvN4kFHTBrZAV6J7uJEiqHWL6OEBg3Wbo
rDlmKBZEqFMNPV78vWQFquN7r+LB8z2ZMsJpJnpaHhOCCgwH2iFKKVHZACU5VMAE
g3oJUUFSgddcsKn6I41Om9BsKlVuzkb8tEhGk8/WTaYNPKfiRNLu91/PXVE4g5dK
8arbUOsKDE29RTJz8XjCUhoKUY4W93+IJ14x+Qh1K2FvHBW94ZyCJm2UlRyJmZgF
pIjduVQCndusSLmJ7YMxhtFWXpi5DpX6s9FE8kQillC1U2kg/Rg=
=bYs8
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
