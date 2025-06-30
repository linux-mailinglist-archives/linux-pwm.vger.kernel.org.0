Return-Path: <linux-pwm+bounces-6575-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2295AED6A0
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 10:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8ABC1884DF7
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 08:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C034A23;
	Mon, 30 Jun 2025 08:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cE4qjfu7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F5217704
	for <linux-pwm@vger.kernel.org>; Mon, 30 Jun 2025 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270740; cv=none; b=Rg1dFVurdZJ/KKu5qBCq6bu9iCUWR6BH9et4b7rQmH3o9gUeX90lS8PmHysWV5iG0FUuG7kLJJB//tcZs5A+HzPbDKj7BBaKklfjnUXNGflU1aj3nkbtAfx6jHkzmy0VDLaC879aYCQ1ijQv3mfiiU9dl4XgNtgX2cjIogWfPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270740; c=relaxed/simple;
	bh=ZmwJqeAo2BLZZhW2DbJGK5Xvo4oxQ9K4lFzIdnopl6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdG2OUfWo01bIOu9DNjgNkv0Cy6LmLTmhr6ILohzfRup3ITI+dUnvAbfJQsaQ024wPcuNCrYtmA4nCwCRumd1J2/KQ4r2C82LqTAWYLptieYWC7ZdC0MKqtTeZ0FL28PIZA1WQ6vBECWUTCXdBStlYx0CuWbdFsFnFr6JID7dco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cE4qjfu7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso3666878a12.2
        for <linux-pwm@vger.kernel.org>; Mon, 30 Jun 2025 01:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751270735; x=1751875535; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmwJqeAo2BLZZhW2DbJGK5Xvo4oxQ9K4lFzIdnopl6c=;
        b=cE4qjfu7y6RG8agCcKyJYD2yQRFjFY1nCZCL+BQGxBM3Blbs2AhJVMpq1HAGsKDhOD
         wnYMUd/5mFE7hIb/609ZWJO0zdp9BAmF8YF97HQon14pykWxrgjd3NvzHxGnuC1KP2or
         1URFhjf2Cuuf+98c4Uksd54hjm/Kh494h/+3tbeXo7w35uP8x89ZlcxZHiMGpRUua6Gg
         9rH+VjSpTz8Z41Plp1Y9jkcVv2VNAZzsV9hujooVGT8gQXfqB2jL0BC52SiLZx9az912
         /p3xMh4Zz3d1koFvYmThibSGdAkXgzUsD9U8WmFfSDkA+3xRDk6Y9YVZa86R2dlIbatt
         dhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751270735; x=1751875535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmwJqeAo2BLZZhW2DbJGK5Xvo4oxQ9K4lFzIdnopl6c=;
        b=aP4llQ7wfjmlty3McPpwr4JmQxi5eQqCJ5VU9CAcV8fhM/2FUsrgd0ug9YGrWhlXIO
         eNsDsRANxZFhbfO7SJzn2eEWRtKCbR/0Kmj5HKtkgSoF6iJ5twVf/385nSbhLtVxDEAe
         alTbmQWbMi8EtHwZmJqEOhYOj0xiUJDTpFlJTEVLr81puXWAeXmfKGOw5PpE0oSjMZtp
         FitcfEjoEFQHWqTgnUOkMgli52yVIM9KHoDkHzOFTkTatyhdYuJQD7xz69c4/CuUbv6c
         Q4ASZUtLycoTNYB+JtBH27Jp4r8THxOZok2UXZ5ceUtFSpLnk/rokugYyUra19VU6/f5
         au8g==
X-Forwarded-Encrypted: i=1; AJvYcCWPE+nnV/GBsyBlloblSIyrEruqJai0AbapyBBrgMGmubqsi8fVDUWV+OZkwCwYKo6vi0S87w80Dk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4X6McZc89LNexjP0FCg+Sol2tiJlqmzTYm4ES8ECG0okhC2NQ
	qltYuTv4LOgrEtqZkxXMwGRKA5gIYBbNaqMMpXT2clFg7lFQ9hdYlhYgao7q6nSEoU/SUE6Pg6W
	Q55Kv
X-Gm-Gg: ASbGncvgQiqqCPUUYBMup9aN5zXskUqiCI7eU9mCHVNz8Wn1/Lp4G9GomJ383IIvXRX
	OXBs609QzEKndf1+Lxjl8r8up92a8SP8IBBD/o5jTzV+0vnYoebxPOxjLibGD+8mh+JytJXQ/sX
	mXKy2+vg7eb97i7byN+k+e9mHr92ThrRjZAP47kPPKKhhT+pCwEL/3umltSa1uuSqczOdZWMr1A
	szhqXPtMlZaFN+rcUSVkdiCmvTG1AWRuwkrLQvmBb23iEbER4NITN5N66QLTHF8K5cQe5ixlbT8
	iYOKKCwgacOR4v4gVQFu52/r1ZglZOZzqleZl7hZ7eMan147idMYgQ/KShevDhGFDxBUW9Qo84j
	Yz8Qf5YsvsfyP6dCCla0Xa+qUtk/h
X-Google-Smtp-Source: AGHT+IHfs4/52Rhwkg8PSSUPtbN9dHqyJYyCRFi94Rqzc77viEKUe7J9vpJsQTgF6FC2JcXWDFRi+A==
X-Received: by 2002:a05:6402:26d4:b0:607:f431:33fb with SMTP id 4fb4d7f45d1cf-60c88b26b30mr12024514a12.3.1751270734555;
        Mon, 30 Jun 2025 01:05:34 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c828e492bsm5423350a12.20.2025.06.30.01.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 01:05:33 -0700 (PDT)
Date: Mon, 30 Jun 2025 10:05:32 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH] Input: max8997_haptic - Optimize PWM configuration
Message-ID: <zj7luad4nn66h2mo4c6ekdtnz5olbvhzg5byicv3pnntoae7ex@i3xyptos5ywx>
References: <20250623112742.1372312-2-u.kleine-koenig@baylibre.com>
 <aaq3c6aljqt63ilx3v5555ususxcrg4kgnezicsesdbmio6zqh@2xrok7qlbjrp>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vawjdtko4sfevjtd"
Content-Disposition: inline
In-Reply-To: <aaq3c6aljqt63ilx3v5555ususxcrg4kgnezicsesdbmio6zqh@2xrok7qlbjrp>


--vawjdtko4sfevjtd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Input: max8997_haptic - Optimize PWM configuration
MIME-Version: 1.0

On Sun, Jun 29, 2025 at 10:30:47PM -0700, Dmitry Torokhov wrote:
> Hi Uwe,
>=20
> On Mon, Jun 23, 2025 at 01:27:42PM +0200, Uwe Kleine-K=F6nig wrote:
> > Both pwm_config() and pwm_enable() are wrappers around
> > pwm_apply_might_sleep(). Instead of calling this function twice only
> > call it once without an intermediate step.
> >=20
> > max8997_haptic_enable() is the only user of
> > max8997_haptic_set_duty_cycle(), so it's known in the latter that the
> > PWM should be enabled.
>=20
> Right, but the question is: is it OK for the PWM to be enabled before we
> enable the regulator/power up the motor?
>=20
> I'm afraid we need to use 2 distinct steps...

In that case the status quo is wrong (at least in general), too, because
the behaviour of a PWM that isn't enabled isn't known/defined. Some
have their output active, some have it inactive, some have it high-z.
And even continuing to toggle would be a valid implementation if there
is no chance to save some power. So if the device relies on e.g. a
constant inactive output, it must enable it (with .duty_cycle =3D 0).

Anyhow, I will try a more conservative approach to get rid of
pwm_config(). Expect a v2 soon.

Best regards
Uwe

--vawjdtko4sfevjtd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhiRUkACgkQj4D7WH0S
/k6vVAgAneAVepN9rJNCloPBI21USUyhfO/nREIppQ8TjVl5yx0ILe23fH2Jc6Bv
n4n29M43RdAXKGJi1JWqWL+rQCub2y66fS1SJDnmrcTDUjy4WHQhOlvvyzxokTQd
+7oAGTxnu3KicAF0DKRWsgoQIV1jkng3Ai3FkQ5ZtINtmxf2VIDb7ewyDLb1Aoh8
2rnFZKQd4rBYz8t2jU82bFYSclpgr3ZCxoSEH/Pl0JgC/8NuiBOvja47+KSdQ+Tt
75HNvhfS2+KKfh/QVih51h3S1ik/XrMo3R+ea/5Ek64kceOe5/XGqMbN3I1uCtq3
gxm3vkdN4w7QGRjCOVfR/75/SAH1Jg==
=7oS7
-----END PGP SIGNATURE-----

--vawjdtko4sfevjtd--

