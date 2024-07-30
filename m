Return-Path: <linux-pwm+bounces-2934-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A236C94099D
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 09:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 261EE1F26720
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 07:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6919047F;
	Tue, 30 Jul 2024 07:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d4USGYZp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA829190051
	for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324180; cv=none; b=kTE2bkgfjj9SKYrYqUVAgLbo06/Yhsx0hFB0GbTEZOTNlOWXYql6GcZF1gQ+YcFk/BmK7BbPv01by6f4bGlJi8HCytKFQx61kXKExWWq9oO3B35NPDoOvvWUAoLYkD4Y2OqfrLUPQSisfF3i6WJHFru1XpJTwGVpVY3CU+LEeGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324180; c=relaxed/simple;
	bh=QpYg136FhucDRi79m4MFpL2EqBEeBQgfY8ZLbFP+9Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE68mSp4hiTJe0/p2i88PaPBvVvOkoQRTi319JX9Hn6rxnLEdpzHz9xmBZAS5zyOL07fDhdjhWaXOPx1USUQeKx+pPWhPJQUnScjAaV0NCbwTTgqQ4I6knKPi+koUBcRt9M7VA657qicfcMtU/PiRmkQ8k7ZZZd+paSnMMBCCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d4USGYZp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52efba36802so7284827e87.2
        for <linux-pwm@vger.kernel.org>; Tue, 30 Jul 2024 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722324176; x=1722928976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTYxcpi+JYSsMyYTJBPyQqfPeZsJ9uV9/vT4R68i47w=;
        b=d4USGYZp6RT1+/6XZtORRBzIs8OL9f2b4mkJhPbDvZpPO1BO09fCSo7wkSJvneXhWQ
         VgijhocVWzS8QvSwGcP/GN40JnlgBM0wysKCyBw5yi9l2qHO37I+hpQtpdhiGMBXzAza
         jMmnkKSXSztzmPXDMfiRGDJi2BRz0tqw/29hTWSCM4B1sNOk5ELmzEvgeOxdA25UjqMb
         t1pr8iqdwUOZoqsyY+HPv8fQRpEfF8U/6tgcNaYeS6doD2YfUiTwNXwhF74drb4sEKtT
         qoj6XvkCWNQYPIv8QqXg641YrGPr5eGYlvoKRnld0c0NXQQuW1x8wywd4C147a2sK2iP
         eVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722324176; x=1722928976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTYxcpi+JYSsMyYTJBPyQqfPeZsJ9uV9/vT4R68i47w=;
        b=RXQFO5DKqRNuBsR5x4CRToMUaOZrBO4SL8h/ZL/i06TTSdW0kfRVDAqEslAHErbrR8
         SCdfe03q8TKZsRsIQjGQPDEn51ReQja1yI23n0LtI1rZlWkvAXqlGKdrV1J/rCecGwOR
         0FPte2N8mPmywEhNjfXr9DqoqihYPTYi+C493NlLjAL52IaftoiG17UZkZK0cMugYF6y
         tvzhimfyq+dxSM49hMBktHkFl54Ys4ruSXcx1ZE+UKUptai/07xFcy4kCb76o2BDWyqt
         VV43FZ/D2xru2We+tBBeC8GWg5w8qVMoTgVbStKoIrf9d2EK3cLeYYxnKadaX63rIw0G
         RhUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6rpYrxfZDlE4UobawyD4FAJzJLXHtrxppCkqDrvnFVfYvfWy7R3/AOfpPjo9IY5auSPciObq/PewqinOexTZ+Tl0xQLzmKgT
X-Gm-Message-State: AOJu0Yxo+5pz+e1ADJl/jSa0JZpx6+vrSdGt3eo3Kvv5YBcDe7pufoEW
	b0vGU60DJkXq157vyiLaV9Ha/fsA3Wmcy5WdjF4KbmT8eI8h3TNWJ5YJlJqDvA8=
X-Google-Smtp-Source: AGHT+IHRdFPhrkXZTlZa2S/uFPF6Q9PkJTGNLXub6r1I7FIJXxoHmxdDzhF95NGsXetZWlFMaWfkyw==
X-Received: by 2002:a05:6512:3416:b0:52c:1d8a:9716 with SMTP id 2adb3069b0e04-5309b270b3cmr9534745e87.19.1722324175528;
        Tue, 30 Jul 2024 00:22:55 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5af507c6e9bsm5491636a12.54.2024.07.30.00.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 00:22:54 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:22:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Make info in traces about affected pwm more useful
Message-ID: <qye5vuh5hzoemdciohq3x4oofjpvw6pwe777loqacqfmhf4grg@5gtprhv3g377>
References: <20240705211452.1157967-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4jgwgwyg7duaxdo4"
Content-Disposition: inline
In-Reply-To: <20240705211452.1157967-2-u.kleine-koenig@baylibre.com>


--4jgwgwyg7duaxdo4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 05, 2024 at 11:14:51PM +0200, Uwe Kleine-K=F6nig wrote:
> The hashed pointer isn't useful to identify the pwm device. Instead
> store and emit chipid and hwpwm.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> ---
>  include/trace/events/pwm.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
> index 12b35e4ff917..8022701c446d 100644
> --- a/include/trace/events/pwm.h
> +++ b/include/trace/events/pwm.h
> @@ -15,7 +15,8 @@ DECLARE_EVENT_CLASS(pwm,
>  	TP_ARGS(pwm, state, err),
> =20
>  	TP_STRUCT__entry(
> -		__field(struct pwm_device *, pwm)
> +		__field(unsigned int, chipid)
> +		__field(unsigned int, hwpwm)
>  		__field(u64, period)
>  		__field(u64, duty_cycle)
>  		__field(enum pwm_polarity, polarity)
> @@ -24,7 +25,8 @@ DECLARE_EVENT_CLASS(pwm,
>  	),
> =20
>  	TP_fast_assign(
> -		__entry->pwm =3D pwm;
> +		__entry->chipid =3D pwm->chip->id;
> +		__entry->hwpwm =3D pwm->hwpwm;
>  		__entry->period =3D state->period;
>  		__entry->duty_cycle =3D state->duty_cycle;
>  		__entry->polarity =3D state->polarity;
> @@ -32,8 +34,8 @@ DECLARE_EVENT_CLASS(pwm,
>  		__entry->err =3D err;
>  	),
> =20
> -	TP_printk("%p: period=3D%llu duty_cycle=3D%llu polarity=3D%d enabled=3D=
%d err=3D%d",
> -		  __entry->pwm, __entry->period, __entry->duty_cycle,
> +	TP_printk("pwmchip%u.%u: period=3D%llu duty_cycle=3D%llu polarity=3D%d =
enabled=3D%d err=3D%d",
> +		  __entry->chipid, __entry->hwpwm, __entry->period, __entry->duty_cycl=
e,
>  		  __entry->polarity, __entry->enabled, __entry->err)
> =20
>  );

I think the patch is obvious enough to be ok even without the tracing
maintainer's blessing. I applied it to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--4jgwgwyg7duaxdo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaolMsACgkQj4D7WH0S
/k6BlAf/SpIzdn/vuKYv7O8al30gASRsLMQDTTJc5u3aLOrVrVzFW0ze4YudCWYm
3Ys6W4cUU80VIs/2Hdy9TSjhzkP0DUqaXoHYrZOBHqyOfZWj/YZqKvBEgN0FXxkw
iqJfll6iJIsVP154PX0iwyXKBejFd3G+B/h7XZn647lARdYjgMWiICo3H9j1EjWq
/aMaCIsjXEjF/q1B7+oBIE/ZInmgL/GF3PxAtMIbg3mqfBdL1gq8J8bu9rTGxZbZ
MmNv2H4ROMePiWPNAGiM+KgjR3Q2zwTlBVxPzivkqESHwXBHOzHkk0duDVVvq9eD
cb4BTZw9WMK7gyqWrBBbwDUecqEBUA==
=IAIp
-----END PGP SIGNATURE-----

--4jgwgwyg7duaxdo4--

