Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA7B50CC41
	for <lists+linux-pwm@lfdr.de>; Sat, 23 Apr 2022 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbiDWQVm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 23 Apr 2022 12:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiDWQVl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 23 Apr 2022 12:21:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3CF1A583D
        for <linux-pwm@vger.kernel.org>; Sat, 23 Apr 2022 09:18:43 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1niISz-0003Gr-VZ; Sat, 23 Apr 2022 18:18:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1niISz-004muk-7g; Sat, 23 Apr 2022 18:18:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1niISx-0059Aq-4w; Sat, 23 Apr 2022 18:18:35 +0200
Date:   Sat, 23 Apr 2022 18:18:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Baruch Siach <baruch@tkos.co.il>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: mvebu: drop pwm base assignment
Message-ID: <20220423161831.ob7cxj7do4423vrv@pengutronix.de>
References: <145383feecbe43f3bbd3e128143f7890f0314b3b.1649658220.git.baruch@tkos.co.il>
 <YmLcdmQrO4+0tEiJ@orome>
 <CACRpkdaqRe8HgPvm-YH9p=ZDetX6jcVHFRgvqk064KW=2-a-mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjcj2mxcxnj5jim4"
Content-Disposition: inline
In-Reply-To: <CACRpkdaqRe8HgPvm-YH9p=ZDetX6jcVHFRgvqk064KW=2-a-mQ@mail.gmail.com>
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


--xjcj2mxcxnj5jim4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 23, 2022 at 12:18:20AM +0200, Linus Walleij wrote:
> On Fri, Apr 22, 2022 at 6:48 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
>=20
> > > -     /*
> > > -      * There may already be some PWM allocated, so we can't force
> > > -      * mvpwm->chip.base to a fixed point like mvchip->chip.base.
> > > -      * So, we let pwmchip_add() do the numbering and take the next =
free
> > > -      * region.
> > > -      */
> > > -     mvpwm->chip.base =3D -1;
>=20
> I don't see why this is removed. I understand why the comment is removed
> but all contemporary GPIO chips should use dynamic assignment of numbers
> i.e. base =3D -1.

This is an assignment to struct pwm_chip::base, not struct gpio_chip::base.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xjcj2mxcxnj5jim4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJkJtQACgkQwfwUeK3K
7AkDOQf+JJa3wYYoQcOKDpIiq9QHXILBS11qMCcYKmZ+EO0wH/DM6rU3tbm4XRps
2tGcAMn1gIer/MJKRHDeyW3TXZObIuDZfRZaymwn30SPdrSF/xHUcaA9HnSWZt85
Bo65p/fw3INrOcHokm8dUwGgEnphZnvZzH77987h7qCmLb2N6Y/zmnGkUraGPRfa
EKivT1pJwIjR0GccG1QeY5d+t8a7pEBJRv7e7TzQP75HkqOuZnezuCW0bVkgPwmF
4VNX27VYw0bP4RVv0NPRgrYPJLSXaMgsIPqIl1v6s/1YXz1l121k200slUPiIQt9
hXg+qaiKSUCizNbX69TNVCrW90dvEQ==
=Kh/e
-----END PGP SIGNATURE-----

--xjcj2mxcxnj5jim4--
