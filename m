Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E0D39D4A6
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 08:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhFGGKZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 02:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhFGGKY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Jun 2021 02:10:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AA9C061766
        for <linux-pwm@vger.kernel.org>; Sun,  6 Jun 2021 23:08:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq8R2-0002CJ-Cl; Mon, 07 Jun 2021 08:08:28 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lq8R1-0001GK-Lo; Mon, 07 Jun 2021 08:08:27 +0200
Date:   Mon, 7 Jun 2021 08:08:27 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM
 state
Message-ID: <20210607060827.vxdihsfqtw3otyco@pengutronix.de>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
 <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
 <YJVhLrkeNXBp6M1p@workstation.tuxnet>
 <20210507231831.zmvyspcq7xhm25y4@pengutronix.de>
 <YLUK8GXHaBYyVe1R@workstation.tuxnet>
 <YLn3MZ+6HJM/UrRT@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lpegus2nl7jlnljt"
Content-Disposition: inline
In-Reply-To: <YLn3MZ+6HJM/UrRT@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--lpegus2nl7jlnljt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Fri, Jun 04, 2021 at 11:49:37AM +0200, Thierry Reding wrote:
> In the interest of making forward progress, I've applied this series.

I proposed a different approach that in contrast to usage_power:

 - is well defined
   (so driver authors and consumers know what to provide or expect resp.);
 - has good name people understand without reading documentation;
 - fully covers the problem Clemens want to address;
 - fully covers what the only implementing lowlevel driver does; and
 - is easy to implement based on the patches in this series

This is not what I call "forward progress". I take it personal that
after I pointed out technical shortcomings with this patch set and even
suggested a better concept, you didn't even made the effort to argue
but instead simply went on applying the patches.

Can you please point out what I'm missing?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lpegus2nl7jlnljt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmC9t9gACgkQwfwUeK3K
7AlykAf9E4vG8VzTUHHapQAZpZPmeJORzF/1HR538KgmDa2z7gXgUnTj+/NUt5lx
MZupuybXwOg1D/grpFsUe/BhP40VmxO2B2jL9uPpYkl2PVQnC+0Nsg43RI1grtej
0T/Wl7QLxcCHcZMFK4g7Ps+O4Wt5f30x6l/ORdpZMGyyFiNMB/lozde3Rl9vtIEl
1Ul70n0cO+aMj1u1EgPx1KsG1dIhh2LLC/SQgYFr0cfZOjuM5+oKOKokR6wEHDk7
5Fw2oA5mhHfvjs8omYYsyJgGJ04gHufYqfac73H40GXHHi75GS5le5uYtGH0OrVo
P/6r4bOaLd916u0tCqs8nwSR/CF9zw==
=qUgw
-----END PGP SIGNATURE-----

--lpegus2nl7jlnljt--
