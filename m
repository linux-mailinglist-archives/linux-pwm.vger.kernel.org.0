Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035827C77B7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442670AbjJLUOJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 16:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442682AbjJLUOI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 16:14:08 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE9DBB
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 13:14:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qr24K-0000E0-Hf; Thu, 12 Oct 2023 22:14:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qr24J-001EXi-UT; Thu, 12 Oct 2023 22:14:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qr24J-00FBvu-LO; Thu, 12 Oct 2023 22:14:03 +0200
Date:   Thu, 12 Oct 2023 22:14:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2 027/109] pwm: sifive: Make use of parent device
 pointer in driver data
Message-ID: <20231012201403.s746dqtymniqa47t@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
 <20231012162827.1002444-138-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="piankgl35ib6hi6c"
Content-Disposition: inline
In-Reply-To: <20231012162827.1002444-138-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--piankgl35ib6hi6c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2023 at 06:28:55PM +0200, Uwe Kleine-K=F6nig wrote:
> struct pwm_chip::dev is about to change. To not have to touch this
> driver in the same commit as struct pwm_chip::dev, make use of the
> already existing pointer to the parent device in driver data.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

This one is wrong, this should also be of the type

	Make use of pwmchip_parent() macro

I'll fix this in my branch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--piankgl35ib6hi6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUoU4oACgkQj4D7WH0S
/k7O+Af/TiUZZmCypadiWQtVGbzQH5P3XLyma/mpP/ofxcOwOLwp2Ef4MsnYuhGk
BocD5fwhgpAM1qtf6Wvh8FT9/3C0aA6MWLJF0ZWNopWHKY6XKSZiDNyD7XSC7tjG
Rsd3YYwHVgFYiRMVNEpi+7SdKiGolPOemWDOLT/M2h9Oj7imOoJyvterWHmLXxBA
pX63FOGJvHLtrvd2iIhOHKvAOv6qObhVcqcADmX1uuMDMLSpSjPFZO0Vm6u5zViA
Ych0SX6GFcl1/NC00/QdbgQn4afXDh1DXWk9HSh+65dK9sQKwfz3+ons7B1J5Js8
oce+QXF7MUhT7PH8l889aFGPgUY38g==
=poa4
-----END PGP SIGNATURE-----

--piankgl35ib6hi6c--
