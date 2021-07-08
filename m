Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28A3C1A9A
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jul 2021 22:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhGHUjo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 8 Jul 2021 16:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhGHUjk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 8 Jul 2021 16:39:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404EBC061760
        for <linux-pwm@vger.kernel.org>; Thu,  8 Jul 2021 13:36:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1alU-0003h7-Iw; Thu, 08 Jul 2021 22:36:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1alT-0003Qf-ML; Thu, 08 Jul 2021 22:36:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1alT-0000MA-LE; Thu, 08 Jul 2021 22:36:55 +0200
Date:   Thu, 8 Jul 2021 22:36:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Baolin Wang <baolin.wang@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>, kernel@pengutronix.de,
        Orson Zhai <orsonzhai@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/5] pwm: Ensure configuring period and duty_cycle isn't
 wrongly skipped
Message-ID: <20210708203655.ry46r6eqo7lcuxx5@pengutronix.de>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
 <20210708123639.vrck33kc534yrnsq@pengutronix.de>
 <YOcGkoQ4jb0G92Iz@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ri7hhnmmtdbv6tdw"
Content-Disposition: inline
In-Reply-To: <YOcGkoQ4jb0G92Iz@orome.fritz.box>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ri7hhnmmtdbv6tdw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

On Thu, Jul 08, 2021 at 04:07:14PM +0200, Thierry Reding wrote:
> On Thu, Jul 08, 2021 at 02:36:39PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Jul 01, 2021 at 10:27:50AM +0200, Uwe Kleine-K=F6nig wrote:
> > > Geert Uytterhoeven found a regression in one of my patches. The same
> > > problem exists in several further commits. The respective drivers are
> > > fixed in this series.
> > >=20
> > > The affected commits for the first patch is already in v5.4, so this
> > > patch should maybe backported to stable.
> > > The others are in Thierry's for-next branch only.
> >=20
> > These four broken patches were now included in your pull request to
> > Linus for v5.14-rc1 but these fixes were not. I wonder that the
> > regression Geert reported made you back out the offending commit but you
> > didn't care for the four identical problems in pwm-spear, pwm-tiecap,
> > pwm-berlin and pwm-ep93xx. Did you miss this series?
>=20
> Ugh... this is a nice big mess now. In retrospect I should've just
> backed out all those patches. Or rather not have applied them in the
> first place until they got a Tested-by.

Agreed, this isn't as optimal as it could have been. My conclusions are
a bit different though. I took the time to look at the details for these
changes:

 - 2021-04-11
   I sent "pwm: Ensure for legacy drivers that pwm->state stays
   consistent" to the linux-pwm list.

 - 2021-06-27
   The merge window for 5.14 opened

 - 2021-06-28
   You applied the patch, it then appeared in next-20210629 for the
   first time in next.

 - 2021-06-29
   Geert reported the regression

 - 2021-06-30
   You dropped the commit.

 - 2021-07-01
   I sent a fixed patch and incremental fixes for the same problems in
   the other drivers.

 - 2021-07-08
   Thierry sent a pull request containing the four broken (and unfixed)
   commits.

For me the conclusions here are:

 - Patches on the mailing list are not widely tested
   (So I think waiting for Tested-bys isn't a pragmatic option unless
   maybe we start adding more people to MAINTAINERS.)

 - Changes in next get (some) testing.

And so I think changes should be put into next earlier than it was the
case in this release cycle and it might be beneficial to check for
unapplied fixes before sending out a PR. Feel free to communicate with
me before sending the next PR if there is something on my radar that is
missing in your for-next branch.

> I'll pull in this series and will send this as a follow-up pull request.

Great.

Uwe



--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ri7hhnmmtdbv6tdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDnYd4ACgkQwfwUeK3K
7AmKBQf/ZuukXQgNXTLpPZ/H42gLz6+oiSJ6vXVZunoJ49hb8rUz2Th+hZt4RZsj
oAdBYw79F2UAT+b7OrGLuVMnVD8vJZNq3yZEeOSlduZaYGsMrddvneponcCwHbYd
urmWcjabJszg1+Vm+qJpYsJy/QUfZH6PThKJ6rEknai+WzRL4orwlsXJUcjyIn5S
y0Uks2RNGjmP1tHxWtpT2O+deOaC3RbsgXv2Vj5o/O+bz7Cmm1KLfmmP5BoOT80d
3GKv6SDLP9/tT4hJYLpbGYx8VrbtSeuK7iPvxsveOy8poVhIiEMncIqDzzLyYAif
Oj2RN+QyVGZjjRncBF5jnBpnhyvXaw==
=gvoK
-----END PGP SIGNATURE-----

--ri7hhnmmtdbv6tdw--
