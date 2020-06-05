Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C711EF5B2
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 12:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgFEKu3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 06:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFEKu3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 5 Jun 2020 06:50:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A76F020772;
        Fri,  5 Jun 2020 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591354228;
        bh=ZkmdIlShUAFHW0pi3QVcOWNFuQmL8jmheacHFvaENQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLcE760t5aG1mrGcTjrY4oXPhQP87W9f9FHSm2jzdENswX23N78yJytXBV9GNzkbR
         HeuVUKObU3X3hnvgtT8mG7IFX03o5feVM1EquN4xEo/fghn9zFIRczyA+hbjD+dXba
         9nY+/TtMcuy1enmXJQ+j+FTTmmFZ/Qpp2ep9hZCM=
Date:   Fri, 5 Jun 2020 11:50:26 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200605105026.GC5413@sirena.org.uk>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <20200605065709.GD3714@dell>
X-Cookie: Air is water with holes in it.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 07:57:09AM +0100, Lee Jones wrote:
> On Thu, 04 Jun 2020, Michael Walle wrote:

> > +	sl28cpld->regmap = devm_regmap_init_i2c(i2c, &sl28cpld_regmap_config);
> > +	if (IS_ERR(sl28cpld->regmap))
> > +		return PTR_ERR(sl28cpld->regmap);

> This is now a shared memory allocator and not an MFD at all.

> I'm clamping down on these type of drivers!

> Please find a better way to accomplish this.

What is the concern with this?  Looking at the patch I'm guessing the
concern would be that the driver isn't instantiating any MFD children
and instead requiring them to be put in the DT?

> Potentially using "simple-mfd" and "simple-regmap".

> The former already exists and does what you want.  The latter doesn't
> yet exist, but could solve your and lots of other contributor's
> issues.

I have no idea what you are thinking of when you say "simple-regmap" so
it is difficult to comment.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7aI3EACgkQJNaLcl1U
h9A7hQf8CDFQ5iLpXTLY4zeynMxyWKwNzkV4jtp9HDi0METL6K488ki/EvosVeJx
URGVB1pt6HfuZ+wo9eI4viS324oVbqB+OLEP2C2JT9IueDFeFAVv/ZID0FjrKlB8
3L1IaFXplUYVhcSJGxL+9p6BB2RpY2jKupLmYwudJ2RKDIT/sf011ENofTZR2i/7
mHJQsYGSN/zKTcrZm9cmx10BOmpL5aSq0hwcOM1qYqPn/tlSs09ErRh1+Tisxg+U
3ZTBCjG5cDlPj0KIBfoZkJapLQ3YklicCzY2LTKFvP1bxloxYa4iyyy0O5oHdBaK
vL9TOwYXvPCnUOSIH1toNvcVphaLDg==
=gwiS
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
