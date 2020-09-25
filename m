Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BE7278003
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 07:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgIYFou (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 01:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgIYFot (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Sep 2020 01:44:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93EBC0613CE
        for <linux-pwm@vger.kernel.org>; Thu, 24 Sep 2020 22:44:49 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kLgXC-0006gp-Hj; Fri, 25 Sep 2020 07:44:42 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kLgWu-00035h-Ql; Fri, 25 Sep 2020 07:44:24 +0200
Date:   Fri, 25 Sep 2020 07:44:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org,
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
Message-ID: <20200925054424.snlr3lggnsv575wu@pengutronix.de>
References: <20200924192455.2484005-1-j.neuschaefer@gmx.net>
 <20200924192455.2484005-6-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b55wkovfqn6iyquo"
Content-Disposition: inline
In-Reply-To: <20200924192455.2484005-6-j.neuschaefer@gmx.net>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--b55wkovfqn6iyquo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jonathan,

On Thu, Sep 24, 2020 at 09:24:53PM +0200, Jonathan Neusch=E4fer wrote:
> +#define NTXEC_REG_WRITE_YEAR	0x10
> +#define NTXEC_REG_WRITE_MONTH	0x11
> +#define NTXEC_REG_WRITE_DAY	0x12
> +#define NTXEC_REG_WRITE_HOUR	0x13
> +#define NTXEC_REG_WRITE_MINUTE	0x14
> +#define NTXEC_REG_WRITE_SECOND	0x15
> +
> +#define NTXEC_REG_READ_YM	0x20
> +#define NTXEC_REG_READ_DH	0x21
> +#define NTXEC_REG_READ_MS	0x23

Is this an official naming? I think at least ..._MS is a poor name.
Maybe consider ..._MINSEC instead and make the other two names a bit longer
for consistency?

> +static int ntxec_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> +	unsigned int value;
> +	int res;
> +
> +	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_YM, &value);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_year =3D (value >> 8) + 100;
> +	tm->tm_mon =3D (value & 0xff) - 1;
> +
> +	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_DH, &value);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_mday =3D value >> 8;
> +	tm->tm_hour =3D value & 0xff;
> +
> +	res =3D regmap_read(rtc->ec->regmap, NTXEC_REG_READ_MS, &value);
> +	if (res < 0)
> +		return res;
> +
> +	tm->tm_min =3D value >> 8;
> +	tm->tm_sec =3D value & 0xff;
> +
> +	return 0;
> +}
> +
> +static int ntxec_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct ntxec_rtc *rtc =3D dev_get_drvdata(dev);
> +	int res =3D 0;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_YEAR, ntxec_reg8(=
tm->tm_year - 100));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MONTH, ntxec_reg8=
(tm->tm_mon + 1));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_DAY, ntxec_reg8(t=
m->tm_mday));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_HOUR, ntxec_reg8(=
tm->tm_hour));
> +	if (res)
> +		return res;
> +
> +	res =3D regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_MINUTE, ntxec_reg=
8(tm->tm_min));
> +	if (res)
> +		return res;
> +
> +	return regmap_write(rtc->ec->regmap, NTXEC_REG_WRITE_SECOND, ntxec_reg8=
(tm->tm_sec));

I wonder: Is this racy? If you write minute, does the seconds reset to
zero or something like that? Or can it happen, that after writing the
minute register and before writing the second register the seconds
overflow and you end up with the time set to a minute later than
intended? If so it might be worth to set the seconds to 0 at the start
of the function (with an explaining comment).

=2Eread_time has a similar race. What happens if minutes overflow between
reading NTXEC_REG_READ_DH and NTXEC_REG_READ_MS?

> +static struct platform_driver ntxec_rtc_driver =3D {
> +	.driver =3D {
> +		.name =3D "ntxec-rtc",
> +	},
> +	.probe =3D ntxec_rtc_probe,

No .remove function?

> +};
> +module_platform_driver(ntxec_rtc_driver);
> +
> +MODULE_AUTHOR("Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>");
> +MODULE_DESCRIPTION("RTC driver for Netronix EC");
> +MODULE_LICENSE("GPL");

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b55wkovfqn6iyquo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9tg7UACgkQwfwUeK3K
7AlEBAf/RcD3gHide1qc5EijimG6s9s/zjWGhHAO0leLwogNaMyb6GdjoIjrvRHf
ETLl9BUqziVi69LGA+Ub9K0+LgKyN024FRYZ/U/RqSo8PfRSw40ehnJibb+fdWjL
W0zTK31qxkj+YBnqWd32Z27hpPCZe0uk6yqaguK9aIPy7XAiwu0gah2e13tD2Bk1
6Cxr82gYMQw8iHO7EjWkQ9D3Yzwcy9ihTCxL8GJtTRif93ZchKTwoLq4wbmf8tc1
5fU0cYWXZ97+4+48/dGfqUQ6fQ2yHZXZR69MNmwFnAIaVleVXMc1B6pYIbmHhnoq
rbAZQzSE6gvnqI203rqDXBH6YXRZCw==
=tcyy
-----END PGP SIGNATURE-----

--b55wkovfqn6iyquo--
