Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52CA2F47B1
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 10:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbhAMJgd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 04:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbhAMJgc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 04:36:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C3C061575
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jan 2021 01:35:52 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzcZD-0005eH-56; Wed, 13 Jan 2021 10:35:51 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kzcZC-0002IQ-Hi; Wed, 13 Jan 2021 10:35:50 +0100
Date:   Wed, 13 Jan 2021 10:35:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] misc: servo-pwm: driver for controlling servo motors via
 PWM
Message-ID: <20210113093546.5v7kbjoog64dfpij@pengutronix.de>
References: <20201222213342.2657026-1-angelo.compagnucci@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g4n5oyrpsiu5y5mt"
Content-Disposition: inline
In-Reply-To: <20201222213342.2657026-1-angelo.compagnucci@gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--g4n5oyrpsiu5y5mt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Cc +=3D gregkh]

On Tue, Dec 22, 2020 at 10:33:42PM +0100, Angelo Compagnucci wrote:
> +static int servo_pwm_probe(struct platform_device *pdev)
> +{
> [...]
> +	ret =3D devm_device_add_groups(&pdev->dev, servo_pwm_groups);

There are very little cases where calling this function is correct and
I think in the probe function of a platform driver it's always wrong.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--g4n5oyrpsiu5y5mt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl/+vu8ACgkQwfwUeK3K
7Ak+VAf/b2sOgGd10aCb7WVRTr28UQdC4BShes27wRwmKs4Dc7fiAb3BFlXryX5Q
LqGwlohSG5XSbpHY0KSRX+b6N6+8/WXU1hhn5iHOxbauWNFob9HdFwCqVE7jJFAQ
C63PRBpGgbdnvZgdlDBnc/QIuG3BvMOvRFwnw7UGnxV75IJGOIMDZxV8fOZouR0p
d7/S+rVhypJSx5OVTalCmt1b6pylIuy3Se51EwcJ3q1jk7kzFowHzlMsyqwvJklF
hqHay8cZrt4q8eM8szMvT9gQo/Wf83e2rKshGmYcPwqhAYNbKn1Yiqea/OpoziPo
MglBXbGZwVvFNsot5T72S6FLPc0K7A==
=pKyx
-----END PGP SIGNATURE-----

--g4n5oyrpsiu5y5mt--
