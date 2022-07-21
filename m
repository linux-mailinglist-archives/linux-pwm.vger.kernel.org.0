Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB557D4FE
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 22:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiGUUpg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 16:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUUpf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 16:45:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C128C5AA
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 13:45:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEd36-0007cE-VT; Thu, 21 Jul 2022 22:45:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEd35-002NmU-4Y; Thu, 21 Jul 2022 22:45:31 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oEd34-006etl-Bn; Thu, 21 Jul 2022 22:45:30 +0200
Date:   Thu, 21 Jul 2022 22:45:22 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Wan Jiabing <wanjiabing@vivo.com>,
        "Wesley W. Terpstra" <wesley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, kernel@pengutronix.de,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 6/7] pwm: sifive: Ensure the clk is enabled exactly one
 per running PWM
Message-ID: <20220721204522.rxmah6k66e5qe2kb@pengutronix.de>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
 <20220721103129.304697-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tw4bbsb5rcnz5y6s"
Content-Disposition: inline
In-Reply-To: <20220721103129.304697-6-u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--tw4bbsb5rcnz5y6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Yash Shah from Cc, their email address bounces]

While browsing the list of open patches in patchwork, I noticed a typo:

$Subject ~=3D s/one/once/

@Thierry: Assuming you are otherwise happy with this patch, should I
resend for this typo, or do you fixup while applying it?

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tw4bbsb5rcnz5y6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLZutkACgkQwfwUeK3K
7Ak4jwf7B0aaBqdXkpF3FQrZPsipc/Vqc1BgGFhde6css7wDonrIajzx0QcrTjVw
l9BeiCddSj2WbeLz+gkxy/G6bZYA3NhlxdkALfaia93EVFRsI1SAAZPZWKt1sF3K
xjMe3i/33frybUvRoOekahbo5QJxKDibu859WrV0vsoMQ1SpWzihDSlUw0Uqaczs
KXKHC24OURPEkdtsvxYHEUZMEKCQ3kY8S1Gwyfc9c/PUfiNR1GDbfaEQPB0aEcg4
i7dySHXZ/WpVf18e0KIdk2GayszXcdoiuAUa8rn1shVw0yeJK9UTEU8z/hLnfqLZ
tZ6T80mq9WUnAft0aNWN3pO4G52Oag==
=iSjr
-----END PGP SIGNATURE-----

--tw4bbsb5rcnz5y6s--
