Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A192F7D6ADA
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Oct 2023 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjJYMIp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 25 Oct 2023 08:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjJYMIp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 25 Oct 2023 08:08:45 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC4B12A
        for <linux-pwm@vger.kernel.org>; Wed, 25 Oct 2023 05:08:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvcgj-0001sB-3b; Wed, 25 Oct 2023 14:08:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvcgi-004AlC-Ib; Wed, 25 Oct 2023 14:08:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qvcgi-005wyH-9Z; Wed, 25 Oct 2023 14:08:40 +0200
Date:   Wed, 25 Oct 2023 14:08:40 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 2/2] pwm: Fix double shift bug
Message-ID: <20231025120840.fowsdkkfbig4rfjo@pengutronix.de>
References: <e031db45-add0-4da7-97fa-dee95ee936ad@moroto.mountain>
 <447a8e49-ee37-4fde-bc4a-ebec3e37a311@moroto.mountain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xxdjgjw3tjdsdt6b"
Content-Disposition: inline
In-Reply-To: <447a8e49-ee37-4fde-bc4a-ebec3e37a311@moroto.mountain>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xxdjgjw3tjdsdt6b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 02:58:18PM +0300, Dan Carpenter wrote:
> These enums are passed to set/test_bit().  The set/test_bit() functions
> take a bit number instead of a shifted value.  Passing a shifted value
> is a double shift bug like doing BIT(BIT(1)).  The double shift bug
> doesn't cause a problem here because we are only checking 0 and 1 but
> if the value was 5 or above then it can lead to a buffer overflow.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2:  White space change.  Split the patch into two parts
>=20
> I didn't put a Fixes tag because it doesn't affect run time

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards and thanks!
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xxdjgjw3tjdsdt6b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU5BUcACgkQj4D7WH0S
/k5ItggAnDwB2il2EA16HJ6v/5bbpaqCk3WkVUbHRIzQdaA25FJ1hQGhRfy8GRvv
EYBG2KhwUqheQyQgqY/mCo0X9H/a+ky0ozS6viVvkcnpqMNEUH+ktADcVr5XxKaM
WameA1oqWq0nT1dKflXcjusk81MU92ozuKjWzWsNivKiGjc37Lm1D6ZCMtzokxVW
dCR68SA9z5GlaXVt7PJZyzgkXqkh5314iptmGwU7UPT8LnvtHcm1lYohbQTUkBqJ
i2+4PJpaYpxpb++VnSvUuxxyqGMeedLR7PCFdW+CO/M0doZuxcjpI0I4fz/eDrxf
MzA+ox64JfsWg+eIeFnWjCGbrHLeeg==
=H3TL
-----END PGP SIGNATURE-----

--xxdjgjw3tjdsdt6b--
