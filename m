Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D94544083B
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Oct 2021 11:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhJ3JaN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Oct 2021 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhJ3JaM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Oct 2021 05:30:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245BC061570
        for <linux-pwm@vger.kernel.org>; Sat, 30 Oct 2021 02:27:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgkeJ-0008RA-Kh; Sat, 30 Oct 2021 11:27:39 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgkeI-00087r-Od; Sat, 30 Oct 2021 11:27:38 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgkeI-0007Py-Nb; Sat, 30 Oct 2021 11:27:38 +0200
Date:   Sat, 30 Oct 2021 11:27:36 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 1/3] pwm: Introduce single-PWM of_xlate function
Message-ID: <20211030092736.eam4ahzimiew7erg@pengutronix.de>
References: <20211025170925.3096444-1-bjorn.andersson@linaro.org>
 <65243a98-61b9-3311-f41d-fa4782448baa@kali.org>
 <CAG3jFytmcFcA5W3vmcpWTWrc36-YFMPZ1wAB8gAJfiHHLWmaCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cwmpryyacyfxuvhj"
Content-Disposition: inline
In-Reply-To: <CAG3jFytmcFcA5W3vmcpWTWrc36-YFMPZ1wAB8gAJfiHHLWmaCA@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--cwmpryyacyfxuvhj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 27, 2021 at 05:06:02PM +0200, Robert Foss wrote:
> On Tue, 26 Oct 2021 at 19:21, Steev Klimaszewski <steev@kali.org> wrote:
> >
> >
> > On 10/25/21 12:09 PM, Bjorn Andersson wrote:
> > > The existing pxa driver and the upcoming addition of PWM support in t=
he
> > > TI sn565dsi86 DSI/eDP bridge driver both has a single PWM channel and
> > > thereby a need for a of_xlate function with the period as its single
> > > argument.
> > >
> > > Introduce a common helper function in the core that can be used as
> > > of_xlate by such drivers and migrate the pxa driver to use this.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Tested-by: Steev Klimaszewski <steev@kali.org>
> > > ---
> > >
> [...]
>=20
> Applied to drm-misc-next.

This is now 3ab7b6ac5d829e60c3b89d415811ff1c9f358c8e in next, the Link:
added in the commit trailer looks as follows:

	Link: https://patchwork.freedesktop.org/patch/msgid/20211025170925.3096444=
-1-bjorn.andersson@linaro.org

but this link doesn't work, for me at least. I wonder what's wrong with
it. If you want to fix it and rewrite the commit, you can also drop the
duplicated "Tested-by: Steev Klimaszewski <steev@kali.org>".

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cwmpryyacyfxuvhj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF9EAQACgkQwfwUeK3K
7AkmVwf/UC0/COH40s3PAmZkJX3EzO2LlqeXFJDYvZZX4T58leO83achdFzOWtXi
F9kK3WlNNmggZ32zqDHV1HOE42tnn1wLXc7xqevjiIYWzRrHAlW5bXcRQT1ndDjo
Tiloo0fTBsi24lmuvWeWPVifk77ZMY4eB/dVovyDilTgvuxo9hf55URQTgnSpD8o
DVToFokj6ckIESylQgJXCKxiM8vqFSIYQFXSqLFDW/FVYDmA9eVlAeme0bjeHv6p
3mWJ+rC2A7dNz65qYqPvqM02uy0+2o1tMJ3G/n+idjv16M8areb0Owvh47r1q7/O
H4TZl0wjy5y8SbZ2l1lo8EaWkVE6pA==
=KqMO
-----END PGP SIGNATURE-----

--cwmpryyacyfxuvhj--
