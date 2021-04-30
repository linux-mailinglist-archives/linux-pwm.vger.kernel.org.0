Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B058136F5E8
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Apr 2021 08:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhD3Gtt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Apr 2021 02:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhD3Gtt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Apr 2021 02:49:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A325C06174A
        for <linux-pwm@vger.kernel.org>; Thu, 29 Apr 2021 23:49:01 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lcMxP-0006K5-Ir; Fri, 30 Apr 2021 08:48:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lcMxO-0007CK-M6; Fri, 30 Apr 2021 08:48:58 +0200
Date:   Fri, 30 Apr 2021 08:48:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: tiecap: Drop .free() callback
Message-ID: <20210430064858.dwyitrocrvxk3lgm@pengutronix.de>
References: <20210429133218.66971-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b6depw7fye6wnvhg"
Content-Disposition: inline
In-Reply-To: <20210429133218.66971-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--b6depw7fye6wnvhg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Apr 29, 2021 at 03:32:18PM +0200, Uwe Kleine-K=F6nig wrote:
> ecap_pwm_free is only called when a consumer releases the PWM (using
> pwm_put() or pwm_free()). The consumer is expected to disable the PWM
> before doing that. It's not clear if a warning about that is justified, b=
ut
> if it is this is independent of the actual driver and can better be done =
in
> the core. Also if there is a good reason it's wrong to disable the hardwa=
re
> and so the call to pm_runtime_put_sync() should be dropped. Moreover there
> is no matching pwm_runtime_get call and so the runtime usage counter might
> become negative.

For the record: The two people from TI (Vaibhav Bedia
<vaibhav.bedia@ti.com>, Avinash Philip <avinashphilip@ti.com>) I
addressed with that patch (because they were involved previously with
this driver) didn't receive my mail. The addresses don't exist according
to TI's mail server. I dropped them from To: for this reply.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b6depw7fye6wnvhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCLqFcACgkQwfwUeK3K
7AkJugf/TDgVRr3KvlHOfBmvfxbK22eYcCXMN2KJtS9UMMqZIcC1AfoshT3nz7BZ
kJCjD3P2WoABs4e/2KPozUEnzdOAbbMrnCgAUlQq95Xel6zOuu2xZDVhFte1Zw/X
CNb/y2/wItBR1Xp5IHIz2mbEqMcN9nV/L0c6L0Z7i4kSGlrDxc1x+/g6jn8rIInG
q56PwU7aOW/b0A+wBEabXGfF+rJ68Xke2U4WBnIRBNPC0OiAxS0xo86MQPFwlSQe
LDG0OseQHZVlFIbs076cvVEXvhM6c9mKktX0v7h8B2fvpNt8j4sn5xXjn14wGArf
SzS3A/hQREfMqTO6Iw7HHbM/EZ7xIw==
=J51X
-----END PGP SIGNATURE-----

--b6depw7fye6wnvhg--
