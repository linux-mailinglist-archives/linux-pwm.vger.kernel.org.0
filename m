Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E657427F1
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Jun 2023 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbjF2OHz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Jun 2023 10:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjF2OHz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Jun 2023 10:07:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B622972
        for <linux-pwm@vger.kernel.org>; Thu, 29 Jun 2023 07:07:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEsJH-0004AX-9P; Thu, 29 Jun 2023 16:07:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEsJG-00AvCP-Hv; Thu, 29 Jun 2023 16:07:46 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEsJF-000nt6-T6; Thu, 29 Jun 2023 16:07:45 +0200
Date:   Thu, 29 Jun 2023 16:07:45 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 3/8] pwm: jz4740: Put per-channel clk into driver data
Message-ID: <20230629140745.fknzjerunbl2wr3k@pengutronix.de>
References: <notmuch-sha1-d2bb15a9dcb5470a6eebca0b1a01c57918a22695>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wljg7bv56o5fj4s5"
Content-Disposition: inline
In-Reply-To: <notmuch-sha1-d2bb15a9dcb5470a6eebca0b1a01c57918a22695>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--wljg7bv56o5fj4s5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Paul,

first of all, your mail is strange. I think the problem is that it
doesn't contain a Message-Id. The result is that I got it twice and in
return vger.kernel.org seems to have refused to take it. At least it's
neither in lore.kernel.org nor in
https://patchwork.ozlabs.org/project/linux-pwm/patch/20230629094839.757092-=
4-u.kleine-koenig@pengutronix.de/
=2E

On Thu, Jun 29, 2023 at 01:12:25PM +0200, Paul Cercueil wrote:
> Le 29 juin 2023 11:48, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de=
> a =E9crit :
> >
> > Stop using chip_data which is about to go away. Instead track the=20
> > per-channel clk in struct jz4740_pwm_chip.=20
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>=20
> > ---=20
> > drivers/pwm/pwm-jz4740.c | 11 +++++++----=20
> > 1 file changed, 7 insertions(+), 4 deletions(-)=20
> >
> > diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c=20
> > index 3b7067f6cd0d..e0a57d71a60c 100644=20
> > --- a/drivers/pwm/pwm-jz4740.c=20
> > +++ b/drivers/pwm/pwm-jz4740.c=20
> > @@ -27,6 +27,7 @@ struct soc_info {=20
> > struct jz4740_pwm_chip {=20
> > struct pwm_chip chip;=20
> > struct regmap *map;=20
> > + struct clk *clk[];=20
> > };=20
> >
> > static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)=
=20
> > @@ -70,14 +71,15 @@ static int jz4740_pwm_request(struct pwm_chip *chip=
, struct pwm_device *pwm)=20
> > return err;=20
> > }=20
> >
> > - pwm_set_chip_data(pwm, clk);=20
> > + jz->clk[pwm->hwpwm] =3D clk;=20
> >
> > return 0;=20
> > }=20
> >
> > static void jz4740_pwm_free(struct pwm_chip *chip, struct pwm_device *p=
wm)=20
> > {=20
> > - struct clk *clk =3D pwm_get_chip_data(pwm);=20
> > + struct jz4740_pwm_chip *jz =3D to_jz4740(chip);=20
> > + struct clk *clk =3D jz->clk[pwm->hwpwm];=20
> >
> > clk_disable_unprepare(clk);=20
> > clk_put(clk);=20
> > @@ -123,7 +125,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, =
struct pwm_device *pwm,=20
> > {=20
> > struct jz4740_pwm_chip *jz4740 =3D to_jz4740(pwm->chip);=20
> > unsigned long long tmp =3D 0xffffull * NSEC_PER_SEC;=20
> > - struct clk *clk =3D pwm_get_chip_data(pwm);=20
> > + struct clk *clk =3D jz4740->clk[pwm->hwpwm];=20
> > unsigned long period, duty;=20
> > long rate;=20
> > int err;=20
> > @@ -229,7 +231,8 @@ static int jz4740_pwm_probe(struct platform_device =
*pdev)=20
> > if (!info)=20
> > return -EINVAL;=20
> >
> > - jz4740 =3D devm_kzalloc(dev, sizeof(*jz4740), GFP_KERNEL);=20
> > + jz4740 =3D devm_kzalloc(dev, sizeof(*jz4740) + info->num_pwms * sizeo=
f(jz4740->clk[0]),=20
> > + =A0=A0=A0=A0=A0 GFP_KERNEL);=20
>=20
> LGTM, but please use struct_size() from <linux/overflow.h>.

Ah, I thought there is such a macro, but I didn't find it neither by
grepping nor by asking in #kernelnewbies. Thanks, will respin the series
in a few days.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wljg7bv56o5fj4s5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSdkDEACgkQj4D7WH0S
/k4CWQf5AR+UGq3YoDMlRby6ypTdN4uJvofxaSs65alvczNoXx3KreoOSmEld+MC
TsmGYDKYb+B/CKCc4VCtiMNKMyUT+urvylbsVTtY7CWZIjx7l5+3R+KTSBE2lgG/
vhEp8ZjgaQDodCjWpVDXTzVmaUklW49kKucKCPDX9gYL4BLaehvsk+NN6lrxcrGH
aESLTqAn8aM2y35hxatPkro8v2oxfdKi/zgqtp+cXGMh62UdszMae3BVadtvuP8z
YK+DYIjHbK1qK3OkTYq09RbG+66bl/JmPSeeTrmsivApEB31QL+8+Taf06gmrqsl
+NhbCg7xd1YKtA7Iy6y2VPcsvvnq8Q==
=Q0mH
-----END PGP SIGNATURE-----

--wljg7bv56o5fj4s5--
