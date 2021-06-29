Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6803B6F89
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jun 2021 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhF2IlW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Jun 2021 04:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbhF2IlW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Jun 2021 04:41:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57458C061574
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jun 2021 01:38:55 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ly9Ge-0000KY-En; Tue, 29 Jun 2021 10:38:52 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ly9Gd-0004Fe-IF; Tue, 29 Jun 2021 10:38:51 +0200
Date:   Tue, 29 Jun 2021 10:38:51 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
Message-ID: <20210629083851.dsejopbe3pbgjer2@pengutronix.de>
References: <20210528214522.617435-1-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twcsnips74edkkg2"
Content-Disposition: inline
In-Reply-To: <20210528214522.617435-1-sean.anderson@seco.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--twcsnips74edkkg2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sean,

I wonder what tree you chose as a base here. I found tags/v5.13-rc1~44^2
as a tree that your patches can be applied to (and tags/v5.13-rc1~44 or
later doesn't work). I recommend using

	git format-patch --base ...

=2E This makes it easier for the responsible maintainers to pick the
right base and allows easier automatic testing.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--twcsnips74edkkg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDa3BcACgkQwfwUeK3K
7AlJowf/dNyTC7mU7OK5CaeXltx0/w38Sm6ieyqX98gYRz2FHFEZ5426HyjnHUe3
PnlLJSwWJL9dTJUyP4IsjLxMJhZFRzMSUnMOUQLSP1+pVUyhdgubCaLsF5X7aROo
9mmeaf5C8RC7zhXyUDJluqAL1tEbOKjsQnFeTG+t4mCpHi6MSIFb6F6nT+vEzCOO
fGNPYMnD17DzB+Cs990uTFHbK4X4Y8GQteRIqxP9BuUI0dPjAs4Ca2UEF9LrN0vm
aq+6YTbgKSLFEQOUULFJt69tsx0boFLS+YlmggAjwSLFUXnwYsrY2JUsX4IcsFis
6wCY4K65/h4cq1PN/SPYQzQsi3fvfg==
=7gCo
-----END PGP SIGNATURE-----

--twcsnips74edkkg2--
