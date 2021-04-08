Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9810B358103
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Apr 2021 12:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhDHKoN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Apr 2021 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhDHKoJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Apr 2021 06:44:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF2C061760
        for <linux-pwm@vger.kernel.org>; Thu,  8 Apr 2021 03:43:57 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUS8h-00051r-Ls; Thu, 08 Apr 2021 12:43:55 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lUS8g-00084V-QV; Thu, 08 Apr 2021 12:43:54 +0200
Date:   Thu, 8 Apr 2021 12:43:54 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 00/14] pwm: Patches I consider ready for the next merge
 window
Message-ID: <20210408104354.het4ub5iazdbtr6l@pengutronix.de>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
 <YFia9Q4lLIlKdEmf@orome.fritz.box>
 <20210323071929.GD2916463@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n4qojyqq33lcjof7"
Content-Disposition: inline
In-Reply-To: <20210323071929.GD2916463@dell>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--n4qojyqq33lcjof7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry, hello Lee,

On Tue, Mar 23, 2021 at 07:19:29AM +0000, Lee Jones wrote:
> Since some of Uwe's patches had been left unreviewed for several
> weeks

We're nearly there again. There are currently 30 open patches in
patchwork:

 - There is the pca9685 series by Clemens Gruber. Some of the patches
   are already marked as changes-requested, but the newly proposed
   staggering-allowed stuff could get some attention by one of you. I'm
   a bit ambivalent as I wrote in my reply. I don't feel competent to
   comment the runtime PM stuff (patch 1).

 - A series to convert the rockchip dt binding to yaml, here I'd wait
   for Heiko St=FCbner to comment. I didn't look in detail but didn't spot
   anything obvious to criticise.

 - In sum 21 patches by me, some got an Ack by the respective driver
   maintainers, some are already >2 weeks on the list. Most of them
   didn't get any attention by you.

:-\
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n4qojyqq33lcjof7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBu3mYACgkQwfwUeK3K
7AkD+Af8DxR+fq6wputYL/kwMTqB7PZXTCT6++w+XOUCgtNNoBa3esGJqq0PyEC3
1qkbSEFS0FlPlsHfabYC8frytNq6p8n3l3Wue+6+ciQWu4wdYbaPlv38Jham2JzA
l0jgw/cOrSjqvWhb7DRf2mhHZdlbQ8GnqfiO1CvnxBS0wDqkKeRHdzclmHOkiHiZ
CebyiqG4q5WB33vxl3uBBPFk0IZc96Bub5L2oFKSsWUkU/UtRyfETq2Uy0t+irSr
QuauhKPTTAO8mUXPo1sRlU5Z9Fzepb/gQQ2e1t+EstayVUh2ateZecV+JccuzCWW
6Y8Ki5QAcYCtpIftyniZf2rjIqXntw==
=lJXL
-----END PGP SIGNATURE-----

--n4qojyqq33lcjof7--
