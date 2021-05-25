Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDFC38FA8C
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 08:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbhEYGNN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 02:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhEYGNJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 02:13:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03584C061756
        for <linux-pwm@vger.kernel.org>; Mon, 24 May 2021 23:11:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llQHu-0003jC-9d; Tue, 25 May 2021 08:11:34 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llQHr-0001vZ-U0; Tue, 25 May 2021 08:11:31 +0200
Date:   Tue, 25 May 2021 08:11:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@pengutronix.de
Subject: Re: [PATCH v3 2/2] clocksource: Add support for Xilinx AXI Timer
Message-ID: <20210525061131.omrbcdewf4z75ib7@pengutronix.de>
References: <20210511191239.774570-1-sean.anderson@seco.com>
 <20210511191239.774570-2-sean.anderson@seco.com>
 <d4bb7b5d-9f38-cf60-fb0b-18f8e0ca2b1e@xilinx.com>
 <5f960034-174d-0ed8-9f52-3d5fde90e16a@seco.com>
 <9f227f96-a310-0fbd-fd34-91eb386306b9@xilinx.com>
 <7a06cf46-0f85-1edb-ca08-abd7b2543ad9@seco.com>
 <41542760-3967-4f9a-0f0c-1206e03ff494@xilinx.com>
 <d206a399-454e-d9c5-e2d3-337d098ed7aa@seco.com>
 <2296d4e5-717a-0470-d487-e0924cf6c076@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wn37yka2xnftryhr"
Content-Disposition: inline
In-Reply-To: <2296d4e5-717a-0470-d487-e0924cf6c076@xilinx.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wn37yka2xnftryhr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean, hello Michal,

On Mon, May 24, 2021 at 09:00:51AM +0200, Michal Simek wrote:
> On 5/20/21 10:13 PM, Sean Anderson wrote:
> > On 5/19/21 3:24 AM, Michal Simek wrote:
> >> On 5/18/21 12:15 AM, Sean Anderson wrote:
> >>> This could be deprecated, but cannot be removed since existing device
> >>> trees (e.g. qemu) have neither clocks nor clock-frequency properties.
> >>
> >> Rob: Do we have any obligation to keep properties for other projects?

If a binding is in the wild and used to be documented, it has to stay.

> >>>> 4. Make driver as module
> >>>> 5. Do whatever changes you want before adding pwm support
> >>>> 6. Extend DT binding doc for PWM support
> >>>> 7. Add PWM support
> >>>
> >>> Frankly, I am inclined to just leave the microblaze timer as-is. The =
PWM
> >>> driver is completely independent. I have already put too much effort =
into
> >>> this driver, and I don't have the energy to continue working on the
> >>> microblaze timer.
> >>
> >> I understand. I am actually using axi timer as pwm driver in one of my
> >> project but never had time to upstream it because of couple of steps a=
bove.
> >> We need to do it right based on steps listed above. If this is too much
> >> work it will have to wait. I will NACK all attempts to add separate
> >> driver for IP which we already support in the tree.
> >=20
> > 1. Many timers have separate clocksource and PWM drivers. E.g. samsung,
> > =A0=A0 renesas TPU, etc. It is completely reasonable to keep separate
> > =A0=A0 drivers for these purposes. There is no Linux requirement that e=
ach
> > =A0=A0 device have only one driver, especially if it has multiple funct=
ions
> > =A0=A0 or ways to be configured.
>=20
> It doesn't mean that it was done properly and correctly. Code
> duplication is bad all the time.

IMHO it's not so much about code duplication. Yes, code duplication is
bad and should be prevented if possible. But it's more important to not
introduce surprises. So I think it should be obvious from reading the
device tree source which timer is used to provide the PWM. I don't care
much if this is from an extra property (like xilinx,provide-pwm),
overriding the compatible or some other explicit mechanism. IIUC in this
suggested patch the selection is implicit and so this isn't so nice.

> > 2. If you want to do work on a driver, I'm all for it. However, if you
> > =A0=A0 have not yet submitted that work to the list, you should not gate
> > =A0=A0 other work behind it. Saying that X feature must be gated behind=
 Y
> > =A0=A0 *even if X works completely independently of Y* is just stifling
> > =A0=A0 development.
>=20
> I gave you guidance how I think this should be done. I am not gating you
> from this work. Your patch is not working on Microblaze arch which is
> what I maintain. And I don't want to go the route that we will have two
> drivers for the same IP without integration. We were there in past and
> it is just pain.
> I am expecting that PWM guys will guide how this should be done
> properly. I haven't heard any guidance on this yet.
> Thierry/Uwe: Any comment?

Not sure I can and want to provide guidance here. This is not Perl, but
still TIMTOWTDI. If it was me who cared here, I'd look into the
auxiliary bus (Documentation/driver-api/auxiliary_bus.rst) to check if
it can help to solve this problem.
=20
> > 3. There is a clear desire for a PWM driver for this device. You, I, and
> > =A0=A0 Alvaro have all written separate drivers for this device because=
 we
> > =A0=A0 want to use it as a PWM. By preventing merging this driver, you =
are
> > =A0=A0 encouraging duplicate effort by the next person who wants to use=
 this
> > =A0=A0 device as a PWM, and sees that there is no driver in the tree.
>=20
> We should do it cleanly that it will be easy to maintain which is not by
> creating two separate drivers or by switching to completely new driver.

+1

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wn37yka2xnftryhr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCslRAACgkQwfwUeK3K
7Ak7YQf/TpIJXkF7drwqBVWLD73Z149/8vSGvkDfPtqJrQq3/B+cxJ2dd9+ehIPH
3HmLTLu2Uv/BUylaRgFZj8FH0vszNMgRyskYTdbyGgrXti63GhAJDad1C/o8xOax
92rsl/YE6PqHz6htoyjjq3XxPjKZyeuWtYAQop+IsKYy06p+H0N3d5A+Rdx/YVwC
IWYfKTrFejAIHADFJuWSesyr8AVjiz5hGq6l8BUd7vkpZ8QS3G3KV0j4aYhgPTpe
Bai+4VHoArdJYF/jBIcBzT5Oxa8W8xtie1Nu5O5E3XTj6gXuzpxPxCwudML62K85
dBVqeYouJgmtxoicWFMRXQ0dFmWWMQ==
=DZ2s
-----END PGP SIGNATURE-----

--wn37yka2xnftryhr--
