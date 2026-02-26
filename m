Return-Path: <linux-pwm+bounces-8165-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOyRO5yMoGkNkwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8165-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 19:10:37 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AEC1AD504
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 19:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00341325A975
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Feb 2026 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA8335A3B3;
	Thu, 26 Feb 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGHdS78F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC998368955;
	Thu, 26 Feb 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128502; cv=none; b=WQFPxvy3p5EkqDLun2psXUbAlAP13mKQ85sI6gik+ukEV2rPQN5zMVMzpAjLu9KdHTFjBqar3Yz/iGZzmxeCXhrvAzAcxdQpQb2GGhgXmpUwzNhEjgTIxbNLFBQqPwF+swbrLU8JuVgVIT3W5SKbRdGD8qedgmUcIebBNeioR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128502; c=relaxed/simple;
	bh=kfgsSbuoxDr0tDtxGzuvF5k71tkpQVjUFxox7uxOLM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWVHv1r5BA+Q6ND1JYXhr49XJD/ib02f5RSq6MKc4ceGT0RY14NTpTCSJNYqeZMr6XxW8ZTOLzYxHMsyVgefwq8qpBujOYkc16lp8KDmGWskGYuJ2XWvYRvaCC1hcq0T2amg4daXdi/rSbQkPR8nByDQhY1yKnQD49KaYNih/R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGHdS78F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780D5C116C6;
	Thu, 26 Feb 2026 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772128501;
	bh=kfgsSbuoxDr0tDtxGzuvF5k71tkpQVjUFxox7uxOLM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGHdS78FZbugXlTNgu7x/qWlavOpSOJiXXFvJE2FD7p9jQjl3IiNbBAooHW3HdUNv
	 RDO6ZXt3sWl16LNL/AyNZ6k79rLGNZzpiJtDnQZclBMtk3kKoiewfCIq4Kx7GkI49Z
	 KOhCfAj6rGtoKvJLXMu+AFpP5aLqt6TdFOUFYDJrYMjQU91T/h3FdJMT427O6foral
	 pK3SQFA0u7EHBpjfw8EbhuFmmC22kYpzHIAFnHNAXsO5FUr40ikXFBUe97hP/ybrcW
	 df3AgxC8D3aruAtYNph42XC4MOh8+rowfEA08q2NYxUheWtLvpUzlJF/F7hWZA7FWx
	 +0cKUS5Gt/h7A==
Date: Thu, 26 Feb 2026 18:54:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux@roeck-us.net, julian.friedrich@frequentis.com
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
Message-ID: <aaCHc4q0I8Az7hpx@monoceros>
References: <20260225125159.20822-1-richard@nod.at>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3h2nkqhfa2uad3p"
Content-Disposition: inline
In-Reply-To: <20260225125159.20822-1-richard@nod.at>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8165-lists,linux-pwm=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ukleinek@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85AEC1AD504
X-Rspamd-Action: no action


--o3h2nkqhfa2uad3p
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] [RFC] hwmon: nct6775: Register fan PWMs as PWM chip
MIME-Version: 1.0

Hello Richard,

just a very quick look:

On Wed, Feb 25, 2026 at 01:51:59PM +0100, Richard Weinberger wrote:
> @@ -3501,6 +3592,131 @@ static int add_temp_sensors(struct nct6775_data *=
data, const u16 *regp,
>  	return 0;
>  }
> =20
> +static int nct6775_pwm_round_waveform_fromhw(struct pwm_chip *chip,
> +					     struct pwm_device *pwm,
> +					     const void *_wfhw,
> +					     struct pwm_waveform *wf)
> +{
> +	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
> +	const u8 *wfhw =3D _wfhw;
> +
> +	if (get_pwm_period(data, pwm->hwpwm, &wf->period_length_ns))
> +		return 1;

That looks wrong. In principle nct6775_pwm_round_waveform_fromhw()
doesn't depend on hardware state. It's supposed to just convert the
settings stored in _wfhw to wf. If you know that some things are
constant during the lifetime of the PWM and you read those from
hardware, return a proper error code, not 1.

> +	wf->duty_length_ns =3D mul_u64_u64_div_u64(*wfhw, wf->period_length_ns,=
 255);
> +	wf->duty_offset_ns =3D 0;
> +
> +	return 0;
> +}
> +
> +static int nct6775_pwm_round_waveform_tohw(struct pwm_chip *chip,
> +					   struct pwm_device *pwm,
> +					   const struct pwm_waveform *wf,
> +					   void *_wfhw)
> +{
> +	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
> +	u8 *wfhw =3D _wfhw;
> +	u64 cur_period;
> +
> +	if (wf->period_length_ns =3D=3D 0) {
> +		*wfhw =3D 0;
> +		return 0;
> +	}
> +
> +	if (get_pwm_period(data, pwm->hwpwm, &cur_period))
> +		return 1;
> +
> +	if (wf->duty_length_ns >=3D cur_period)
> +		*wfhw =3D 255;
> +	else
> +		*wfhw =3D mul_u64_u64_div_u64(wf->duty_length_ns, 255, wf->period_leng=
th_ns);
> +
> +	if (wf->period_length_ns !=3D cur_period)
> +		return 1;

Rounding down wf->period_length_ns is fine, so this must be:

	if (wf->period_length_ns < cur_period)
		return 1;

> +
> +	return 0;
> +}
> +
> +
> +static int nct6775_pwm_write_waveform(struct pwm_chip *chip,
> +				      struct pwm_device *pwm,
> +				      const void *_wfhw)
> +{
> +	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
> +	const u8 *wfhw =3D _wfhw;
> +
> +	return write_pwm(data, pwm->hwpwm, 0, *wfhw);
> +}
> +
> +static int nct6775_pwm_read_waveform(struct pwm_chip *chip,
> +				     struct pwm_device *pwm,
> +				     void *_wfhw)
> +{
> +	struct nct6775_data *data =3D nct6775_update_device(pwmchip_parent(chip=
));
> +	u8 *wfhw =3D _wfhw;
> +	int val;
> +
> +	val =3D read_pwm(data, pwm->hwpwm, 0);
> +	if (val < 0)
> +		return val;
> +
> +	*wfhw =3D (u8)val;
> +
> +	return 0;
> +}
> +
> +static int nct6775_pwm_request(struct pwm_chip *chip, struct pwm_device =
*pwm)
> +{
> +	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
> +
> +	if (data->pwm_enable[pwm->hwpwm] > manual)
> +		return -EBUSY;
> +
> +	data->pwm_exported[pwm->hwpwm] =3D true;
> +
> +	return 0;
> +}
> +
> +static void nct6775_pwm_free(struct pwm_chip *chip, struct pwm_device *p=
wm)
> +{
> +	struct nct6775_data *data =3D pwmchip_get_drvdata(chip);
> +
> +	data->pwm_exported[pwm->hwpwm] =3D false;
> +}
> +
> +static const struct pwm_ops nct6775_pwm_ops =3D {
> +	.sizeof_wfhw =3D sizeof(u8),
> +	.request =3D nct6775_pwm_request,
> +	.free =3D nct6775_pwm_free,
> +	.round_waveform_fromhw =3D nct6775_pwm_round_waveform_fromhw,
> +	.round_waveform_tohw =3D nct6775_pwm_round_waveform_tohw,
> +	.write_waveform =3D nct6775_pwm_write_waveform,
> +	.read_waveform =3D nct6775_pwm_read_waveform,
> +};
> +
> +static int nct6775_register_pwm_chip(struct device *dev, struct nct6775_=
data *data)
> +{
> +	struct pwm_chip *chip;
> +	int ret;
> +
> +	if (data->pwm_num < 1)
> +		return 0;
> +
> +	chip =3D devm_pwmchip_alloc(dev, data->pwm_num, 0);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	chip->ops =3D &nct6775_pwm_ops;
> +	pwmchip_set_drvdata(chip, data);
> +
> +	ret =3D devm_pwmchip_add(dev, chip);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Could not add PWM chip\n");
> +
> +

s/\n\n/\n/

> +	return 0;
> +}
> +
>  int nct6775_probe(struct device *dev, struct nct6775_data *data,
>  		  const struct regmap_config *regmapcfg)
>  {

Best regards
Uwe

--o3h2nkqhfa2uad3p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmmgiPAACgkQj4D7WH0S
/k7+qwf8DYvT9KnkwIV/jHr/jMcAGczIwwcEZ3mTbtmBytOsQ13yaljhIUtEI5BZ
e9Y5hzfKItnkJh/PxdvAGHHXxKI5w6Lkm1k/h2ywW/F8qOpZELz/sXyMzSM/hh+u
en3QDjhK+hTUAb4sNdOMYjMz++2sc5x6K6sepaIfcgdXohL2T6ixIFmgTChIHLMx
x09UkXMds3I7XPWjOl1042I7sYn1Fr+b0sBPqFKtvZstuE+Cw3QlpwvddX8SdVLD
g0YXBwOZ7IdNzto8zDkEpGLHgc3bSMzRjRnGsMDcXw4bjpMKJUpnH+1zV8cRajly
DoT6CvDOz7d9cM3yGZ3rMAIxnZOgNg==
=TW2C
-----END PGP SIGNATURE-----

--o3h2nkqhfa2uad3p--

