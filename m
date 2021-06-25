Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F83A3B47B9
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 18:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhFYQ7N (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFYQ7H (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 12:59:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B800C061574
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 09:56:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwp8G-0008Sy-IH; Fri, 25 Jun 2021 18:56:44 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwp8E-0003Jw-Rq; Fri, 25 Jun 2021 18:56:42 +0200
Date:   Fri, 25 Jun 2021 18:56:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210625165642.5iuorl5guuq5c7gc@pengutronix.de>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <20210528214522.617435-3-sean.anderson@seco.com>
 <20210625061958.yeaxjltuq7q2t7i7@pengutronix.de>
 <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3zxyysw7boxvafm5"
Content-Disposition: inline
In-Reply-To: <a748143d-f157-562e-795d-dcd9a0cf9d85@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--3zxyysw7boxvafm5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Fri, Jun 25, 2021 at 11:13:33AM -0400, Sean Anderson wrote:
> On 6/25/21 2:19 AM, Uwe Kleine-K=F6nig wrote:
> > On Fri, May 28, 2021 at 05:45:22PM -0400, Sean Anderson wrote:
> >> + * Hardware limitations:

Please make this "* Limitations:" to match what the other drivers do and
so ease grepping for this info.

> >> + * - When changing both duty cycle and period, we may end up with one=
 cycle
> >> + *   with the old duty cycle and the new period.
> >
> > That means it doesn't reset the counter when a new period is set, right?
>=20
> Correct. The only way to write to the counter is to stop the timer and
> restart it.

ok.

> >> + * - Cannot produce 100% duty cycle.
> >
> > Can it produce a 0% duty cycle? Below you're calling
> > xilinx_timer_tlr_period(..., ..., ..., 0) then which returns -ERANGE.
>=20
> Yes. This is what you get when you try to specify 100% duty cycle (e.g.
> TLR0 =3D=3D TLR1).

OK, so the hardware can do it, but your driver doesn't make use of it,
right?

> >> + * - Only produces "normal" output.
> >
> > Does the output emit a low level when it's disabled?
>=20
> I believe so.

Is there a possibility to be sure? I'd like to know that to complete my
picture about the behaviour of the supported PWMs.

> >> + */
> >> +
> >> [...]
> >> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*unused,
> >> +			    const struct pwm_state *state)
> >> +{
> >> +	int ret;
> >> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> >> +	u32 tlr0, tlr1;
> >> +	u32 tcsr0 =3D xilinx_timer_read(priv, TCSR0);
> >> +	u32 tcsr1 =3D xilinx_timer_read(priv, TCSR1);
> >> +	bool enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> >> +
> >> +	if (state->polarity !=3D PWM_POLARITY_NORMAL)
> >> +		return -EINVAL;
> >> +
> >> +	ret =3D xilinx_timer_tlr_period(priv, &tlr0, tcsr0, state->period);
> >> +	if (ret)
> >> +		return ret;
> >
> > The implementation of xilinx_timer_tlr_period (in patch 2/3) returns
> > -ERANGE for big periods. The good behaviour to implement is to cap to
> > the biggest period possible in this case.
>=20
> Ok. Is this documented anywhere?

I tried but Thierry didn't like the result and I didn't retry. The
problem is also that many drivers we already have in the tree don't
behave like this (because for a long time nobody cared). That new
drivers should behave this way is my effort to get some consistent
behaviour.

> And wouldn't this result in the wrong duty cycle? E.g. say the max
> value is 100 and I try to apply a period of 150 and a duty_cycle of 75
> (for a 50% duty cycle). If we cap at 100, then I will instead have a
> 75% duty cycle, and there will be no error.

Yes that is right. That there is no feedback is a problem that we have
for a long time. I have a prototype patch that implements a
pwm_round_state() function that lets a consumer know the result of
applying a certain pwm_state in advance. But we're not there yet.

> So I will silently get the wrong duty cycle, even when that duty cycle
> is probably more important than the period.

It depends on the use case and every policy is wrong for some cases. So
I picked the policy I already explained because it is a) easy to
implement for lowlevel drivers and b) it's easy to work with for
consumers once we have pwm_round_state().

> > Also note that state->period is an u64 but it is casted to unsigned int
> > as this is the type of the forth parameter of xilinx_timer_tlr_period.
>=20
> Hm, it looks like I immediately cast period to a u64. I will change the
> signature for this function next revision.

Then note that period * clk_get_rate(priv->clk) might overflow.
=20
> >> +	ret =3D xilinx_timer_tlr_period(priv, &tlr1, tcsr1, state->duty_cycl=
e);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	xilinx_timer_write(priv, tlr0, TLR0);
> >> +	xilinx_timer_write(priv, tlr1, TLR1);
> >> +
> >> +	if (state->enabled) {
> >> +		/* Only touch the TCSRs if we aren't already running */
> >> +		if (!enabled) {
> >> +			/* Load TLR into TCR */
> >> +			xilinx_timer_write(priv, tcsr0 | TCSR_LOAD, TCSR0);
> >> +			xilinx_timer_write(priv, tcsr1 | TCSR_LOAD, TCSR1);
> >> +			/* Enable timers all at once with ENALL */
> >> +			tcsr0 =3D (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
> >> +			tcsr1 =3D TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
> >> +			xilinx_timer_write(priv, tcsr0, TCSR0);
> >> +			xilinx_timer_write(priv, tcsr1, TCSR1);
> >> +		}
> >> +	} else {
> >> +		xilinx_timer_write(priv, 0, TCSR0);
> >> +		xilinx_timer_write(priv, 0, TCSR1);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
> >> +				 struct pwm_device *unused,
> >> +				 struct pwm_state *state)
> >> +{
> >> +	struct xilinx_timer_priv *priv =3D xilinx_pwm_chip_to_priv(chip);
> >> +	u32 tlr0 =3D xilinx_timer_read(priv, TLR0);
> >> +	u32 tlr1 =3D xilinx_timer_read(priv, TLR1);
> >> +	u32 tcsr0 =3D xilinx_timer_read(priv, TCSR0);
> >> +	u32 tcsr1 =3D xilinx_timer_read(priv, TCSR1);
> >> +
> >> +	state->period =3D xilinx_timer_get_period(priv, tlr0, tcsr0);
> >> +	state->duty_cycle =3D xilinx_timer_get_period(priv, tlr1, tcsr1);
> >> +	state->enabled =3D xilinx_timer_pwm_enabled(tcsr0, tcsr1);
> >> +	state->polarity =3D PWM_POLARITY_NORMAL;
> >
> > Are the values returned here sensible if the hardware isn't in PWM mode?
>=20
> Yes. If the hardware isn't in PWM mode, then state->enabled will be
> false.

Ah right. Good enough.

> >> +	else if (pwm_cells)
> >> +		return dev_err_probe(dev, -EINVAL, "#pwm-cells must be 0\n");
> >
> > What is the rationale here to not support #pwm-cells =3D <2>?
>=20
> Only one PWM is supported. But otherwise there is no particular
> reason.

The usual binding is to have 3 additional parameters.
 1) chip-local pwm number (which can only be 0 for a pwmchip having
    .npwm =3D 1)
 2) the "typical" period
 3) some flags (like PWM_POLARITY_*)

I don't care much if you implement it with or without 1), but 2) and 3)
should IMHO be here. If you don't want 1),
http://patchwork.ozlabs.org/project/linux-pwm/patch/20210622030948.966748-1=
-bjorn.andersson@linaro.org/
might be interesting for you. (But note, Thierry didn't give feedback to
this yet, it might be possible he wants 1)-3) for new drivers.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3zxyysw7boxvafm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDWCscACgkQwfwUeK3K
7AkDIQf/TV7EB3dZy+PUjYdTIhuIgqUzB/j6cxlnHCfHMehLbF3hPzo4ONQSKMqo
lQaZUgbbEu1WIXOz3CgrpiL8GA9z6+d+xFWQynPJrkfwhBMYWA/MKTr/iPJ1lvvG
W3Lb0V3Wtz461AEhYF9KRiqyKFHbfxuEKSoudxOaTac5RTQvxxoy0cW0XpnnbYLk
8UqFXTjFVdCCcqLDfoB9mjiD6hkhu15saaAK5ykOH2R82fG2+NTRv3aYEkfuAg2y
wwsdYYvPhTZaT5gISXAYvbe3Df9ufnxuCh4CReVI3txtYUfLquMw/o3TAkwtQPS5
B+iukDSUGDOFKwYfDbEug70vYXlBgg==
=weBO
-----END PGP SIGNATURE-----

--3zxyysw7boxvafm5--
