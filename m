Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42887357DB6
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Apr 2021 09:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhDHH7l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Apr 2021 03:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDHH7l (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Apr 2021 03:59:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18507C061760
        for <linux-pwm@vger.kernel.org>; Thu,  8 Apr 2021 00:59:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUPZU-0002a4-DU; Thu, 08 Apr 2021 09:59:24 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUPZQ-0005CS-Vf; Thu, 08 Apr 2021 09:59:20 +0200
Date:   Thu, 8 Apr 2021 09:59:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     linux-pwm@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        devicetree@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM
 support
Message-ID: <20210408075920.rfrcqxec2yvepj3y@pengutronix.de>
References: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210212131910.557581-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210212164144.wcvy7jkxmrysqxux@pengutronix.de>
 <20210407231548.4paov2fb33cpxxui@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="geu5564gy6ryykgp"
Content-Disposition: inline
In-Reply-To: <20210407231548.4paov2fb33cpxxui@toshiba.co.jp>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--geu5564gy6ryykgp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Nobuhiro,

On Thu, Apr 08, 2021 at 08:15:48AM +0900, Nobuhiro Iwamatsu wrote:
> > > +	/*
> > > +	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
> > > +	 * When the settings of the PWM are modified, the new values are sh=
adowed in hardware until
> > > +	 * the period register (PCSR) is written and the currently running =
period is completed. This
> > > +	 * way the hardware switches atomically from the old setting to the=
 new.
> > > +	 * Also, disabling the hardware completes the currently running per=
iod and keeps the output
> > > +	 * at low level at all times.
> >=20
> > Did you just copy my optimal description or is your hardware really that
> > nice?
>=20
> Yes, this hardware works as you wrote.
> And I added about the state if the sinnal when this hardware disabled.
>=20
> >=20
> > Do you know scripts/checkpatch.pl? I bet it will tell you to limit your
> > lines to approx. 80 chars where sensible.
>=20
> Yes, I know. I ran scripts/checkpatch.pl before send patch.
> I understand that the number of characters per line has been changed to
> 100 characters. Does the pwm driver recommend 80 characters?

For free-text comments I'd still recommend 80, yes. For code lines I'd
be indeed more lax, as a line break in function calls reduces readability.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--geu5564gy6ryykgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBut9MACgkQwfwUeK3K
7AlwEwf+LOf+gfIUqpelOcF+8SK6n10H1NShUmwZh32SQfCI6WR7zeuehzeR3f2r
ujKiNUDTbhTyqUUV8FKZL0ezCJkW8LGiVMzMLnmS3xJkfPkLzaiJfRwtRksWJlRU
KIyrRmN2c2sQsEBqZNX++V1QYjorEMAieBJfq442oePYvToBW1EsIXC+/FZ2SNec
mZfVX6SqYvMCHZ5hLxIveAhseJ+LE+QRwQNoWQNanYPRlXf2QfN4H6GLQXTqNyw/
BxGNekeiyyXlUPovaHgdiCYiph6t4AqhPq0q9AG/kSjGeQDyhmWnxSjRtUHs1li4
mr2MPB0qxKRjT5876znW5v2bOWw/9g==
=aMAV
-----END PGP SIGNATURE-----

--geu5564gy6ryykgp--
