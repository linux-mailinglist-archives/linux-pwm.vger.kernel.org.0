Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790FE6DFA7B
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 17:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjDLPmL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjDLPmI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 11:42:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA7FB2
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 08:41:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmcbR-0004Pl-G6; Wed, 12 Apr 2023 17:41:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmcbQ-00Alqy-95; Wed, 12 Apr 2023 17:41:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pmcbP-00CeEE-EN; Wed, 12 Apr 2023 17:41:43 +0200
Date:   Wed, 12 Apr 2023 17:41:43 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lee Jones <lee@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: stm32: enforce settings for pwm capture
Message-ID: <20230412154143.xvgtwnxxbljkysmq@pengutronix.de>
References: <20221213102707.1096345-1-olivier.moysan@foss.st.com>
 <20221213105128.74skjowy5v7dlaf6@pengutronix.de>
 <2ab70bb7-dbf1-5f19-8118-6cfd9b5dc278@foss.st.com>
 <20230117214337.vgvduhiltzczra6l@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oe4jo4jds2sm7egs"
Content-Disposition: inline
In-Reply-To: <20230117214337.vgvduhiltzczra6l@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--oe4jo4jds2sm7egs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[Cc -=3D Benjamin Gaignard, their email address bounced]

On Tue, Jan 17, 2023 at 10:43:37PM +0100, Uwe Kleine-K=F6nig wrote:
> On Wed, Dec 14, 2022 at 04:09:08PM +0100, Olivier MOYSAN wrote:
> > On 12/13/22 11:51, Uwe Kleine-K=F6nig wrote:
> > > Looking at drivers/counter/stm32-timer-cnt.c it does seem to work in
> > > slave mode, TISEL isn't touched though. So maybe this driver needs a
> > > similar fix?
>=20
> I want to come back to this question. I only checked lightly, but I
> guess the counter patch needs the same patch.

I cared for that one, now. See
https://lore.kernel.org/linux-iio/20230412153709.3557323-1-u.kleine-koenig@=
pengutronix.de

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--oe4jo4jds2sm7egs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ20TYACgkQj4D7WH0S
/k6qtwf/QK0kEk+EbOD5WlBpRKmlZNhihYGuNmq6A2mmmtZpwj66x3pyGdUqfYB4
ReJrigtlw+8v/59Z0xKVwER3O3QrdbTMwRfGvswGu+JFnn+fEh7roKokMzv1o5S5
oE8K92nKJ3OEHi6Pc2RxPZ+K17Sp6R/2rUZl+ulUM5d5CPtlGnJvewbRxbTe9kGF
/mQq8tWVivMlBI01VJCyzvorOFNEEWbRsgheey1YcHFvnaXLAWLwCIUhk8M+NXBp
iv82xDkskgru413rF4CkDYv2RAAM+tLLjmdj3SWlMEuc4kM9Ymo0Jb6+BjStdh9+
Pz/qbACMQhoCYL+47X9HW4G7ekH2JA==
=AL7P
-----END PGP SIGNATURE-----

--oe4jo4jds2sm7egs--
