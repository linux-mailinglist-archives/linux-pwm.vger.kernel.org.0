Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952FA26BBFE
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Sep 2020 07:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIPFyO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Sep 2020 01:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPFyO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 16 Sep 2020 01:54:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A790EC06174A
        for <linux-pwm@vger.kernel.org>; Tue, 15 Sep 2020 22:54:13 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kIQOO-0006zN-SI; Wed, 16 Sep 2020 07:54:08 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kIQOL-0000o7-MG; Wed, 16 Sep 2020 07:54:05 +0200
Date:   Wed, 16 Sep 2020 07:54:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pwm: convert to use DEFINE_SEQ_ATTRIBUTE macro
Message-ID: <20200916055405.woiqhxrzrk5ozpbi@pengutronix.de>
References: <20200916025028.3992887-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5xwzlqzcr2znjnib"
Content-Disposition: inline
In-Reply-To: <20200916025028.3992887-1-liushixin2@huawei.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5xwzlqzcr2znjnib
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2020 at 10:50:28AM +0800, Liu Shixin wrote:
> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Looks good. I didn't test but assume it compiles and works as before.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5xwzlqzcr2znjnib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl9hqHoACgkQwfwUeK3K
7An7mQf+IKY8DA6Q1/iCBgKvIhrh+WLMCqwdY1HhMof8ZB9oiFpVqswghNtN+B8e
KdDg7ZA4YSjyT+aCrjtt7jkxtU/f1xagud6kazfr7izhMglcfwRWFEjoXOxPQS+i
uNLnmyEHk3BtjEfR/fdu28vAme4iiiQAAA7EVp/6PUc8pvMoGZLWhAedhqzo9J/s
rGUzJZB8CZkNWH7xUJiUzFQAAE/76j42cYjsY3oDAzho5FYG1lM7fP8ecIAVzTP0
q82roR9RJJ3Hy5G3Z6yreJZxgVRFar8TJ+ovP8aV9iscasnesmQZ2DyAKAyVvzAD
0xV94x81vWsMU8KoSF6VuShwYavQ2Q==
=pW1Z
-----END PGP SIGNATURE-----

--5xwzlqzcr2znjnib--
