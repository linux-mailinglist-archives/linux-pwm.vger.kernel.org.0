Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B103B40F4
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 11:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhFYJ5e (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhFYJ5d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 05:57:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392EBC061760
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 02:55:13 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwiYI-0000ds-Ik; Fri, 25 Jun 2021 11:55:10 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwiYI-00028u-9I; Fri, 25 Jun 2021 11:55:10 +0200
Date:   Fri, 25 Jun 2021 11:55:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sven Van Asbroeck <TheSven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org
Subject: Re: PWM-Patches for next merge window
Message-ID: <20210625095510.gnlzgzx24gotnace@pengutronix.de>
References: <YJVhLrkeNXBp6M1p@workstation.tuxnet>
 <20210507231831.zmvyspcq7xhm25y4@pengutronix.de>
 <YLUK8GXHaBYyVe1R@workstation.tuxnet>
 <YLn3MZ+6HJM/UrRT@orome.fritz.box>
 <20210607060827.vxdihsfqtw3otyco@pengutronix.de>
 <YL4vzvznTzqih0pA@orome.fritz.box>
 <20210607185158.jweahkoa3cxwl2nh@pengutronix.de>
 <20210609204144.nkksqjovs2yqfiyo@pengutronix.de>
 <YMIPjGtYfby6ZXKl@orome.fritz.box>
 <20210621064745.v7ndjlybjav7ai6y@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njva6pmtarrgfmyi"
Content-Disposition: inline
In-Reply-To: <20210621064745.v7ndjlybjav7ai6y@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--njva6pmtarrgfmyi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Jun 21, 2021 at 08:47:45AM +0200, Uwe Kleine-K=F6nig wrote:
> On Thu, Jun 10, 2021 at 03:11:40PM +0200, Thierry Reding wrote:
> > Small fixes and cleanups are less likely to break things, so I'm going
> > to apply them after.
>=20
> I wonder what's the ideal delay for fixes and cleanups in your book.
> We're two weeks after merging that high-impact patch series and Linus
> just released -rc7.

I don't know Linus' release plan but after reading his -rc7 announcement
=66rom last weekend and looking what happend in his tree since then, I
wouldn't be surprised if he cuts v5.13 this weekend.  Even for small
fixes and cleanups I'd prefer to have them in next before the merge
window opens.

Also if you find an issue for a patch, it's quite demotivating to get
feedback when the merge window is already about to open because it's too
late then to discuss and rework. The devm_pwmchip_add patch is about to
miss its second merge window already ... :-\

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--njva6pmtarrgfmyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDVp/oACgkQwfwUeK3K
7AnS2gf/aneV5IGvEYopKfoURF0lxNext2R3pGtddDRR9p6CQEKHzUxppF/02AF/
1COwBPN+ej1S7h6WeBMoqWG4jAF07jVKxWuMJSR0KZY9YAWtIqA5U6VAAGo4Nseq
zy0otv46xWcdmwuSkSTNNzLglu5BRcgZz10qiHa4c0VEpeeOWlp3IsZ+n4Zg2t0/
NyG2Z2FMkvzp5drJ3CxPGLojLB8MHEhooXpjxnlV367rvpu2wvKWUgT9jFNOi7Wg
RT+jMqvf40sW9iR+t/nzF/0vFKWHYg+hA6FhxuRtlO+zYbbzu4nqoG0sDqS8qQQR
Sp2wDTgOVg0jzF9tvRic17/kyDWudw==
=qAZ2
-----END PGP SIGNATURE-----

--njva6pmtarrgfmyi--
