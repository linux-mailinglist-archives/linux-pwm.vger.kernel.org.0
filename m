Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5D7456BCF
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Nov 2021 09:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhKSIq7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Nov 2021 03:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhKSIq7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Nov 2021 03:46:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE86FC061574
        for <linux-pwm@vger.kernel.org>; Fri, 19 Nov 2021 00:43:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnzUv-0006Rg-Rl; Fri, 19 Nov 2021 09:43:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnzUu-000Qv7-RB; Fri, 19 Nov 2021 09:43:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnzUt-0004nv-SX; Fri, 19 Nov 2021 09:43:51 +0100
Date:   Fri, 19 Nov 2021 09:43:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com
Subject: Re: [PATCH v10 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20211119084351.hhk4omumje45hpge@pengutronix.de>
References: <20211112185504.1921780-1-sean.anderson@seco.com>
 <20211112185504.1921780-3-sean.anderson@seco.com>
 <20211118092813.xhulsyy5l36ukngw@pengutronix.de>
 <e826e68c-d725-79ef-2140-365383eaf0e0@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jjoutxsjvw4quph7"
Content-Disposition: inline
In-Reply-To: <e826e68c-d725-79ef-2140-365383eaf0e0@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jjoutxsjvw4quph7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Thu, Nov 18, 2021 at 04:08:45PM -0500, Sean Anderson wrote:
> On 11/18/21 4:28 AM, Uwe Kleine-K=C3=B6nig wrote:
> > On Fri, Nov 12, 2021 at 01:55:04PM -0500, Sean Anderson wrote:
> > > [...]
> > > +	/* cycles has a max of 2^32 + 2 */
> > > +	return DIV64_U64_ROUND_CLOSEST(cycles * NSEC_PER_SEC,
> > > +				       clk_get_rate(priv->clk));
> >=20
> > Please round up here.
>=20
> Please document the correct rounding mode you expect. The last time we
> discussed this (3 months ago), you only said that rounding down was
> incorrect...

I think you refer to
https://lore.kernel.org/linux-pwm/20210817180407.ru4prwu344dxpynu@pengutron=
ix.de
here, right? I agree that I could have been a bit more explicit here.

=2Eapply should first round down .period to the next achievable setting
and then .duty_cycle should be round down to the next achievable setting
(in combination with the chosen period).

To get .apply =E2=88=98 .get_state idempotent (i.e. if I apply the result f=
rom
get_state there are no changes), .get_state has to round up.

After our longer discussion about v4 I would have expected that this was
already obvious. There you wrote[1]:

> * The apply_state function shall only round the requested period down, and
>    may do so by no more than one unit cycle. If the requested period is
>    unrepresentable by the PWM, the apply_state function shall return
>    -ERANGE.
> * The apply_state function shall only round the requested duty cycle
>    down. The apply_state function shall not return an error unless there
>    is no duty cycle less than the requested duty cycle which is
>    representable by the PWM.
> * After applying a state returned by round_state with apply_state,
>    get_state must return that state.

The requirement to round up is a direct consequence of these three
points, which I confirmed (apart from some wording issues).

[1] https://lore.kernel.org/linux-pwm/ddd2ad0c-1dff-c437-17a6-4c7be72c2fce@=
seco.com

> > > +	period_cycles =3D min_t(u64, state->period, ULONG_MAX * NSEC_PER_SE=
C);
> > > +	period_cycles =3D mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC=
);
> > > +	if (period_cycles < 2 || period_cycles - 2 > priv->max)
> > > +		return -ERANGE;
> >=20
> > if period_cycles - 2 > priv->max the right reaction is to do
> >=20
> > 	period_cycles =3D priv->max + 2
>=20
> It has been 5 months since we last talked about this, and yet you have
> not submitted any patches for a "pwm_round_rate" function. Forgive me if
> I am reticent to implement forward compatibility for an API which shows
> no signs of appearing.

This requirement is not only for round_state. It's also to get some
common behaviour for at least new drivers. The primary goal here is to
make the result for pwm_apply more predictable.

> > > +static int xilinx_timer_probe(struct platform_device *pdev)
> > > +{
> > > +	int ret;
> > > +	struct device *dev =3D &pdev->dev;
> > > +	struct device_node *np =3D dev->of_node;
> > > +	struct xilinx_timer_priv *priv;
> > > +	struct xilinx_pwm_device *pwm;
> >=20
> > The name "pwm" is usually reserved for struct pwm_device pointers. A
> > typical name for this would be xlnxpwm or ddata.
>=20
> I suppose. However, no variables of struct pwm_device are used in
> this driver.

Still it provokes wrong expectations when reading

	platform_set_drvdata(pdev, pwm);

in a pwm driver.

> > > +	u32 pwm_cells, one_timer, width;
> > > +	void __iomem *regs;
> > > +
> > > +	ret =3D of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> > > +	if (ret =3D=3D -EINVAL)
> > > +		return -ENODEV;
> >=20
> > A comment about why this is done would be great.
>=20
> OK. How about:
>=20
> /* If there are no #pwm-cells, this binding is for a timer and not a PWM =
*/

Fine. Does that mean the timer driver won't bind in the presence of the
#pwm-cells property, and the timer driver uses the same compatible?
Sounds a bit strange to me.

> > > +	/*
> > > +	 * The polarity of the generate outputs must be active high for PWM
> >=20
> > s/generate/generated/
>=20
> The signals I am referring to are called "GenerateOut0" and
> "GenerateOut1".

Then maybe:

	The polarity of the outputs "GenerateOut0" and "GenerateOut1"
	...

?

> > > +static struct platform_driver xilinx_timer_driver =3D {
> > > +	.probe =3D xilinx_timer_probe,
> > > +	.remove =3D xilinx_timer_remove,
> > > +	.driver =3D {
> > > +		.name =3D "xilinx-timer",
> >=20
> > Doesn't this give a wrong impression as this is a PWM driver, not a
> > timer driver?

This directly relates to the fact that the timer driver and the pwm
driver (seem to) bind on the same compatible as already mentioned above.
The dt people didn't agree to this yet, did they?

> Perhaps. Though this is the PWM driver for the Xilinx AXI timer, not the
> Xilinx AXI PWM.

I would be happier with "xilinx-timer-pwm" then.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jjoutxsjvw4quph7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGXY8MACgkQwfwUeK3K
7Ami0Qf/XojQGupME2R59XL954UP3h1Mvkt4lm0+lwyIsNWvCKgciys1iPkwTSPi
1o2DQYQInawTy/r0+6WqQ1CECPY6eTt4I00/tAqjGu+8aomH6srl6lvc5wSVVB1n
v0HNo7FHYNTUpXO0bnYw8U8eDl7o+jxzn/ufY/fUNVTQH/aMT/PvrLGROoYXLtIr
iJE6z8u/iSNbZCjfPHSJUmfuXlanllDj2wuGjbblCWBZOG1eyeEemoy0Q+yuloen
x8zBGZIfX+mLx2lqwJi2Tc+jdmYZayGBTm/jIYYZoc/R4I/iSiA41jHhYsznIJwd
+jShC+o6iF/0R0NaG8RzfNS/Yf0aYw==
=gzPZ
-----END PGP SIGNATURE-----

--jjoutxsjvw4quph7--
