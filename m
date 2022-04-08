Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8182D4F99B4
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Apr 2022 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiDHPor (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Apr 2022 11:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbiDHPom (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Apr 2022 11:44:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB21789302
        for <linux-pwm@vger.kernel.org>; Fri,  8 Apr 2022 08:42:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqkn-0002Sw-7H; Fri, 08 Apr 2022 17:42:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqkn-001pNw-Pk; Fri, 08 Apr 2022 17:42:28 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ncqkl-001zy6-IV; Fri, 08 Apr 2022 17:42:27 +0200
Date:   Fri, 8 Apr 2022 17:42:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel-tcp: Make atmel_tcb_divisors static
Message-ID: <20220408154224.ol37chvot4mhkuz3@pengutronix.de>
References: <20220408152910.167698-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tnaxwvygcxg2ksiy"
Content-Disposition: inline
In-Reply-To: <20220408152910.167698-1-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tnaxwvygcxg2ksiy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Thierry,

I fat fingered the driver name in the subject line. Iff you apply this=20
patch please fixup accordingly (i.e. s/tcp/tcb/).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tnaxwvygcxg2ksiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJQV90ACgkQwfwUeK3K
7AmI3Qf/XFmwcGu4jAIhLhcRyom2P7NnxGUBVoqjtmRs2MupKHQ17XUk92wR0va4
tV6fERNjrQ2Hnq6/ZzniKz5pou2LEu2x4wXeJEbShLNqzLK8fOCYS59lF4CRTlE5
AGG9GtntIl91K+eNPhu8NNaiu16uyFmivwiUGZxgBIAbyp4D1KUbQFM+nJwVmI2Q
ip17z/qbIRUiQXeydKWLF0F+TYNHQma/PfSzQObWqG+vrZS1UHmU54eS/C3gUjBv
DfUZY5LiQVqGhs6wW9Zk8xy3Qx/auiO4ntgIHBAoJhvmtQG9E47zfaiCALHczlk3
KlH7va523tZzZpquj3ivF6Tg7hVKpw==
=GpHi
-----END PGP SIGNATURE-----

--tnaxwvygcxg2ksiy--
