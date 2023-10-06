Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481E87BB4E5
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Oct 2023 12:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjJFKKI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Oct 2023 06:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjJFKKG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 6 Oct 2023 06:10:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE87EAD
        for <linux-pwm@vger.kernel.org>; Fri,  6 Oct 2023 03:10:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b64b98656bso339259366b.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Oct 2023 03:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696587002; x=1697191802; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eu4ltSFAgsNLorASJE0h+XVXz39l9OgRNHgiaoDjrE=;
        b=GddGlVSWmnMO1L7bhY/3ikIY/9d1vV0Gz1lpSr8dP27/fuC0gwdwb2q/4XtN0uhezS
         S9xeieABtDMOXKD//N7biHbdg8I0wQJlixX9/YexrifO52wUL2SCEtwbNhJA9wYlG8Lf
         P8lD9DWFyp3UdcG/UsOXsc60Rpb1tFAj0Pjs2HzO7L0UZdPPZKm/RrRzwgO1UVif1W2I
         fbTWutttPuOSR2V0Atx4rPvML08oyqb5k63CR26g7JZ4Hmn91sKUZvVDxx8cWD9JwNfg
         kQgoz0923VuCSWxYP0D0yeFrrWbMecJnmP0hemN4ZXjv3pPC/DqModn043jqRV9clzRG
         chzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696587002; x=1697191802;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eu4ltSFAgsNLorASJE0h+XVXz39l9OgRNHgiaoDjrE=;
        b=vX7NGAUW/rKBGSQq9pRB7ehytWiAm5vrxPTGv9Baepxt5gStJ7VeaiDMcxcUzi9QlN
         DZRAFqdvaS+bh9mVh1kjPEpO5tVBPm+sfOXqVp8b1QNyxNvS8nkl/iDP4FBIoFxLTGCB
         w1QGOGz6j9Z/UGv7jKEwELco9yuB3yPP/38vKmKgMLDqVJrTGnCs/dyP+0dJK4dPTVJ7
         uZy66ccv9oexxq3egtmLrSyJGIpnmeM/tLjzSGu5caum80ntodG32sfFbSo/MLWW606S
         v+4n96OR9RYO1KZi2nkof+qvZdi6nbqFJD/sHo/COP1hiKPnIs1mg0Rg2Ac4i8QnHhpR
         vfmg==
X-Gm-Message-State: AOJu0YzYGcjCRvL6qUZbMErnTTtDhs/D6Lkh7JkhxVNQAwzUMSja+1/Q
        syO6c2nsXQRIMLOtP661+gbf7DW6PzQ=
X-Google-Smtp-Source: AGHT+IH8H0zeVOhMZbnXfixByhpxEkyGNPvwhb4+NSo8Wp7bxYQ/nk4xUYa6d95yhTn2qYH36qqNNg==
X-Received: by 2002:a17:907:7857:b0:9ad:ef31:6efc with SMTP id lb23-20020a170907785700b009adef316efcmr6627489ejc.21.1696587002178;
        Fri, 06 Oct 2023 03:10:02 -0700 (PDT)
Received: from orome.fritz.box (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090617c200b009ad8084e08asm2598702eje.0.2023.10.06.03.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 03:10:01 -0700 (PDT)
Date:   Fri, 6 Oct 2023 12:09:59 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 101/101] pwm: Add more locking
Message-ID: <ZR_c99evPTimrQY9@orome.fritz.box>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
 <20230808171931.944154-102-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5KxTbeDQy5xgjRiI"
Content-Disposition: inline
In-Reply-To: <20230808171931.944154-102-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--5KxTbeDQy5xgjRiI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 08, 2023 at 07:19:31PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> This ensures that a pwm_chip that has no corresponding driver isn't used
> and that a driver doesn't go away while a callback is still running.
>=20
> As with the previous commit this was not expected to be a problem in the
> presence of device links, but still it can happen with the command
> sequence mentioned in the previous commit. Even if this should turn out
> to be a problem that could be fixed by improving device links, this is a
> necessary preparation to create race-free pwmchip character devices.
>=20
> A not so nice side effect is that all calls to the PWM API are
> serialized now. If this turns out to be problematic this can be replaced
> by per-pwm_chip locking later. As long as this bottleneck isn't known to
> be a problem in practise, the simpler approach of a single lock is used
> here.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/pwm/core.c  | 50 ++++++++++++++++++++++++++++++++++++---------
>  include/linux/pwm.h |  2 ++
>  2 files changed, 42 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index fcf30f77da34..66743ded66f6 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -230,6 +230,7 @@ static struct pwm_chip *pwmchip_alloc(struct device *=
parent, unsigned int npwm,
>  	dev->release =3D pwmchip_release;
> =20
>  	chip->npwm =3D npwm;
> +	chip->ready =3D false;
> =20
>  	for (i =3D 0; i < chip->npwm; i++) {
>  		struct pwm_device *pwm =3D &chip->pwms[i];
> @@ -309,6 +310,8 @@ int __pwmchip_add(struct pwm_chip *chip, struct modul=
e *owner)
>  		module_put(owner);
>  	}
> =20
> +	chip->ready =3D true;
> +
>  	mutex_unlock(&pwm_lock);
> =20
>  	return ret;
> @@ -324,12 +327,25 @@ EXPORT_SYMBOL_GPL(__pwmchip_add);
>  void pwmchip_remove(struct pwm_chip *chip)
>  {
>  	pwmchip_sysfs_unexport(chip);
> +	unsigned int i;

This looks weird, mixing declarations and code.

> =20
>  	if (IS_ENABLED(CONFIG_OF))
>  		of_pwmchip_remove(chip);
> =20
>  	mutex_lock(&pwm_lock);
> =20
> +	for (i =3D 0; i < chip->npwm; ++i) {
> +		struct pwm_device *pwm =3D &chip->pwms[i];
> +
> +		if (test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> +			dev_alert(&chip->dev, "Freeing requested pwm #%u\n", i);

s/pwm #%u/PWM #%u/

> +			if (pwm->chip->ops->free)
> +				pwm->chip->ops->free(pwm->chip, pwm);
> +		}
> +	}
> +
> +	chip->ready =3D false;
> +
>  	idr_remove(&pwmchip_idr, chip->id);
> =20
>  	mutex_unlock(&pwm_lock);
> @@ -505,7 +521,7 @@ static void pwm_apply_state_debug(struct pwm_device *=
pwm,
>  int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *stat=
e)
>  {
>  	struct pwm_chip *chip;
> -	int err;
> +	int err =3D 0;
> =20
>  	/*
>  	 * Some lowlevel driver's implementations of .apply() make use of
> @@ -522,17 +538,24 @@ int pwm_apply_state(struct pwm_device *pwm, const s=
truct pwm_state *state)
> =20
>  	chip =3D pwm->chip;
> =20
> +	mutex_lock(&pwm_lock);
> +
> +	if (!chip->ready) {
> +		err =3D -ENXIO;
> +		goto out_unlock;
> +	}
> +
>  	if (state->period =3D=3D pwm->state.period &&
>  	    state->duty_cycle =3D=3D pwm->state.duty_cycle &&
>  	    state->polarity =3D=3D pwm->state.polarity &&
>  	    state->enabled =3D=3D pwm->state.enabled &&
>  	    state->usage_power =3D=3D pwm->state.usage_power)
> -		return 0;
> +		goto out_unlock;
> =20
>  	err =3D chip->ops->apply(chip, pwm, state);
>  	trace_pwm_apply(pwm, state, err);
>  	if (err)
> -		return err;
> +		goto out_unlock;
> =20
>  	pwm->state =3D *state;
> =20
> @@ -542,7 +565,10 @@ int pwm_apply_state(struct pwm_device *pwm, const st=
ruct pwm_state *state)
>  	 */
>  	pwm_apply_state_debug(pwm, state);
> =20
> -	return 0;
> +out_unlock:
> +	mutex_unlock(&pwm_lock);
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(pwm_apply_state);
> =20
> @@ -566,7 +592,12 @@ int pwm_capture(struct pwm_device *pwm, struct pwm_c=
apture *result,
>  		return -ENOSYS;
> =20
>  	mutex_lock(&pwm_lock);
> -	err =3D pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
> +
> +	if (pwm->chip->ready)
> +		err =3D pwm->chip->ops->capture(pwm->chip, pwm, result, timeout);
> +	else
> +		err =3D -ENXIO;
> +
>  	mutex_unlock(&pwm_lock);
> =20
>  	return err;
> @@ -978,18 +1009,17 @@ void pwm_put(struct pwm_device *pwm)
> =20
>  	mutex_lock(&pwm_lock);
> =20
> -	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags)) {
> -		pr_warn("PWM device already freed\n");

Don't we want to keep this message? We do want to make sure that we're
always calling things in the right order and this might help catch
errors.

> +	if (!test_and_clear_bit(PWMF_REQUESTED, &pwm->flags))
>  		goto out;
> -	}
> =20
> -	if (pwm->chip->ops->free)
> +	if (pwm->chip->ready && pwm->chip->ops->free)
>  		pwm->chip->ops->free(pwm->chip, pwm);

These callbacks may do things like decrease internal reference counts or
free memory, etc. Don't we want to run those even if the PWM chip isn't
operational anymore? Wouldn't we otherwise risk leaking memory and/or
other resources?

> =20
>  	pwm->label =3D NULL;
> =20
> -	put_device(&pwm->chip->dev);
>  out:
> +	put_device(&pwm->chip->dev);
> +
>  	mutex_unlock(&pwm_lock);
>  }
>  EXPORT_SYMBOL_GPL(pwm_put);
> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> index 3dd46b89ab8b..f5b65994a30e 100644
> --- a/include/linux/pwm.h
> +++ b/include/linux/pwm.h
> @@ -289,6 +289,7 @@ struct pwm_ops {
>   * @of_pwm_n_cells: number of cells expected in the device tree PWM spec=
ifier
>   * @list: list node for internal use
>   * @pwms: array of PWM devices allocated by the framework
> + * @ready: tracks if the chip is operational
>   */
>  struct pwm_chip {
>  	struct device dev;
> @@ -302,6 +303,7 @@ struct pwm_chip {
>  	unsigned int of_pwm_n_cells;
> =20
>  	/* only used internally by the PWM framework */
> +	bool ready;

Can we find a better name for this? Maybe something like "available" or
"operational"? Those are a bit longer, but I feel like they convey more
accurately what's going on. In other words, "ready" is very vague.

Thierry

--5KxTbeDQy5xgjRiI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmUf3PUACgkQ3SOs138+
s6FEPQ//d4EPa8EfZtSjLYtppWXNB2HPfiTA6DvfnMQ3ejxk6jxeBguHHQ5v4vzH
J3GxlB+dtD2tTmMuS2l6MI2Y80igvrJjldUqvvi9/+O6dyWurvYOX5cQWdb1yZX6
gemx/Yv9EOqjBnX1Sv4NUFI+7oh1mT3/4pqi2DbmJm2dak3rvX/BisSxMtJQo8zi
0m8If6siSL/m+3K/wfEjbzVZjpTIHy92topNMNUz3TMJLTvQRG57tRnJa4pZ4he7
vX0qZ2OxapAAuh1bsbODMlCYYKq61XfAzB75tulrThPBVni4k02Za0aOIBz2ZvB4
9MhqXUk875kIK2NbSKrpX44XxSK6POpN6+WCxE1DDiy7cXbUhwVX1nx/iECBmVtB
XEduMUd1+cvfcH6em4p+9U6QdXgKxocwdmQWIYNEEde71imwfAWCRPSfnSnVDOaQ
upUiE/j3j2mj4gIqGZrmTW81SyqyejnHb/TVH8k04+iszhPFrC7SF4xtGkDQsYwW
lNGJyjl7afNryyF479oIZ7roQEu270WmUX53n/GOmt0scJjv2qGWWYaEWOtRAEJa
EUwUPthct0zx/4W3U52fRPB+kXKeUsth7rfFogAq6kyjH5UUkwnz4ArhuCIEjjCt
MuSaiVMxwLnUWVHbylGgkogLu2j6lhKOYkVYBt+kk7hQ2YF5hVc=
=0bDJ
-----END PGP SIGNATURE-----

--5KxTbeDQy5xgjRiI--
