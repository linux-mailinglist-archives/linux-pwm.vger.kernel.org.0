Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1173B4830
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jun 2021 19:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhFYR2C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Jun 2021 13:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFYR2B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Jun 2021 13:28:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5DDC061574
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jun 2021 10:25:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwpaA-0003PI-LO; Fri, 25 Jun 2021 19:25:34 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lwpa7-0005jr-Px; Fri, 25 Jun 2021 19:25:31 +0200
Date:   Fri, 25 Jun 2021 19:25:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Roman Beranek <roman.beranek@prusa3d.cz>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Emil Lenngren <emil.lenngren@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] pwm: sun4i: Avoid waiting until the next period
Message-ID: <20210625172531.ikrds7uxakuocn5h@pengutronix.de>
References: <YK0onNy2r30aNw2g@orome.fritz.box>
 <CBO0N2KNI5MJ.1KDTI8B2UE4SM@zen.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aszybtxybgdwzbnh"
Content-Disposition: inline
In-Reply-To: <CBO0N2KNI5MJ.1KDTI8B2UE4SM@zen.local>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--aszybtxybgdwzbnh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Roman,

On Thu, May 27, 2021 at 02:10:35PM +0200, Roman Beranek wrote:
> On Tue May 25, 2021 at 6:41 PM CEST, Thierry Reding wrote:
> > I'm pretty sure Alexandre at the time reported that the instantiation of
> > the controller that he was using required waiting for the period to
> > complete before the output went to the disabled state. It's possible
> > that this was changed in subsequent versions of the IP, so perhaps we
> > need to distinguish based on compatible string?
>=20
> I've got myself an A10 (sun4i) board to test my new patchset with and
> indeed the 2 cycles seem to be enough.
>=20
> I have yet to write a cover letter for it though, expect it by Monday
> at the latest.

You didn't send an update here (or did I miss it?). Still I think it's
correct that the patch we're discussion here is not suiteable to be
merged as is and so I marked the patch as "Changes Requested" in
patchwork. Please speak up if you think that's wrong.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--aszybtxybgdwzbnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDWEYgACgkQwfwUeK3K
7AnQdwf/cYHxrf6a1yeNbbW6hlzhmy3+ZAsCa+x6yEaptTPkGzoIbqnqaTE5eyZI
E5xXOZNNziQWUvzLTBJaLZGwosWseS1jOobZBI0Wd1aUNlu4yrqboDQhABETndaP
ctabD9InS3TZ1WbqhrFlv88sU1d7BDoVqLmuvu1Ux1pW/bt37PI00OgZMp79V8xQ
bry5iYMg3LB58fgxcfpgqrqFM+fZE0tOojJoGirYO56BNCmUaJzQ396QRbZDVa7k
TZUtNRB4UqcEGjQnKBaKyQKZgRFUzrp3yrLrM7MCmSNgm/YWE6pz//lqKuMU+yDs
ibuTgf0dNO43+I18syaJZzWLkixXfQ==
=RU6q
-----END PGP SIGNATURE-----

--aszybtxybgdwzbnh--
