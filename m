Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6269133C157
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Mar 2021 17:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCOQMv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Mar 2021 12:12:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:37062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhCOQMs (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 15 Mar 2021 12:12:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1A270AE44;
        Mon, 15 Mar 2021 16:12:46 +0000 (UTC)
Message-ID: <1255e56c66c8704c93adad77f605357267de0231.camel@suse.de>
Subject: Re: [PATCH v8 11/11] pwm: Add Raspberry Pi Firmware based PWM bus
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
Date:   Mon, 15 Mar 2021 17:12:44 +0100
In-Reply-To: <20210312201217.n2sav23swy7ii4uo@pengutronix.de>
References: <20210312122454.24480-1-nsaenzjulienne@suse.de>
         <20210312122454.24480-12-nsaenzjulienne@suse.de>
         <20210312201217.n2sav23swy7ii4uo@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-JjHV4KNwgAtLbBPYBur8"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--=-JjHV4KNwgAtLbBPYBur8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Fri, 2021-03-12 at 21:12 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Nicolas,
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> 2021?

Yes.

> > + * For more information on Raspberry Pi's PoE hat see:
> > + * https://www.raspberrypi.org/products/poe-hat/
>=20
> Out of personal interest: Is this hat also able to power a RPi CM4?

I haven't tested it, and can't at the moment (no PoE injector available). B=
ut
the physical pin layout, and routing in CM4's IO board fits the hat. So I'd=
 say
yes.

> > + * Limitations:
> > + *  - No disable bit, so a disabled PWM is simulated by duty_cycle 0
> > + *  - Only normal polarity
> > + *  - Fixed 12.5 kHz period
> > + *
> > + * The current period is completed when HW is reconfigured.
> > + */
>=20
> Other than that as mentioned in the previous round: This looks good,
>=20
> Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Thanks!

> What is your thought about how to get this series merged?
> At least input, staging, armsoc, clk, reset anf firmware are touched. Do =
you
> prepare a branch for merging in the relevant trees (once you have all the
> necessary Acks)?

As per Linusw suggestion I'll send a pull request myself into the SoC tree =
and
hope for the best. :)

Regards,
Nicolas


--=-JjHV4KNwgAtLbBPYBur8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmBPh3wACgkQlfZmHno8
x/53LQf/dUgfBEd6vbH95M6DCLvf5pt99cSCUEMCwlP7yqwyFwU0PwzaIaaWDZr6
ndzNDlkPo08HzcPgZ4YenCX25lpjQNMsJ4XAmXsWNv+mmSfFTHlqyZPD9zlfvFe4
uCxDMhTSdDOW6but1Qq5GoTIOWS49aU6v0ycjXPL6xky1xL6na9w4XuBI0fzQJa8
cH3A/zt0sFSE6zedvH88o2JcKJqASiIC6M5P8dhShbpQFyJIZSzcebENxCt3AoeA
Asui9I4P4auIKH3UlvuVYtr2q438+xMD24EpDeMVxeimtYrTcQyB7bwP4v+0cH49
VTZL6KPpv5TbPD0BnhXJI0owDekNSQ==
=RDjK
-----END PGP SIGNATURE-----

--=-JjHV4KNwgAtLbBPYBur8--

