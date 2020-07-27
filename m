Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED1522E7CC
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 10:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgG0IeS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgG0IeS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 04:34:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F224FC061794
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2020 01:34:17 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jzyaI-0000ik-4Y; Mon, 27 Jul 2020 10:34:10 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jzyaG-0001dX-V7; Mon, 27 Jul 2020 10:34:08 +0200
Date:   Mon, 27 Jul 2020 10:34:08 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Martin Botka <martin.botka1@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period
 with u64 data length
Message-ID: <20200727083408.jqm72hty62w7kxdc@pengutronix.de>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-3-martin.botka1@gmail.com>
 <CAHp75VdJ14p+_+XqxrgRrjXF7m6L4nGr5vB03NTM=0xjgw4c7Q@mail.gmail.com>
 <CADQ2G_HkiAZx8OhfQ_jeizveMaB-QN9dfN6Tcwfk9XuF97rmOg@mail.gmail.com>
 <CADQ2G_HYTE6cd=PM2JzCTadkPe2DDb8dxObPdPJtz1626ktE9Q@mail.gmail.com>
 <20200727075243.cjkxblsivgnn6jsk@pengutronix.de>
 <CADQ2G_GcYh13CGbApCqvi3xcHU-Ur2ej98VccKFOUSOZPrQZnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lvdzfpf3t7glasbo"
Content-Disposition: inline
In-Reply-To: <CADQ2G_GcYh13CGbApCqvi3xcHU-Ur2ej98VccKFOUSOZPrQZnQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lvdzfpf3t7glasbo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Mon, Jul 27, 2020 at 09:58:01AM +0200, Martin Botka wrote:
> > I hit "reply-to-all" and the mail only was sent to you because you wrote
> > to only me.
>=20
> Yes my reply was only to you. But your original message was sent only to =
me too.
> So when i clicked reply to all it was only you as you sent it only to me.

Oh indeed. Bummer, and I was so sure to always reply to all :-|

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lvdzfpf3t7glasbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8ekX0ACgkQwfwUeK3K
7AnF8Af/auMYk0XSqHjSdH6o5BpdaRw4k2nwyrLlpPbA1EAo1doDPo+5qggDDEEI
Hhasvj30vEfKAP5PHmRcwHSacAYoUrLgzL9vrO3VLDrSfq1+xPoR2oZNyvEwyNjY
ORMuV/aXEqcOgjfqciLl/qjMouS5RFyMryESdDULaQTPtIPNJGtFAL63cWibRVB2
jh8JDB9F/rijp8QsmEDDqEMVSyjbLoGWHdQJvbbd3N9Xy8Rke6Iob+AUXulnFzaC
q1sOJT3ypUjDhMhvxNBUSMVto8pKUUPZfuJosWBWDpWmAA1Bqi93FvTNyAGKeo4E
D7Ne9+lzuKLmtH6bwgskg/LCNtlsRA==
=VGmX
-----END PGP SIGNATURE-----

--lvdzfpf3t7glasbo--
