Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6812D440000
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Oct 2021 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhJ2QFl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Oct 2021 12:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2QFk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Oct 2021 12:05:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED7C061570
        for <linux-pwm@vger.kernel.org>; Fri, 29 Oct 2021 09:03:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgULU-0001XF-48; Fri, 29 Oct 2021 18:03:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgULS-0006B0-R7; Fri, 29 Oct 2021 18:03:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mgULS-0003nI-Q4; Fri, 29 Oct 2021 18:03:06 +0200
Date:   Fri, 29 Oct 2021 18:03:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Duc Nguyen <duc.nguyen.ub@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: tpu: Add R-Car V3U device tree bindings
Message-ID: <20211029160303.lv6je33mjr6zk7xh@pengutronix.de>
References: <8ec1e2aadfc894a3cc8c412e266b87220fa0404e.1635337616.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huylye2lgi4m6fcw"
Content-Disposition: inline
In-Reply-To: <8ec1e2aadfc894a3cc8c412e266b87220fa0404e.1635337616.git.geert+renesas@glider.be>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--huylye2lgi4m6fcw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 27, 2021 at 02:28:09PM +0200, Geert Uytterhoeven wrote:
> From: Duc Nguyen <duc.nguyen.ub@renesas.com>
>=20
> Add device tree bindings for TPU with the PWM controller found
> on R-Car V3U SoCs.
>=20
> Signed-off-by: Duc Nguyen <duc.nguyen.ub@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

=46rom PWM POV:

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--huylye2lgi4m6fcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF8GzQACgkQwfwUeK3K
7An7fQf8DFdybcvRxVh8XBIsxx+6d+5MzUKod0cQ0USNT23oy07go9t4QIF87SF0
Wc3+JW7Csy+HU4yE+FJ4DUT+PD0J47i/xEccNoCKVYH7Y1WYr0Dbbfxga2olbeiN
f/uzXvpENrLVwway31Lrved4JkAZypGZVpLYRQN/v2Gt/PE0sRQ9U2pTUrRiX787
FYwNxW2B3hIDzZp1sqvJl8i5ApuFZutCxegtamcxSWcXvDZZ7flFApBX/DREax7M
VFb5MNvfpqBevEWrnfP4rFVCoSKKRyoJFFyQ2m1FlwOxSlFf7WQ8ke4lSq4HoQQl
4abm+2hvVP0WLK7ebqa5q8gp+WTjVg==
=RkJf
-----END PGP SIGNATURE-----

--huylye2lgi4m6fcw--
