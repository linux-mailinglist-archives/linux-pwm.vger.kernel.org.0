Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A583BE2C0
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 07:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGGFpa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 01:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhGGFpa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 01:45:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5924C06175F
        for <linux-pwm@vger.kernel.org>; Tue,  6 Jul 2021 22:42:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m10KX-0004jT-PC; Wed, 07 Jul 2021 07:42:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m10KU-0002Jb-Ow; Wed, 07 Jul 2021 07:42:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m10KU-0005MY-Nk; Wed, 07 Jul 2021 07:42:38 +0200
Date:   Wed, 7 Jul 2021 07:42:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <20210707054236.rn6fjivsozuxecgv@pengutronix.de>
References: <305eacc9c57c2404795b6be76a08915808e23108.1624771446.git.baruch@tkos.co.il>
 <20210705072055.5mvux5h6zdewzabz@pengutronix.de>
 <875yxmg1pi.fsf@tarshish>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="toaf4l6z656y72vb"
Content-Disposition: inline
In-Reply-To: <875yxmg1pi.fsf@tarshish>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--toaf4l6z656y72vb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

On Wed, Jul 07, 2021 at 07:58:01AM +0300, Baruch Siach wrote:
> On Mon, Jul 05 2021, Uwe Kleine-K=F6nig wrote:
> > On Sun, Jun 27, 2021 at 08:24:04AM +0300, Baruch Siach wrote:
> >> +/*
> >> + * Enable bit is set to enable output toggling in pwm device.
> >> + * Update bit is set to reflect the changed divider and high duration
> >> + * values in register.
> >> + */
> >> +#define PWM_ENABLE		0x80000000
> >> +#define PWM_UPDATE		0x40000000
> >> +
> >> +/* The frequency range supported is 1Hz to 100MHz */
> >> +#define MIN_PERIOD_NS	10
> >> +#define MAX_PERIOD_NS	1000000000
> >
> > Please use a driver prefix for these defines.
>=20
> I take this to refer also to the defines below, right?

right.

> >> +
> >> +/*
> >> + * The max value specified for each field is based on the number of b=
its
> >> + * in the pwm control register for that field
> >> + */
> >> +#define MAX_PWM_CFG		0xFFFF
> >> +
> >> +#define PWM_CTRL_HI_SHIFT	16
> >> +
> >> +#define PWM_CFG_REG0 0 /*PWM_DIV PWM_HI*/
> >> +#define PWM_CFG_REG1 1 /*ENABLE UPDATE PWM_PRE_DIV*/
>=20
> ...
>=20
> >> +static void config_div_and_duty(struct pwm_device *pwm, int pre_div,
> >> +			unsigned long long pwm_div, unsigned long period_ns,
> >> +			unsigned long long duty_ns)
> >
> > Please also use a consistent prefix for function names.
> >
> > I suggest to use u64 for some of the parameters. While this doesn't
> > change anything, it is cleaner as the caller passes variables of this
> > type.
>=20
> Actually for pre_div and pwm_div the caller passes int values. I agree
> this is inconsistent.
>=20
> ...
>=20
> >> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> >> +			 const struct pwm_state *state)
> >> +{
> >> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(chip);
> >> +	unsigned long freq;
> >> +	int pre_div, close_pre_div, close_pwm_div;
> >> +	int pwm_div;
> >> +	long long diff;
> >> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> >> +	unsigned long min_diff =3D rate;
> >> +	uint64_t fin_ps;
> >> +	u64 period_ns, duty_ns;
> >> +
> >> +	if (state->period < MIN_PERIOD_NS)
> >> +		return -ERANGE;
> >
> > MIN_PERIOD_NS depends on clk_get_rate(ipq_chip->clk), doesn't it?
>=20
> probe sets this clock to the fixed 100MHz rate (CLK_SRC_FREQ). Would you
> prefer to derive MIN_PERIOD_NS from CLK_SRC_FREQ?

I'd like to either have all of ipq_pwm_apply use this information that
the clock rate is 100MHz or nothing, but having MIN_PERIOD_NS hardcoding
that information and use clk_get_rate(ipq_chip->clk) for calculating
fin_ps is strange.

> >> +	freq =3D div64_u64(NSEC_PER_SEC, period_ns);
> >> +	fin_ps =3D div64_u64(NSEC_PER_SEC * 1000ULL, rate);
> >> +	close_pre_div =3D MAX_PWM_CFG;
> >> +	close_pwm_div =3D MAX_PWM_CFG;
> >> +
> >> +	for (pre_div =3D 0; pre_div <=3D MAX_PWM_CFG; pre_div++) {
> >> +		pwm_div =3D DIV64_U64_ROUND_CLOSEST(period_ns * 1000,
> >> +						  fin_ps * (pre_div + 1));
> >> +		pwm_div--;
> >> +		if (pwm_div < 0 || pwm_div > MAX_PWM_CFG)
> >> +			continue;
> >> +
> >> +		diff =3D ((uint64_t)freq * (pre_div + 1) * (pwm_div + 1))
> >> +			- (uint64_t)rate;
> >> +
> >> +		if (diff < 0) /* period larger than requested */
> >> +			continue;
> >> +		if (diff =3D=3D 0) { /* bingo */
> >> +			close_pre_div =3D pre_div;
> >> +			close_pwm_div =3D pwm_div;
> >> +			break;
> >> +		}
> >> +		if (diff < min_diff) {
> >> +			min_diff =3D diff;
> >> +			close_pre_div =3D pre_div;
> >> +			close_pwm_div =3D pwm_div;
> >> +		}
> >
> > I didn't check deeply, but I assume this calculation can be done more
> > efficiently.
>=20
> The thing is that we have two dividers to play with. I can't think of a
> cleaner way to find the best match for a given target frequency.

OK, with two equal dividers it might indeed be necessary to do it this
way. After seeing a get_state implemententation I will think about this
some more.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--toaf4l6z656y72vb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDlPsgACgkQwfwUeK3K
7Am+owgAlZ57tEF7uYb8WHDBMeqO3L/l2O+Zn4bj5BolgsNZ5Buk9VZKh04Hivu4
M5DHSX0vVucXLLb8PhsTYJmtBohr7ENSSkqtYnUozoT1uDJ48QQ450NZqlA2+HeA
gQ+Sj5o3sD55AoA3egVXbzIkHivw9dId1aMLYSlhAVDcPpyHbDRsAiRuaTLH5X0v
SSShDZRJKZxkxkQpgr1tRSZs7FHdDjRj9XcesD1hKQ+Z+ifY+jW2uB3YIq8vCAHe
imNKUTWXUhhA1lvzgC6hJSg5qcFd+rP9/ZhetjNF1LxqbUrgwxHnp4iqUsy4+3fV
qG5ROhFAFBlZ+evWkJNG+k+s0OJVnA==
=6Fzw
-----END PGP SIGNATURE-----

--toaf4l6z656y72vb--
