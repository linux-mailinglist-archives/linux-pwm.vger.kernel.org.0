Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003F53630ED
	for <lists+linux-pwm@lfdr.de>; Sat, 17 Apr 2021 17:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhDQPiA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 17 Apr 2021 11:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDQPh7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 17 Apr 2021 11:37:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A355C061574
        for <linux-pwm@vger.kernel.org>; Sat, 17 Apr 2021 08:37:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXn0k-0002O5-3p; Sat, 17 Apr 2021 17:37:30 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lXn0i-00061s-I3; Sat, 17 Apr 2021 17:37:28 +0200
Date:   Sat, 17 Apr 2021 17:37:28 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <20210417153728.eohhphmtm6qf26y4@pengutronix.de>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54aqtxtziy54ce7u"
Content-Disposition: inline
In-Reply-To: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--54aqtxtziy54ce7u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 12, 2021 at 03:27:38PM +0200, Clemens Gruber wrote:
> The switch to the atomic API goes hand in hand with a few fixes to
> previously experienced issues:
> - The duty cycle is no longer lost after disable/enable (previously the
>   OFF registers were cleared in disable and the user was required to
>   call config to restore the duty cycle settings)
> - If one sets a period resulting in the same prescale register value,
>   the sleep and write to the register is now skipped
> - Previously, only the full ON bit was toggled in GPIO mode (and full
>   OFF cleared if set to high), which could result in both full OFF and
>   full ON not being set and on=3D0, off=3D0, which is not allowed accordi=
ng
>   to the datasheet
> - The OFF registers were reset to 0 in probe, which could lead to the
>   forbidden on=3D0, off=3D0. Fixed by resetting to POR default (full OFF)

I didn't recheck all details, but the patch is definitively an
improvement, so:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--54aqtxtziy54ce7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmB7ALUACgkQwfwUeK3K
7AlVdggAoS7BHRyKl6WFJouJ75w3XjMgnOTjufwOF5iYwFx58DiepBgqt1jJKVrD
YXf0on8BN0vflcK9RkpUwZhRHz/FB9gOCv+9spRNreutxXl5v2QI3u+inQF5cnhb
xaR9owxjEso4FaVvWdeKzK9I6wM2b149CxYZ2hwOxD4dk+1LNGqZ1CRPcGSUc7TE
T/R2TDBa3UYEgzRmNawWj2wGp+VTHWdydwd1JpKG2q1tU/SasGvQkXucIhhXgxb6
eH47hHjhQaDhaVR+NHApJ08srwd2oZIU9y2wXS3ypshq2i6mu+9VcCkpHpqj2oYP
3loztBlWhwujp8bKZheuxAnoDf9Kwg==
=v9h2
-----END PGP SIGNATURE-----

--54aqtxtziy54ce7u--
