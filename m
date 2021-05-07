Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65BF37677A
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 17:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbhEGPEb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbhEGPEV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 May 2021 11:04:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34185C061761
        for <linux-pwm@vger.kernel.org>; Fri,  7 May 2021 08:03:21 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lf20c-0000O7-MC; Fri, 07 May 2021 17:03:18 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lf20b-0002zp-Vp; Fri, 07 May 2021 17:03:17 +0200
Date:   Fri, 7 May 2021 17:03:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Clemens Gruber <clemens.gruber@pqgruber.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM
 state
Message-ID: <20210507150317.bnluhqrqepde4xjm@pengutronix.de>
References: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5l7l24l74cfsloy"
Content-Disposition: inline
In-Reply-To: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--r5l7l24l74cfsloy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, May 07, 2021 at 03:18:42PM +0200, Clemens Gruber wrote:
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 5bb90af4997e..5a73251d28e3 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -54,12 +54,17 @@ enum {
>   * @duty_cycle: PWM duty cycle (in nanoseconds)
>   * @polarity: PWM polarity
>   * @enabled: PWM enabled status
> + * @usage_power: If set, the PWM driver is only required to maintain the=
 power
> + *               output but has more freedom regarding signal form.
> + *               If supported, the signal can be optimized, for example =
to
> + *               improve EMI by phase shifting individual channels.
>   */
>  struct pwm_state {
>  	u64 period;
>  	u64 duty_cycle;
>  	enum pwm_polarity polarity;
>  	bool enabled;
> +	bool usage_power;
>  };
> =20
>  /**

If we really want to support this usecase, I would prefer to not have it
in pwm_state because this concept is not a property of the wave form. So
for a driver it doesn't really make sense to set this flag in
=2Eget_state().

Maybe it makes more sense to put this in a separate argument for a
variant of pwm_apply_state? something like:

	int pwm_apply_state_transition(struct pwm_device *pwm, const struct pwm_st=
ate *state, const struct pwm_state_transition *transition);

and pwm_state_transition can then contain something like this usage
power concept and maybe also a sync flag that requests that the call
should only return when the new setting is active and maybe also a
complete_period flag that requests that the currently running period
must be completed before the requested setting is implemented.

OTOH the information "I only care about the relative duty cycle" is
relevant longer than during the transition to a new setting. (So if
there are two consumers and one specified to be only interested in the
relative duty cycle, the other might be allowed to change the common
period.)

Having said that, I don't like the proposed names. Neither "usage_power"
nor "pwm_apply_state_transition".

In a non-representative survey among two hardware engineers and one
software engineer who already contributed to PWM (!=3D me) I found out
that these three have an intuitive right understanding of
"allow-phase-shift" but have no idea what "usage-power" could mean.

On a side note: The hardware guys noted that it might make sense to
align the shifted phases. i.e. instead of shifting channel i by i *
period/16, it might be better to let the 2nd channel get active when the
first gets inactive. (i.e. try to keep the count of active channels
constant).

And as already mentioned earlier I still think we should define the
concept of "usage power" better. It should be clearly defined for a
driver author which setting they should pick for a given request. This
removes surprises for consumers and guessing for lowlevel driver
authors. Also a uniform policy brings conflicts better to light.
(Something like driver A does the right thing for consumer C and driver
B makes it right for D. But once D tries to use A things break. (And
then maybe A is changed to fit D, and C doesn't object because they
don't read the pwm list resulting in a breakage for C later.))

So in sum: I think this concept is too inchoate and we shouldn't apply
these patches. I would prefer to go for allow-phase-shift (if at all)
for now. There the concept is clear what is allowed (for a lowlevel
driver) resp. can be expected (for a consumer).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--r5l7l24l74cfsloy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmCVVq0ACgkQwfwUeK3K
7AnTuwgAhP667IaX+Z5p2hqnp++5ZCSeUJr7CCWWn4FPrv/YvY+6Hmb124IHkyN4
7ve3JPC3uk+3b79IlihpbTQsv1X1oUw3ZtdaD2wHoBrzBkloTBk2bP8X4+AXNg1i
XgrQmcJ2j10RI8m9KFXvsnjEcGxL15Lcondxt/iJkhISpW9Adz1fcg8bsaFPySww
C/6UUpB8wet/hHeCFSqgOepoYmibkgYbr7HIHNO2aSnNJuTu1z9wS5WfqoSFARw9
1f4P0JP+Ouz1OV6nwgAP0HfpKSmoc4nCdeKOtlxLEBpQX6pEVABSXtqIvF7v2N2l
+bG+a2Sk1XpAGdkuLhGmo9NHF+NrWg==
=Y7ZD
-----END PGP SIGNATURE-----

--r5l7l24l74cfsloy--
