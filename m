Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBFB6729AA
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jan 2023 21:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjARUtP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Jan 2023 15:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjARUtM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jan 2023 15:49:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4A9470A9
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jan 2023 12:49:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIFMr-0005hf-Tk; Wed, 18 Jan 2023 21:49:09 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIFMq-006zZg-Sz; Wed, 18 Jan 2023 21:49:08 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIFMq-00DxmX-4l; Wed, 18 Jan 2023 21:49:08 +0100
Date:   Wed, 18 Jan 2023 21:49:07 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Axel Lin <axel.lin@ingics.com>, kernel@pengutronix.de
Subject: Re: [PATCH] pwm: ab8500:
Message-ID: <20230118204907.jtjdfyqvw4pbl23n@pengutronix.de>
References: <20230103231841.1548913-1-u.kleine-koenig@pengutronix.de>
 <CACRpkdYMUBGOPoS3BUhwv=pwhnPfq94VLsanyBs0J_ajrsq30Q@mail.gmail.com>
 <20230105210215.4ov3erqpyib2ah6f@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5yoafnpbxh5f4hml"
Content-Disposition: inline
In-Reply-To: <20230105210215.4ov3erqpyib2ah6f@pengutronix.de>
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


--5yoafnpbxh5f4hml
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jan 05, 2023 at 10:02:15PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Thu, Jan 05, 2023 at 01:14:33AM +0100, Linus Walleij wrote:
> > Believe it or not but there is a hard-to-find public datasheet:
> > https://web.archive.org/web/20130614115108/http://www.stericsson.com/de=
velopers/CD00291561_UM1031_AB8500_user_manual-rev5_CTDS_public.pdf
> >=20
> > These register bits are described on page 282-283.
>=20
> Hmm, there are three settings related to the PWM (page 70):
>=20
>  EnaPWMOut(i)
>  FreqPWMOut(i)
>  DutyPWMOut(i)
>=20
> If I understand the manual correctly, the driver is totaly bogous.
> With FreqPWMOut the period is defined, this is always set to 4b0, so the
> frequency is 293 Hz =E2=89=83 3412969 ns. So if .duty_cycle =3D 1 ns is r=
equested,
> we currently get 2 * 3412969 / 1024 ns =E2=89=83 6666 ns?!
>=20
> The EnaPWMOut bits are not handled at all. I assume when this is unset,
> the output is inactive?

That's wrong, the EnaPWMOut bit is handled. Don't know why I missed
that.
=20
> Probably the three PWMs are better represented as one chip with 3
> outputs instead of three chips with one PWM each, given there is only
> one register for the EnaPWMOut bits.

Earlier today I looked again into this driver and (I hope) fixed the
problems I was seening. I'm marking the patch in this thread as
superseeded.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5yoafnpbxh5f4hml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPIW0AACgkQwfwUeK3K
7Am6pQf/bD6KoiXTz8C+5VtWCpF52Xcl2t1Sd9fgSkKe3mC+dlU2f18wBDMa/8Oe
q8x1TbBQgfEz8NGony5x5CK8IOrIPp1IbahnUR8OUrBckg34NU2mQTmcG/zPVnqP
5sZtXFN0mtV5tXTziBlLLpydE4HcUA6+PSU4jqtWMqjgtw77rdKdetxzl78Nky9c
WU2zI+jblfsO4rWdCjcjxBu1CCiOZ4W/7ZX1r9uugJLOSDfTZtU62xKwPh+qHTR+
y6ltGahev2goBKdtm9B6trp2n1Z7mZXizlCoHW3RmeJgOVInlWYCIY4OGahZ5Vhw
uvIv73eR7nG+NQ9rSNZ/r2IW5ogCAA==
=UFWJ
-----END PGP SIGNATURE-----

--5yoafnpbxh5f4hml--
