Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54035ADEE
	for <lists+linux-pwm@lfdr.de>; Sat, 10 Apr 2021 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbhDJODQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 10 Apr 2021 10:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbhDJODP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 10 Apr 2021 10:03:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C073C06138B
        for <linux-pwm@vger.kernel.org>; Sat, 10 Apr 2021 07:03:01 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVECR-0000IE-DQ; Sat, 10 Apr 2021 16:02:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVECQ-0008ND-RT; Sat, 10 Apr 2021 16:02:58 +0200
Date:   Sat, 10 Apr 2021 16:02:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Clemens Gruber <clemens.gruber@pqgruber.com>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 4/8] dt-bindings: pwm: Support new
 PWM_STAGGERING_ALLOWED flag
Message-ID: <20210410140258.aabqgpieooocznov@pengutronix.de>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210406164140.81423-4-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="et57x42kd5xy4kgt"
Content-Disposition: inline
In-Reply-To: <20210406164140.81423-4-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--et57x42kd5xy4kgt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Rob,

On Tue, Apr 06, 2021 at 06:41:36PM +0200, Clemens Gruber wrote:
> Add the flag and corresponding documentation for the new PWM staggering
> mode feature.
>=20
> Cc: Rob Herring <robh+dt@kernel.org>

For now reviewing this patch is not necessary, we're discussing a better
name for this flag.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--et57x42kd5xy4kgt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBxsA8ACgkQwfwUeK3K
7AnAIQgAiT7KRuBByp/Ex26JJTcMRAYOhSYXy4GO9MLFfhM0GZu6Cbq9RmTKpxIA
Bd2qVI3u8cemWP6i76JCtDPU9tv3FVgjDYRb+X34eoPIzyej/Ix/D1lijFK62cUS
PgmgtsSnyQIqNDmL3PsrxAr51N9hAZ3v/f62hkHyuIgFppnqM/PKH6YF/Oia6YbL
FY3NIirZdgcO7/BFqnZO/xL2nZxlyWwokzbJCCBIB29iWFwnwhRKC0Od82SLsAvw
rkVngz1PhBTp3c9v4fTDMSiePgXkgn+YaX8yWkSuZVyGg064718wvhGzkIazN9tf
QW8bDTyicCZdyXeJbtx1gL6+dYoFQQ==
=CF1D
-----END PGP SIGNATURE-----

--et57x42kd5xy4kgt--
