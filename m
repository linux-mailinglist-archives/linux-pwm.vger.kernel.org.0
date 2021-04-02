Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF97353049
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Apr 2021 22:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhDBU1v (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Apr 2021 16:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBU1v (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Apr 2021 16:27:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C31C0613E6
        for <linux-pwm@vger.kernel.org>; Fri,  2 Apr 2021 13:27:49 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lSQOR-0005Z8-GH; Fri, 02 Apr 2021 22:27:47 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lSQOQ-0002dg-BM; Fri, 02 Apr 2021 22:27:46 +0200
Date:   Fri, 2 Apr 2021 22:27:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Claudiu.Beznea@microchip.com
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        linux-pwm@vger.kernel.org, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, Nicolas.Ferre@microchip.com,
        kernel@pengutronix.de
Subject: Re: [PATCH] pwm: atmel: Free resources only after pwmchip_remove()
Message-ID: <20210402202743.hvx7dz3iraesfcbs@pengutronix.de>
References: <20210324195635.75037-1-u.kleine-koenig@pengutronix.de>
 <34080c7a-71d3-334c-498e-cb65dad9f817@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xlb6hwwprgvrxfrm"
Content-Disposition: inline
In-Reply-To: <34080c7a-71d3-334c-498e-cb65dad9f817@microchip.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--xlb6hwwprgvrxfrm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 02, 2021 at 10:55:14AM +0000, Claudiu.Beznea@microchip.com wrot=
e:
> Hi Uwe,
>=20
> On 24.03.2021 21:56, Uwe Kleine-K=F6nig wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Before pwmchip_remove() returns the PWM is expected to be functional. So
> > remove the pwmchip before disabling the clock.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>> ---
>=20
> Does this need a fixes tag?

Hmm, that would be:

Fixes: 32b16d46e415 ("pwm: atmel-pwm: Add Atmel PWM controller driver")

which is the commit that introduced the driver in 2013.

> Other than this:
> Ack-by: Claudiu Beznea <claudiu.beznea@microchip.com>

You might want to make this "Acked-by:" so that patchwork automatically
picks this up.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xlb6hwwprgvrxfrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmBnfjwACgkQwfwUeK3K
7Anz5wf/TQQooZspkXqEhDtlJ0iTO+KdO++X1hoDcUho0Pa0dZfhp6NRPae2XT5W
BUxYblWSj/72VCiVYSSR4YXH8pX2TLfvv+AgX7uuSK1jGje+3LNXkZ1xTXUChRzj
5zh/0jM56QauzzBxTcUUB8jWsoctbfUbxawMjUYOeIQu67hO0jYNJcXNiS5eBDs8
sDunXuSMRDV/hEjWxF7JqhZKGD4PXiulpjd/TeBBsWLZ35j/qLVf+B0SK5EGdQ9q
cZHwXj2lrId0dhNApj8jmMa5ZTSPnGqMHAgiOSNpfozAUHF77k3tookbiayiwoGA
m5huZS4wK9XdaEdayYbRUC2mt1D33Q==
=hGal
-----END PGP SIGNATURE-----

--xlb6hwwprgvrxfrm--
