Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC82A2F210F
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 21:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbhAKUpY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 15:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391137AbhAKUod (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 11 Jan 2021 15:44:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A68C06179F
        for <linux-pwm@vger.kernel.org>; Mon, 11 Jan 2021 12:43:53 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz42Z-00015t-03; Mon, 11 Jan 2021 21:43:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kz42Y-0002eK-Ja; Mon, 11 Jan 2021 21:43:50 +0100
Date:   Mon, 11 Jan 2021 21:43:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Message-ID: <20210111204350.k2bhpdj7xnnqkfi3@pengutronix.de>
References: <20201216125320.5277-1-clemens.gruber@pqgruber.com>
 <20201216125320.5277-2-clemens.gruber@pqgruber.com>
 <CAGngYiWkKZGkQ4TTTy8bQYvnGBK45V0A0JCe_+M5V+vuVU+zkQ@mail.gmail.com>
 <X9uYqGboZg5DuEtf@workstation.tuxnet>
 <CAGngYiUYOL6EF3VTGwcwTuN4EmE26ML3ye7689FTEpowjEcU2w@mail.gmail.com>
 <X/H5CqcRHelg5M4p@workstation.tuxnet>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ol44sy6xmafby4sj"
Content-Disposition: inline
In-Reply-To: <X/H5CqcRHelg5M4p@workstation.tuxnet>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ol44sy6xmafby4sj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 03, 2021 at 06:04:10PM +0100, Clemens Gruber wrote:
> Another point is the period: Sven suggested we do not read out the
> period at all, as the PWM is disabled anyway (see above).
> Is this acceptable?

In my eyes consumers should consider the period value as "don't care" if
the PWM is off. But this doesn't match reality (and maybe also it
doesn't match Thierry's opinion). See for example the
drivers/video/backlight/pwm_bl.c driver which uses the idiom:

	pwm_get_state(mypwm, &state);
	state.enabled =3D true;
	pwm_apply_state(pb->pwm, &state);

which breaks if .period is invalid. (OK, this isn't totally accurate
because currently the .get_state callback has only little to do with
pwm_get_state(), but you get the point.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ol44sy6xmafby4sj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/8uIMACgkQwfwUeK3K
7AliDgf/WEtJ/jp7SG6NJErnQJqh69fn4dYEeKw3nDmdy3iDQ1D2d0b9shJHas5T
brvWT+wJ3NUEwL7EwNcn3XxmAIgS5M+3Zj8BaPIxx73dS06zUGbmgcAS/dJ0rTz+
obDb/99aRtlt+wByM6rajNibTEKVPInCTowBGJS0Un5g7BPG3kYwb4kqjJ85V2gv
JooIK5Ee1BpTJhvQy3m1n9nVpTf7PtUNxz/fOMRPaTYSRspy20rE1IW5QSsvrh60
kDkeh8zLk9vFehP+QaQov629NOldazJAFOH8IC+EI+W/4uu/5Y6hZnkW/rTMGiS5
OwTYJRjjSz0MMhEiMAE3RHI4j4zWcg==
=3j/z
-----END PGP SIGNATURE-----

--ol44sy6xmafby4sj--
