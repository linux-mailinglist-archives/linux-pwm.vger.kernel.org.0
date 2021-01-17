Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA86B2F9258
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Jan 2021 13:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbhAQMfq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Jan 2021 07:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbhAQMfX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 Jan 2021 07:35:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057FFC061573
        for <linux-pwm@vger.kernel.org>; Sun, 17 Jan 2021 04:34:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l17GT-0006Bg-Bn; Sun, 17 Jan 2021 13:34:41 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l17GS-0003nB-MC; Sun, 17 Jan 2021 13:34:40 +0100
Date:   Sun, 17 Jan 2021 13:34:40 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nicola Di Lieto <nicola.dilieto@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/2] pwm: pwm-gpio: Add DT bindings
Message-ID: <20210117123440.6ziqtrjodf7ahx7w@pengutronix.de>
References: <20201209072842.amvpwe37zvfmve3g@pengutronix.de>
 <20201211170432.6113-1-nicola.dilieto@gmail.com>
 <20201211170432.6113-3-nicola.dilieto@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jlpew4ituyqacppy"
Content-Disposition: inline
In-Reply-To: <20201211170432.6113-3-nicola.dilieto@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--jlpew4ituyqacppy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Dec 11, 2020 at 06:04:32PM +0100, Nicola Di Lieto wrote:
> Added Documentation/devicetree/bindings/pwm/pwm-gpio.yaml

this looks fine to me, but this patch should be sent to the dt mailing
list (devicetree@vger.kernel.org) to catch the attention of the people
who have to Ack it.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jlpew4ituyqacppy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmAELt0ACgkQwfwUeK3K
7AnRjAgAiLO2U/nwHglcEd7QYAmwvnL3x9/DjbDCr0fEpEp8ESk2PyNzaRz8UsIL
felzhmugx6v+zls9F0I+xsiRnM7ASqpIm05h6/nd9JMziRud7q4nysXoLj6Q2Yl4
0S3bru/xKG4RJmpgMFB0SVpB4nsgfxMIJ8yUtoGyrVBSebH5fb+wWUusHlpmqtdn
CLv8SzMLTCi7V6o8xSD4kGvhDgTgRbDTWvE0bQbphgyOXPhaIj8JACKIVuAyRret
FFJTvdMAH5sBIYu4LCFvjvnrmDZNlF+KC176HoOVssaFd4MH9z6VCuMkuRsRg/8c
wBnJJlRsQLEBDG6cmRPSVN5uDCUmTw==
=mOml
-----END PGP SIGNATURE-----

--jlpew4ituyqacppy--
