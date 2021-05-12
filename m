Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F8E37B518
	for <lists+linux-pwm@lfdr.de>; Wed, 12 May 2021 06:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhELEmy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 May 2021 00:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhELEmx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 May 2021 00:42:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA9C061574
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 21:41:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lgggk-0008Nm-Ch; Wed, 12 May 2021 06:41:38 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lgggf-00008N-Ep; Wed, 12 May 2021 06:41:33 +0200
Date:   Wed, 12 May 2021 06:41:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Roman Beranek <roman.beranek@prusa3d.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Subject: Re: [PATCH] pwm: sun4i: Avoid waiting until the next period
Message-ID: <20210512044133.6yfwyluzdx6yfh4c@pengutronix.de>
References: <20210511220014.1945519-1-roman.beranek@prusa3d.com>
 <CAO1O6seU7t==O=yCVBQK0iAkeEyO3dbRQ71obJh3Jm26xxWobw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="saayrskbwdpt2efe"
Content-Disposition: inline
In-Reply-To: <CAO1O6seU7t==O=yCVBQK0iAkeEyO3dbRQ71obJh3Jm26xxWobw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--saayrskbwdpt2efe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Emil,

On Wed, May 12, 2021 at 02:55:26AM +0200, Emil Lenngren wrote:
> Well that's one way of "solving it" ;)
>=20
> But on what hardware do you really need to wait until one full pulse
> cycle ends, before a disable command takes effect?
>=20
> On the hardware I've tested on (GR8 and V3s), it's enough to wait at
> most two clock cycles in order for it to take effect before we can
> close the gate. And with clock cycle I mean 24 MHz divided by the
> prescaler. With prescaler 1, that's 84 nanoseconds. By closing the
> gate when the pwm should be disabled, I guess we could save some
> nanoampere or microampere (is this important?)

If I understood correctly you really have to wait longer to achieve that
the output is inactive in the disabled state. Do you talk about the same
thing?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--saayrskbwdpt2efe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCbXHkACgkQwfwUeK3K
7Alk8gf+PoEyVuzpjQzz1SYXo6Tvw6FS4eBA8P/AXv6ecUg11n9QjfqsTxOUivq+
MTt6IkNEoR9jqgiWXfoYdyVmZpUt+NGSk/+LlJOih4NQfNQWTMP7bo4sVCC/Msal
Hp6RxqUF2HGQE8EwGSELnSAHRcznHulk7j6XDs+DZV4YaY3C/9KaNFhOxFCgiS3T
GFM+R0TOrKA3Z4iD8gMiX42jbsaci1zXqsQmwLWDGBZM7X/Jx1b2RC807QJ5V7w1
WvHQgeMmVpB3MTq7Hf87Rvz+nbDDPsQDS92dnd0EzzkW/sXtT6wmPpPVv3o7qJvy
gw10lVybXAwQVn56rbxSj6pEzyb7MA==
=1cnQ
-----END PGP SIGNATURE-----

--saayrskbwdpt2efe--
