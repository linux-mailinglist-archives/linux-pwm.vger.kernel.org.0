Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83F440009
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhJ2QJY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 12:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2QJX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 12:09:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C32DC061570
        for <linux-pwm@vger.kernel.org>; Fri, 29 Oct 2021 09:06:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgUP3-00021D-I6; Fri, 29 Oct 2021 18:06:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgUP2-0006Bm-EL; Fri, 29 Oct 2021 18:06:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgUP2-0003oJ-DI; Fri, 29 Oct 2021 18:06:48 +0200
Date:   Fri, 29 Oct 2021 18:06:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     =?utf-8?Q?M=C3=A5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@axis.com
Subject: Re: [PATCH v3] pwm: pwm-samsung: Trigger manual update when
 disabling PWM
Message-ID: <20211029160644.vtaaxy2txszcjybn@pengutronix.de>
References: <20210909101042.17431-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q7kvriufgpq3ocbc"
Content-Disposition: inline
In-Reply-To: <20210909101042.17431-1-marten.lindahl@axis.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--q7kvriufgpq3ocbc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 09, 2021 at 12:10:42PM +0200, M=E5rten Lindahl wrote:
> When duty-cycle is at full level (100%), the TCNTn and TCMPn registers
> needs to be flushed in order to disable the signal. The PWM manual does
> not say anything about this, but states that only clearing the TCON
> auto-reload bit should be needed, and this seems to be true when the PWM
> duty-cycle is not at full level. This can be observed on an Axis
> ARTPEC-8, by running:
>=20
>   echo <period> > pwm/period
>   echo <period> > pwm/duty_cycle
>   echo 1 > pwm/enable
>   echo 0 > pwm/enable
>=20
> Since the TCNTn and TCMPn registers are activated when enabling the PWM
> (setting TCON auto-reload bit), and are not touched when disabling the
> PWM, the double buffered auto-reload function seems to be still active.
> Lowering duty-cycle, and restoring it again in between the enabling and
> disabling, makes the disable work since it triggers a reload of the
> TCNTn and TCMPn registers.
>=20
> Fix this by securing a reload of the TCNTn and TCMPn registers when
> disabling the PWM and having a full duty-cycle.
>=20
> Signed-off-by: M=E5rten Lindahl <marten.lindahl@axis.com>

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--q7kvriufgpq3ocbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF8HBEACgkQwfwUeK3K
7AnnFwf9FZQyiD0gWjYiiMAoL4zPazLDwCb3ZQ7RrNmFEFJLX3xtLbbKQZbc3/AF
2gSMFqHxUaAZ5UBE425qDtmQuzK5E7umFjZH+1cu2Eu9OmDzy5QPjYPWTf8U0ZkQ
tzLa+1ziXtVV2iEUTKsQ0H8EyT6ZiSTwe1uQJOXTcm3dc/TW0YUz4Bj9wuQNTI2G
MCYirj4midSHJwSYXRXLmze+N4OBZbWtGaYEW/d5c4xrCpO6C4WgWwsdszX9OH+8
Q0URE2uC61RR+45RYHK/HoYEA6DkGrq3AKxY6S3A7cS93WYtSWDICoG4GF/78m0y
2lsIVAMH7ieRPCJNqsI4iJoqb35ypQ==
=fANT
-----END PGP SIGNATURE-----

--q7kvriufgpq3ocbc--
