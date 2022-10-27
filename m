Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B9A60F06F
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Oct 2022 08:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiJ0GkK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 27 Oct 2022 02:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiJ0GkJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 27 Oct 2022 02:40:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4030564
        for <linux-pwm@vger.kernel.org>; Wed, 26 Oct 2022 23:40:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1onwYf-00027u-Gh; Thu, 27 Oct 2022 08:40:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onwYf-000eP7-Dh; Thu, 27 Oct 2022 08:40:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1onwYd-00B2Tv-QC; Thu, 27 Oct 2022 08:40:03 +0200
Date:   Thu, 27 Oct 2022 08:40:03 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: tegra: Fix required rate when clock is lower
 than needed
Message-ID: <20221027064003.22hx7iftdpg7s5hi@pengutronix.de>
References: <20221026101305.30670-1-jonathanh@nvidia.com>
 <20221026101305.30670-2-jonathanh@nvidia.com>
 <20221026142301.3cgwqozpafpuu34k@pengutronix.de>
 <5bb9e817-9e4d-dd02-9c04-443efcf58226@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nakcmayqsjlncj32"
Content-Disposition: inline
In-Reply-To: <5bb9e817-9e4d-dd02-9c04-443efcf58226@nvidia.com>
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


--nakcmayqsjlncj32
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jon,

On Wed, Oct 26, 2022 at 09:17:08PM +0100, Jon Hunter wrote:
> On 26/10/2022 15:23, Uwe Kleine-K=F6nig wrote:
> > On Wed, Oct 26, 2022 at 11:13:05AM +0100, Jon Hunter wrote:
> > > If the 'required_clk_rate' is greater than the clock rate that can be
> > > provided, then when mul_u64_u64_div_u64() is called to determine the
> > > 'rate' for the PWM divider, 0 will be returned. If 'rate' is 0, then =
we
> > > will return -EINVAL and fail to configure the PWM. Fix this by adding=
 1
> > > to the PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to ens=
ure
> > > that 'rate' is greater or equal to 1. This fixes an issue on Tegra234
> > > where configuring the PWM fan fails.
> > >=20
> > > Fixes: 8c193f4714df ("pwm: tegra: Optimize period calculation")
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > >   drivers/pwm/pwm-tegra.c | 13 +++++++++++++
> > >   1 file changed, 13 insertions(+)
> > >=20
> > > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > > index 8a33c500f93b..973e2c1533ab 100644
> > > --- a/drivers/pwm/pwm-tegra.c
> > > +++ b/drivers/pwm/pwm-tegra.c
> > > @@ -148,6 +148,19 @@ static int tegra_pwm_config(struct pwm_chip *chi=
p, struct pwm_device *pwm,
> > >  		required_clk_rate =3D DIV_ROUND_UP_ULL((NSEC_PER_SEC << PWM_DUTY_W=
IDTH),
> > >  						     period_ns);
> > > +		/*
> > > +		 * If the 'required_clk_rate' is greater than the clock rate
> > > +		 * that can be provided, then when mul_u64_u64_div_u64() is
> > > +		 * called to determine the 'rate' for the PWM divider, 0 will
> > > +		 * be returned. If 'rate' is 0, then we will return -EINVAL and
> > > +		 * fail to configure the PWM. If this case, add 1 to the
> > > +		 * PWM_DUTY_WIDTH when calculating the 'required_clk_rate' to
> > > +		 * ensure that 'rate' is greater or equal to 1.
> > > +		 */
> > > +		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
> > > +			required_clk_rate =3D DIV_ROUND_UP_ULL((NSEC_PER_SEC << (PWM_DUTY=
_WIDTH + 1)),
> > > +							     period_ns);
> > > +
> >=20
> > It's implicit knowledge that (roughly) doubling the clk rate is the
> > right value (i.e the minimal value to get a
> > clk_rate >=3D (NSEC_PER_SEC << PWM_DUTY_WIDTH) / period_ns?
>=20
> Are you suggesting I drop the comment? Sorry not sure what you are trying=
 to
> say here and if you think something should be changed.

No, I just wondered about that +1 being the right thing to do. Consider
period_ns was 400003. Then you get required_clk_rate =3D 639996.
Now we want to prevent that calling dev_pm_opp_set_rate(..., 639996)
yields a rate less than 639996.

You're implicitly claiming that 1279991 will do. But without further
knowledge also that value might yield a rate less than 639996; or 959993
might yield a rate that better fits our needs (i.e.

	639996 <=3D clk_round_rate(..., 959993) < clk_round_rate(..., 1279991)

). So my question was about "why 1279991?" and if there is implicit
knowledge that makes 1279991 the right choice. Assuming there is such a
reasoning, I'd prefer a comment like:

	/*
	 * To achieve a period not bigger than the requested period we
	 * must ensure that the input clock runs with at least
	 * $required_clk_rate Hz. As consecutive possible rates differ
	 * by a factor of two we double our request if
	 * $required_clk_rate yields a too slow rate.
	 */

I'm not entirely sure this would be a sound assumption but I think you
get the point?! (It might be necessary to double exactly the requested
value and then you still have to make some (reasonable) assumption about
clk_round_rate().)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nakcmayqsjlncj32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNaJ8AACgkQwfwUeK3K
7Akzagf9EiHnVv4T9wv5Me5C+2A5p3Wf94o3hfthcl6I+CCdCiynnJ2226KEv7h0
+tlOFsfhLalX7gL2+p6AguK76bqPNTRRzVfwhTdjZSX8tyQiv5LtrsvhzUcnlchm
q7ZvxDopF9UfTFo04q7Dlx7UuaFmYpp+8Ig3v7mvTJqkNUva/pKUKW6Aye0b36xl
OANwEPB3CmINO+1Rkh9/ueL6kW9VxW3GDzg1J333sy64p0bOvtLLZm2IJ5ugnBPQ
3/n3RcWnc9LdVxjicvs19bBpnvb/c0YkWJZ6Yqt3Og6x0ias58iZKxg+GSdGImmi
vXdHcVtVfmiFN2MVGXxI0hi1WzmKxg==
=zKMF
-----END PGP SIGNATURE-----

--nakcmayqsjlncj32--
