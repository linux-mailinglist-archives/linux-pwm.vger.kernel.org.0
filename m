Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F6828C3AD
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Oct 2020 23:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgJLVBT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Oct 2020 17:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbgJLVBS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 12 Oct 2020 17:01:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F220C0613D0
        for <linux-pwm@vger.kernel.org>; Mon, 12 Oct 2020 14:01:18 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kS4wT-0002yn-F6; Mon, 12 Oct 2020 23:01:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kS4wS-0001ed-EQ; Mon, 12 Oct 2020 23:01:12 +0200
Date:   Mon, 12 Oct 2020 23:01:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: Re: [PATCH v10 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201012210112.tdca3so6dzplootw@pengutronix.de>
References: <cover.1602090900.git.vijayakannan.ayyathurai@intel.com>
 <a8cb129092283cb6415e56b928293ef7121a851b.1602090900.git.vijayakannan.ayyathurai@intel.com>
 <20201007205734.vguookvp6wt3knuq@pengutronix.de>
 <DM6PR11MB42507C555C3F183ED6EB98ADFB070@DM6PR11MB4250.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m7qxjxu7pzwt6i3g"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB42507C555C3F183ED6EB98ADFB070@DM6PR11MB4250.namprd11.prod.outlook.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--m7qxjxu7pzwt6i3g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Ayyathurai,

you're quoting style is strange. I fixed it up and hope I got it right.

On Mon, Oct 12, 2020 at 08:04:47PM +0000, Ayyathurai, Vijayakannan wrote:
> > On Thu, Oct 08, 2020 at 01:40:30AM +0800, vijayakannan.ayyathurai@intel=
=2Ecom wrote:
> > > +static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_devic=
e *pwm,
> > > +			     const struct pwm_state *state) {
> > > +	struct keembay_pwm *priv =3D to_keembay_pwm_dev(chip);
> > > +	struct pwm_state current_state;
> > > +	u16 pwm_h_count, pwm_l_count;
> > > +	unsigned long long div;
> > > +	unsigned long clk_rate;
> > > +	u32 pwm_count =3D 0;
> > > +
> > > +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> > > +		return -ENOSYS;
> > > +
> > > +	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> > > +				KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
> > > +
> > > +	keembay_pwm_get_state(chip, pwm, &current_state);
> > > +
> > > +	if (!state->enabled) {
> > > +		if (current_state.enabled)
> > > +			keembay_pwm_disable(priv, pwm->hwpwm);
> > > +		return 0;
> > > +	}
> > > +
> > > +	/*
> > > +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register contain
> > > +	 * the high time of the waveform, while the last 16 bits contain
> > > +	 * the low time of the waveform, in terms of clock cycles.
> > > +	 *
> > > +	 * high time =3D clock rate * duty cycle
> > > +	 * low time =3D  clock rate * (period - duty cycle)
> > > +	 */
> > > +
> > > +	clk_rate =3D clk_get_rate(priv->clk);
> > > +	/* Configure waveform high time */
> > > +	div =3D clk_rate * state->duty_cycle;
> > > +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC);
> > > +	if (div > KMB_PWM_COUNT_MAX)
> > > +		return -ERANGE;
> > > +
> > > +	pwm_h_count =3D div;
> > > +	/* Configure waveform low time */
> > > +	div =3D clk_rate * (state->period - state->duty_cycle);
> > > +	div =3D DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC - pwm_h_count);
> >=20
> > In reply to your v7 I suggested the example:
> >=20
> > 	clk_rate =3D 333334 [Hz]
> > 	state.duty_cycle =3D 1000500 [ns]
> > 	state.period =3D 2001000 [ns]
> >=20
> > where the expected outcome is
> >=20
> > 	pwm_h_count =3D 333
> > 	pwm_l_count =3D 334
> >=20
> > . Please reread my feedback there. I tried to construct an example
> > where the value is more wrong, but with the constraint that
> > pwm_h_count must be <=3D KMB_PWM_COUNT_MAX this isn't easy. The best I
> > could come up with is:
> >=20
> > 	clk_rate =3D 1000000000
> > 	state.duty_cycle =3D 65535 [ns]
> > 	state.period =3D 131070 [ns]
> >=20
> > where the right value for pwm_l_count is 65535 while you calculate
> > 65539 (and then quit with -ERANGE).
>
> I have applied the formula mentioned in v7 and got different duty
> cycle result then what was expected.=20
>=20
> Formula referred by Uwe at v7:
> pwm_l_count =3D (clk_rate * state->period) / NSEC_PER_SEC - pwm_h_count
>=20
> %     clk_rate        period          duty_cycle      NSEC_PER_SEC    pwm=
_h_count             pwm_l_count
> 50%   333334          2001000         1000500         1000000000      333=
                     667
> 25%   500000000       20000           5000            1000000000      250=
0                    10000
> 50%   100000000       131070          65535           1000000000      655=
3                    13107

For the first line:

        (clk_rate * state->period) // NSEC_PER_SEC - pwm_h_count =3D
        (333334 * 2001000) // 1000000000 - 333 =3D
        667.001334 - 333 =3D
        334

This gives duty cycle =3D 333 * 1000000000 / 333334 =3D 998998.0020039959 ns
and a period =3D (333 + 334) * 1000000000 / 333334 =3D 2000995.998008004 ns
which is well in the limits.

I guess you assumed my formula to be
(clk_rate * state->period) / (NSEC_PER_SEC - pwm_h_count), but that's
not what I meant.

> Whereas the below table is the result of minor modification from your for=
mula and getting the right result.
> pwm_l_count =3D clk_rate * (state->period - state->duty_cycle) / NSEC_PER=
_SEC - pwm_h_count
>=20
> %     clk_rate        period          duty_cycle      NSEC_PER_SEC    pwm=
_h_count             pwm_l_count
> 50%   333334          2001000         1000500         1000000000      333=
                     333
> 25%   500000000       20000           5000            1000000000      250=
0                    7500
> 50%   100000000       131070          65535           1000000000      655=
3                    6553
>=20
> Please review this and confirm.

In the code you used

        clk_rate * (state->period - state->duty_cycle) / (NSEC_PER_SEC - pw=
m_h_count)

which is notably different. For the example in the first line again you
then get 333, which is a less optimal result than 334 I get with my
(fixed) formula. I'm still convinced my formula is the right and optimal
one.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m7qxjxu7pzwt6i3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+ExBQACgkQwfwUeK3K
7AmYjQf+NbKYGiIF5C248lUUAQnRzDMOkhK+R7iq754qNaSiDP0GKZO9dR8ItCPW
+B8/GAWlGguVaQ/+4vbcVPlxzHYJu5jG3GuOrz1N1skWG8yLpex2ob7qYmJiBjqM
T/iW7A3nTumvhi1LZllHSRKRhc/Np9XacvuoEUv07pisyA+7HLhZhXEN4lUbJQ2Z
iG+Pkew0tyZkCSPPi3wZLj+nAy+xiW/v+ic6Eb+vgyTE57LJmbHLilSgRBM5GeDq
GtReF4/bUNDGpDzI4HMEQOiP2NNOzwx12Fi9VWmRXJ9SgQOX/iRLPIwCftMKSk4Z
yM9Yjx2yLjL10dBMz/oovbvUJVrWAQ==
=2F7J
-----END PGP SIGNATURE-----

--m7qxjxu7pzwt6i3g--
