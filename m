Return-Path: <linux-pwm+bounces-6619-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D085AEF080
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 10:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1488440C3D
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B3926A08D;
	Tue,  1 Jul 2025 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AqjpnFTG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D072690F1
	for <linux-pwm@vger.kernel.org>; Tue,  1 Jul 2025 08:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357260; cv=none; b=Yyzng5KfzKkAjJ4Non/t/Z8g3/jr+a8Fn4GW7De3X74bmFpcRITFc8nlH6UpzvBob4g9taAfHNWEV0/dQXZsXznE/qQ4GWFKbXDYIYMqOEXcyLuURFfEG4fHZNfJ0kmExTTFKGRtXlXIbtRnRfubUe05osC62EfWPBJz6iCIHnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357260; c=relaxed/simple;
	bh=H0Y4Y+6gT+bDypAMIHZWwwMwEHGCor/BmB+uA98E2OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MulN40V8dVXcEHGKkSgCjsQ2i1107YVKQrBU7bLVu1TJrtrotPJlL18Y84dNu066ZJHQQtY+heqV6eTnxxfM+pTD3UfnCaG2Tn+t10CblwDGKlbPWW7XntjOA9rGvw+2TIq/9mdUJLLwmloun/90k0786L+kISLyF8yDnkLHEyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AqjpnFTG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-453066fad06so35810715e9.2
        for <linux-pwm@vger.kernel.org>; Tue, 01 Jul 2025 01:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751357256; x=1751962056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H0Y4Y+6gT+bDypAMIHZWwwMwEHGCor/BmB+uA98E2OM=;
        b=AqjpnFTGEtugxyyAcHyl681om2dHnlCy8CdjgqBVqbtw5TNLTs4zFvZ3bNcYK1azHg
         biMD624SqsVQ4u3qrTxNITdcGsNJOnHnTHyFQzsrGcvG9CRi1ksp88mOym8uXZN7kxQp
         2xaf0GOrE1rZ/bWsYvHIqB9kQ0jbjSZ2bvSTkH7Kwr2kLZMTZ0I806vPue/L3xlSm7o9
         +MjI7oSQH5ubov93lLpPIyJIq2+6B0ZsnfMBbH82O6qtSLao2sTbVv7CbrpC24PSq4le
         8EtlC0Ol9JnTF9rmRbPCmv+qdopbO5fkvaW2rccimOlPUNZoNKF/1QpMfajscnJPy7fq
         A4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751357256; x=1751962056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0Y4Y+6gT+bDypAMIHZWwwMwEHGCor/BmB+uA98E2OM=;
        b=WZp8PtdbzmiP8PeY10N4KmzUmNZaxxlaFtZ06MFxQvaWYZAXATfCqLtUKTHhS39j7W
         9/0Ei7gqewxMbNF8BVB9ABEQ7xRmYi5kcirDKpUW6MuUcCWcTRuYx3Ppk/cAntS1oSwU
         gtmJ1/nBxiXiNAwu2VMzOUD4dFqSAhfIrFsbsKbMA3kXdobloTO7HhPrcxVulmjK9GfI
         YZ03K1SztcG7gp4jA7E5beXiovKgfgzxbS/6v+MY1coWL3IILGPqJfp/aMKD2yl7sm0N
         Nkgy/4dhzuQJsBhxs5+EAR8rDDbEl3qJPXzj4qdcuQ1YRugQHK5aSHeIvPLOsHfI3KdT
         MJJg==
X-Forwarded-Encrypted: i=1; AJvYcCUc8T5ma2+hFWSlE+Fkql5Un+8q1HpLbHuHN8clF5XDx8D6X8nMupv+bFWtVMBknGJPoKj/ZfGZEjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfHiK99Eb45u5+/fic2D/53u+3wDmeaT+n9DvTZNJKFQzXRlL
	lZ9U2hE8lat9sel9iMFQWdEFCyNOUGZ3ufb1z+G8QAeU+IXPwjRJRxQcDZDry2Wdmkg=
X-Gm-Gg: ASbGncu/0dBTc0xkoEOXVAIJXne0dHKtTNtV9FRfrKGQBBJFb99iKnCPNH52/i1HdfB
	/cp7bD8Np/RbGNYviLcJXQqFxu1rftsb+ezh0o0RvSNTOyyv7gOp5sXMiEbxk4M63OXDHrmg+YT
	8PllUOG+vSquE55vp6katrIW7vHYYtM3ebY+fC61Uwyp5TO0g1CicjmPcqUBAQyS8ioA8fY3GKv
	TspWnzwnnde+a32dUIN3rxLW6H5UwQLFZQ1NFSORAmBAudnlxxRbNPJteYdocYpYI6L3BCJP8YO
	sJIs3a81aSeYfT773if31XA0yGglb50Drlo7ZDy2W927+X676SMpkoGOfRycMipWMOTamFD+IGT
	K2digE3kJnEqFNNq1xRUwNocPlCa4
X-Google-Smtp-Source: AGHT+IEkvw7q8yaEKSS8eRq5KhPLb/USfD4VwQI9bANbNz4VBucJ8+YaGLRWc+lnBjN/LzGzNJ94Sw==
X-Received: by 2002:a05:6000:4211:b0:3aa:34f4:d437 with SMTP id ffacd0b85a97d-3aa34f4d5e9mr10737912f8f.37.1751357255736;
        Tue, 01 Jul 2025 01:07:35 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a892e52ca4sm12574894f8f.58.2025.07.01.01.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:07:35 -0700 (PDT)
Date: Tue, 1 Jul 2025 10:07:34 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2] Input: max8997_haptic - Optimize PWM configuration
Message-ID: <57t6j7caxdtrf5iakjjekns6vslc7f2slnj2dodfjnojgak2t2@yh7h2dvcigve>
References: <20250630093718.2062359-2-u.kleine-koenig@baylibre.com>
 <gu55xwoyr2zolonk2dxupmflcpgqgqp4kh4v4ulpluvsdwik3r@gm2he7khmtut>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xzuleplk7zzz7weg"
Content-Disposition: inline
In-Reply-To: <gu55xwoyr2zolonk2dxupmflcpgqgqp4kh4v4ulpluvsdwik3r@gm2he7khmtut>


--xzuleplk7zzz7weg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] Input: max8997_haptic - Optimize PWM configuration
MIME-Version: 1.0

Hello Dmitry,

On Mon, Jun 30, 2025 at 12:34:11PM -0700, Dmitry Torokhov wrote:
> On Mon, Jun 30, 2025 at 11:37:17AM +0200, Uwe Kleine-K=F6nig wrote:
> > Both pwm_config() and pwm_enable() are wrappers around
> > pwm_apply_might_sleep(). Instead of calling this function twice only
> > call it once without an intermediate step.
> >=20
> > Setup the PWM in max8997_haptic_enable() only where it was enabled
> > historically. max8997_haptic_set_duty_cycle() is renamed accordingly to
> > make it clear this function is only about the internal setup now.
> > pwm_config() was called earlier back then, but that call has no effect
> > on the hardware when the PWM is disabled, so delaying this configuration
> > doesn't make a difference.
> >=20
> > As pwm_apply_might_sleep() is used now defining the whole state of the
> > PWM, the call to pwm_apply_args() in .probe() can be dropped now, too.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
>=20
> Applied with a couple of minor tweaks, thank you.

I looked up your tree, found that commit and looked at the differences.
They are fine, thanks.

Best regards
Uwe

--xzuleplk7zzz7weg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhjl0IACgkQj4D7WH0S
/k6knwgAiuzH4vkp1G1sEMYiQud9QwFbf8hWt9RVmSFDbliu3fBD6s9mf77frTnN
SfVrgR34DdjPqPalq9lEqOmMMhunwKFLM61UPP8X309CIkirinlyspzyd7O5/s+Z
fAITIEwYtUBzLZR54MSbKxKwd9SR5cNzxSRtJR9UZW7yXrYa+v8AniYGXdmKi0BT
LqHXLcprxC7q/qJe6qdC82PeXM0SyemgC+tyxlGUJqpIcYcBDexyAfE98SENnprF
NRKoTuU0HBsH8I21nQ4M57ue64Gz/zcOSMOJrBPidq+T6Giv1m22wsaSYS9cOejk
DXACqkdJ1YVqGkea43pXo/ekR8YjYg==
=lHs2
-----END PGP SIGNATURE-----

--xzuleplk7zzz7weg--

