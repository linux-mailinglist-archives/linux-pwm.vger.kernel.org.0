Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E65D343F56
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhCVLMu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhCVLMl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:12:41 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A126FC061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:12:40 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id 61so16203507wrm.12
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wgqCcp/jCKEsOBDUrYEIq93bqpzlD5V408Jv85w0RnE=;
        b=buiH3QX7xd2/x+1CrOu1z/1Kzp+jN0bBqswAlZW0rci66rRbWY+A9rzjCaCYZRnBRD
         dEgoOm8z3v/ZUNYf0bb4BJyF/4Y/h72knhqdOFvdlP/98mnxa1t3MhCtmbjV28h263jw
         r14O7KMTlGvYfu4luH6ABqLwsfby+xzFH81O3g1x9b+kaVn9xBfWj5cmZmS7FXe2A3Iu
         blXVa31JNFm+7MUJvb0/9Uv9vmjV9vFiaGLaOTbe/aBJxeH6YjoRBSzyBW7C+XLhdIlv
         kQRdP2r3KIfCUW2dGHzGPJDeiDJolDpcga9ZCiv9RVTepdInSD/kx2mqbxKGThC3ycwY
         6ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wgqCcp/jCKEsOBDUrYEIq93bqpzlD5V408Jv85w0RnE=;
        b=PDN8o5tWarcNUiVy8xWnn5Wwz/HKup2ngcV+ZA7fTZ/Lzwr+YK6YKAU6Ss9L+8LLYm
         xbM9YgTJ6/3l/9JK6Pr7uzD7tPSGPvAjgFjXbqtenlDBnTbJlRs55f6dJaBgwm+6Z026
         dwsfJBhFyee0DGnWzv0CLRzlfYZ8owOpTEy0Z+qHaHqpFKzlqWwFrqrMMrzsNM8RfzgA
         W/w9SHxsIQmWCWexXFCAYAmGPGOGP0dnCh3y+iBn6eek9F0nzCet/jCeDhxhDruCyEkS
         H5eFD7YYbqSvd2qLJLR9su5z/k5gLZXl6Tqk1iY+z4oeZDaZ5z7A82WszINONcyFaxHL
         WHwQ==
X-Gm-Message-State: AOAM531LLZzQxC3A+y1VpYuvYtt2rmpwVIokojoup/PiKjY5rdsQ9HsV
        j0I7r9S1vudN5C4c3x0gMPKr7fPEOJ8=
X-Google-Smtp-Source: ABdhPJyIIfgqTPCD7MNKfMkLqGikxVL9noJtoergsGR1LeRDMkBG0BSZxN6XneUHzMKhrB3zxSw+oA==
X-Received: by 2002:a5d:6205:: with SMTP id y5mr17463760wru.238.1616411559420;
        Mon, 22 Mar 2021 04:12:39 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q9sm19387683wrp.79.2021.03.22.04.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:12:38 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:12:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Guru Das Srinagesh <gurus@codeaurora.org>
Subject: Re: [PATCH v3] pwm: Soften potential loss of precision in compat code
Message-ID: <YFh7uCgeir4L+ZTf@orome.fritz.box>
References: <20210315080050.2337075-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZrNSc5Uee7EOKo4m"
Content-Disposition: inline
In-Reply-To: <20210315080050.2337075-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--ZrNSc5Uee7EOKo4m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 15, 2021 at 09:00:51AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The legacy callback .config() only uses int for period and duty_cycle
> while the corresponding values in struct pwm_state are u64. To prevent
> that a value bigger than INT_MAX is discarded to a very small value,
> explicitly check for big values and pass INT_MAX instead of discarding.
>=20
> Acked-by: Guru Das Srinagesh <gurus@codeaurora.org>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v2 (Message-Id: 20210312212119.1342666-1-u.kleine-koenig@pe=
ngutronix.de)
>=20
>  - Fixed indention of comment (noticed by Guru Das)
>  - Add Ack for Guru Das.
>=20
>  drivers/pwm/core.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4b3779d58c5a..b1adf3bb8508 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -605,9 +605,18 @@ int pwm_apply_state(struct pwm_device *pwm, const st=
ruct pwm_state *state)
> =20
>  		if (state->period !=3D pwm->state.period ||
>  		    state->duty_cycle !=3D pwm->state.duty_cycle) {
> +			int duty_cycle, period;
> +
> +			/*
> +			 * The legacy callbacks use only (signed!) int for
> +			 * period and duty_cycle compared to u64 in struct
> +			 * pwm_state. So clamp the values to INT_MAX.
> +			 */
> +			period =3D min(state->period, (u64)INT_MAX);
> +			duty_cycle =3D min(state->duty_cycle, (u64)INT_MAX);

Do we want to highlight this using a WARN()? It seems to me like doing
this would always be a programming error and easy to fix. Silently
truncating this to just INT_MAX may not give the desired effect and be
actively wrong most of the time.

Come to think of it: why not just refuse such requests with -EINVAL?
That's what drivers already do if they're faced with values that they
can't handle.

Thierry

--ZrNSc5Uee7EOKo4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYe7gACgkQ3SOs138+
s6Fe4xAAiC0YLWT/KrbcPfrZhPSp57htI2lXBOf3OMQp2wKWikwSHC4NYZK6gTSW
FnkLu6D0Ya8AMRxtf+cOeHjQjVepeMlbtA2WKC9pgMIM2n5cFxtF/2EfFoZboX49
rtQKScqqZqB4C16ufkozNdV+FjFNGqMDT+JRXiv4ri0E0FF9jjD0HuzL1I+yyNQ6
tx2/Ul2GQ3n2JPGonhvtotw10gdYP25+91pcuiCu28l17HXBqzcobFDr2tdLQc1y
sOJ16WikKmtydj4kg9EaOY8BnuoUnqiq8vot0PxB0GubCZo1SCU3rEpWs9TNbNy9
8en4Dr32jUsekA3cMpWVl/zO0R2W2H1JCDTbubPD6wSxLtrJDD6+eFstTtd31hI/
VTkYRncaShdx3ePJvA1zl+GPZE4RZzaWeJkke57uaBYNC9xDBiF8bmosb5G9UPfj
34yuE+m7XejmQCmEMXM15t4l9cLsQCpPLOLT79wlDamnaY2pqfajXiZEYna+GU07
v+JeCITc+GMPifUGXBQ4qc0GqBlZuaW1bCrKR9gyNW17YzQQz2o8f+Tygn1A4MWH
Vbl4oFsrFIzHtn0B8onXgkkGqmNLtNs6YnGdv3ka1JOsTBJ9KXGHRPkmSbQZOpy0
DG9ttNI11iOB7SVG88DHe20Ys4a5aJSQxnDXnP4wSlRnTOFPyT0=
=Crm6
-----END PGP SIGNATURE-----

--ZrNSc5Uee7EOKo4m--
