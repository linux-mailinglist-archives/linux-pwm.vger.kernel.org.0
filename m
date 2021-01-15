Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC082F744A
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Jan 2021 09:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbhAOI3K (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Jan 2021 03:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbhAOI3K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 15 Jan 2021 03:29:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250A7C061575
        for <linux-pwm@vger.kernel.org>; Fri, 15 Jan 2021 00:28:30 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0KT4-00040t-Dd; Fri, 15 Jan 2021 09:28:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0KT3-0004r3-G2; Fri, 15 Jan 2021 09:28:25 +0100
Date:   Fri, 15 Jan 2021 09:28:25 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: add a config symbol for legacy drivers
Message-ID: <20210115082825.3e3kahhxfuxstttb@pengutronix.de>
References: <20200613155742.31528-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zp46fca5mcu55o5s"
Content-Disposition: inline
In-Reply-To: <20200613155742.31528-1-uwe@kleine-koenig.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--zp46fca5mcu55o5s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Jun 13, 2020 at 05:57:42PM +0200, Uwe Kleine-K=F6nig wrote:
> This (slightly) simplifies the core, reduces the size of the pwm_ops
> struct, and makes it more obvious for driver authors to not add new drive=
rs
> relying on the old set of callbacks.

I didn't get feedback for this patch. Even in the presence of PWM_DEBUG
I consider it worthwhile, mainly for the last reason stated in the
commit log.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zp46fca5mcu55o5s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmABUiYACgkQwfwUeK3K
7AkzEwgAlpZ8QV/AiDgpfHrL6762Idq8lln70sofPOdf8oaCXryIXhrcsF0yKyR7
AgCgQYqc/gtFpjNIBm7a1hoZMzn/ojNFq2pEHMEcCx3s7Lspt8nVLXJ9+/HlzvFK
WAAPezxKUKUBt6psj7cbq8fBVm4nDvh3UOhzPVbiFejETiISNoaQgIXevNn9auY/
e/nxl15yWeWTX5QW2QHtEtqLE0V0FW6D6PN6u5/07hRMoH2Qnjd3QE5hCIs9TJpL
4FBNu7nSKfiublr33tjEZfTYm17652BnfvCjLk1o8FlKEQ3r4GbpCAfsCFiDAKSR
iNlC0AspNokN4fvl2PQtCw4Dbk50gw==
=VZhN
-----END PGP SIGNATURE-----

--zp46fca5mcu55o5s--
