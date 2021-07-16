Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2069F3CB2EE
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Jul 2021 09:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbhGPHH2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Jul 2021 03:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbhGPHH2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Jul 2021 03:07:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EC9C06175F
        for <linux-pwm@vger.kernel.org>; Fri, 16 Jul 2021 00:04:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4Htf-0004lP-Qm; Fri, 16 Jul 2021 09:04:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4Hte-0000Ac-HB; Fri, 16 Jul 2021 09:04:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m4Hte-0000BX-Fp; Fri, 16 Jul 2021 09:04:30 +0200
Date:   Fri, 16 Jul 2021 09:04:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Robert Marko <robert.marko@sartura.hr>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Balaji Prakash J <bjagadee@codeaurora.org>
Subject: Re: [PATCH v5 2/4] pwm: driver for qualcomm ipq6018 pwm block
Message-ID: <20210716070427.kv7w6imp2zoxhyz5@pengutronix.de>
References: <f79128fa287e37ee59cb03ae04b319ecb3d68c29.1626176145.git.baruch@tkos.co.il>
 <1173e7b0b58730fd187871d9e14a02cab85158cc.1626176145.git.baruch@tkos.co.il>
 <20210714201839.kfyqcyvowekc4ejs@pengutronix.de>
 <87eebyst5z.fsf@tarshish>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="msgtg5ygrpgwvoay"
Content-Disposition: inline
In-Reply-To: <87eebyst5z.fsf@tarshish>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--msgtg5ygrpgwvoay
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Baruch,

On Fri, Jul 16, 2021 at 08:51:20AM +0300, Baruch Siach wrote:
> On Wed, Jul 14 2021, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jul 13, 2021 at 02:35:43PM +0300, Baruch Siach wrote:
> >> +/* The frequency range supported is 1Hz to 100MHz */
> >
> > A space between number and unit is usual and makes this better readable.
>=20
> Quick 'git grep' indicates that '[[:digit:]]\+MHz' is a little more
> popular than '[[:digit:]]\+ MHz' in kernel code. But OK, not a big deal.

"usual" was not meant in the sense "How it is used in the kernel" but
what the typesetting rules say. (Not 100% sure about English, but in
German you're supposed to add a space.)

> >> +#define IPQ_PWM_CLK_SRC_FREQ	(100*1000*1000)
> >> +#define IPQ_PWM_MIN_PERIOD_NS	(NSEC_PER_SEC / IPQ_PWM_CLK_SRC_FREQ)
> >
> > You're assuming here that the parent clock runs at exactly the set rate.
> > Is this a sensible assumption? If this division didn't have an integer
> > result there would be rounding issues.
>=20
> The code only uses this for period validity check. It saves us some code
> for run-time division.

This check is only completely right if the clock really runs at 100 MHz,
and I'd prefer correct over saving a division. (If you know the clock
will run at 100 MHz for sure, you can better hard code it everywhere
giving the compiler the opportunity to optimize.) So the TL;DR here is:
use one or the other and use that one consistently.

> >> +	unsigned int val;
> >> +
> >> +	regmap_read(ipq_chip->regmap, off, &val);
> >> +
> >> +	return val;
> >> +}
> >> +
> >> +static void ipq_pwm_reg_write(struct pwm_device *pwm, unsigned reg,
> >> +		unsigned val)
> >> +{
> >> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(pwm->chip);
> >> +	unsigned int off =3D ipq_chip->regmap_off + ipq_pwm_reg_offset(pwm, =
reg);
> >> +
> >> +	regmap_write(ipq_chip->regmap, off, val);
> >> +}
> >> +
> >> +static void config_div_and_duty(struct pwm_device *pwm, unsigned int =
pre_div,
> >> +			unsigned int pwm_div, u64 period_ns, u64 duty_ns,
> >> +			bool enable)
> >> +{
> >> +	unsigned long hi_dur;
> >> +	unsigned long long quotient;
> >> +	unsigned long val =3D 0;
> >> +
> >> +	/*
> >> +	 * high duration =3D pwm duty * (pwm div + 1)
> >> +	 * pwm duty =3D duty_ns / period_ns
> >> +	 */
> >> +	quotient =3D (pwm_div + 1) * duty_ns;
> >> +	hi_dur =3D div64_u64(quotient, period_ns);
> >
> > this division should use the actual period, not the target period.
> > Otherwise the result might be to small.

I just noticed: Using the period here is also bad for precision as the
actual period is the result of a division.

> >> +	val =3D FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
> >> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
> >> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG0, val);
> >> +
> >> +	val =3D FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
> >> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
> >> +
> >> +	/* Enable needs a separate write to REG1 */
> >> +	val |=3D IPQ_PWM_REG1_UPDATE;
> >
> > Setting this bit results in the two writes above being configured
> > atomically so that no mixed settings happen to the output, right?
>=20
> I guess so. I have no access to hardware documentation, mind you. I
> first tried to do only one write to REG1, but it had no effect. The
> existence of the UPDATE bit also indicates that hardware works as you
> suggest.

I wouldn't trust HW documentation here. If you have some means to
inspect the waveform this is easy to test. Depending on how long you can
make the periods an LED is enough. If you start with a slower parent
clk, a big pre_div and hi_dur =3D 0 the LED is supposed to be off. Then
set hi_dur =3D pwm_div/2 which either make the LED blink slowly or keeps
off. Then setting pre_div =3D 2 either increased the blink frequency or it
doesn't. ...

> > Does the hardware complete the currently running cycle on
> > reconfiguration?
>=20
> No idea.

This is easy to test, too. If you set a big period and duty_cycle and
immediately after that set a small period and duty.

> >> +	if (enable)
> >> +		val |=3D IPQ_PWM_REG1_ENABLE;
> >> +	else
> >> +		val &=3D ~IPQ_PWM_REG1_ENABLE;
> >
> > The else branch has no effect as val is initialized as zero above, so
> > please drop it.
> >
> >> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
> >
> > How does the hardware behave with the ENABLE bit unset? Does it drive
> > the pin to zero?
>=20
> Yes. That's what experimentation here shows. The pin is pulled up, but
> the PWM keeps it low.

And with polarity set to inverted the PWM pulls the line up? As the
different hardwares behave differently and some consumers have
expectations here, having this documented would be great.

> >> +static int ipq_pwm_apply(struct pwm_chip *chip, struct pwm_device *pw=
m,
> >> +			 const struct pwm_state *state)
> >> +{
> >> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(chip);
> >> +	unsigned long freq;
> >> +	unsigned int pre_div, pwm_div, close_pre_div, close_pwm_div;
> >> +	long long diff;
> >> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> >> +	unsigned long min_diff =3D rate;
> >> +	uint64_t fin_ps;
> >> +	u64 period_ns, duty_ns;
> >
> > You have to refuse the request if state->polarity !=3D
> > PWM_POLARITY_NORMAL.
> >
> >> +
> >> +	if (state->period < IPQ_PWM_MIN_PERIOD_NS)
> >
> > It's strange that you assume here the hardcoded 100 MHz but below you
> > use clk_get_rate(ipq_chip->clk).
>=20
> As I said above, this is meant to save code for the less critical
> case. Should I use clk_get_rate() here as well? If we go with
> assigned-clock-rates, as you suggest below, we'll have to do that
> anyway.

Sounds right. (That is: use assigned-clock-rates + use clk_get_rate
consistently)
=20
> >> +		return -ERANGE;
> >> +
> >> +	period_ns =3D min(state->period, IPQ_PWM_MAX_PERIOD_NS);
> >> +	duty_ns =3D min(state->duty_cycle, period_ns);
> >> +
> >> +	/* freq in Hz for period in nano second */
> >> +	freq =3D div64_u64(NSEC_PER_SEC, period_ns);
> >> +	fin_ps =3D div64_u64(NSEC_PER_SEC * 1000ULL, rate);
> >
> > I don't understand that factor 1000. This just cancels with the 1000 in
> > the calculation of pwm_div below?! Maybe this is to soften the precision
> > loss?
>=20
> That is my understanding of the code intent.
>=20
> >> +	close_pre_div =3D IPQ_PWM_MAX_DIV;
> >> +	close_pwm_div =3D IPQ_PWM_MAX_DIV;
> >> +
> >> +	for (pre_div =3D 0; pre_div <=3D IPQ_PWM_MAX_DIV; pre_div++) {
> >> +		pwm_div =3D DIV64_U64_ROUND_CLOSEST(period_ns * 1000,
> >> +						  fin_ps * (pre_div + 1));
> >
> > Having fin_ps in the divisor results in loss of precision. When ever the
> > closest rounding division rounds down diff becomes negative below. So
> > you should round up here.
> >
> > Also if you do:
> >
> > 	pwm_div =3D round_up((period_ns * rate) / (NSEC_PER_SEC * (pre_div + 1=
)))
> >
> > there is no relevant loss of precision. (You might have to care for
> > period_ns * rate overflowing though or argue why it doesn't overflow.)
>=20
> Looks better.

And doesn't need the factor 1000 to improve precision \o/

> >> +		pwm_div--;
> >> +		if (pwm_div > IPQ_PWM_MAX_DIV)
> >> +			continue;
> >
> > This check can be dropped if the loop (depending on the other parameter=
s)
> > does not start with pre_div =3D 0 but some bigger number.
>=20
> That is, calculate the minimum pre_div value for which the division
> above always produces pwm_div in range, right?

Yes, that was my idea. I didn't do the math but expect this not to be so
difficult.

> [...]
> >> +static void ipq_pwm_get_state(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> >> +			      struct pwm_state *state)
> >> +{
> >> +	struct ipq_pwm_chip *ipq_chip =3D to_ipq_pwm_chip(chip);
> >> +	unsigned long rate =3D clk_get_rate(ipq_chip->clk);
> >> +	unsigned int pre_div, pwm_div, hi_dur;
> >> +	u64 effective_div, hi_div;
> >> +	u32 reg0, reg1;
> >> +
> >> +	reg0 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG0);
> >> +	reg1 =3D ipq_pwm_reg_read(pwm, IPQ_PWM_CFG_REG1);
> >> +
> >> +	state->polarity =3D PWM_POLARITY_NORMAL;
> >> +	state->enabled =3D reg1 & IPQ_PWM_REG1_ENABLE;
> >> +
> >> +	pwm_div =3D FIELD_GET(IPQ_PWM_REG0_PWM_DIV, reg0);
> >> +	hi_dur =3D FIELD_GET(IPQ_PWM_REG0_HI_DURATION, reg0);
> >> +	pre_div =3D FIELD_GET(IPQ_PWM_REG1_PRE_DIV, reg1);
> >> +	effective_div =3D (pre_div + 1) * (pwm_div + 1);
> >
> > Please add a comment here that with pre_div and pwm_div <=3D 0xffff the
> > multiplication below doesn't overflow
> >
> >> +	state->period =3D div64_u64(effective_div * NSEC_PER_SEC, rate);
> >> +
> >> +	hi_div =3D hi_dur * (pre_div + 1);
> >
> > This suggests that the hardware cannot do 100% relative duty cycle if
> > pwm_div =3D=3D 0xffff? I suggest to clamp pwm_div to 0xfffe then.
>=20
> What is "100% relative duty"? How does pwm_div clamping helps?

relative duty =3D duty_cycle / period. So 100% relative duty means period =
=3D=3D
duty_cycle. With pwm_div =3D=3D 0xffff period is
0x10000 * (pre_div + 1) / rate but duty_cycle cannot achieve that as the
maximum is 0xffff * (pre_div + 1) / rate.

> >> +	pwm->clk =3D devm_clk_get(dev, "core");
> >> +	if (IS_ERR(pwm->clk))
> >> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
> >> +				"failed to get core clock");
> >> +
> >> +	ret =3D clk_set_rate(pwm->clk, IPQ_PWM_CLK_SRC_FREQ);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "clock rate set failed");
> >
> > Would it make more sense to set this in the device tree using
> > assigned-clock-rate?
>=20
> That's 'assigned-clock-rates' I believe. I'll try that.

Ah right, I missed the s.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--msgtg5ygrpgwvoay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDxL3kACgkQwfwUeK3K
7Angggf+LgbLHMsfYXQfkWgXRHVd62Qz0nRhL4ak8mG5b1VgKEM4J2qOu4+m86Iu
tZonOx9d84GqwsiCvlJhpqLX/UZCmH4i+r6ADIMD85S/523X1BqVjqdvNZJ+5FjK
/Ckgd3YHDFH953h2kSrc6ncMJ8WXE8+BjU/UrM5LK/7uOmRUo5/D+ikcPKyWjU9S
+NLVvpkDpz0w6M1ycfrHMqFzy9F3fpBokjMMNmR8alV+GMgUnL8ytqNHxU5dP+LS
a3xnrmwIhi/2NIW0p5Yzv9xF+zyDrPdG6Qe9irdN+Okap/TnLLV+2CKGuNCFXPMc
n81aBT2MzLlYM13U/WZ7uKbCIzUSiw==
=YlFY
-----END PGP SIGNATURE-----

--msgtg5ygrpgwvoay--
