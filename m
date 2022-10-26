Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E116E60E342
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Oct 2022 16:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiJZOYw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Oct 2022 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiJZOYt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Oct 2022 10:24:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402FA13F68
        for <linux-pwm@vger.kernel.org>; Wed, 26 Oct 2022 07:24:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onhKn-0006lr-5d; Wed, 26 Oct 2022 16:24:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onhKn-000Wai-Bw; Wed, 26 Oct 2022 16:24:44 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onhKl-00ApV5-My; Wed, 26 Oct 2022 16:24:43 +0200
Date:   Wed, 26 Oct 2022 16:24:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: tegra: Improve required rate calculation
Message-ID: <20221026142441.5yrqx76jnmvdbexq@pengutronix.de>
References: <20221026101305.30670-1-jonathanh@nvidia.com>
 <20221026141754.22ohncsbb3efhuqb@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjbecma5z4lfjutf"
Content-Disposition: inline
In-Reply-To: <20221026141754.22ohncsbb3efhuqb@pengutronix.de>
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


--tjbecma5z4lfjutf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 26, 2022 at 04:17:55PM +0200, Uwe Kleine-K=F6nig wrote:
> On Wed, Oct 26, 2022 at 11:13:04AM +0100, Jon Hunter wrote:
> > For the case where dev_pm_opp_set_rate() is called to set the PWM clock
> > rate, the requested rate is calculated as ...
> >=20
> >  required_clk_rate =3D (NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
> >=20
> > The above calculation may lead to rounding errors because the
> > NSEC_PER_SEC is divided by 'period_ns' before applying the
> > PWM_DUTY_WIDTH multiplication factor. For example, if the period is
> > 45334ns, the above calculation yields a rate of 5646848Hz instead of
> > 5646976Hz. Fix this by applying the multiplication factor before
> > dividing and using the DIV_ROUND_UP macro which yields the expected
> > result of 5646976Hz.
> >=20
> > Fixes: 1d7796bdb63a ("pwm: tegra: Support dynamic clock frequency confi=
guration")
> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > ---
> >  drivers/pwm/pwm-tegra.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index dad9978c9186..8a33c500f93b 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -145,8 +145,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >  		 * source clock rate as required_clk_rate, PWM controller will
> >  		 * be able to configure the requested period.
> >  		 */
> > -		required_clk_rate =3D
> > -			(NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
> > +		required_clk_rate =3D DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_WID=
TH),
> > +						     period_ns);
>=20
> This also has the nice side effect that required_clk_rate doesn't become
> zero any more for big period_ns values.
>=20
> Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I just noticed you could drop a pair of parenthesis in the first parameter
to DIV_ROUND_UP_ULL.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--tjbecma5z4lfjutf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNZQycACgkQwfwUeK3K
7Akg6gf/RUeV5JAYYnnCe2QPjgD2FULW5iwkewMh79DiDNq1ahpKthSPG6CeRVc1
HGE6PdvFLgN6fmIHuXq/BuppJKGriHieMueQtqOIk9jw2lUlWAxlVDdxHup6o+Mr
kEqkOHgRSLkpEKOqqwG0Wv2kTCzJr2QhsbuM26WU+WWNZru2Ens6aGzb1EatOX8o
LHppUnknX6qtWUxoFG6k5FFTG45WY+kDjyXSgpU9NUA/frgTv4KFnXukP5dOfJ38
uudCvv2dwnSHSdlj0aJMJjnj9shvkuhvJYUAKA7WxRewyIMeNcOYfvD0hbdoMqp0
7REg5OUzYVSwg982lQveNuN5HxmaZQ==
=9K/K
-----END PGP SIGNATURE-----

--tjbecma5z4lfjutf--
