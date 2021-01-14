Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25A42F69E0
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 19:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbhANSpb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jan 2021 13:45:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:39726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbhANSpa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 14 Jan 2021 13:45:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 248D5B77E;
        Thu, 14 Jan 2021 18:44:48 +0000 (UTC)
Message-ID: <99a7d6e80646ff7ac6c1fc615146fc4ad1428552.camel@suse.de>
Subject: Re: [PATCH v6 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, f.fainelli@gmail.com,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Date:   Thu, 14 Jan 2021 19:44:46 +0100
In-Reply-To: <20210112091842.3th64ardbqjafvuq@pengutronix.de>
References: <20201211164801.7838-1-nsaenzjulienne@suse.de>
         <20201211164801.7838-12-nsaenzjulienne@suse.de>
         <20210112091842.3th64ardbqjafvuq@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Gc66jpwjN4JFK05BfjVR"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-Gc66jpwjN4JFK05BfjVR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe, thanks for the review.

On Tue, 2021-01-12 at 10:18 +0100, Uwe Kleine-K=C3=B6nig wrote:

[...]

> > +                duty_cycle =3D DIV_ROUND_CLOSEST_ULL(state->duty_cycle=
 * RPI_PWM_MAX_DUTY,
> > +					           RPI_PWM_PERIOD_NS);
>=20
> ... and round down here.
>=20
> Just to be sure: writing RPI_PWM_MAX_DUTY (i.e. 255) yields 100% duty
> cycle, right?

Yes, at 255 the signal is flat.

> > +        else
> > +                duty_cycle =3D RPI_PWM_MAX_DUTY;
> > +
> > +	if (duty_cycle =3D=3D rpipwm->duty_cycle)
> > +		return 0;
> > +
> > +	ret =3D raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_CUR_DU=
TY_REG,
> > +					   duty_cycle);
> > +	if (ret) {
> > +		dev_err(chip->dev, "Failed to set duty cycle: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/*
> > +	 * This sets the default duty cycle after resetting the board, we
> > +	 * updated it every time to mimic Raspberry Pi's downstream's driver
> > +	 * behaviour.
> > +	 */
> > +	ret =3D raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_DEF_DU=
TY_REG,
> > +					   duty_cycle);
> > +	if (ret) {
> > +		dev_err(chip->dev, "Failed to set default duty cycle: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +        rpipwm->duty_cycle =3D duty_cycle;
>=20
> Please use tabs for indention. (The general hint is to use checkpatch
> which (I hope) tells you about problems like this.)

Sorry for that.

I took note of the rest of comments and will update the code.

Regards,
Nicolas



--=-Gc66jpwjN4JFK05BfjVR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAAkR4ACgkQlfZmHno8
x/7WpAf+OcmBebYI8HGJFfpFhX3gBSdN6587Todi3RNaMrm6loRFFbe3HDS3rO0u
pv9Zl7lrjVKV1+Fug2/3rTL4Kh0/w98EZJ5mpf6n5k0EG+EoMqGqfqElaLL0mvW9
7NpiNF15W4/v/U22BH3jtFUkt0PpjN1J2WPclOl+ZPEe31vjdiEauq7zAhRT9Gpr
XHH9ZbY9f4oXR2s91ZaYGdni3ikxxB4cG/aS50GAM019KW/RIkEibfYpDjrCNOml
M4Z4Y15Mqi8aouumlLNKiuxNmNhtyCilx3jHPeNm+2b5GeBp/S9jtAVkVaUaYQ9I
N8qh4QzVUk4qMeucxLeRRemzuIWCOw==
=pJN/
-----END PGP SIGNATURE-----

--=-Gc66jpwjN4JFK05BfjVR--

