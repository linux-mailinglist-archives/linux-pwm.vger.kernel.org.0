Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9A5337349
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Mar 2021 14:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhCKNBb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 Mar 2021 08:01:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:59444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233322AbhCKNBE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 11 Mar 2021 08:01:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4820BAC16;
        Thu, 11 Mar 2021 13:01:02 +0000 (UTC)
Message-ID: <fc60ac5ab9760d791aa5e184258accf53e07ce1e.camel@suse.de>
Subject: Re: [PATCH v7 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com
Date:   Thu, 11 Mar 2021 14:01:00 +0100
In-Reply-To: <20210310115041.s7tzvgdpksws6yss@pengutronix.de>
References: <20210118123244.13669-1-nsaenzjulienne@suse.de>
         <20210118123244.13669-12-nsaenzjulienne@suse.de>
         <20210310115041.s7tzvgdpksws6yss@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rPtClvAMAu3vmlHUSTv2"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-rPtClvAMAu3vmlHUSTv2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,
thanks for taking the time to look into this. :)

On Wed, 2021-03-10 at 12:50 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Nicolas,
>=20
> On Mon, Jan 18, 2021 at 01:32:44PM +0100, Nicolas Saenz Julienne wrote:

[...]

> > +	/*
> > +	 * This sets the default duty cycle after resetting the board, we
> > +	 * updated it every time to mimic Raspberry Pi's downstream's driver
> > +	 * behaviour.
> > +	 */
> > +	ret =3D raspberrypi_pwm_set_property(rpipwm->firmware, RPI_PWM_DEF_DU=
TY_REG,
> > +					   duty_cycle);
> > +	if (ret) {
> > +		dev_err(chip->dev, "Failed to set default duty cycle: %pe\n",
> > +			ERR_PTR(ret));
> > +		return ret;
>=20
> This only has an effect for the next reboot, right?

It effects all reboots until it's further changed.

> If so I wonder if it is a good idea in general. (Think: The current PWM
> setting enables a motor that makes a self-driving car move at 100 km/h.
> Consider the rpi crashes, do I want to car to pick up driving 100 km/h at
> power up even before Linux is up again?)

I get your point. But this isn't used as a general purpose PWM. For now the
interface is solely there to drive a PWM fan that's arguably harmless. This
doesn't mean that the RPi foundation will not reuse the firmware interface =
for
other means in the future. In such case we can always use a new DT compatib=
le
and bypass this feature (the current DT string is
'raspberrypi,firmware-poe-pwm', which is specific to this use-case).

My aim here is to be on par feature wise with RPi's downstream implementati=
on.
So as for them to be able to use it as is and avoid duplication. Now, if th=
is
is blocking the driver from being merged, I'd rather remove it. It'll be a
patch for the downstream kernel to maintain, but better than nothing.

> And if we agree it's a good idea: Should raspberrypi_pwm_apply return 0 i=
f
> setting the duty cycle succeeded and only setting the default didn't?

Good point. I don't think so. We'd be also missing on the following by
returning early:

	rpipwm->duty_cycle =3D duty_cycle;

I propose to change it to a 'best effort' approach, if it fails, log it and
continue successfully.

Regards,
Nicolas


--=-rPtClvAMAu3vmlHUSTv2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBKFIwACgkQlfZmHno8
x/5Xwwf/epKXd8rgN+dNn1qRP2YYm1lUu6pbJFf3mtkjI4AkSoZaHsvNqGMSIe5q
FZEL262SPZKC5f2EaZhbvuGF2Jengz0t4cC1dID9Asup+lK4baI17+1iNzOJoAgC
6OewHa2pkDzUoo+J94nSB8FMPqTorYR+8kP7O2+olrz1UPvH2UJonwSlgiWuzI1Q
rIxjBhqHy0Q/R5Aa9oNCZalpdmeGaq9ewIZFfpYyns/MAOSGH3tYP/dH70yUBQO3
awy7Ly59mr2+ggecgxW5R0okT95/CdRxivA+DmOE2jxl3/BhNHglRijTY9KRj8c6
kS3q0R8eKZK6q0C2OJFotH6xrhPVOA==
=/TKa
-----END PGP SIGNATURE-----

--=-rPtClvAMAu3vmlHUSTv2--

