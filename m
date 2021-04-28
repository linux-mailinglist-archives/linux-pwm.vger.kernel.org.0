Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AD436DC43
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Apr 2021 17:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240924AbhD1Pq3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Apr 2021 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbhD1Pp4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Apr 2021 11:45:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDC7C0612B2
        for <linux-pwm@vger.kernel.org>; Wed, 28 Apr 2021 08:40:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbmIV-000764-N8; Wed, 28 Apr 2021 17:40:19 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lbmIU-0007KG-Is; Wed, 28 Apr 2021 17:40:18 +0200
Date:   Wed, 28 Apr 2021 17:40:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     fenglinw@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        subbaram@codeaurora.org, collinsd@codeaurora.org,
        aghayal@codeaurora.org
Subject: Re: [PATCH 2/2] pwm: pwm-qcom: add driver for PWM modules in QCOM
 PMICs
Message-ID: <20210428154018.fiknoxraymestnnj@pengutronix.de>
References: <20210427102247.822-1-fenglinw@codeaurora.org>
 <20210427102247.822-3-fenglinw@codeaurora.org>
 <20210427170748.wglupc6zwrndalxs@pengutronix.de>
 <6eccf4583cb1eb36775e50cdf069cdbc@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t5k3x7s7xr2lhlm7"
Content-Disposition: inline
In-Reply-To: <6eccf4583cb1eb36775e50cdf069cdbc@codeaurora.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--t5k3x7s7xr2lhlm7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Apr 28, 2021 at 08:42:58PM +0800, fenglinw@codeaurora.org wrote:
> On 2021-04-28 01:07, Uwe Kleine-K=F6nig wrote:
> > On Tue, Apr 27, 2021 at 06:22:10PM +0800, Fenglin Wu wrote:
> >  - Does the hardware complete the currently running period when the PWM
> >    is disabled?
>
> No, the output stops immediately as soon as the PWM channel is disabled

Is this only because you clear PWM_EN_GLITCH_REMOVAL on disable?

> >  - Does the output pin pull to the inactive level when the PWM is
> >    disabled?
>
> Actually, the QCOM PMIC PWM module doesn't have physical pin out. Its out=
put
> is normally connected to other hardware module in the same PMIC as intern=
al
> signals, such as: control signal for LED module for scaling LED brightnes=
s,
> input signal for vibrator module for vibration strength control. It's out=
put
> can also be routed through PMIC GPIO or other pin using internal DTEST
> lines, and that depends on HW connection, and it will also need addition
> configuration in the GPIO module or the DTEST and that's outside of the
> PWM module scope.
>
> For the output signal itself, it's always inactive when the PWM module
> is disabled.

Inactive as in "outputs a 0" and not as in "driver is disabled", right?
(Not sure this is a well defined term given that the output isn't
normally externally visible.)

> > > +static int qcom_pwm_channel_set_glitch_removal(
> > > +		struct qcom_pwm_channel *pwm, bool en)
> > > +{
> > > +	u8 mask, val;
> > > +
> > > +	val =3D en ? PWM_EN_GLITCH_REMOVAL_MASK : 0;
> > > +	mask =3D PWM_EN_GLITCH_REMOVAL_MASK;
> > > +	return qcom_pwm_channel_masked_write(pwm,
> > > +			REG_PWM_TYPE_CONFIG, mask, val);
> >
> > What is the effect of this setting?
>
> As I explained at the beginning, enable this setting would garantee the P=
WM
> module complete current period before swtiching to the new settings.

Then there is no reason to unset this bit when the PWM is disabled and
the setting can better be done once in .probe()?

> > > +static void __qcom_pwm_calc_pwm_period(u64 period_ns,
> > > +			struct qcom_pwm_config *pwm_config)
> > > +{
> > > +	struct qcom_pwm_config configs[NUM_PWM_SIZE];
> > > +	int i, j, m, n;
> > > +	u64 tmp1, tmp2;
> > > +	u64 clk_period_ns =3D 0, pwm_clk_period_ns;
> > > +	u64 clk_delta_ns =3D U64_MAX, min_clk_delta_ns =3D U64_MAX;
> > > +	u64 pwm_period_delta =3D U64_MAX, min_pwm_period_delta =3D U64_MAX;
> > > +	int pwm_size_step;
> > > +
> > > +	/*
> > > +	 *              (2^pwm_size) * (2^pwm_exp) * prediv * NSEC_PER_SEC
> > > +	 * pwm_period =3D -------------------------------------------------=
--
> > > +	 *                               clk_freq_hz
> > > +	 *
> > > +	 * Searching the closest settings for the requested PWM period.
> >
> > Please don't pick the nearest setting, but the next smallest one.
>
> I am not quite sure here. You can see from the equation above, there are 4
> settings can impact PWM period calculation and each setting has an array =
of
> values. We can't easily sort out the sequence of settings to achieve an
> ascending
> or descending PWM periods and choose the closest one or the next smallest
> one,
> instead, the logic below is to walk through all of the settings and find =
the
> closest one.
> I am also confused about not choosing the nearest settings but the
> next smallest one, let's say if we are trying to achieve 1ms PWM period, =
and
> there are three settings can get 0.90ms, 0.99ms, 1.05ms respectively
> should we choose 0.99ms which is the closest one, or 1.05ms which is the
> next
> smallest one?

My wording was bad, you should pick the biggest period not bigger than
the requested period. So in your example you should pick 0.99ms.

And if your options are 0.90ms and 1.01 ms and the request is for 1 ms,
pick 0.90ms. I'm working on a series that allows a consumer to make an
informed choice. One precondition for that is that .apply picks a
setting according to the above algorithm though.

> > > +	 */
> > > +
> > > +	for (n =3D 0; n < ARRAY_SIZE(pwm_size); n++) {
> > > +		pwm_clk_period_ns =3D period_ns >> pwm_size[n];
> > > +		for (i =3D ARRAY_SIZE(clk_freq_hz) - 1; i >=3D 0; i--) {
> > > +			for (j =3D 0; j < ARRAY_SIZE(clk_prediv); j++) {
> > > +				for (m =3D 0; m < ARRAY_SIZE(pwm_exponent); m++) {
> > > +					tmp1 =3D 1 << pwm_exponent[m];
> > > +					tmp1 *=3D clk_prediv[j];
> > > +					tmp2 =3D NSEC_PER_SEC;
> > > +					do_div(tmp2, clk_freq_hz[i]);
> > > +
> > > +					clk_period_ns =3D tmp1 * tmp2;
> > > +
> > > +					clk_delta_ns =3D abs(pwm_clk_period_ns
> > > +						- clk_period_ns);
> > > +					/*
> > > +					 * Find the closest setting for
> > > +					 * PWM frequency predivide value
> > > +					 */
> > > +					if (clk_delta_ns < min_clk_delta_ns) {
> > > +						min_clk_delta_ns
> > > +							=3D clk_delta_ns;
> > > +						configs[n].pwm_clk
> > > +							=3D clk_freq_hz[i];
> > > +						configs[n].prediv
> > > +							=3D clk_prediv[j];
> > > +						configs[n].clk_exp
> > > +							=3D pwm_exponent[m];
> > > +						configs[n].pwm_size
> > > +							=3D pwm_size[n];
> > > +						configs[n].best_period_ns
> > > +							=3D clk_period_ns;
> > > +					}
> > > +				}
> > > +			}
> > > +		}
> > > +
> > > +		configs[n].best_period_ns *=3D 1 << pwm_size[n];
> > > +		/* Find the closest setting for PWM period */
> > > +		pwm_period_delta =3D min_clk_delta_ns << pwm_size[n];
> > > +		if (pwm_period_delta < min_pwm_period_delta) {
> > > +			min_pwm_period_delta =3D pwm_period_delta;
> > > +			memcpy(pwm_config, &configs[n],
> > > +					sizeof(struct qcom_pwm_config));
> > > +		}
> > > +	}
> >
> > Huh, this is complicated. It would be great if this could be simplified.
> > If you provide a reference manual or at least a .get_state function, I
> > can try to advise.
>
> Hmm, I am not sure how to describe the HW implementation here, but as I
> explained, there are four parameters impacting the PWM period calculation
> with different way, so the code logic here is trying to walk through all
> of the the settings and find the one which can achieve the closest PWM
> period.

OK, so we have:

              (2^pwm_size) * (2^pwm_exp) * prediv * NSEC_PER_SEC
 pwm_period =3D ---------------------------------------------------
                               clk_freq_hz

with pwm_size being either 6 or 9, pwm_exp is an integer in the range
[0..7], prediv is one of 1, 3, 5, or 6 and clk_freq_hz is one of 1024,
32768 or 19200000, right? And picking 9 for pwm_size has the advantage
that the duty-cycle setting has a finer resolution, right?

(BTW, I wonder about the choice for prediv, one of the set {1, 3, 5, 7}
would make more sense in my eyes and additionally it might even be a tad
cheaper to implement in hardware.)

This is indeed a strange formula that hardly allows to implement the
picking of parameters in a clever way.

I wonder if the hardware can emit a 100% duty cycle.

> > > +	for (i =3D 0; i < chip->num_channels; i++) {
> > > +		chip->pwms[i].chip =3D chip;
> > > +		chip->pwms[i].chan_idx =3D i;
> > > +		chip->pwms[i].reg_base =3D base + i * REG_SIZE_PER_CHANN;
> > > +		rc =3D qcom_pwm_channel_read(&chip->pwms[i], REG_PERPH_SUBTYPE,
> > > +				&chip->pwms[i].subtype);
> >
> > Can a single device have channels with different sub-types?
>
> Hmm, it has the possibility. Normally, in one PMIC, all PWM modules should
> have the same sub-type of PWM modules. But since each PWM module is acces=
sed
> independantly, so we will need to check the sub-type here for each PWM
> module.

But if all channels are known to have the same subtype, you don't need
to test them all individually and a single member in qcom_pwm_chip
indicating the type would be enough.

> > > +		if (rc < 0) {
> > > +			dev_err(chip->dev, "Read PWM channel %d subtype failed, rc=3D%d\n=
",
> > > +					i, rc);
> > > +			return rc;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int qcom_pwm_probe(struct platform_device *pdev)
> > > +{
> > > +	int rc;
> > > +	struct qcom_pwm_chip *chip;
> > > +
> > > +	chip =3D devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> > > +	if (!chip)
> > > +		return -ENOMEM;
> >
> > If you parse qcom,num-channels already before allocating driver data you
> > can allocate driver and per channel data in a single chunk, making some
> > operations simpler and maybe even save some memory.
>
> In a single chunk do you mean by calling devm_zalloc() once?
> Can you let me know how to do that? The per channel data is anothe pointer
> which is different from the driver data, how can we make sure two differe=
nt
> pointers can be allocated in the same chunk of memory?

You can do the following:

	struct qcom_pwm_channel {
		...
	};

	struct qcom_pwm_chip {
		...
		struct qcom_pwm_channel channel[];
	};

	qc =3D devm_kzalloc(&pdev->dev, sizeof(*qc) + num_channels * sizeof(struct=
 qcom_pwm_channel), GFP_KERNEL);

Then the individual channels can be accessed using qc->channel[i].

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--t5k3x7s7xr2lhlm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCJgd8ACgkQwfwUeK3K
7AkX0wf/UDJc+cNHkvYyD5dGuaUi1Pt/fHTs8S8QSl89VP6aE6iMAAYiVTKLozmV
r9tFryY0ayAmD7GgstQxxOdCYNT1JVLO5BHsf5H0kjERPY6TIj72iapxHx9S5+Z/
NCiVEQ39VRhxOG2BkLMnyzpDIkWE6+QGGJJgyKMVIWOx9vEw6Sz0/ZPfJFG6UuL0
9pe7t6y+UkeB8AZek/DrHXFrRsGMzzpORyYQPM3upUdBgQB1FoSof16g46qr65tC
kR89n9m7TWoIMN3HfV77YmR4sdbVAuRGwf2WTDg69v/CK4am4X8rOmGLtx+qUBry
6SPki8A/z8WagFeScoGSNnh7X9oH7w==
=2qL4
-----END PGP SIGNATURE-----

--t5k3x7s7xr2lhlm7--
