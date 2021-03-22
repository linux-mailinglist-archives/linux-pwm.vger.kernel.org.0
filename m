Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601FD34466B
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 15:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCVOBe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCVOAv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 10:00:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2FC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 07:00:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOL6u-0000uu-5A; Mon, 22 Mar 2021 15:00:48 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lOL6t-0005A1-Om; Mon, 22 Mar 2021 15:00:47 +0100
Date:   Mon, 22 Mar 2021 15:00:47 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH 00/14] pwm: Patches I consider ready for the next merge
 window
Message-ID: <20210322140047.26txw6mmgrdljj2h@pengutronix.de>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
 <YFia9Q4lLIlKdEmf@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iyepj4cznmkxevfo"
Content-Disposition: inline
In-Reply-To: <YFia9Q4lLIlKdEmf@orome.fritz.box>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--iyepj4cznmkxevfo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Mon, Mar 22, 2021 at 02:26:13PM +0100, Thierry Reding wrote:
> On Fri, Mar 19, 2021 at 11:28:38AM +0100, Uwe Kleine-K=F6nig wrote:
> > this is the set of patches that are open on the list for some time.
> > Lee suggested to resend them.
> >=20
> > @Thierry: I'm unsure what is the best way to nag. Is it really
> > resending? Or does this just result mostly in overhead because the
> > patches are still open in patchwork and it adds copies to your mailbox?
> > (Another downside is that taking the patches from this thread results in
> > recording a newer Author Date compared to picking up the originals.)
>=20
> I use patchwork extensively for tracking, so merely resending patches so
> that they float to the top of my inbox isn't useful in itself. Patches
> do, by the way, float to the top of my inbox when you just reply to them
> (e.g. by pinging). Resending a particular series is fine because it's
> then easy to mark the old version as "superseded". Sending a collection
> of patch such as this is a bit more annoying because now the duplicates
> are spread about a bit more in patchwork, so it's a bit more work to get
> patchwork cleaned up. But it's not that bad, so no harm done.
>=20
> Usually when I look at patchwork I will look at the A/F/R/T column and
> the more flags I see there, the more likely I will be to go and apply
> it. Anything else I will go and look at myself and comment and/or apply
> or sometimes wait for someone else to review.
>=20
> Perhaps a better way to nag me would be to delegate patches that you've
> reviewed or think are ready to me, which would make them stand out more
> among the others.

ok, so my doubts were justified. I'll try the delegation idea next time
:-)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--iyepj4cznmkxevfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBYowwACgkQwfwUeK3K
7AlUXQf+KDqZXOqiL3lwky9cAZmzQdxsNm87lwhsFIUm4bwL2JXFQ6mOAtxw66ts
/wBjlttO14M4sP6BNp9voGL87oQ9aeGD294jCsI1tJNHkw3F4QczCd13o5P+Vfs7
JMOHikdy2UaP4kOyRgixIwhomh50R0vKcnxTtghDLuATbvWSjTtO5C1k70Ih+5fy
+jFzTWyvewuPF1Qz0y3ha7Vnko+NXxfyfMNKsqsZHlVI7N0Flhc/DLPrRIpGpFGK
vbqJbLZ3lY5rLQXftWi0hsojcVmQfnYhTvaFaePO+8FyxL3Ctxq0rpC6CXjJRjsa
Qh+y+leyTaL9kWNJZNgjvHiu10lpOg==
=zJD8
-----END PGP SIGNATURE-----

--iyepj4cznmkxevfo--
