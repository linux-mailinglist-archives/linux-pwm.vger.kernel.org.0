Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADD0371180
	for <lists+linux-pwm@lfdr.de>; Mon,  3 May 2021 08:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhECGMG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 May 2021 02:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhECGMG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 May 2021 02:12:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A5C06174A
        for <linux-pwm@vger.kernel.org>; Sun,  2 May 2021 23:11:13 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldRnM-0005hJ-Cw; Mon, 03 May 2021 08:11:04 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldRnI-0004Ec-38; Mon, 03 May 2021 08:11:00 +0200
Date:   Mon, 3 May 2021 08:10:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v2 2/2] pwm: Add Aspeed ast2600 PWM support
Message-ID: <20210503061059.xrcpuyouga4z5nno@pengutronix.de>
References: <20210414104939.1093-1-billy_tsai@aspeedtech.com>
 <20210414104939.1093-3-billy_tsai@aspeedtech.com>
 <20210426204333.gzqke6td33dtugnh@pengutronix.de>
 <A89B45FD-FD3D-43F2-A850-8A7FBB1AF165@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5iy7kxz67qvpu36y"
Content-Disposition: inline
In-Reply-To: <A89B45FD-FD3D-43F2-A850-8A7FBB1AF165@aspeedtech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5iy7kxz67qvpu36y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, May 03, 2021 at 04:42:59AM +0000, Billy Tsai wrote:
> On 2021/4/27, 4:44 AM,Uwe Kleine-K=F6nigwrote:
>     >> +/* PWM fixed value */
>     >> +#define PWM_FIXED_PERIOD 0xff
>     >> +
>     >> +struct aspeed_pwm_data {
>     >> +	struct pwm_chip chip;
>     >> +	struct clk *clk;
>     >> +	struct regmap *regmap;
>     >> +	struct reset_control *reset;
>     >> +};
>     >> +
>     >> +static void aspeed_set_pwm_channel_enable(struct regmap *regmap, =
u8 pwm_channel,
>     >> +					  bool enable)
>     >> +{
>     >> +	regmap_update_bits(regmap, PWM_ASPEED_CTRL_CH(pwm_channel),
>     >> +			   (PWM_CLK_ENABLE | PWM_PIN_ENABLE),
>     >> +			   enable ? (PWM_CLK_ENABLE | PWM_PIN_ENABLE) : 0);
>=20
>     > What is the semantic difference between CLK_ENABLE and PIN_ENABLE? =
Does
>     > the pin stay at it's inactive level if PIN_ENABLE is unset? Does the
>     > output just freeze at it's current level if CLK_ENABLE is unset?
>=20
> Yes.=20
> When PIN_ENABLE is unset the pwm controller will always output low to the=
 extern.
> When CLK_ENABLE is unset the pwm controller will freeze at it's current l=
evel.

These two are relevant to mention at the top of the driver.

>     > The intended goal is to provide the biggest possible period not big=
ger
>     > than the requested value.
>    =20
> So, did you mean that if the request period is 100ns and our divide can r=
each 100.1ns or 95ns
> the user prefer 95ns to 100.1ns?

Yes. It's unclear if the user really prefers 95ns, but to get a
consistent behaviour among the different drivers, that's what I ask you
to implement.

Currently there is no way that allows a consumer to specify which
setting they prefer, I have an idea for a fix though. For that it is
also important that .apply() doesn't yield 100.1 ns.

>     >> +	dev_dbg(dev, "freq: %d, duty_pt: %d", freq, duty_pt);
>     >> +	if (state->enabled) {
>     >> +		aspeed_set_pwm_freq(priv, pwm, freq);
>     >> +		aspeed_set_pwm_duty(priv, pwm, duty_pt);
>     >> +		aspeed_set_pwm_polarity(priv, pwm, state->polarity);
>=20
>     > How does the hardware behave in between these calls? If for example=
 the
>     > polarity is changed, does this affect the output immediately? Does =
this
>     > start a new period?
>=20
> The pwm output will inverse immediately. The period will not change.

Please mention that at the top of the driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5iy7kxz67qvpu36y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCPk/EACgkQwfwUeK3K
7Anp8Af/Z+uYW/3/GCvR2oftIQAZuwphFiTi35Xsodu+DFT3+XSHD43eTtMlcicY
hImlVwznE+vf/Jvv8L6uIhxf9AZqPGs37mxCgPKi6bNrYd7KVBLnT1PFepDNVec+
RbI3RX16fdsXIuv1UMubsbG98NrlUDEmCNxXwDx6oHbobk7FBnvw/5Mg0xiDT1ci
XnSkgFe2HhKYGwfmAEIREQr2JsaNiOwBDFqOZhiVxUKyAn6cPB0+UUIm0ZCXblCR
SWtzhJ6LC26jdoqUWtL+h3+LhsxKJkGW6YMoFI1Vj2pO75woHGq+DAKB5KuPwwQ4
tqP5L4yGmD/CIZEHg9o3L5cgMm9AXw==
=XsrH
-----END PGP SIGNATURE-----

--5iy7kxz67qvpu36y--
