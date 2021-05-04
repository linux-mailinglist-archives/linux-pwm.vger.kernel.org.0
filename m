Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB8372DCD
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 18:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbhEDQOt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 12:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhEDQOf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 12:14:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7005EC0613ED
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 09:13:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldxg0-0003NR-2y; Tue, 04 May 2021 18:13:36 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldxfz-0004c0-6D; Tue, 04 May 2021 18:13:35 +0200
Date:   Tue, 4 May 2021 18:13:34 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <20210504161334.tzylwyiz4k2tcztq@pengutronix.de>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <20210503214413.3145015-2-sean.anderson@seco.com>
 <20210504085112.edyy6loprfzejrjl@pengutronix.de>
 <dc6d9f40-a913-90c4-9675-0f84f789ab61@xilinx.com>
 <71694d6a-21d8-2b31-0e66-2dfea52a6390@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fsu5b2qmawl4p2fd"
Content-Disposition: inline
In-Reply-To: <71694d6a-21d8-2b31-0e66-2dfea52a6390@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fsu5b2qmawl4p2fd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

[Adding Rob to the list of recipents, as he for sure has a valuable
opinion on this matter.]

On Tue, May 04, 2021 at 11:57:20AM -0400, Sean Anderson wrote:
> On 5/4/21 8:32 AM, Michal Simek wrote:
> > On 5/4/21 10:51 AM, Uwe Kleine-K=F6nig wrote:
> >> On Mon, May 03, 2021 at 05:44:13PM -0400, Sean Anderson wrote:
> >>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> >>> found on Xilinx FPGAs. There is another driver for this device located
> >>> at arch/microblaze/kernel/timer.c, but it is only used for timekeepin=
g.
> >>> This driver was written with reference to Xilinx DS764 for v1.03.a [1=
].
> >>>
> >>> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi=
_timer/v1_03_a/axi_timer_ds764.pdf
> >>>
> >>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> >>> ---
> >>>
> >>>   arch/arm64/configs/defconfig |   1 +
> >>>   drivers/pwm/Kconfig          |  11 ++
> >>>   drivers/pwm/Makefile         |   1 +
> >>>   drivers/pwm/pwm-xilinx.c     | 322 ++++++++++++++++++++++++++++++++=
+++
> >>>   4 files changed, 335 insertions(+)
> >>>   create mode 100644 drivers/pwm/pwm-xilinx.c
> >>>
> >>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defcon=
fig
> >>> index 08c6f769df9a..81794209f287 100644
> >>> --- a/arch/arm64/configs/defconfig
> >>> +++ b/arch/arm64/configs/defconfig
> >>> @@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=3Dy
> >>>   CONFIG_PWM_SL28CPLD=3Dm
> >>>   CONFIG_PWM_SUN4I=3Dm
> >>>   CONFIG_PWM_TEGRA=3Dm
> >>> +CONFIG_PWM_XILINX=3Dm
> >>>   CONFIG_SL28CPLD_INTC=3Dy
> >>>   CONFIG_QCOM_PDC=3Dy
> >>>   CONFIG_RESET_IMX7=3Dy
> >>
> >> I think this should go into a separate patch once this driver is
> >> accepted. This can then go via the ARM people.
> >>
> >>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >>> index d3371ac7b871..01e62928f4bf 100644
> >>> --- a/drivers/pwm/Kconfig
> >>> +++ b/drivers/pwm/Kconfig
> >>> @@ -628,4 +628,15 @@ config PWM_VT8500
> >>>   	  To compile this driver as a module, choose M here: the module
> >>>   	  will be called pwm-vt8500.
> >>>
> >>> +config PWM_XILINX
> >>> +	tristate "Xilinx AXI Timer PWM support"
> >>> +	depends on !MICROBLAZE
> >>
> >> I don't understand this dependency.
> >
> > The dependency is clear here because microblaze has already driver for
> > this timer here arch/microblaze/kernel/timer.c.

Then at least add a comment.

> > And that's exactly pointing to the way how this should be done.
> > IP itself is single or dual timer and in case of dual timer you can
> > select if there is pwm output and use it for PWM generation.
> >
> > It means it is timer with PMW together.
> > I didn't have a time but Uwe likely knows this better how to design it.
> >
> > I see that gpio-mvebu driver instantiate pwm driver. Maybe that's the
> > way to go.
>=20
> I think drivers/clocksource/samsung_pwm_timer.c and
> drivers/pwm/pwm-samsung.c provide another example for how to go about
> this.

I recently had a similar problem (with code that isn't (yet) in
mainline), where a timer can be used as a counter. I chose to change the
compatible. Transferred to this example this would mean to use e.g.

	static const struct of_device_id xilinx_pwm_of_match[] =3D {
		{ .compatible =3D "xlnx,xps-timer-pwm-1.00.a" },
		...
	};

and if you want to use the hardware as a PWM, you overwrite the
compatible in your machine.dts.

Not sure however that this is nice enough to be accepted by the dt
people?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fsu5b2qmawl4p2fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCRcqsACgkQwfwUeK3K
7AntOwf/anwLjThveWM2RlDIDXOZhGyF/r12T+TxL+rYZV0ZVE4hAVwbdCeLY93X
+hqUjyyoDbzhgbQm+4HmZ1NDOA3SfcAB9yszmf619NPTW+gPnEo/a6EDPwsWkbKB
gRtCKV4i5wMkpP2RpvkoCE7rFoQFjfvQc4TboS1Zv6gUw7PLtK1UsVY1SRfwu8kG
+ZGO5CEST71AelWYpAVB5g6Z3a8mgPT55k6JI4GsFJ/93y6Uhd/fBHxLwEU9GzO1
48cXF50tBjWYfqxFfNsWpuUOiAYa/mLiy7uQ0LtnGWF1LVruEY9L8oA1PgeVUwL+
fRrQvlWGbXoC1eitrWwTr5Z8Si+A6A==
=0mp3
-----END PGP SIGNATURE-----

--fsu5b2qmawl4p2fd--
