Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA1B60D856
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Oct 2022 02:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiJZAK2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Oct 2022 20:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbiJZAK1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Oct 2022 20:10:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD33B7ED4
        for <linux-pwm@vger.kernel.org>; Tue, 25 Oct 2022 17:10:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onTzx-0007gK-Na; Wed, 26 Oct 2022 02:10:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onTzw-000PHW-V4; Wed, 26 Oct 2022 02:10:20 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onTzv-00Afau-Bc; Wed, 26 Oct 2022 02:10:19 +0200
Date:   Wed, 26 Oct 2022 02:10:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-tegra@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: tegra: Optimize period calculation
Message-ID: <20221026001016.4cm4kbhfzdsmb4rq@pengutronix.de>
References: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
 <a0b92a81-71f7-ea14-e887-4486a398b709@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y5mlvctuqwwfxfxd"
Content-Disposition: inline
In-Reply-To: <a0b92a81-71f7-ea14-e887-4486a398b709@nvidia.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--y5mlvctuqwwfxfxd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jon,

On Tue, Oct 25, 2022 at 03:22:18PM +0100, Jon Hunter wrote:
> On 25/04/2022 14:22, Uwe Kleine-K=F6nig wrote:
> > Dividing by the result of a division looses precision because the resul=
t is
> > rounded twice. E.g. with clk_rate =3D 48000000 and period =3D 32760033 =
the
> > following numbers result:
> >=20
> > 	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH =3D 187500
> > 	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns) =3D 3052
> > 	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz) =3D 6144
> >=20
> > The exact result would be 6142.5061875 and (apart from rounding) this is
> > found by using a single division. As a side effect is also a tad
> > cheaper to calculate.
> >=20
> > Also using clk_rate >> PWM_DUTY_WIDTH looses precision. Consider for
> > example clk_rate =3D 47999999 and period =3D 106667:
> >=20
> > 	mul_u64_u64_div_u64(pc->clk_rate >> PWM_DUTY_WIDTH, period_ns,
> > 			    NSEC_PER_SEC) =3D 19
> >=20
> > 	mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> > 			    NSEC_PER_SEC << PWM_DUTY_WIDTH) =3D 20
> >=20
> > (The exact result is 20.000062083332033.)
> >=20
> > With this optimizations also switch from round-closest to round-down for
> > the period calculation. Given that the calculations were non-optimal for
> > quite some time now with variations in both directions which nobody
> > reported as a problem, this is the opportunity to align the driver's
> > behavior to the requirements of new drivers. This has several upsides:
> >=20
> >   - Implementation is easier as there are no round-nearest variants of
> >     mul_u64_u64_div_u64().
> >   - Requests for too small periods are now consistently refused. This w=
as
> >     kind of arbitrary before, where period_ns < min_period_ns was
> >     refused, but in some cases min_period_ns isn't actually implementab=
le
> >     and then values between min_period_ns and the actual minimum were
> >     rounded up to the actual minimum.
> >=20
> > Note that the duty_cycle calculation isn't using the usual round-down
> > approach yet.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > changes since (implicit) v1: Updated changelog to explain why rate =3D 0
> > is refused now.
> >=20
> > Best regards
> > Uwe
> >=20
> >   drivers/pwm/pwm-tegra.c | 10 +++++-----
> >   1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index e5a9ffef4a71..7fc03a9ec154 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -99,7 +99,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
> >   			    int duty_ns, int period_ns)
> >   {
> >   	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> > -	unsigned long long c =3D duty_ns, hz;
> > +	unsigned long long c =3D duty_ns;
> >   	unsigned long rate, required_clk_rate;
> >   	u32 val =3D 0;
> >   	int err;
> > @@ -156,11 +156,9 @@ static int tegra_pwm_config(struct pwm_chip *chip,=
 struct pwm_device *pwm,
> >   		pc->clk_rate =3D clk_get_rate(pc->clk);
> >   	}
> > -	rate =3D pc->clk_rate >> PWM_DUTY_WIDTH;
> > -
> >   	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
> > -	hz =3D DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
> > -	rate =3D DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
> > +	rate =3D mul_u64_u64_div_u64(pc->clk_rate, period_ns,
> > +				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
> >   	/*
> >   	 * Since the actual PWM divider is the register's frequency divider
> > @@ -169,6 +167,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, =
struct pwm_device *pwm,
> >   	 */
> >   	if (rate > 0)
> >   		rate--;
> > +	else
> > +		return -EINVAL;
>=20
>=20
> I am seeing more problems with this ...
>=20
> 1. In the case where we call dev_pm_opp_set_rate() to set the PWM clock
>    rate, the requested rate is calculated as ...
>=20
>   required_clk_rate =3D (NSEC_PER_SEC / period_ns) << PWM_DUTY_WIDTH;
>=20
>    For Tegra234, I have a case where the period is 45334 and so the
>    above yields a rate of 5646848Hz. In this case, mul_u64_u64_div_u64()
>=20
>    returns 0 because ...
>=20
>    (5646848 * 45334)/(NSEC_PER_SEC << PWM_DUTY_WIDTH) =3D 0.9999
>=20
>    We can fix this by ...
>=20
>   required_clk_rate =3D (NSEC_PER_SEC << PWM_DUTY_WIDTH) / period_ns;
>=20
>    The above produces a rate of 5646975 vs 5646848Hz.

You probably also want to round up that division such that you work with
5646976.

> 2. Even after fixing issue #1, above, I then ran into another issue
>    where even if I request a clock rate of 5646975 I still get a lower
>    clock. This also causes  mul_u64_u64_div_u64() to return 0 and then I
>    see the -EINVAL returned. The simple solution here is to not return
>    -EINVAL for 0. After all 0, could be valid if the rate if we are
>    not dividing down the parent clock in the PWM. However, then there is

As you have to subtract 1 from the result of the division, you need to
write a -1 in the register which doesn't work. Writing a 0 results in a
bigger period than requested which is the thing I intended to fix with
the blamed commit.

If clk_rate was 5646976 (don't know if that matches as nicely as it
should? If dev_pm_opp_set_rate might set a lower rate you're out of luck
again) we get:

	rate =3D mul_u64_u64_div_u64(5646976, 45334, 1000000000 << 8)

which is 1 and everything is fine.

Note that the math before my commit already had that problem. Before the
driver was just more lax and didn't subtract 1 from rate and so
configured a bigger period than requested/expected

There are probably similar cases where the driver still configures a too
big period (i.e. when the effect you described yields a rate that is too
small but bigger than 0).

So the optimal way to fix this is to adapt the calculation of
required_clk_rate as you suggested + rounding up and to make sure that
dev_pm_opp_set_rate doesn't configure a rate lower than requested. The
latter might be complicated as the API (AFAIK) isn't specific about
rounding directions and there isn't a dev_pm_opp_round_rate function.

As a short term work-around dropping the -EINVAL is probably best, I'd
like to have it documented clearly however that continuing in that case
is wrong and yields unexpected settings.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--y5mlvctuqwwfxfxd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNYeuUACgkQwfwUeK3K
7AntMgf/eCVEaeeIgxHvQ3kUZWzUIhfnPpzhVwoYKBYVFbd73aFZ5uLbyw0OT1FB
2iyxtIboRghcoLpY1wZnqeFLu6LxziDzqHnIIIZpUO7jVuJC5FGmwWhu4XAnxLRr
5Co5WvRSlNihesabVjLwuh896/IkYc/qIWT5h+vGgdTPY99Mml6HnLzqEDs4JEa/
VGPXm6AwMXDAofa5A26m03byJGFNraHffGez1KygbCq0z/WfifkjLlRqhWMXq/Ii
DBKyBJawqoWxlaj3lLg2xtIchvx0WNWtKG8XMH4Ex3JBV1Llz/6R5aa1XBQSNnzc
b3ASd1NBS0MlOSlHdtG1YkocWYR+Cg==
=Kw6/
-----END PGP SIGNATURE-----

--y5mlvctuqwwfxfxd--
