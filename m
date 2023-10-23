Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEF97D3DC0
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjJWRbk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 13:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjJWRbJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 13:31:09 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987CFD6E
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 10:30:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quyke-00070y-4X; Mon, 23 Oct 2023 19:30:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quykb-003lLS-AE; Mon, 23 Oct 2023 19:30:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quykb-004Ue5-0e; Mon, 23 Oct 2023 19:30:01 +0200
Date:   Mon, 23 Oct 2023 19:29:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] pwm: atmel-hlcdc: Use DEFINE_SIMPLE_DEV_PM_OPS
 for PM functions
Message-ID: <20231023172958.xbfptbl4khct657g@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
 <20231013174204.1457085-14-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hytmesjdv5r4p2ko"
Content-Disposition: inline
In-Reply-To: <20231013174204.1457085-14-u.kleine-koenig@pengutronix.de>
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


--hytmesjdv5r4p2ko
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 13, 2023 at 07:42:06PM +0200, Uwe Kleine-K=F6nig wrote:
> This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
> care about when the functions are actually used, so the corresponding
>=20
> Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
> isn't enabled.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Something in my processing queue ate a line after the first paragraph:

	#ifdef can be dropped.

I don't understand yet where this happend. It also affects a few other
patches in this series. I'll investigate and resend. In the meantime I
discard this series from patchwork.

Thanks to Jan L=FCbbe who pointed out that problem to me (by PM).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hytmesjdv5r4p2ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmU2rZUACgkQj4D7WH0S
/k4+hgf+KsA50qBARXgzOw53g2n42Aw6CfQzX+3ap3mZJEuNaoOQN1xBwSh/9P9h
lMWFWPwwbGkIW7OKS6r0QTV5wuqZAlO+GeJwULEFApvVajt7brL63btvwtgX8FvO
dA2u0xWDbbTTqIojWI1b4chH3c3K3xT5A5Pwv+Ck/u4XwLIBtQyb0zVfiZoNDwVU
4JDEgYwk8PTZ1a7IrSI1dWqMeZN4NneQdfbkWn236R7TNwegj4oLAs4+irnaBX2S
EMMFes1YOFc9ErvAJCxHeOJIKY/fxgupmAQvy+UuDjh3QULi/OeHvkVtWdF2mMt/
Y8KsYCatREcKZxhGeTPoyd/WldesRA==
=QD/8
-----END PGP SIGNATURE-----

--hytmesjdv5r4p2ko--
