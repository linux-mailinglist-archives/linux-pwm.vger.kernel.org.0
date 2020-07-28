Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BE22306DA
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 11:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgG1Jr1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 05:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1Jr0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 05:47:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5B7C061794
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 02:47:26 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0MCf-0006Wm-VV; Tue, 28 Jul 2020 11:47:21 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k0MCe-00025Z-98; Tue, 28 Jul 2020 11:47:20 +0200
Date:   Tue, 28 Jul 2020 11:47:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200728094720.x6pucwxsfwvz6nvv@pengutronix.de>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-7-michael@walle.cc>
 <20200728074352.ckyfso5zwsfgupjx@pengutronix.de>
 <58b53cacc5289f17f669159beeeada03@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="htulbp2bdc2ny5pv"
Content-Disposition: inline
In-Reply-To: <58b53cacc5289f17f669159beeeada03@walle.cc>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--htulbp2bdc2ny5pv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo,

On Tue, Jul 28, 2020 at 10:21:22AM +0200, Michael Walle wrote:
> Am 2020-07-28 09:43, schrieb Uwe Kleine-K=F6nig:
> > On Sun, Jul 26, 2020 at 01:18:27AM +0200, Michael Walle wrote:
> > > +static int sl28cpld_pwm_probe(struct platform_device *pdev)
> > > +{
> > > +	struct sl28cpld_pwm *priv;
> > > +	struct pwm_chip *chip;
> > > +	int ret;
> > > +
> > > +	if (!pdev->dev.parent)
> > > +		return -ENODEV;
> > > +
> > > +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	priv->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > > +	if (!priv->regmap)
> >=20
> > Error message here?
>=20
> This shouldn't really happen and I put it into the same category
> as the two above and report no error. But I can add it.

For kzalloc it is right to not emit an error because a failing kzalloc
is already loud on its own. I missed the first error path, that should
get a message, too.

> Generally, it looked to me that more and more drivers don't
> really report errors anymore, but just return with an -EWHATEVER.
> So if someone can shed some light here, I'm all ears.

IMHO it's wrong not to add error messages. At one point in time it will
fail and then you're happy if you don't have to add printks all over the
place first to debug that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--htulbp2bdc2ny5pv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8f9CUACgkQwfwUeK3K
7AlkpAf9GX/MdqMREp3J4dX8H7TLp3wVx7/FOTFnrRDTkszIftG16IG7J9g1qiyY
lN54gRXDEtuTo7PfeKcJ09lh/jT2xRPE/Y6kHSW6BQKNw2C0S74Pv2UMc1aYWsvZ
GlE/2BL1tB7F7+OLVIFRhL5N5O0QKaBO5bxaC/DKd4ZAnvbLPloAcysP0kHzqvXP
H72qdOstHSP5znm4z6+Vcb7xiI9XiT9GWgnumpwo1f6s58SEGsbQUiLRLXIkRURN
LKzxXtqSMbW1n+U34jSgI6BI+wyDAGQz0iJ0WxKV6DUa5IO7IqucION92J9s7w32
ntP5cEULmXHKeTvOGXgM59juqdxEtg==
=KNkY
-----END PGP SIGNATURE-----

--htulbp2bdc2ny5pv--
