Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A28527E564
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Sep 2020 11:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgI3Jlt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Sep 2020 05:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3Jlt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Sep 2020 05:41:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C731C061755
        for <linux-pwm@vger.kernel.org>; Wed, 30 Sep 2020 02:41:49 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kNYcN-0003XC-IS; Wed, 30 Sep 2020 11:41:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kNYcM-0004kH-LT; Wed, 30 Sep 2020 11:41:46 +0200
Date:   Wed, 30 Sep 2020 11:41:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pwm: sysfs: Set class on pwm devices
Message-ID: <20200930094146.73s3qzvf5ekjeavc@pengutronix.de>
References: <20200929121953.2817843-1-poeschel@lemonage.de>
 <20200930065726.fjcsm4pfh65medgl@pengutronix.de>
 <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o3hdainfrilot7qp"
Content-Disposition: inline
In-Reply-To: <20200930092056.maz5biy2ugr6yc3p@lem-wkst-02.lemonage>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--o3hdainfrilot7qp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I added Greg Kroah-Hartman who I discussed this with via irc a bit to
Cc:.

On Wed, Sep 30, 2020 at 11:20:56AM +0200, Lars Poeschel wrote:
> thank you for your review!
>=20
> On Wed, Sep 30, 2020 at 08:57:26AM +0200, Uwe Kleine-K=F6nig wrote:
> > On Tue, Sep 29, 2020 at 02:19:53PM +0200, poeschel@lemonage.de wrote:
> > > From: Lars Poeschel <poeschel@lemonage.de>
> > >=20
> > > This adds a class to exported pwm devices.
> > > Exporting a pwm through sysfs did not yield udev events. The
> >=20
> > I wonder what is your use-case here. This for sure also has a place to
> > be mentioned in the commit log. I suspect there is a better way to
> > accomplish you way.
>=20
> Use-case is to be able to use a pwm from a non-root userspace process.
> I use udev rules to adjust permissions.

Hmm, how do you trigger the export? Without being aware of all the
details in the sysfs code I would expect that the exported stuff is
available instantly once the write used to export the PWM is completed.
So changing the permissions can be done directly after triggering the
export in the same process.

Out of interest: What do you use the pwm for? Isn't there a suitable
kernel driver that can do the required stuff? Compared to the kernel-API
the sysfs interface isn't atomic. Is this an annoyance?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--o3hdainfrilot7qp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl90UtcACgkQwfwUeK3K
7AmRZQf+KaTzPbBhN7fMCCPaf6pgb67liKkvJ0P6RHTGVGFfZZvJqBjvHCbWA50v
Dx/M83bka52mKmvhEJ36g65VnKltsFb80hLpoTMKsSWsrn6aRneuZ6nLJlXNYMVH
OCYqRXBT3HT2/FMEZaYGVwlHkQGremP+Ye3pmcMXAhg0A5c7U3Kvb+1EpmsPjK5T
lNiYbQFvvfbddSiI5EoyuJprZlDXxzDqIKlQpAagIGuQJKEDWcCI/IEe0Mow1PK0
c4kPY/GPsnd5wB789Rt8QLjnRfrjoPOhiZLiC/zz1Y8BxcwaLpUly+JvGYg2UPaY
l4mp3H0p0Xwn0TPvExFit/ay4xnm8w==
=rEDs
-----END PGP SIGNATURE-----

--o3hdainfrilot7qp--
