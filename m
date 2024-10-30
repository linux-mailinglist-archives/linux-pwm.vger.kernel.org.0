Return-Path: <linux-pwm+bounces-3971-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC119B5D58
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 09:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858821F22147
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Oct 2024 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D333E1C4603;
	Wed, 30 Oct 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nnvI9yec"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB518B46E
	for <linux-pwm@vger.kernel.org>; Wed, 30 Oct 2024 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275527; cv=none; b=Z8YiJsRB8hzRHk4y9Jwh/HrwLJU2QRYlgKTAOC2tNDvyoE+YCDh3Z242iFcjLhbL15hyUIf9Sr8G6hsrHQeLApgcWya18jRuSl0spiOf+ozKGfb9u7dKzyhlKsGiPGjG2jDnbrWPXSf1/U4ccRz/gLx/5x9K1MS/JdpOhd4R0pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275527; c=relaxed/simple;
	bh=xC9SDy6NXbn2MbGBsoWI1wrFZt4s6GO3mVUzc8cbiTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK/8yq0ro0D8HXv1qVrBFdjUwrpZhr5S+GJgPJMshyT6GOgmgtUlV5ynmFHlujpKIeZ2nU3QWAEvliBsVxtUg25PJNev1qUK6tIiDLrq93/LyNnIJsGPcwGS/PR3rEHrgg7m1e/Zzj40am0TiJ0gYTam7gWKnA7BI8u5dYZ20Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nnvI9yec; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d495d217bso5669808f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 30 Oct 2024 01:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730275523; x=1730880323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBSXK7Wg5WPAyNzi9dlLEOve6W9CQsYBAJ6iQX8H4CY=;
        b=nnvI9yecWX5PYC3ROyrEzSdvaXYbh7IfV079+W21tejbFQoM4BaqBmsZmWObDM5VI6
         vUSuZhvvlZR4NoQ2R8xOy3dgdzqljy53SphyB2NlEeLPm4EpCw3ODPI6Q/1LQFjxCKcj
         y5+vt7IWx89lMtE0SS+aoR+NgRF9XlKlpgxsMZzUO0jY5t/b6J0HbTOLr8XRhfycg5lU
         oYdTvJxZn/pefvFuccvwSkzdVdPlgH4yxFGg+O6ntwehHjKt5PZIKpXYBPCNfP5hSJZN
         e+z6vYGHGjfmEZyY9WSZAhztY141Cj1Zd2rMPlInz75nFPQuydfgJxp9B9H9/asI0mgx
         MyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730275523; x=1730880323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBSXK7Wg5WPAyNzi9dlLEOve6W9CQsYBAJ6iQX8H4CY=;
        b=HPJZMa5HtlqgIqgKdOgoMRKeu2j2mEYtro+iJrXFMZWGVoKKmCk5S5ElF4Lu07FjG+
         KmAwQe6HiByg8z6w8eoW2q1ElhJsbTYlk80dRDme6tsQIUU65QTxrahDFqcDfexHuGKm
         6zKLhyUfxYtWHZCdcY/AudHt3QxTum06i7MHll77UQJWlQz/n3Z+zXGsB8t6KFT7j4/e
         Q6Z1g63HYIndSl3VqWqapbMwmrKY35CxFnD6xJ5zxUEFzvTMfzwehFyOzum0SsGeS7g5
         XNgAMShlrkljRLLcHkU69JfcA9nWZi+QOTAjTw/4MRpuE3KmZH71Z7zDKrQKaXO+AKks
         22tw==
X-Forwarded-Encrypted: i=1; AJvYcCXeptxk9nPH+mXLLu0oX3JpjQT3Bu83ZwPW0KlQQoYbox0sYG/SWeBY/6oXgKpk4fGHig0BEi9u/Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7TLftfccnzk0dFtH+yAiPcjrgeROwloPp6QBxNa8PMEx+Pbx+
	tT7qjKFG71Vd3yTIZ/O0xTFC9/+EagSzBfSBehBTaK5w3P47NV+AkM9CnSEaBuE=
X-Google-Smtp-Source: AGHT+IGceO7R29gh2xhL8jB1UfhwxoZLLZgd3BfsnBexJNOLf5xxbem07mn/P4nQljDwmtDKiKtHBA==
X-Received: by 2002:a5d:484b:0:b0:37d:3705:84e7 with SMTP id ffacd0b85a97d-380611721b4mr13268064f8f.17.1730275523040;
        Wed, 30 Oct 2024 01:05:23 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd97d84bsm13254625e9.30.2024.10.30.01.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 01:05:22 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:05:21 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Guillaume Stols <gstols@baylibre.com>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] pwm: core: export pwm_get_state_hw()
Message-ID: <5nhyokdabeuw73btvkyyvoohbnqqyxpe64dxkrpwa4jvdpdqjr@zmpfnngcceq3>
References: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
 <20241029-pwm-export-pwm_get_state_hw-v2-1-03ba063a3230@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="prvkimffi7gaxyfc"
Content-Disposition: inline
In-Reply-To: <20241029-pwm-export-pwm_get_state_hw-v2-1-03ba063a3230@baylibre.com>


--prvkimffi7gaxyfc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] pwm: core: export pwm_get_state_hw()
MIME-Version: 1.0

Hello David,

On Tue, Oct 29, 2024 at 04:18:49PM -0500, David Lechner wrote:
> Export the pwm_get_state_hw() function. This is useful in cases where
> we want to know what the hardware is actually doing, rather than what
> what we requested it should do.
>=20
> Locking had to be rearranged to ensure that the chip is still
> operational before trying to access ops now that this can be called
> from outside the pwm core.

Good point, I didn't notice that in my review of v1.
=20
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>=20
> v2 changes:
> * Dropped __pwm_get_state_hw() function.
> * Reworded commit message.
> ---
>  drivers/pwm/core.c  | 40 +++++++++++++++++++++++++++-------------
>  include/linux/pwm.h |  1 +
>  2 files changed, 28 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 4399e793efaf..ccbdd6dd1410 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -718,40 +718,54 @@ int pwm_apply_atomic(struct pwm_device *pwm, const =
struct pwm_state *state)
>  }
>  EXPORT_SYMBOL_GPL(pwm_apply_atomic);
> =20
> -static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *st=
ate)
> +/**
> + * pwm_get_state_hw() - get the current PWM state from hardware
> + * @pwm: PWM device
> + * @state: state to fill with the current PWM state
> + *
> + * Similar to pwm_get_state() but reads the current PWM state from hardw=
are
> + * instead of the requested state.
> + *
> + * Returns: 0 on success or a negative error code on failure.
> + * Context: May sleep.
> + */
> +int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
>  {
>  	struct pwm_chip *chip =3D pwm->chip;
>  	const struct pwm_ops *ops =3D chip->ops;
>  	int ret =3D -EOPNOTSUPP;
> =20
> +	might_sleep();

Maybe this should be better

	if (!chip->atomic)
		might_sleep();

but I'm open to keep it unconditional until someone wails about it.

> +	guard(pwmchip)(chip);
> +
> +	if (!chip->operational)
> +		return -ENODEV;
> +

Huh, that means that __pwm_read_waveform() et al were called before
without holding the chip lock. How embarrassing. I think nothing bad
happens (because at this stage the PWM wasn't exposed to its consumer
yet and so no concurrency could happen), but still.

>  	if (ops->read_waveform) {
>  		char wfhw[WFHWSIZE];
>  		struct pwm_waveform wf;
> =20
>  		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
> =20
> -		scoped_guard(pwmchip, chip) {
> +		ret =3D __pwm_read_waveform(chip, pwm, &wfhw);
> +		if (ret)
> +			return ret;
> =20
> -			ret =3D __pwm_read_waveform(chip, pwm, &wfhw);
> -			if (ret)
> -				return ret;
> -
> -			ret =3D __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
> -			if (ret)
> -				return ret;
> -		}
> +		ret =3D __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
> +		if (ret)
> +			return ret;
> =20
>  		pwm_wf2state(&wf, state);
> =20
>  	} else if (ops->get_state) {
> -		scoped_guard(pwmchip, chip)
> -			ret =3D ops->get_state(chip, pwm, state);
> -
> +		ret =3D ops->get_state(chip, pwm, state);
>  		trace_pwm_get(pwm, state, ret);
>  	}
> =20
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(pwm_get_state_hw);
> =20
>  /**
>   * pwm_adjust_config() - adjust the current PWM config to the PWM argume=
nts

I applied that patch to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Best regards
Uwe

--prvkimffi7gaxyfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmch6L4ACgkQj4D7WH0S
/k5KDwgApe8+6qRz714F7VZDGYPSHpvJlgBvVHDUxARmJz3UbLD6bxux2z16SCft
fNuGMLcyuEZUVDDAgkJbJisOBGmO3OdRutS35F7tFTCNlx7Ge2x2ngc08ix32RY+
/6+3EDbDZvHGv0xvO+cSTv15u6BNN2kBri5qjyw+oH3bZEUAmcXW/+0ZIOXYTOLK
VgpkVAu3/cWfqbeMnxesCpc+SCkJuQ5udpEYgEW0dJLB7K1pdorUxRsKE9YDjpSC
SNkW0IdlIm1NFx8ExGUuAwY8bijNHffCSTWjz0HZFL+yf1d5MfWOosXi+n85FAdf
s0XQ/2Osvsw9bIEeijXdOOai73gpFA==
=Z/Pr
-----END PGP SIGNATURE-----

--prvkimffi7gaxyfc--

