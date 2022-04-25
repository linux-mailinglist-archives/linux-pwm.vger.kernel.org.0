Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3638950E6E5
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Apr 2022 19:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243873AbiDYRUT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Apr 2022 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243889AbiDYRUB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Apr 2022 13:20:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821CF255BC
        for <linux-pwm@vger.kernel.org>; Mon, 25 Apr 2022 10:16:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nj2KT-00070s-AZ; Mon, 25 Apr 2022 19:16:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nj2KT-005BnN-OU; Mon, 25 Apr 2022 19:16:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nj2KR-005ZPM-Ku; Mon, 25 Apr 2022 19:16:51 +0200
Date:   Mon, 25 Apr 2022 19:16:41 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: samsung: Implement .apply() callback
Message-ID: <20220425171641.tf2cgkzbwrx36pn6@pengutronix.de>
References: <20220328073434.44848-1-u.kleine-koenig@pengutronix.de>
 <d7030fc5-3165-0255-0055-b2bc2e387d53@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bjhnm6upzki7ytsi"
Content-Disposition: inline
In-Reply-To: <d7030fc5-3165-0255-0055-b2bc2e387d53@linaro.org>
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


--bjhnm6upzki7ytsi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 05:11:02PM +0200, Krzysztof Kozlowski wrote:
> On 28/03/2022 09:34, Uwe Kleine-K=F6nig wrote:
> > To eventually get rid of all legacy drivers convert this driver to the
> > modern world implementing .apply().
> >=20
> > The size check for state->period is moved to .apply() to make sure that
> > the values of state->duty_cycle and state->period are passed to
> > pwm_samsung_config without change while they are discarded to int.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/pwm/pwm-samsung.c | 54 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 42 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
> > index 0a4ff55fad04..9c5b4f515641 100644
> > --- a/drivers/pwm/pwm-samsung.c
> > +++ b/drivers/pwm/pwm-samsung.c
> > @@ -321,14 +321,6 @@ static int __pwm_samsung_config(struct pwm_chip *c=
hip, struct pwm_device *pwm,
> >  	struct samsung_pwm_channel *chan =3D pwm_get_chip_data(pwm);
> >  	u32 tin_ns =3D chan->tin_ns, tcnt, tcmp, oldtcmp;
> > =20
> > -	/*
> > -	 * We currently avoid using 64bit arithmetic by using the
> > -	 * fact that anything faster than 1Hz is easily representable
> > -	 * by 32bits.
> > -	 */
> > -	if (period_ns > NSEC_PER_SEC)
> > -		return -ERANGE;
> > -
> >  	tcnt =3D readl(our_chip->base + REG_TCNTB(pwm->hwpwm));
> >  	oldtcmp =3D readl(our_chip->base + REG_TCMPB(pwm->hwpwm));
> > =20
> > @@ -438,13 +430,51 @@ static int pwm_samsung_set_polarity(struct pwm_ch=
ip *chip,
> >  	return 0;
> >  }
> > =20
> > +static int pwm_samsung_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> > +			     const struct pwm_state *state)
> > +{
> > +	int err, enabled =3D pwm->state.enabled;
> > +
> > +	if (state->polarity !=3D pwm->state.polarity) {
> > +		if (enabled) {
> > +			pwm_samsung_disable(chip, pwm);
> > +			enabled =3D false;
> > +		}
> > +
> > +		err =3D pwm_samsung_set_polarity(chip, pwm, state->polarity);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	if (!state->enabled) {
> > +		if (enabled)
> > +			pwm_samsung_disable(chip, pwm);
> > +
> > +		return 0;
> > +	}
> > +
> > +	/*
> > +	 * We currently avoid using 64bit arithmetic by using the
> > +	 * fact that anything faster than 1Hz is easily representable
> > +	 * by 32bits.
> > +	 */
> > +	if (state->period > NSEC_PER_SEC)
>=20
> Isn't this changing a bit logic in case of setting wrong period and
> inverted signal?
>=20
> Before, the config would return early and do nothing. Now, you disable
> the PWM, check the condition here and exit with PWM disabled. I think
> this should reverse the tasks done, or the check should be done early.

The intension here is to just push the legacy implementation of .apply()
(i.e.  pwm_apply_legacy()) into the driver, to be able to get rid of the
legacy handing in the core. I think the problem you point out is real,
but it is not introduced by my change which doesn't change behaviour.

The problem is just that it's not possible to "see" that period is
invalid at the time the polarity is changed and so it exists since at
least 5ec803edcb703fe379836f13560b79dfac79b01d, my patch just made it
more obvious.

So yes, there is potential to further improve the driver, but that's out
of scope for this 1:1 conversion patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--bjhnm6upzki7ytsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJm13YACgkQwfwUeK3K
7AkHcwgAiZZLshS33GmSlxC8igZ7wcJ7QpVj0i7+a+MGiTWH+4escZ+Bxe5LF/ES
UQeNn2Zx+Z1MmMxXisHstQ3geEeQEo5Pbicq0Ns23jEwvxlk+hcDEt1/bh+ooKmm
2d+/L5sJfSgwpH+Beg7mS7LNkhcw2p6kw2LgMINmvPQLJRhNJxxWPSHZfrGEnX0z
uoEDcXzRamLRM8tmkwSMzVDij+Bajhv6EcKPyHPNyTFzKOeI6axHdtRmbkT0wiMW
IV/E4pmWOeZhTq9WGRdrccHsAwgUG0J5Tw2rLG/FEv4YMiJgritIQ7tpkVra1jqL
JC12aAc32zPRNEKb3f7BPW/rFbB4HQ==
=tK4M
-----END PGP SIGNATURE-----

--bjhnm6upzki7ytsi--
