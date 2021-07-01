Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92BE3B918D
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 14:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhGAMWQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 08:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbhGAMWQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 08:22:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BACDC061756
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 05:19:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyvfT-0001M8-Gk; Thu, 01 Jul 2021 14:19:43 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyvfS-0008WB-K0; Thu, 01 Jul 2021 14:19:42 +0200
Date:   Thu, 1 Jul 2021 14:19:42 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 0/3] pwm: Some improvements for legacy drivers
Message-ID: <20210701121942.uz7rtcil3i5v2sfr@pengutronix.de>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
 <CAMuHMdWFL42BV9m7Oigvy0m7=-i4W0hnQT8izHdNNiYG0BfiMQ@mail.gmail.com>
 <20210701104528.dbnhhswxp6rgzzj3@pengutronix.de>
 <CAMuHMdUBUG1bgfaWGt3OPhXyt+wt1XTT_uKKJemE-UcK7V8BZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yiyyemoirwaq56z2"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUBUG1bgfaWGt3OPhXyt+wt1XTT_uKKJemE-UcK7V8BZQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--yiyyemoirwaq56z2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Geert,

On Thu, Jul 01, 2021 at 01:41:19PM +0200, Geert Uytterhoeven wrote:
> On Thu, Jul 1, 2021 at 12:45 PM Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> > his for-next branch is based on v5.13-rc1 and there are no changes in it
> > touching drivers/pwm/core.c, so I expect this to be fine.
>=20
> Git tends to disagree:
>=20
> $ git log --oneline v5.13-rc1..pwm/for-next -- drivers/pwm/core.c
> 9ae241d06ef7aca8 pwm: core: Simplify some devm_*pwm*() functions
> c333b936c1530e76 pwm: core: Remove unused devm_pwm_put()
> e625fb70a6d21e4d pwm: core: Unify fwnode checks in the module
> e5c38ba9f2813beb pwm: core: Reuse fwnode_to_pwmchip() in ACPI case
> ca06616b1eed3112 pwm: core: Convert to use fwnode for matching
> ad5e085c63f59391 pwm: Drop irrelevant error path from pwmchip_remove()
> bcda91bf86c1ff76 pwm: Add a device-managed function to add PWM chips
> 9e40ee18a1dc1623 pwm: core: Support new usage_power setting in PWM state
> 69230cfac3d02c1b pwm: Autodetect default value for of_pwm_n_cells from
> device tree
> 5447e7833629ee42 pwm: Drop of_pwm_simple_xlate() in favour of
> of_pwm_xlate_with_flags()
> cf38c978cf1d2a28 pwm: Make of_pwm_xlate_with_flags() work with #pwm-cells=
 =3D <2>

I thought this was my command line, too, but *now* it shows some output.
I'm unable to find out what I did wrong ...  *shrug* I assume and hope
Thierry is able to cope with that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--yiyyemoirwaq56z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdstsACgkQwfwUeK3K
7An6MAf/WZsWeJioFw26fJ26bHJEmR/rNdGnkuq5vPWvkScHaUGVkWhC18BIMfIF
yvcsqrp9f7FONAIiLnNkt+07UFYdeEMDdfyMADMCiI68tweapajoIcuQn4q3AkZ/
8aCw+tarxOe9i08n4+3Uu6DNEMYWJvCogpxqrwR1aT7+RhdADFyuloC5wJvqZj3b
gsPHSNdpVB6bqvpv4djc7kPjO3IDIGS37SV9Hz0mW9g4dbyw4uRqfAu69qgVDk33
lT8ksnXFhvCvdxAEIdWK80acV7uiwoQriLywQ+R5kEAGwQqGVPDGFAUKC+Pq9m7P
ftRqa0K/ZDe/qxL1HWjvXZWbkkaLUA==
=yZ5V
-----END PGP SIGNATURE-----

--yiyyemoirwaq56z2--
