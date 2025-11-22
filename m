Return-Path: <linux-pwm+bounces-7663-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD14C7D4DD
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Nov 2025 18:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91D454E0EE7
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Nov 2025 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A17326F2A6;
	Sat, 22 Nov 2025 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vews1kzq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56819F115
	for <linux-pwm@vger.kernel.org>; Sat, 22 Nov 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763833213; cv=none; b=lCTvMyeZOz+e++XI3h0bf3LTupnuBlh7RXUG7lSReM8X2DOVPz936nSk3UIqLQAW/41fJ7wMo1IP10PANwjd0tmbfAD2grmufYJ6BsNBgzTf8ZGIDyQWNnRa7Zs/+z1pnUYOhA1BMmFs5yL5h05BJDYrr6wAWRiJIJrQ+WtM/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763833213; c=relaxed/simple;
	bh=W0sOBsZOLElWNX2pZaNks+cTbmmZVnLMSdKXs/TKbPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz5dS9jClTiNHo9R6HoFG+0OZqgRru3hLCoLtzEtUoTyiSU+5iQQalSqKm6tZZOpAV6qu4HRZ2H/SZhKtyQFiMZ5rl08S3fwhLnVVVLKyheMQfEPlC9tQBu1Qvj27s/y0R3vM62KK1FSZkPW3+fH0TnVy79kkEzr7b6enAyv4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vews1kzq; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b735e278fa1so1964666b.0
        for <linux-pwm@vger.kernel.org>; Sat, 22 Nov 2025 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763833208; x=1764438008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=21OD+SyCQNqSK3AXddaaZ+MerlVY+Gk8EKG5MQw7KZg=;
        b=Vews1kzqTLdfJasE2EcwP0UgjzgzR/DpmXudd+TG4PVUoz92rnakz7gHjCbCU0KEnX
         fEZpICDF+P5HFEU6bRPp23mA5Blddhglp2Gwc4NAQ1ZeIQzTNSp1KtDYbr569jPnSMDv
         tNZdXBGAyjh1N0/kRUBH39nBUhtsIQccAHIxbwsMx2zyUi8GvN+FvTFsehvQAknm2lme
         m7nytfwP5aYqK+tMxjwZvzaWfQYic5aOupt+NOU8cWaf5e1WhKICT4NpMp7qfPaoksxq
         nABqvjs+2noWVxSL3yl7CclOw4/TlL1nsE8JRHcfiuWOqwopbgjD6mii10w5OHHbp3xw
         /pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763833208; x=1764438008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21OD+SyCQNqSK3AXddaaZ+MerlVY+Gk8EKG5MQw7KZg=;
        b=FX1B0+OBS8FHieE1TJQzYxgWsHFt9/CWRyjhx+0wGH3/F699ymwarJiRkZAOsUy5ny
         Z8ZJZbr2vvRUdm6b9VDmhpNmPWKYueH/cIS+HklmJQiFgvvM1n6NhJVtgcR1/mPNnGQ6
         UE9pW+e9xIIRCTDGKocm96n2yzDxk3zPXWTN+EWpMlCNFkPdF3K6oJYt7E2VX84jLIFG
         ENgu7gdEOHGdobt11X89l9AqP/4CQGq9+2YH13i+nj+Aua4qBi+FY5pHVUwpYsvZmCmG
         S2GykEJJw1ietpriulLwkUFuMLK9ukyBn46KjbiZ5fuZr0T5NSAhys341vljkSajq0vR
         KBUQ==
X-Gm-Message-State: AOJu0YzN4dSlevvDOtGVBI7aztKmOghSkxFPXVElsGFDaDSL5gVFk9tM
	QNCyrNP7liyGUU6Ys4Ok/PYnLEGeNpIWLRnW1z/XoJlD12Jp16Vw1bnynbn0oUb2PB4fyBAIaKQ
	9hTzm
X-Gm-Gg: ASbGncsxyLr7PH3iMSltCx6hGAqOxuB0mt5fHIK5RWTLAVYDq1vW/DZ2vE2zPIMCLxv
	uV76WzS3T0X5fVHSKuTLcKLxofFDD3LGHlStNNom0nf8SMHLY/5bWPnU+J+RgZ083SGawfV+zQ+
	U7s0apNf7V3mDUk5vh1qigWkhvKcGgyJFOFui38UAl1JBpIXRNuSqx7XcytQEVinb0qYZtdo7m+
	T0N5nPqbTO7uOHVZtcTOiI2uMfWifwpBMalEH4j93oTHI2V865ItqEfAqWv0aBRUWpyVdlWgHrv
	yPbCz9j8lxHdNjTi+dUJgMKK8XjuUmCbRQQ9AeK86Z2uhdguF4YoCqzY85qaxhoJUS5hPnRqWV5
	OzyDLCtCxW2wbvLVXa9/+UvwdtbY1ObLKYo27T+Bil9PzCtF1G2LTZL0fj1wEW8mUiEGOUnffFy
	Xrb+IlLCfV1sA6tKkUwGoSy7GnG7M=
X-Google-Smtp-Source: AGHT+IEmLb/MIfTqpzCYZatvuH5VzJQUKqKgokYm9oXE/T+8S0OSS7GwjcXzAZ2iAsKXa2RKxRnIgw==
X-Received: by 2002:a17:907:84a:b0:b3a:ecc1:7774 with SMTP id a640c23a62f3a-b767189c935mr573878966b.53.1763833208317;
        Sat, 22 Nov 2025 09:40:08 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7655028400sm748246066b.56.2025.11.22.09.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 09:40:07 -0800 (PST)
Date: Sat, 22 Nov 2025 18:40:06 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Sean Young <sean@mess.org>
Cc: linux-pwm@vger.kernel.org
Subject: Re: PWM and rounding for pwm-ir-tx
Message-ID: <gntbqz4wgenwm2nwfr3vq32r2gztqdbvao5nftvkueci4ha5lt@ypcal2nsqfk4>
References: <o7fry6bjh3trqrjb5vethqq4mumg37wjnvqafjlzuxc2ynedck@nb4x43jajm3j>
 <aSDjuAcJRhDFhmgc@gofer.mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="inph5jfho4vjyyub"
Content-Disposition: inline
In-Reply-To: <aSDjuAcJRhDFhmgc@gofer.mess.org>


--inph5jfho4vjyyub
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: PWM and rounding for pwm-ir-tx
MIME-Version: 1.0

Hello Sean,

On Fri, Nov 21, 2025 at 10:12:08PM +0000, Sean Young wrote:
> On Fri, Nov 21, 2025 at 05:04:41PM +0100, Uwe Kleine-K=F6nig wrote:
> > I'm currently working on the pwm-bcm2835 driver, converting it to the
> > waveform PWM API.
> >=20
> > A result of that conversation is that calling pwm_apply_atomic() will
> > result in the period being rounded down instead of rounded to the
> > nearest possible value. Looking at commit 11fc4edc483b ("pwm: bcm2835:
> > Improve precision of PWM") I guess you will be unhappy about that.
> >=20
> > The obvious way forward is to let the pwm-ir-tx driver make use of the
> > waveform API which allows better control over the actual hardware
> > output.
>=20
> That's very interesting, I must have missed the new waveform API. I agree,
> this is a great way forward.

I guess I'm not a good advertiser for the improvements I do :-)

> > I looked into the pwm-ir-tx driver to check if I can do the conversion,
> > but didn't understand the protocol good enough to try that.
> >=20
> > I wonder if you are still interested enough in the driver to do the
> > conversion yourself? Alternatively can you point me to some documention
> > resource explaining the protocol? Maybe there is even an easy way to
> > test changes?
>=20
> I'm more than happy to do the conversion, then I can also test that works
> correctly with a logic analyizer.

That's great.

The functions that are already there should be enough in theory to pick
the best configuration for your use case. Feel free to create helper
functions in the pwm subsystem that help you. I guess a function
pwm_roundup_waveform_might_sleep() might be useful.

> For the pwm-bcm2835 driver: do you have a draft commit that enables the
> waveform API? That way I can start testing any changes I make to pwm-ir-tx
> on RPi.

I pushed my wip change to:

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/wip=
-bcm2835-waveform

I already did some testing on these changes and I think there are very
little changes needed (if any at all) before posting that. But I want to
apply another round of self-review before sending it out officially.

Best regards
Uwe

--inph5jfho4vjyyub
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkh9XMACgkQj4D7WH0S
/k61tQf+IV6eGFNCLYoPhdYqb1CrZhi3YKsY1kIBs46LgyDA45OnmUbLux7piCYs
f2vtsNWwoAxTd7X38rjoGF1wOn4N3dhO5qVFUjPELL2Qj74b5Z7MZU2/v7jG9Hcf
CqpljwwYlbWY2MLkYvURE1vcRMvssVgz4DnVIhq5ihhzYH1wSbAEPEzMHZ4SmsbE
eiE03acqQHQpgGigxryMd9d1h290BM4mttKfu6nicSKk+NEuqI+tkLfs6WQQHIBa
CHhhdvGYL24ej+mMPZ8zK1oB33bXcg/AxIvw3EpP81+b1tUQX+V7QE6qzDv9MFpL
InA8KVcl20pLltnhIW3QB8vY0uQyZQ==
=eCYf
-----END PGP SIGNATURE-----

--inph5jfho4vjyyub--

