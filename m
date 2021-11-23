Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4ABB459E69
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Nov 2021 09:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhKWIpI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Nov 2021 03:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbhKWIpH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Nov 2021 03:45:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF6EC061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 00:41:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpRNE-0007nU-7A; Tue, 23 Nov 2021 09:41:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpRND-000aYR-JV; Tue, 23 Nov 2021 09:41:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpRNC-0001lM-6K; Tue, 23 Nov 2021 09:41:54 +0100
Date:   Tue, 23 Nov 2021 09:41:51 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com
Subject: Re: [PATCH v10 3/3] pwm: Add support for Xilinx AXI Timer
Message-ID: <20211123084151.dtfwhm2s23k7dli5@pengutronix.de>
References: <20211112185504.1921780-1-sean.anderson@seco.com>
 <20211112185504.1921780-3-sean.anderson@seco.com>
 <20211118092813.xhulsyy5l36ukngw@pengutronix.de>
 <e826e68c-d725-79ef-2140-365383eaf0e0@seco.com>
 <20211119084351.hhk4omumje45hpge@pengutronix.de>
 <94175b6c-bda0-08ce-85be-0164eabcb477@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ymboqdqlsdll7jnh"
Content-Disposition: inline
In-Reply-To: <94175b6c-bda0-08ce-85be-0164eabcb477@seco.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ymboqdqlsdll7jnh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

On Mon, Nov 22, 2021 at 12:32:19PM -0500, Sean Anderson wrote:
> On 11/19/21 3:43 AM, Uwe Kleine-K=C3=B6nig wrote:
> > On Thu, Nov 18, 2021 at 04:08:45PM -0500, Sean Anderson wrote:
> > > On 11/18/21 4:28 AM, Uwe Kleine-K=C3=B6nig wrote:
> > > > On Fri, Nov 12, 2021 at 01:55:04PM -0500, Sean Anderson wrote:
> > > > > [...]
> > > > > +	/* cycles has a max of 2^32 + 2 */
> > > > > +	return DIV64_U64_ROUND_CLOSEST(cycles * NSEC_PER_SEC,
> > > > > +				       clk_get_rate(priv->clk));
> > > >
> > > > Please round up here.
> > >=20
> > > Please document the correct rounding mode you expect. The last time we
> > > discussed this (3 months ago), you only said that rounding down was
> > > incorrect...
> >=20
> > I think you refer to
> > https://lore.kernel.org/linux-pwm/20210817180407.ru4prwu344dxpynu@pengu=
tronix.de
> > here, right? I agree that I could have been a bit more explicit here.
> >=20
> > .apply should first round down .period to the next achievable setting
> > and then .duty_cycle should be round down to the next achievable setting
> > (in combination with the chosen period).
> >=20
> > To get .apply =E2=88=98 .get_state idempotent (i.e. if I apply the resu=
lt from
> > get_state there are no changes), .get_state has to round up.
> >=20
> > After our longer discussion about v4 I would have expected that this was
> > already obvious. There you wrote[1]:
> >=20
> > > * The apply_state function shall only round the requested period down=
, and
> > >    may do so by no more than one unit cycle. If the requested period =
is
> > >    unrepresentable by the PWM, the apply_state function shall return
> > >    -ERANGE.
> > > * The apply_state function shall only round the requested duty cycle
> > >    down. The apply_state function shall not return an error unless th=
ere
> > >    is no duty cycle less than the requested duty cycle which is
> > >    representable by the PWM.
> > > * After applying a state returned by round_state with apply_state,
> > >    get_state must return that state.
> >=20
> > The requirement to round up is a direct consequence of these three
> > points, which I confirmed (apart from some wording issues).
> >=20
> > [1] https://lore.kernel.org/linux-pwm/ddd2ad0c-1dff-c437-17a6-4c7be72c2=
fce@seco.com
>=20
> Ok, will fix. But again, a little something in
> Documentation/driver-api/pwm.rst would help a lot.

Ack, will take another attempt to care for that.

> > > > > +	period_cycles =3D min_t(u64, state->period, ULONG_MAX * NSEC_PE=
R_SEC);
> > > > > +	period_cycles =3D mul_u64_u32_div(period_cycles, rate, NSEC_PER=
_SEC);
> > > > > +	if (period_cycles < 2 || period_cycles - 2 > priv->max)
> > > > > +		return -ERANGE;
> > > >
> > > > if period_cycles - 2 > priv->max the right reaction is to do
> > > >
> > > > 	period_cycles =3D priv->max + 2
> > >=20
> > > It has been 5 months since we last talked about this, and yet you have
> > > not submitted any patches for a "pwm_round_rate" function. Forgive me=
 if
> > > I am reticent to implement forward compatibility for an API which sho=
ws
> > > no signs of appearing.
> >=20
> > This requirement is not only for round_state. It's also to get some
> > common behaviour for at least new drivers. The primary goal here is to
> > make the result for pwm_apply more predictable.
>=20
> The behavior you specify is *not* common. No drivers currently round in
> the manner you specify here.

Hmm, if this is true I failed during the reviews before.

Looking through the last added drivers:

 - visconti: There is no division involved, so there is no rounding
   issue. Also period is round down if a too high value is requested.
 - ntxec: There is no get_state callback because the hardware state
   cannot be read out. Period is reduced as requested.
 - raspberrypi-poe: Rounds up in .get_state() and down in .apply(). (A
   bit special as this HW has a fixed period.)
 - intel-lgm: Rounds up in .get_state() and down in .apply(). Ditto this
   is a fixed-period driver and only too small periods are refused.
 - dwc: This is indeed wrong. I didn't review the finally merged
   version, but pointed out the driver being wrong in v2
   (https://lore.kernel.org/linux-pwm/20200524201116.pc7jmffr6jxlwren@pengu=
tronix.de)
 - keembay: Rounds up in .get_state and dowan in .apply()
   (Though the detection of a too high period might be broken?! Didn't
   look into the details.)
 - pwm-sl28cpld is aligned to this behaviour (though this is a bit of a
   special case as there is no rounding involved). Refusing too big
   periods (only) is done right in it.
 - iqs620a: Is aligned to my request, too
 - pwm-sprd: This is wrong, too. My review comments were not addressed
   here either (e.g.
   https://lore.kernel.org/linux-pwm/20190814150304.x44lalde3cwp67ge@pengut=
ronix.de)

So while the situation isn't ideal, it's not as worse as you picture it.

> In fact, returning -ERANGE or -EINVAL is
> far more common than attempting to handle this case. If you would like
> new drivers to use a new algorithm, I suggest first converting existing
> drivers. I think it is unreasonable to hold new drivers to a standard
> which no existing driver is held to.

In the past Thierry opposed to adapting existing drivers. :-\
Having said that being more strict for new drivers isn't that uncommon.
For example I expect it wouldn't be possible to get something like
drivers/tty/serial/8250 into mainline today.

> > > > > +static int xilinx_timer_probe(struct platform_device *pdev)
> > > > > +{
> > > > > +	int ret;
> > > > > +	struct device *dev =3D &pdev->dev;
> > > > > +	struct device_node *np =3D dev->of_node;
> > > > > +	struct xilinx_timer_priv *priv;
> > > > > +	struct xilinx_pwm_device *pwm;
> > > >
> > > > The name "pwm" is usually reserved for struct pwm_device pointers. A
> > > > typical name for this would be xlnxpwm or ddata.
> > >=20
> > > I suppose. However, no variables of struct pwm_device are used in
> > > this driver.
> >=20
> > Still it provokes wrong expectations when reading
> >=20
> > 	platform_set_drvdata(pdev, pwm);
> >=20
> > in a pwm driver.
>=20
> The second most common use of this function in drivers/pwm is the above u=
sage.
>=20
> $ git grep -h platform_set_drvdata v5.15 drivers/pwm/ | sort | uniq -c | =
sort -n
>       1 	platform_set_drvdata(pdev, atmel_pwm);
>       1 	platform_set_drvdata(pdev, bpc);
>       1 	platform_set_drvdata(pdev, ddata);
>       1 	platform_set_drvdata(pdev, ec_pwm);
>       1 	platform_set_drvdata(pdev, fpc);
>       1 	platform_set_drvdata(pdev, ip);
>       1 	platform_set_drvdata(pdev, lpc18xx_pwm);
>       1 	platform_set_drvdata(pdev, lpwm);
>       1 	platform_set_drvdata(pdev, mdp);
>       1 	platform_set_drvdata(pdev, omap);
>       1 	platform_set_drvdata(pdev, p);
>       1 	platform_set_drvdata(pdev, pwm_chip);
>       1 	platform_set_drvdata(pdev, rcar_pwm);
>       1 	platform_set_drvdata(pdev, spc);
>       1 	platform_set_drvdata(pdev, tcbpwm);
>       1 	platform_set_drvdata(pdev, tpm);
>       1 	platform_set_drvdata(pdev, tpu);
>       3 	platform_set_drvdata(pdev, chip);
>       3 	platform_set_drvdata(pdev, priv);
>       4 	platform_set_drvdata(pdev, pwm);
>       6 	platform_set_drvdata(pdev, pc);

Ack, this are all "old" drivers (i.e. img (2015), stmpe (2016), sun4i
(2015) and tegra(2012); "old" in the sense "before I engaged in pwm
reviews") ISTR that in this question Thierry agrees that only variables
with type struct pwm_chip * should be named pwm.

> With other contenders being "pc", "chip", "pwm_chip", and "p". This used
> to be more common, but several examples have been converted to
> devm_pwmchip_add. To say that such a variable (used once!) "provokes the
> wrong expectations" would be to have expectations misaligned with the
> corpus of existing drivers.

Yeah, I don't oppose to this interpretation. I'm not happy with the code
base. Reworking this is a big effort and difficult with the request to
not break assumption for existing drivers.

> > > > > +	u32 pwm_cells, one_timer, width;
> > > > > +	void __iomem *regs;
> > > > > +
> > > > > +	ret =3D of_property_read_u32(np, "#pwm-cells", &pwm_cells);
> > > > > +	if (ret =3D=3D -EINVAL)
> > > > > +		return -ENODEV;
> > > >
> > > > A comment about why this is done would be great.
> > >=20
> > > OK. How about:
> > >=20
> > > /* If there are no #pwm-cells, this binding is for a timer and not a =
PWM */
> >=20
> > Fine. Does that mean the timer driver won't bind in the presence of the
> > #pwm-cells property, and the timer driver uses the same compatible?
> > Sounds a bit strange to me.
>=20
> Correct. See below.
>=20
> > > > > +	/*
> > > > > +	 * The polarity of the generate outputs must be active high for=
 PWM
> > > >
> > > > s/generate/generated/
> > >=20
> > > The signals I am referring to are called "GenerateOut0" and
> > > "GenerateOut1".
> >=20
> > Then maybe:
> >=20
> > 	The polarity of the outputs "GenerateOut0" and "GenerateOut1"
> > 	...
> >=20
> > ?
>=20
> The exact wording of the configuration option is
>=20
> > Active state of Generate Out signal
>=20
> with a drop-down to select between "Active High" and "Active Low". So
> the most exact way to specify this would be
>=20
> 	The polarity of the Generate Out signals must be...
>=20
> > > > > +static struct platform_driver xilinx_timer_driver =3D {
> > > > > +	.probe =3D xilinx_timer_probe,
> > > > > +	.remove =3D xilinx_timer_remove,
> > > > > +	.driver =3D {
> > > > > +		.name =3D "xilinx-timer",
> > > >
> > > > Doesn't this give a wrong impression as this is a PWM driver, not a
> > > > timer driver?
> >=20
> > This directly relates to the fact that the timer driver and the pwm
> > driver (seem to) bind on the same compatible as already mentioned above.
> > The dt people didn't agree to this yet, did they?
>=20
> Rob Herring has acked the binding. And switching based on the presence
> of #pwm-cells was his idea in the first place:
>=20
> > If a PWM, perhaps you want a '#pwm-cells' property which can serve as
> > the hint to configure as a PWM.
>=20
> As I understand it, the compatible should be the same if the hardware is
> the same. Ideally, this sort of thing would be configurable by userspace
> at runtime, but timers get probed so early that we have to use something
> in the devicetree.
>=20
> [1] https://lore.kernel.org/linux-pwm/20210513021631.GA878860@robh.at.ker=
nel.org/

OK, then my expectation that Rob won't agree was wrong. Fine then.

> > > Perhaps. Though this is the PWM driver for the Xilinx AXI timer, not =
the
> > > Xilinx AXI PWM.
> >=20
> > I would be happier with "xilinx-timer-pwm" then.
>=20
> I've changed it to "xilinx_pwm".

OK.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ymboqdqlsdll7jnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGcqUwACgkQwfwUeK3K
7AkMewf7BJxQCRRb9gCnnkx3PfydHkFRGihjk7DIx/ugO6LW41ZwvbycrR2AyGFw
/jCfyCzszaHi363z+7b9JK/BROYxwmJxjTxlAolzGbfX3DglrN9PUZ86qaq351cp
34oWUTiD8f/ZIAfys3cC8OZlsjqXyYfmJuGLCYDAV631A9HmLQEr9fYzb0Sn7Pxd
OBPitf7YVPo1Vokx0Z5RjGPXn+nhza+XSG+oDylH5VbW+UXodX8H6W8Y0wZLnyii
an3IXwLu0NoR+bIpXlmTiXOZUIFEFdyP/oJ6o/1d2ZVWK0+kS+iEdr3uVKGqBjH/
SL6vIaCuMX+FX65jgfjRNr64Mk+Kww==
=4vds
-----END PGP SIGNATURE-----

--ymboqdqlsdll7jnh--
