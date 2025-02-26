Return-Path: <linux-pwm+bounces-5004-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B52DA466E4
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 17:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3CE1887CE7
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2025 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311B220694;
	Wed, 26 Feb 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1v04m/g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E71821CFF4;
	Wed, 26 Feb 2025 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587693; cv=none; b=e9Q9tBYZk9+KL4S3RQFZxKNAczrbI0AXa3ROvvzT4uXZwEUmLjyJbT/QPCw5SROTZRd96fpbM4ywGIWTeq25wqNtvlPLCZ3yalbZ/f843n1lh0vNVPQmaN2o4ReoirqeG6CBOaIvu/RJarEjVFa1nkOnQkMpsLMXYMJoectWG8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587693; c=relaxed/simple;
	bh=mvx6+EXXly8II1zzsjmdmKG74+6KBaMwBa7GrjjKFVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzcgLPVk3+xtGHG7UyDPLLsVStEJ6GiM3TzToQw7m11UZIbHMX0aH+TGlqQIecOvLYHJk4ZM9947BZsx7nc+x7Nn0mFZ6udxE99lvcrp1d2VuzMOTlB/BF3ZycqLzwmSPUeXaverQlPI2DGiOqCVW+6X02FFuCPYQ7AMNv8RPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1v04m/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A07C4CED6;
	Wed, 26 Feb 2025 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740587693;
	bh=mvx6+EXXly8II1zzsjmdmKG74+6KBaMwBa7GrjjKFVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1v04m/gG7AL5wvVNPKsD+wqei/+x1E+JQo7GYgjWeCnMgyFcgyP3jxUyZCD/4dEy
	 PhYj3OJ+rEo3G+jfTIDfkrfqhUb9QmdPBGqXbgfqae/plKwXSfw9XDxFwrgFQn7RO+
	 vt+kbWjlFs6UG/YkxuZ2kajLR997Mn6k4uspIA1gNxapxwasjLOvhOX7ELg8GURtv+
	 +iSwtU+c739KQrmOxzJOXrYJl1gwuR+7r+a5DfxBbCBfK/rVum1TnUf7Akel6KaZl+
	 uIbey7eo7b4wIJF1J4ErFquTuVgcJf7xtywgDVJp1M7IQmwYaf2V0lbutHW2tTq8R7
	 31vEBpYOdXN0Q==
Date: Wed, 26 Feb 2025 17:34:50 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-pwm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] backlight: pwm_bl: Read back PWM period from provider
Message-ID: <xltamao27utfrsax2pc6mh5tthanmrqszz4k7gyw3knqkm24xp@4tydmhfh6g4j>
References: <20250226-pwm-bl-read-back-period-from-hw-v1-1-ccd1df656b23@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t53jomeslf3qf4an"
Content-Disposition: inline
In-Reply-To: <20250226-pwm-bl-read-back-period-from-hw-v1-1-ccd1df656b23@linaro.org>


--t53jomeslf3qf4an
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] backlight: pwm_bl: Read back PWM period from provider
MIME-Version: 1.0

Hello,

On Wed, Feb 26, 2025 at 05:31:08PM +0200, Abel Vesa wrote:
> The current implementation assumes that the PWM provider will be able to
> meet the requested period, but that is not always the case. Some PWM
> providers have limited HW configuration capabilities and can only
> provide a period that is somewhat close to the requested one. This
> simply means that the duty cycle requested might either be above the
> PWM's maximum value or the 100% duty cycle is never reached.

If you request a state with 100% relative duty cycle you should get 100%
unless the hardware cannot do that. Which PWM hardware are you using?
Which requests are you actually doing that don't match your expectation?
=20
> This could be easily fixed if the pwm_apply*() API family would allow
> overriding the period within the PWM state that's used for providing the
> duty cycle. But that is currently not the case.

I don't understand what you mean here.

> So easiest fix here is to read back the period from the PWM provider via
> the provider's ->get_state() op, if implemented, which should provide the
> best matched period. Do this on probe after the first ->pwm_apply() op has
> been done, which will allow the provider to determine the best match
> period based on available configuration knobs. From there on, the
> backlight will use the best matched period, since the driver's internal
> PWM state is now synced up with the one from provider.
> [...]
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/p=
wm_bl.c
> index 237d3d3f3bb1a6d713c5f6ec3198af772bf1268c..71a3e9cd8844095e85c01b194=
d7466978f1ca78e 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -525,6 +525,17 @@ static int pwm_backlight_probe(struct platform_devic=
e *pdev)
>  		goto err_alloc;
>  	}
> =20
> +	/*
> +	 * The actual period might differ from the requested one due to HW
> +	 * limitations, so sync up the period with one determined by the
> +	 * provider driver.
> +	 */
> +	ret =3D pwm_get_state_hw(pb->pwm, &pb->pwm->state);

As a consumer you're not supposed to write to &pb->pwm->state. That's a
layer violation. Please call pwm_get_state_hw() with a struct pwm_state
that you own and save the relevant parts in your driver data.

> +	if (ret && ret !=3D -EOPNOTSUPP) {
> +		dev_err(&pdev->dev, "failed to get PWM HW state");
> +		goto err_alloc;
> +	}
> +
>  	memset(&props, 0, sizeof(struct backlight_properties));
> =20
>  	if (data->levels) {

Best regards
Uwe

--t53jomeslf3qf4an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAme/QqcACgkQj4D7WH0S
/k4bwAgArDWKg0WhEwFLL4M/6k79bOAvJmMv8uejFcfzyG+Fd/V5nucWn7itRBo8
ocKADshbtsuMT2Nir9cg3s7PdimAOYQowvJdq+yrVpx4K3XBIgLmIdvZq+jM0ZBI
qCf7EeEFYnP/RmXj+Uo2vyKO8bVTRrgAgkERBEXBtAEJiYQnCQLJGs4YV2weHdI4
60kHuK9dj3VBrg+8kQt4t1I4+sPxAq82WUjY6CwMSDvSG/afgr80e+ROQJnsTLDo
Dd5Lt+R6aSaT2w2IxaX1m7lBYP9avafCk0mqcEsGI4H6q42VKZdKHza5bLw5gurH
v/1zfCMKzB9KZXQeomIYTu7C+vAhRA==
=rPaF
-----END PGP SIGNATURE-----

--t53jomeslf3qf4an--

