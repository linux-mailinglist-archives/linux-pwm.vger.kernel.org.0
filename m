Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 411932F2168
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 22:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbhAKVDc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 16:03:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:45088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbhAKVDb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Jan 2021 16:03:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01C45AB7F;
        Mon, 11 Jan 2021 21:02:49 +0000 (UTC)
Message-ID: <47b4dbc7a70d8f900789608e753be6faa36cebeb.camel@suse.de>
Subject: Re: [PATCH v6 00/11] Raspberry Pi PoE HAT fan support
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        gregkh <gregkh@linuxfoundation.org>
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com, Eric Anholt <eric@anholt.net>
Date:   Mon, 11 Jan 2021 22:02:46 +0100
In-Reply-To: <20201211164801.7838-1-nsaenzjulienne@suse.de>
References: <20201211164801.7838-1-nsaenzjulienne@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-638U3w+irQodfqeZCK9N"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-638U3w+irQodfqeZCK9N
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-12-11 at 17:47 +0100, Nicolas Saenz Julienne wrote:
> The aim of this series is to add support to the fan found on RPi's PoE
> HAT. Some commentary on the design can be found below. But the imporant
> part to the people CC'd here not involved with PWM is that, in order to
> achieve this properly, we also have to fix the firmware interface the
> driver uses to communicate with the PWM bus (and many other low level
> functions). Specifically, we have to make sure the firmware interface
> isn't unbound while consumers are still up. So, patch #1 & #2 introduce
> reference counting in the firwmware interface driver and patches #3 to
> #8 update all firmware users. Patches #9 to #11 introduce the new PWM
> driver.
>=20
> I sent everything as a single series as the final version of the PWM
> drivers depends on the firwmare fixes, but I'll be happy to split this
> into two separate series if you think it's better.
>=20
> --- Original cover letter below ---
>=20
> This series aims at adding support to RPi's official PoE HAT fan[1].
>=20
> The HW setup is the following:
>=20
> > Raspberry Pi                               | PoE HAT                   =
 |
> =C2=A0arm core -> Mailbox -> RPi co-processor -> I2C -> Atmel MCU -> PWM =
-> FAN
>=20
> The arm cores have only access to the mailbox interface, as i2c0, even if
> physically accessible, is to be used solely by the co-processor
> (VideoCore 4/6).
>=20
> This series implements a PWM bus, and has pwm-fan sitting on top of it as=
 per
> this discussion: https://lkml.org/lkml/2018/9/2/486. Although this design=
 has a
> series of shortcomings:
>=20
> - It depends on a DT binding: it's not flexible if a new hat shows up wit=
h new
> =C2=A0=C2=A0functionality, we're not 100% sure we'll be able to expand it=
 without
> =C2=A0=C2=A0breaking backwards compatibility. But without it we can't mak=
e use of DT
> =C2=A0=C2=A0thermal-zones, which IMO is overkill.
>=20
> - We're using pwm-fan, writing a hwmon driver would, again, give us more
> =C2=A0=C2=A0flexibility, but it's not really needed at the moment.
>=20
> I personally think that it's not worth the effort, it's unlikely we'll ge=
t
> things right in advance. And ultimately, if the RPi people come up with
> something new, we can always write a new driver/bindings from scratch (as=
 in
> not reusing previous code).
>=20
> That said, I'm more than happy to change things if there is a consensus t=
hat
> another design will do the trick.
>=20
> [1] https://www.raspberrypi.org/blog/introducing-power-over-ethernet-poe-=
hat/
>=20
> ---

I'd say at this point the series is pretty clean and, AFAIK, there aren't a=
ny
objections. I'm not so sure who should take it, given that it covers numero=
us
subsystems. Any suggestions on how to handle it?

Regards,
Nicolas

> Changes since v5:
> =C2=A0- Small cleanups
> =C2=A0- Add extra code comments
>=20
> Changes since v4:
> =C2=A0- Cleanup devm calls
> =C2=A0- Rename compatible string so it's unique to the PoE HAT
>=20
> Changes since v3:
> =C2=A0- Split first patch, #1 introduces refcount, then #2 the devm funct=
ion
> =C2=A0- Fix touchscreen function
> =C2=A0- Use kref
>=20
> Changes since v2:
> =C2=A0- Introduce devm_rpi_firmware_get()
> =C2=A0- Small cleanups in PWM driver
>=20
> Changes since v1:
> =C2=A0- Address PWM driver changes
> =C2=A0- Fix binding, now with 2 cells
>=20
> Nicolas Saenz Julienne (11):
> =C2=A0=C2=A0firmware: raspberrypi: Keep count of all consumers
> =C2=A0=C2=A0firmware: raspberrypi: Introduce devm_rpi_firmware_get()
> =C2=A0=C2=A0clk: bcm: rpi: Release firmware handle on unbind
> =C2=A0=C2=A0gpio: raspberrypi-exp: Release firmware handle on unbind
> =C2=A0=C2=A0reset: raspberrypi: Release firmware handle on unbind
> =C2=A0=C2=A0soc: bcm: raspberrypi-power: Release firmware handle on unbin=
d
> =C2=A0=C2=A0staging: vchiq: Release firmware handle on unbind
> =C2=A0=C2=A0input: raspberrypi-ts: Release firmware handle when not neede=
d
> =C2=A0=C2=A0dt-bindings: pwm: Add binding for RPi firmware PWM bus
> =C2=A0=C2=A0DO NOT MERGE: ARM: dts: Add RPi's official PoE hat support
> =C2=A0=C2=A0pwm: Add Raspberry Pi Firmware based PWM bus
>=20
> =C2=A0.../arm/bcm/raspberrypi,bcm2835-firmware.yaml |  20 ++
> =C2=A0arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  54 +++++
> =C2=A0drivers/clk/bcm/clk-raspberrypi.c             |   2 +-
> =C2=A0drivers/firmware/raspberrypi.c                |  69 +++++-
> =C2=A0drivers/gpio/gpio-raspberrypi-exp.c           |   2 +-
> =C2=A0drivers/input/touchscreen/raspberrypi-ts.c    |   2 +-
> =C2=A0drivers/pwm/Kconfig                           |   9 +
> =C2=A0drivers/pwm/Makefile                          |   1 +
> =C2=A0drivers/pwm/pwm-raspberrypi-poe.c             | 216 +++++++++++++++=
+++
> =C2=A0drivers/reset/reset-raspberrypi.c             |   2 +-
> =C2=A0drivers/soc/bcm/raspberrypi-power.c           |   2 +-
> =C2=A0.../interface/vchiq_arm/vchiq_arm.c           |   2 +-
> =C2=A0.../pwm/raspberrypi,firmware-poe-pwm.h        |  13 ++
> =C2=A0include/soc/bcm2835/raspberrypi-firmware.h    |  10 +
> =C2=A014 files changed, 395 insertions(+), 9 deletions(-)
> =C2=A0create mode 100644 drivers/pwm/pwm-raspberrypi-poe.c
> =C2=A0create mode 100644 include/dt-bindings/pwm/raspberrypi,firmware-poe=
-pwm.h
>=20



--=-638U3w+irQodfqeZCK9N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/8vPcACgkQlfZmHno8
x/4R5Af/YvMUXETi3hHekSRpuPNb4Zm1CBsYK+FRbnRq8W4gTWSDtIaawje7j3Lk
HR+/zx0QY/qW8xM8LkPlr4xgheQ/OK1J73ZQ8Wzcq0D1R1p+uynGzLy3eaRmCfcC
N80kvtAArsEkYJsOqkzGNoWlCZrTJmvPPwjS48SiAQlq2o2SWApcWvcmzGe5R08c
3fa4RLG2DVuLx39Np4NxWaTy/2S2cVNW0T+PZe+SA6NKsfbhe3Cj+cn4fSmJQgsF
7yPw9UaMw17oXRcDJrfof5nwva6uVun4I4B9oiVHFqmk5y+jkjTPFul+xewqA2w9
L5Nb5j/qHTSFJa23gghq7Zct1OjgWA==
=ioOp
-----END PGP SIGNATURE-----

--=-638U3w+irQodfqeZCK9N--

