Return-Path: <linux-pwm+bounces-2817-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ED1931BAF
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 22:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CF91C21BCE
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 20:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E52ADDA1;
	Mon, 15 Jul 2024 20:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hegxHZVI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CE2AF1E
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721074641; cv=none; b=SLVrABE6YVF6F4MzZ6YdsARrBZpWn9LsuAIFQ1FeOqTmVvDOfk0MFMCC8QSkbntQ0V+MQV7zTUFrSy+GGPcpcOxTC9LnyMpn1e5a9XkCWWcgPnwzep3GX2DIZayJVU6THVIcP57jlDkh4kaPQ5vSc157+7dhTo/8Alq/TqSDq7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721074641; c=relaxed/simple;
	bh=3EIIrKBBrhIsWxMcdit3iY8O2CsiiBccoG4hcuhClTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABkXi34AKB2KwscIKqgkxoQfLh7CK4gW5tPj4I4lxnaXKLuEGan79NDQIkpIVdHb6bn/oySvBCAAVmnqXHkSBIJ8AxQua1/E6x57mZE4tKvdm7FdDQsDUjJQnVtfan0/TJ1S9HZk1m757KJgBd4lHjCqx6F+yQmt5LqQgR16QW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hegxHZVI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6c4so6289842a12.2
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721074636; x=1721679436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVGPDMW5ACaePClC2HjhPkUzzvrjP1uyWUzR6u42Rsk=;
        b=hegxHZVInvYdZ9yxqNzlIzgLazMRUM0I2MwjLIwy1YBLAy2UQQ7yuGumliE315kKVB
         BMwXthdwD0YbakqqyybmehEp9b7b5Gp23MfooFiFJhdvnfLcft6j5L6gZgQjvi7jkBlb
         lcc507BHsW2muSyOztu73D0LibvbzyFJd6897aGfR0izOfmo12bR0c8WItU3pLFmPEwA
         +cQrV1DUfDUvL3a48xWLm6ktzy0mT4qnSGK5p4ajriApQ/OiBesS2bDhI7EIdpDLM8kc
         QiPiXTWhy2HArTpmAkDkakmZ633bidNgRlxwB2zlnoWxCoeuvl5MOl9ujCHgqHzLk1G3
         3+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721074636; x=1721679436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVGPDMW5ACaePClC2HjhPkUzzvrjP1uyWUzR6u42Rsk=;
        b=YODvLIHhH8CruIb11bdp36s53fRb91gLwnBnnfOFG6xZI8SALJwyF0XXQD1igODgMB
         uNiNQJ5Mf/hsrKNUuuxnJlUXQszZZaQ/wZNwN6ubcMif2g9vxLl5Q3TpXWISsDcuDF6H
         DQTIABJvzLbINVDS+TqD22vG9gh5w8korE26xmaDuiy96tSHWfQEsZQjvC4QQWRzZ7Q/
         Wk31ZbSzLqJlZAv44JcwjepXr+bAY1ukosqj5bPQLTynkVR7sihepEhKKADIQPBG9nRZ
         CfITdPvEzjsB2sOP1/lciYX493hXRrc/ROZXnH1HTcsGN40xQT2hXFYK0iGEvh+Nu2Kr
         Cr1w==
X-Gm-Message-State: AOJu0YwF7NWVX1/kr0bGaNM03zsevmV4x5rfcT8UJDnzxlX4FKqmzoci
	YGHCWAywcbF8m5NISaGf0Ga/DEX5Gr6StbJSPj7sgvv2Jf/xLFKiMyoRtr5PvSE=
X-Google-Smtp-Source: AGHT+IEwzbcC3u4UezNV8Oodtuk2nzGqlF87K1yJWM2BtQKoBucv3kg1u6BkBXl48JCveBS2M4rNlg==
X-Received: by 2002:a05:6402:5187:b0:59a:a997:6229 with SMTP id 4fb4d7f45d1cf-59e9923393cmr569654a12.40.1721074636381;
        Mon, 15 Jul 2024 13:17:16 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b25528cd4sm3753870a12.57.2024.07.15.13.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:17:15 -0700 (PDT)
Date: Mon, 15 Jul 2024 22:17:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 3/8] pwm: New abstraction for PWM waveforms
Message-ID: <yai3vygaf2k3udqaybn63uvokly64dfdxioyahr6g5vaj2isle@ycydrttrcvnp>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
 <a4bdcfd66bc40fd245f521b89797993eba993afe.1721040875.git.u.kleine-koenig@baylibre.com>
 <0b267668-a02f-4052-8075-d7134c9f8242@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gznwrz3z4ilotga6"
Content-Disposition: inline
In-Reply-To: <0b267668-a02f-4052-8075-d7134c9f8242@baylibre.com>


--gznwrz3z4ilotga6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jul 15, 2024 at 01:55:43PM -0500, David Lechner wrote:
> On 7/15/24 6:16 AM, Uwe Kleine-K=F6nig wrote:
> > @@ -213,18 +311,60 @@ static int __pwm_apply(struct pwm_device *pwm, co=
nst struct pwm_state *state)
> >  	    state->usage_power =3D=3D pwm->state.usage_power)
> >  		return 0;
> > =20
> > -	err =3D chip->ops->apply(chip, pwm, state);
> > -	trace_pwm_apply(pwm, state, err);
> > -	if (err)
> > -		return err;
> > +	if (ops->write_waveform) {
> > +		struct pwm_waveform wf;
> > +		char wfhw[WFHWSIZE];
> > =20
> > -	pwm->state =3D *state;
> > +		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
>=20
> Since this is already validated in pwm_ops_check(), do we really need the
> BUG_ON() check?

It indeed should not happen, and I'm glad you seem to agree it's safe.
The motivation to still keep it is that if (now or after some changes
in the future) I missed a code path, it's IMHO better when the kernel
dies on a BUG_ON (which indicates the error condition) than via some
stack corruption some time later.

> > diff --git a/include/linux/pwm.h b/include/linux/pwm.h
> > index 464054a45e57..2a1f1f25a56c 100644
> > --- a/include/linux/pwm.h
> > +++ b/include/linux/pwm.h
> > @@ -49,6 +49,30 @@ enum {
> >  	PWMF_EXPORTED =3D 1,
> >  };
> > =20
> > +/*
> > + * struct pwm_waveform - description of a PWM waveform
> > + * @period_length: PWM period
> > + * @duty_length: PWM duty cycle
> > + * @duty_offset: offset of the rising edge from the period's start
> > + *
> > + * This is a representation of a PWM waveform alternative to struct pw=
m_state
> > + * below. It's more expressive than struct pwm_state as it contains a
> > + * duty_offset and so can represent offsets other than $period - $duty=
_cycle
> > + * which is done using .polarity =3D PWM_POLARITY_INVERSED. Note there=
 is no
> > + * explicit bool for enabled. A "disabled" PWM is represented by .peri=
od =3D 0.
> > + *
> > + * Note that the behaviour of a "disabled" PWM is undefined. Depending=
 on the
> > + * hardware's capabilities it might drive the active or inactive level=
, go
> > + * high-z or even continue to toggle.
> > + *
> > + * The unit for all three members is nanoseconds.
> > + */
> > +struct pwm_waveform {
> > +	u64 period_length;
> > +	u64 duty_length;
> > +	u64 duty_offset;
> > +};
>=20
> Perhaps it would be helpful to take a hint from the IIO subsystem
> and include the units of measurement in the field names here?
> For example, period_length_ns or even just period_ns. This way,
> the value is obvious even without reading the documentation.

Good idea. For duty_length the "length" part is more important than for
period_length. And indeed I wasn't sure if I should rename period at
all. Being a fan of consistency I prefer to keep "length" also for
period (length). But I like the _ns suffix and will rework accordingly.

Best regards
Uwe

--gznwrz3z4ilotga6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaVg8YACgkQj4D7WH0S
/k4U7Af+OOsCDFVK+Nhgnkx9aSgt8+x5sHsLD5soIpRhGHD8JbXnuQ+6Im+J4UxD
pC+UHtLlfDOqYO6LSjQGVFVf0JMV9HyegcwgcZVZy1K966RhSQz7yz3TF/mONeKb
BUqat3Wx9hI4ExZggvj5jdBLJ0lyscL28ZoVfc+tyUygKAqxVCUiyz9YGFxpp1f/
2JhHnrk4s85o6y5hA17SHTiKiMg9l6tfYgzFmHoo9FW+yzL94I65Noh9nW4kTJLl
QrTSmTn7THh3AmkTTo4bk/Rao4TVxQfm3kpSBdND2PaAZKegl1ongaMG7or13MOW
gmRRhrdM5IYHmiL++G2Sk6H1nQFMkQ==
=Lf/q
-----END PGP SIGNATURE-----

--gznwrz3z4ilotga6--

