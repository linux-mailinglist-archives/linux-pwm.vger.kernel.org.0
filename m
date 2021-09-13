Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209C5408623
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Sep 2021 10:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbhIMINA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 13 Sep 2021 04:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbhIMIM7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 13 Sep 2021 04:12:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF4DC061574
        for <linux-pwm@vger.kernel.org>; Mon, 13 Sep 2021 01:11:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mPh42-0005hp-3Q; Mon, 13 Sep 2021 10:11:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mPh41-00009i-4o; Mon, 13 Sep 2021 10:11:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mPh41-0002Ic-3h; Mon, 13 Sep 2021 10:11:41 +0200
Date:   Mon, 13 Sep 2021 10:11:35 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     zhaoxiao <long870912@gmail.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: visconti: Simplify using devm_pwmchip_add()
Message-ID: <20210913081135.u4m34k3ktmkln5gx@pengutronix.de>
References: <20210913061553.21450-1-long870912@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m4o7mwcv7sqon6jo"
Content-Disposition: inline
In-Reply-To: <20210913061553.21450-1-long870912@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--m4o7mwcv7sqon6jo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2021 at 02:15:53PM +0800, zhaoxiao wrote:
> This allows to drop the platform_driver's remove function. This is the
> only user of driver data so this can go away, too.
>=20
> Signed-off-by: zhaoxiao <long870912@gmail.com>

Oh, it seems I missed that one when I converted the PWM drivers to use
devm_pwmchip_add(). Probably because the driver is new and wasn't in my
tree when I started the conversion. Thanks

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--m4o7mwcv7sqon6jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE/B7QACgkQwfwUeK3K
7Amb9Qf+NmYIv7QiSQKAPQGDKIFu22A5BTfjfDw8PuQ/Fofg+olbuq+dKRMjxbAa
WVNpwvNqV+3hpHJb+7zjkyi8JxqkPt2qnBAHK1zWN11JQi2VHoIeP6CSw0m79bxd
EMmfzy+jd90ozFErjXdxCjPaJE0SrYCycQSUpcNx9wouXrrA7EFb+jN2iI5Siuq2
MEwQ5aYHw6CsY9Axcazd50TjzLhpCTJJ1p8x0ECu29zEYX2NjBfG0tdog8RSZgJe
eelmaxiLwheJdevyAX1qwhiCgyiPLMIItMUaMhNtBO/eyALcMNx5/7p09OKoG3qW
fkosIpEUKGLg2nxokaMg2Dv5VkDJ5A==
=Zv1U
-----END PGP SIGNATURE-----

--m4o7mwcv7sqon6jo--
