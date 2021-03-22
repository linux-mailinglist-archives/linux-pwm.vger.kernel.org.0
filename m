Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE41343EE4
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Mar 2021 12:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbhCVLGi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 22 Mar 2021 07:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhCVLGJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 22 Mar 2021 07:06:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932A7C061574
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:06:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v4so16195120wrp.13
        for <linux-pwm@vger.kernel.org>; Mon, 22 Mar 2021 04:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kyiTdUwNYw6dLidsLSPD0/SFf2GANz2OS8I8XIqxxEU=;
        b=tF18rZ9ZLeBFKR//uF/w5HvqYgYXKV9Q+VKS9iIapYZor5dTSj/6SVZf29oLmFUtDy
         N3Sg8YGLIeDwxZfSUX5f7Ar2f5WSSKcjrPjpoyf2JZawNVE5akxNhAVngrN6LQj6Nubg
         GQiA7ruxafjhPRhSbnONpyrwGUwcBqjf+EzqlntSMSzevfAVuYSAVDnWm+MEpdmv6KgI
         nZHf97WW98d7NBW45U6t53iGSaY+82SJfjGLc6cK36L2iCW9WRjmz2wEZDVQnZCdtYMd
         VOPQUaXFouKhBXSGZrd2ptbpzqzSwroTSjuwTKSF2j9syJyePeL4/CD0C3YqnAVZMJVN
         Kgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kyiTdUwNYw6dLidsLSPD0/SFf2GANz2OS8I8XIqxxEU=;
        b=d9huz8PZus6SSE7tA51TCw37b35eFeOZdKMYJ2xqH1+PyRVoVcpxXpbMQw/lmvKdkq
         Z2chiWUGQRaluDXmBmvr/nh9mXYJiPzplkq8ZgxLwAIcMBdg0ueaUcZYNUISCeqEPj84
         7TZep7dYP1vbQc/ffEGIrcBzVPGwTWDBt22B8hNvWFqBy4aQ0gRQZ6tElJoAvFKlpnQL
         0uEVgxTfE2lvFz0Wg6PCPEzs4XTvfrUygpBclwf/cx4d6GVXeqpjEkXjRhHDWvVIYEMd
         K2L4E0Lztt+R7JlKZyF86eBEzD8XoMGy4ERdB9fAtmNNuj2CybafzOgK0JAcMcW17xi2
         d2Mw==
X-Gm-Message-State: AOAM5314+SmULaztDfGIij5Jc3Z92XGGeWreLQXXCtlhOi1pT3Od0xQ0
        jY48Wu8VsxoBcIMW2282Qdk=
X-Google-Smtp-Source: ABdhPJxVAy1TJpPhiPg9dN98IWTzM7V/pHBTNNjQRbDQq8wUtotagPr2hEgSr/ECIVaJH8mShaJTVw==
X-Received: by 2002:a5d:6c6f:: with SMTP id r15mr17780686wrz.77.1616411165247;
        Mon, 22 Mar 2021 04:06:05 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j136sm16954644wmj.35.2021.03.22.04.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 04:06:02 -0700 (PDT)
Date:   Mon, 22 Mar 2021 12:06:20 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: atmel-tcb: Implement .apply callback
Message-ID: <YFh6LP1tVoO+8TLO@orome.fritz.box>
References: <20210308095012.26529-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6M/naGGbLMiNdL9l"
Content-Disposition: inline
In-Reply-To: <20210308095012.26529-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--6M/naGGbLMiNdL9l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 08, 2021 at 10:50:12AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> This is just pushing down the core's compat code down into the driver usi=
ng
> the legacy callback nearly unchanged. The call to .enable() was just
> dropped from .config() because .apply() calls it unconditionally.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Changes since (implicit) v1:
>=20
>  - fix typo in Subject (s/tcp/tcb/)
>  - Add S-o-b
>=20
>  drivers/pwm/pwm-atmel-tcb.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
> index ee70a615532b..4d2253f3048c 100644
> --- a/drivers/pwm/pwm-atmel-tcb.c
> +++ b/drivers/pwm/pwm-atmel-tcb.c
> @@ -362,20 +362,37 @@ static int atmel_tcb_pwm_config(struct pwm_chip *ch=
ip, struct pwm_device *pwm,
>  	tcbpwm->div =3D i;
>  	tcbpwm->duty =3D duty;
> =20
> -	/* If the PWM is enabled, call enable to apply the new conf */
> -	if (pwm_is_enabled(pwm))
> -		atmel_tcb_pwm_enable(chip, pwm);
> -
>  	return 0;
>  }
> =20
> +static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device =
*pwm,
> +			       const struct pwm_state *state)
> +{
> +	int duty_cycle, period;
> +	int ret;
> +
> +	/* This function only sets a flag in driver data */
> +	atmel_tcb_pwm_set_polarity(chip, pwm, state->polarity);
> +
> +	if (!state->enabled) {
> +		atmel_tcb_pwm_disable(chip, pwm);
> +		return 0;
> +	}
> +
> +	period =3D state->period < INT_MAX ? state->period : INT_MAX;
> +	duty_cycle =3D state->duty_cycle < INT_MAX ? state->duty_cycle : INT_MA=
X;
> +
> +	ret =3D atmel_tcb_pwm_config(chip, pwm, duty_cycle, period);
> +	if (ret)
> +		return ret;
> +
> +	return atmel_tcb_pwm_enable(chip, pwm);
> +}

Given that this applies the state in a hardware specific manner, I think
the shortcut for the disable case is fine because the internal, SW state
remains consistent. That is, if someone were to reactivate the PWM, they
would be able to do so by just switching the "enabled" state to "true".

The fact that the period and duty-cycle changes aren't applied to the
hardware is irrelevant at this point because there are no observable
changes to the physical signal.

Just mentioning this as additional information to highlight what I said
earlier in the PCA driver thread and to the "glitch" patch that I
requested a change on.

Applied, thanks.

Thierry

--6M/naGGbLMiNdL9l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBYeiwACgkQ3SOs138+
s6GbDw/6AlNBma78YDUc0AZdjQIptzfh00iWeck+Kp1NMaLLAPLh/MCJwbBGHU17
x3zPLzxXpIurJ8kAY4sUQYdeBq7bhA4huBhk+FsIPofGYteu7mk3ubR4b2q99jNr
vtdhiESBm6GuMlPexvFQdIOMA04/ri6Ww+l74445J1WkrKV702+3/qQVDzUld5JJ
xRgasRnWfHQVkl4mYJDtp31FXJn+b8135fe2whKu7qV7ON9h0fwv/IS0J+bH3T9c
GsoMPBbJi+XHVcbEMXjFGTCECmDkIbYq9KNibMYhwtevXqK4s/vuCVXsKYEsFQQP
0k1+ssHoeQTXGZGdkGJbdjuxGBdjTQB0MXoFGRQUZklOFiA7ZRhDSFT74KBZb5sy
Slka4y13KpVocFU0P2DPu7jHQ3yIKkHtdzhDUdVcy4WQLLiYM7UpbcX1ewXby+IS
q7ZyFsfeviPQjXNVEX0w9PdfXCb/GXHOUZm3QqTmWIe2AqLBY1qgmzwnaRJu2qum
l33StGMHhrN007hkeMYdJoiR112Gt2UljnJ+pli9Y9ZpPZGASisjKbvRwWLymAex
1ZG6hoOTDZGh+cJYltza0HxUqdv+aysvs9vN3Gj/AffPHjckB2xspm+ShEICa4ST
N9ogOQeQoNHrxiVB2DdLT3/r/sOxF+Std+esSMFRo7/XJl4OB5g=
=FhGW
-----END PGP SIGNATURE-----

--6M/naGGbLMiNdL9l--
