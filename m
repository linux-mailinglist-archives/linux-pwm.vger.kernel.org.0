Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348272D68F9
	for <lists+linux-pwm@lfdr.de>; Thu, 10 Dec 2020 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393054AbgLJUkO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 10 Dec 2020 15:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392781AbgLJUkO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 10 Dec 2020 15:40:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200FBC0613D3
        for <linux-pwm@vger.kernel.org>; Thu, 10 Dec 2020 12:39:34 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knSip-0003FW-15; Thu, 10 Dec 2020 21:39:31 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1knSin-0000yN-5z; Thu, 10 Dec 2020 21:39:29 +0100
Date:   Thu, 10 Dec 2020 21:39:26 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v4 1/4] pwm: pca9685: Switch to atomic API
Message-ID: <20201210203926.ouzrq3ff5k6zhlvt@pengutronix.de>
References: <X863KNo0IaekkU7q@workstation.tuxnet>
 <20201208091033.bxzrlad7mjbe3dsp@pengutronix.de>
 <X89RgpTb3sBBI++w@workstation.tuxnet>
 <X8+DI7ZN7mXtsxv9@ulmo>
 <CAGngYiXgVbEXj-yR=DTeA4pO-N3=WhiHjQhknFsbfXBeD_yRbw@mail.gmail.com>
 <X8+waLH58pOaMI06@ulmo>
 <20201208182637.hm5uzuw5ueelo26k@pengutronix.de>
 <X9EDGHySNYb7CxcW@ulmo>
 <20201210090124.rfswkrcttsg5gszp@pengutronix.de>
 <X9JWlVPb9ZGdB4q9@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6hqwfc7bua5ltiig"
Content-Disposition: inline
In-Reply-To: <X9JWlVPb9ZGdB4q9@ulmo>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6hqwfc7bua5ltiig
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Dec 10, 2020 at 06:10:45PM +0100, Thierry Reding wrote:
> Like I said, that's not what I was saying. I was merely saying that if
> there aren't any use-cases that current users rely on that would be
> broken by using this simpler implementation, then I'm okay with it, even
> if it's less flexible than a more complicated implementation. It should
> be possible to determine what the current users are by inspecting device
> trees present in the kernel. Anything outside the kernel isn't something
> we need to consider, as usual.

If "users in mainline" is the criteria that's a word.

So you agree we remove the following drivers?:

 - pwm-hibvt.c
   Last driver specific change in Feb 2019, no mainline user
 - pwm-sprd.c
   Last driver specific change in Aug 2019, no mainline user

Most PWMs are added to cpu.dtsi files with status =3D "disabled", I wonder
if it makes sense to check the machine.dts files if some of the PMWs are
completely unused. Do you consider status =3D "okay" a use that we have to
retain even if the node has no phandle?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6hqwfc7bua5ltiig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/Sh3oACgkQwfwUeK3K
7AmP8Qf9GxIYeSesTUkCn0UtSODfFJd48hbFBAeZx2uy1WaoXDh7LsV2VpFQRoE8
l27azqQkSmEbZBTsnJxKQl14/e9O/OgTRqQ5q/2lNPs2NLPbHEm3nqzvUQXkZOXu
OBZnVhlI4CuHUlBZTdNw5coBppk0p359sMi1IWkGfF0ZR+NHvYdZZSeZR2oUtPhc
MHvirb1POLfTTFMqoTnzO4oZYZuM0TPeejNlEvh0AnCZrR1OInEXt7kg0YJNL/cy
xQcjfyMRroLzJTa0E3V+EGv2HHKsY1PQ5HdnV8Iwik8T52K3sglprQZDCDh/d4MX
v6XmR9alAfAQjsEI0rd2tynXyybn+g==
=pUE3
-----END PGP SIGNATURE-----

--6hqwfc7bua5ltiig--
