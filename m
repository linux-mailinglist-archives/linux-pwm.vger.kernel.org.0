Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F012B3B8783
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 19:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhF3RSj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Jun 2021 13:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhF3RSj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 30 Jun 2021 13:18:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1767FC061756;
        Wed, 30 Jun 2021 10:16:09 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i20so5129345ejw.4;
        Wed, 30 Jun 2021 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pDIjLeXpC8f4SrwaNQHei9Q0hIuQjEOAhAQSLnVuvC8=;
        b=hLlMwpnnTWxASeGtVhEcVhZ1KBmmai5mafliMTkOA9oFWSqDUgXHcq2/Q7VPOro6Fr
         1DcQVkmKssQp7EFBWr3pVIiQkFIXzNRzOGftnFbIpmskyXULG9EWRJCuxWf1opfW1Vv3
         LQhdsG3omXbMCwVQqf0JiCOHhwlwnI/EvVzBNttffxyTkRAmFTJeefpIZ2XBAzftzqI/
         Hktr+ZjHaOGH27WGUQmwfxXyjgmoLjZ32Ov+mmtIWJKhTUVeLjCXmSnrzhzHgMePg2i2
         er6KLoSJxcWPsuM3WeikGobQb9tB4MR0Dn65Oi5gXY3lQfzH/EBM8Z5RKPAgM0QDlTG3
         LULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pDIjLeXpC8f4SrwaNQHei9Q0hIuQjEOAhAQSLnVuvC8=;
        b=Kep0fqqohU8rZuBnedKFkV6wOGeV0kEgOydrs8CblLlF8FNluNZHWGxTEykDviSbRs
         Q7ixysH5sMRvUg0eOLUSzB6XMIPpYUIfI8EW473sZk1UzNxus9GJPujspAkoc3MvoCvW
         bh3LN0lKq8PRDaUm+RhJSl1DtW/BZVx7l5crPQDIxrWNSdAeqPvRPPM95KB3C8jl1Hyo
         uiJrjiMTgLPN2uMeorYbADAe+hAttqrGMsJSd9ae+td6OuSJr3Nwq8aa3CocUL+4bn5H
         ZxkVSwoXZ06Eov6io8LEF69JsDNpch4eyKbMNhqdf7vamBcw5wmROthP1NdgNMeRg8Fb
         SfpQ==
X-Gm-Message-State: AOAM532GBJmN0B9t+axVR2UGh1kIiTWThibUK0I+A8k0+wI/4kkuMnCN
        q0hGmxN66nvnXXseKICTcXc=
X-Google-Smtp-Source: ABdhPJyFUczUrhBjdXstMpEss1HudE8rGx8nl2wIBoB8P1GCjyz67MFcPGe9C0wFR8x3rTnJNT9puw==
X-Received: by 2002:a17:906:c41a:: with SMTP id u26mr12319675ejz.270.1625073367583;
        Wed, 30 Jun 2021 10:16:07 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f14sm12766974edd.69.2021.06.30.10.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:16:05 -0700 (PDT)
Date:   Wed, 30 Jun 2021 19:18:22 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2] pwm: Ensure for legacy drivers that pwm->state stays
 consistent
Message-ID: <YNynXgD2jhUFLZig@orome.fritz.box>
References: <20210411160451.1207799-1-u.kleine-koenig@pengutronix.de>
 <20210501160943.108821-1-u.kleine-koenig@pengutronix.de>
 <alpine.DEB.2.22.394.2106292138100.1194476@ramsan.of.borg>
 <20210630064826.4u2p37tlbriiwtsn@pengutronix.de>
 <CAMuHMdV0w8mxxLVT4abrD-FgqS9Kg4BLomDQbXS_csdMyqhypQ@mail.gmail.com>
 <20210630162128.ufmul6euxkwnou25@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LmvJ9qUf5fEz3po8"
Content-Disposition: inline
In-Reply-To: <20210630162128.ufmul6euxkwnou25@pengutronix.de>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--LmvJ9qUf5fEz3po8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 30, 2021 at 06:21:28PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> On Wed, Jun 30, 2021 at 12:22:22PM +0200, Geert Uytterhoeven wrote:
> > Hi Uwe,
> >=20
> > On Wed, Jun 30, 2021 at 8:48 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Tue, Jun 29, 2021 at 09:44:38PM +0200, Geert Uytterhoeven wrote:
> > > > On Sat, 1 May 2021, Uwe Kleine-K=C3=B6nig wrote:
> > > > > Without this change it can happen that if changing the polarity s=
ucceeded
> > > > > but changing duty_cycle and period failed pwm->state contains a m=
ixture
> > > > > between the old and the requested state.
> > > > >
> > > > > So remember the initial state before starting to modify the confi=
guration
> > > > > and restore it when one of the required callback fails.
> > > > >
> > > > > Compared to the previous implementation .disable() (if necessary)=
 is called
> > > > > earlier to prevent a glitch.
> > > > >
> > > > > Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix=
=2Ede>
> > > >
> > > > Thanks for your patch, which is now commit d7bff84fe7ed8c3b ("pwm:
> > > > Ensure for legacy drivers that pwm->state stays consistent") in
> > > > pwm/for-next.
> > > >
> > > > This commit broke the backlight on the Atmark Techno Armadillo 800 =
EVA
> > > > board (arch/arm/boot/dts/r8a7740-armadillo800eva.dts), which now sh=
ows a
> > > > black screen.  Reverting the commit fixes the problem.
> > > >
> > > > Do you have an idea what is wrong, and how to fix it?
> > >
> > > I starred at the patch for some time now and couldn't find a problem.
> > > Looking at drivers/pwm/pwm-renesas-tpu.c I don't see something obviou=
s.
> > > (The .set_polarity callback is faulty as I doesn't commit the request=
 to
> > > hardware, but that shouldn't matter here.)
> > >
> > > I guess the first request the backlight driver emits is
> > >
> > >         .period =3D 33333,
> > >         .duty_cycle =3D 33333,
> > >         .enabled =3D true,
> > >         .polarity =3D PWM_POLARITY_INVERSED,
> > >
> > > which should result into the following driver calls (with and without
> > > the breaking commit):
> > >
> > >         tpu_pwm_set_polarity(chip, pwm, PWM_POLARITY_INVERSED);
> > >         tpu_pwm_config(chip, pwm, 33333, 33333);
> > >         tpu_pwm_enable(chip, pwm);
> > >
> > > Can you confirm that?
> >=20
> > tpu_pwm_config() is no longer called:
> >=20
> >      renesas-tpu-pwm e6600000.pwm: tpu_pwm_set_polarity:334: channel
> > 2, polarity =3D 1
> >     -renesas-tpu-pwm e6600000.pwm: tpu_pwm_config:257: channel =3D 2,
> > duty_ns =3D 0, period_ns =3D 33333
> >     -renesas-tpu-pwm e6600000.pwm: tpu_pwm_config:257: channel =3D 2,
> > duty_ns =3D 33333, period_ns =3D 33333
> >      renesas-tpu-pwm e6600000.pwm: tpu_pwm_enable:346: channel 2
>=20
> OK, I see a problem (though this doesn't explain the display staying
> off directly after boot):
>=20
> After doing:
>=20
> 	pwm_apply_state(pwm, { .period =3D 33333, .duty_cycle =3D 0, .enabled =
=3D false, .polarity =3D ..});
>=20
> .period and .duty_cycle are assumed to be set even though calling
> ->config was skipped because .enabled is false.
>=20
> So when
>=20
> 	pwm_apply_state(pwm, { .period =3D 33333, .duty_cycle =3D 0, .enabled =
=3D true, .polarity =3D ..});
>=20
> is called next, ->config isn't called because the core assumes
> .duty_cycle and .period are already setup fine.
>=20
> So we either must not skip calling ->config when .enabled is false:
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index ab38627bcacd..f8a5a095a410 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -558,12 +558,8 @@ static int pwm_apply_legacy(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>  		pwm->state.polarity =3D state->polarity;
>  	}
> =20
> -	if (!state->enabled) {
> -		if (pwm->state.enabled)
> -			chip->ops->disable(chip, pwm);
> -
> -		return 0;
> -	}
> +	if (!state->enabled && pwm->state.enabled)
> +		chip->ops->disable(chip, pwm);
> =20
>  	if (state->period !=3D pwm->state.period ||
>  	    state->duty_cycle !=3D pwm->state.duty_cycle) {
> @@ -577,7 +573,7 @@ static int pwm_apply_legacy(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  		pwm->state.duty_cycle =3D state->duty_cycle;
>  	}
> =20
> -	if (!pwm->state.enabled) {
> +	if (state->enabled && !pwm->state.enabled) {
>  		err =3D chip->ops->enable(chip, pwm);
>  		if (err)
>  			goto rollback;
>=20
> or we have to call ->config unconditionally:
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index ab38627bcacd..05d7afe25b42 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -565,17 +565,21 @@ static int pwm_apply_legacy(struct pwm_chip *chip, =
struct pwm_device *pwm,
>  		return 0;
>  	}
> =20
> +	/*
> +	 * We cannot skip this even if state->period =3D=3D pwm->state.period &&
> +	 * state->duty_cycle =3D=3D pwm->state.duty_cycle because we might have
> +	 * exited early in the last call to pwm_apply_state because of
> +	 * !state->enabled and so the two values in pwm->state might not be
> +	 * configured in hardware.
> +	 */
> +	err =3D chip->ops->config(pwm->chip, pwm,
> +				state->duty_cycle,
> +				state->period);
> +	if (err)
> +		goto rollback;
> +=20
> +	pwm->state.period =3D state->period;
> +	pwm->state.duty_cycle =3D state->duty_cycle;
> -	if (state->period !=3D pwm->state.period ||
> -	    state->duty_cycle !=3D pwm->state.duty_cycle) {
> -		err =3D chip->ops->config(pwm->chip, pwm,
> -					state->duty_cycle,
> -					state->period);
> -		if (err)
> -			goto rollback;
> -
> -		pwm->state.period =3D state->period;
> -		pwm->state.duty_cycle =3D state->duty_cycle;
> -	}
> =20
>  	if (!pwm->state.enabled) {
>  		err =3D chip->ops->enable(chip, pwm);
>=20
> I slightly prefer the latter patch, but if this is indeed your problem
> both should fix it for you.

The first variant has the benefit of writing all of the state through to
hardware, which is more likely to be what a proper atomic implementation
would do. Technically it shouldn't be necessary to reconfigure *and*
disable a PWM, but it's traditionally the safer way to make sure the
hardware is really "off".

In any case, I've dropped the original patch for now. Feel free to send
an updated patch with either of the above, I don't have a strong enough
preference for either, so take your pick. But given that this is riskier
than I thought, I'll defer this to v5.15.

Thierry

--LmvJ9qUf5fEz3po8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmDcp14ACgkQ3SOs138+
s6FTkw/+I8K3ohsl1dWUlTpPTTX3SkFmhjStgRFN6lSvBfCOCpdMsb3QRGRcCGEi
kr/rSuxgI8JfVkax6K83IUEQn9XUzgC0MfdgwgtrNr6150AKCxSO2rnyPtQ46YRH
RvH9iJC6rJYfN9kvW6SYpmwQhwyOI7jnh6NK1/NjybUDsvuMpjaEPW9F1numzodt
JFQVUyPKaLXrgD5Rw1AkKKkeQhBCt8McVrGTVPYqPvlZmxlIFpqW8qzUgRdb8FmZ
7TM9eFL/NjiE4z7nPCc11/NunREaR3i0tLIVFFOIs+ttcWyNMLMA6hcNH38BUhsN
7+9NsClpau6HnFmfTRmHlEYjNgQ+XgSJ/T7861VPFE3OQw0m8I9cROvnAQ5HRD0a
PqobeD0Onn+kGyJ0gWaFbjoyIuAs6Le3swRDEIVi1XSV6LMISqy3Un679mhF89ir
R15b3qK5YSE0fbrxSBP4vOFEkl52WEfNtSHHVQJRuAEf8McxyfzsTaGGOJt1JiME
rNyK7EX2oMMI8xChwiPKOQ3gozICWZ9G4QjEyL+07QlUHh3wpeSZoF0mjKliQ376
F74a7AS36/dp8zXxbrCV5n5lHwhmy5k3jcV+ywuRJ4+QsKKyO3ZlgNt00jLcKnG4
dnsjboBSmG/se97aJToy6zyUzT8FXBODvF549Dfi1Ch6WuOoU0k=
=0WuZ
-----END PGP SIGNATURE-----

--LmvJ9qUf5fEz3po8--
