Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23D4329414
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 22:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243685AbhCAVqh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 16:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244170AbhCAVnK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Mar 2021 16:43:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A31C06178A
        for <linux-pwm@vger.kernel.org>; Mon,  1 Mar 2021 13:41:20 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGqI0-0002xf-66; Mon, 01 Mar 2021 22:41:16 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGqHz-0000eG-FC; Mon, 01 Mar 2021 22:41:15 +0100
Date:   Mon, 1 Mar 2021 22:41:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v5 1/7] pwm: pca9685: Switch to atomic API
Message-ID: <20210301214115.xolncig676tgnxwn@pengutronix.de>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
 <CAGngYiWbQ2STTgh2OwJTqQ-niBDbbn+OdMkk7PMzYnrZWzSy9Q@mail.gmail.com>
 <X9uL13GA1uDbLJiG@workstation.tuxnet>
 <CAGngYiW7vcJjz36xsBYx5n7=j1_5sE5a1AGpqC3Jj+tw0+FAXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6kszh3ywon4ute5k"
Content-Disposition: inline
In-Reply-To: <CAGngYiW7vcJjz36xsBYx5n7=j1_5sE5a1AGpqC3Jj+tw0+FAXQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6kszh3ywon4ute5k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2020 at 12:10:10PM -0500, Sven Van Asbroeck wrote:
> On Thu, Dec 17, 2020 at 11:48 AM Clemens Gruber
> <clemens.gruber@pqgruber.com> wrote:
> >
> > I can initialize the values to 0 of course and check the file for other
> > places with missing initializations.
> >
> > Or would it be better to check the return codes of regmap_read/write in
> > such cases? I'm not sure.
>=20
> I think that checking the regmap_read/write return values is overkill
> in this driver. These functions can't realistically fail, except if the i=
2c
> bus is bad, i.e. h/w failure or intermittency. And that's an externality
> which I believe we can ignore.
>=20
> Maybe Thierry or Uwe have further insights here.

I'm a fan of full checking, but I'm not sure what's Thierry's position
on that.

My reasoning is: If the bus is bad and a request to modify the PWM fails
because of that, the PWM consumer probably wants to know.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6kszh3ywon4ute5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmA9X3cACgkQwfwUeK3K
7AlrWAf+IoY5j0pCSD2uxjSOPPsQw0d+qZHf9gkrbmxtz5QZLAAB3pUMv1M0tk+r
XDR1LP0+paIQXGmhF+CN9aLc2yIxap9ClaV4EBRN5eYFFdCmrPKdTyjYB2bBSkE1
1BahYAP+7ROrC3LIa0Dsi/ezq6ImEn1+mkcro28rW5YNHCLAqDzTx0ZybyYdtAJs
t4N3md9wPyeJA4yC//K8ht9MnUu2vjCVMZL459C3H/Pu/RQCG1cDgNQVJhGv1auN
sGhJ0PsIZc2pP8LkjqwLzTvNRgRQyni2ER5G8srycf7M58/sbajvzbt/yEBSDYXj
EKcJocs9u3kDtRDA0Uxus2+o22lmMw==
=TcHV
-----END PGP SIGNATURE-----

--6kszh3ywon4ute5k--
