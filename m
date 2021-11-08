Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB39F44800C
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Nov 2021 14:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbhKHNLg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Nov 2021 08:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbhKHNLe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Nov 2021 08:11:34 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D5C061570
        for <linux-pwm@vger.kernel.org>; Mon,  8 Nov 2021 05:08:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4OF-0008EQ-D9; Mon, 08 Nov 2021 14:08:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4OD-00065I-Ma; Mon, 08 Nov 2021 14:08:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mk4OD-0002ap-Lc; Mon, 08 Nov 2021 14:08:45 +0100
Date:   Mon, 8 Nov 2021 14:08:43 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jisheng Zhang <jszhang@marvell.com>, linux-pwm@vger.kernel.org,
        Thomas Hebb <tommyhebb@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, kernel@pengutronix.de
Subject: Re: [PATCH 2/4] pwm: berlin: Put channel config into driver data
Message-ID: <20211108130843.zcug25uy4ubijdcu@pengutronix.de>
References: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
 <20210504132537.62072-2-u.kleine-koenig@pengutronix.de>
 <YYkThshvvjq06KNU@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fqv6mikvqhpwv4fc"
Content-Disposition: inline
In-Reply-To: <YYkThshvvjq06KNU@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--fqv6mikvqhpwv4fc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 08, 2021 at 01:09:42PM +0100, Thierry Reding wrote:
> On Tue, May 04, 2021 at 03:25:35PM +0200, Uwe Kleine-K=F6nig wrote:
> > Instead of allocating extra data in .request() provide the needed memory
> > in struct berlin_pwm_chip. This reduces the number of allocations. A si=
de
> > effect is that on suspend and resume the state for all four channels is
> > always saved and restored. This is easier (and probably quicker) than
> > looking up the matching pwm_device and checking its PWMF_REQUESTED bit.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-berlin.c | 37 ++++++-------------------------------
> >  1 file changed, 6 insertions(+), 31 deletions(-)
>=20
> This doesn't look like a worthwhile change to me. The per-PWM channel
> data was originally introduced to support exactly this type of use-case,
> so I don't see why we shouldn't keep using it here.

My reasons to not use the per-channel data are:

 - up to 5 smaller mallocs instead of a single bigger one. A single
   allocation is more effective (AFAIK) regarding memory management
   overhead, memory management overhead, and cache locality

 - bad naming, this isn't per-chip data as the function name
   "pwm_set_chip_data" suggests, but per-channel ("pwm"?) data.

 - maybe subjectively the data model is easier to understand if all
   required data (clk, channel state etc) is in a single data structure

 - With an arm allmodconfig bloat-o-meter reports for my patch:

	add/remove: 0/2 grow/shrink: 0/2 up/down: 0/-376 (-376)
	Function                                     old     new   delta
	berlin_pwm_free                               44       -     -44
	berlin_pwm_suspend                           364     256    -108
	berlin_pwm_resume                            444     332    -112
	berlin_pwm_request                           112       -    -112
	Total: Before=3D3712, After=3D3336, chg -10.13%

   So code size (and probably also run time) is improved.

If "back then we considered per-channel data a good idea, so let's use
it" is really your best argument to keep the code as is, I ask you to
reconsider that.

I checked the other drivers that make use of pwm_set_chip_data, and some
of them have a really strange usage pattern. Will prepare patches for
these and let you judge if these are worthwile.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fqv6mikvqhpwv4fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGJIVgACgkQwfwUeK3K
7AkB9Qf/Vo5FCB9O0bZKPO1ht9cG8JfNdQ1bQYGwroq3OUTjew8VpTG9/vsyDuDf
9ZYrTDVljKzOysYTtQvy4Gv1cZk9nI58Qf+9OGzr4VxKD3OOFoLUtQgQnZtEIzLc
U5duS33KC3s9vA3b6/GBK6htF0zYeVdt2Az04649XcLytQq02Bth37+vDJOrIXRZ
ylgF1mVAg+yWKBMRpZsH/zsaTDPKkTOSgslTN/SIGZ/38NKx2GeC5IR5y8EWpVk8
ajzaluq0E9U/eBaYDTYHVZ7KuQyamISlxbGwZUEzdOTXaBvc4T9JGSb/UI9O8+NJ
fNpxwQ91j3imX1bz+gtKOckDGprcIQ==
=iwEV
-----END PGP SIGNATURE-----

--fqv6mikvqhpwv4fc--
