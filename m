Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E422E6F3
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 09:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgG0Hwz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Jul 2020 03:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgG0Hwz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Jul 2020 03:52:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77026C0619D4
        for <linux-pwm@vger.kernel.org>; Mon, 27 Jul 2020 00:52:55 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jzxwC-00040Z-QA; Mon, 27 Jul 2020 09:52:44 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jzxwB-0008Oq-Im; Mon, 27 Jul 2020 09:52:43 +0200
Date:   Mon, 27 Jul 2020 09:52:43 +0200
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
Message-ID: <20200727075243.cjkxblsivgnn6jsk@pengutronix.de>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
 <20200724213659.273599-3-martin.botka1@gmail.com>
 <CAHp75VdJ14p+_+XqxrgRrjXF7m6L4nGr5vB03NTM=0xjgw4c7Q@mail.gmail.com>
 <CADQ2G_HkiAZx8OhfQ_jeizveMaB-QN9dfN6Tcwfk9XuF97rmOg@mail.gmail.com>
 <CADQ2G_HYTE6cd=PM2JzCTadkPe2DDb8dxObPdPJtz1626ktE9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mpvmemv5yw3hvfa3"
Content-Disposition: inline
In-Reply-To: <CADQ2G_HYTE6cd=PM2JzCTadkPe2DDb8dxObPdPJtz1626ktE9Q@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--mpvmemv5yw3hvfa3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Martin,

On Mon, Jul 27, 2020 at 09:29:19AM +0200, Martin Botka wrote:
> On Sat, Jul 25, 2020 at 09:12:23PM +0200, Martin Botka wrote:
> >> > Note there is already a series that changes these values to u64. See
> >> > a9d887dc1c60ed67f2271d66560cdcf864c4a578 in linux-next.
> >>
> >> Amazing. But isn't there the same issue with it as this one where this
> >> would fail to build on 32 bit architecture?
> >
> > In theory all these cases are coped for. I didn't see any problems yet,
> > so I still assume also the 32 bit archs are fine.
>=20
> OK then all is fine. I will drop the patch in V2.
>=20
> Also Uwe i just realized that you sent the original message and also
> this reply only to me and not to anyone else.
> Could you please send the messages also to everyone else ?

I hit "reply-to-all" and the mail only was sent to you because you wrote
to only me.

Also threading is somehow strange because your reply to my mail (with

	Message-Id: 20200727070411.ovkuwm76vuw3heo7@pengutronix.de

) has

	In-Reply-To: <CADQ2G_HkiAZx8OhfQ_jeizveMaB-QN9dfN6Tcwfk9XuF97rmOg@mail.gma=
il.com>

=2E So I assume all the strange things happened on your side until proved
otherwise. :-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mpvmemv5yw3hvfa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl8eh8cACgkQwfwUeK3K
7AmqRgf+LF2ACIQRbyfDBMtCAu02MQT3NxAZnOjqpQDAAHorTjQai+jQc33k+CZV
KZR0cLROaFcfgDQnBtDglqbfboTEOlIhxsSMRtNpE5tiDVhORIVgvw0xr1UNR9A5
UZIPcfC3P6CuGZAwOJOLQsmCKwLAu+FZNrQA0pLRrhadwkh9UEff09J+quoycHCX
2PEmSoOfux9TG0GO8OTYC6tLI6BTkcyM/6NaJO2RCSlOwFBkQHxpETrI++qD3FpE
lON/IgXogThGKOnDjkPWLdR3QtEE+ExFnO3SGgPS5/nkeyToKd1hjZ3xbvfwUUld
Ob3rwCEjGhInxkeIni5Fqe96oqbBnA==
=Sbbf
-----END PGP SIGNATURE-----

--mpvmemv5yw3hvfa3--
