Return-Path: <linux-pwm+bounces-4701-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1C2A190CF
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 12:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421D61887EC3
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CAE211A35;
	Wed, 22 Jan 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PnA0yEVF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2A211A2D
	for <linux-pwm@vger.kernel.org>; Wed, 22 Jan 2025 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546266; cv=none; b=alKiw/EECeYbS5tFeM/5AmgfUbfmuGpOq/Yh81uwd4+rWUSWSmcG1ICo1FillcSOViK4WhnF7qYbrmn7hTpWFI0hdZu+YxKlahM5zCRV5OrvzpaAR8JQP+cj/geb4uYXlgA8ojWlOF/M4UU7wCPnibmlMf7dWR3+5NxWVh9UV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546266; c=relaxed/simple;
	bh=qRcHBbxRj9/+mw1hT4SgAww/Kfcu1ucDLKgwJdhbQsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldCQhsSG6TgOcE/7yx5vdB3+cmlgIgIJqyArrkl0z65guC5SfqD6fg/9FF5uBcmi+4jSyODorKY3kODlwTaRH9UQPew3bnDBuXMlgLRpiubiVULCNlrb0evi+Z9PT7HrZk71DbE9CrKn8e1IEE8MYUCEWRJFf7EXaCsS4hqCj6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PnA0yEVF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385eed29d17so3600334f8f.0
        for <linux-pwm@vger.kernel.org>; Wed, 22 Jan 2025 03:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737546262; x=1738151062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkX0a57JR5odRnLVM5SFxw3AxDdDdOTq75/JTvBeTHA=;
        b=PnA0yEVFPyR2Rw5Z9PT2CC9RllHxtr6os7kIaDilne2a6b6TAHKs8g74W8D7RP2mqA
         Ac8Hi67X39L3a63713epp2UX9xPvSXAlWjP0zr31iLK9KDZnXoTlXMiuqnA2Uf7rbwgC
         SvmcwJnf0vr2vQ/2R7CvFjtHEjF7n/qybTtZRKw/adJB4LZy+RbFZkOLPszMxymo28iP
         r4ANY/0hlGLzLR8rur6uUBmoAcmtlBp9rjDZGQCscBhvQStA8RuY/n0XHVGVRl7VhDh9
         Gr5oMIRYsXLmRiI7MYr12s1LSKBaN5ByKVUcL+t4H2rs+rDATSFMoQTiwAyzAZf6U5CX
         2zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546262; x=1738151062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkX0a57JR5odRnLVM5SFxw3AxDdDdOTq75/JTvBeTHA=;
        b=CNO8mwHm+fb7yGmZEwYh7S/FykmvvDa2xF7RI4Wy5hZqmAqVykZZd3VgRwYETAsbhv
         Qn0wk04cT016nOFtXj5SQCXFo1T1YlSpqphTAQuubnXKzXgd2W4aCkNAqLnQNs2unp4W
         gVEOJXRJ5vBIgQ8LMujOEjbBBJceo2r8qO6RSoUBcXCGbssb8SHdn/3WzzYwQ2iBLNag
         xoODjhIB9kPSsa/XT3NMLC0V0EVXovjBlOljvH4WXu0TCwd0BH5ty77ukMI6Vsiz9fml
         qpFcXLgcRQnG3EsO2QK67fQb8OQtiupKqRfVKsbR7tj+zzZWuDr889KRb0GbZE0KpxBh
         VSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYDVOttayM2iErDHiM75HO8LzodOjHZRZbr/T9uygxsWKJi5Y2+PvUxKlqxkEE5k4r4eBA28CEXMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw29LNcel3He/o9dGUYt/2Wa0qVe+c+hby+zxeZ5qzZU4xa2f4f
	YzVwcKmjBoHvuShIzRcr8xS+JZ2JjeIuBiUMwZWZtz2ZPmEZYI2pk+GLRKAd1Yw=
X-Gm-Gg: ASbGnctxmpRsSymTPmcAIiBUk+lmqsmuYdEq853n6cbnAudSWP4V/LnKraFfyQudz70
	xugtX0XtzQsRR6A/CqBClGeqPwMrG9+C4s10NQ+r7ZZBwIXJwEw53vd9C7FHgebFEyLzFoozDI3
	JHxxUKULN/BSvm4sNIzG3tB98ymYpQ3Mx45qe3Ipb5mx5QiELdjBgtXdFHUhMx/g2JbbL0c4GUR
	bjdIMQIR9j+QvxVAMFGrVkPaFOuNN9r2qIE2qhjpJu8N++T4TSgq/G0GUH5MYpHoRWPzAB4xhBr
	wd5FktDN3GTJkSH8ncD/dfkcv5DtNuU5Jl0s
X-Google-Smtp-Source: AGHT+IFrcGALdmUCWHJnjpC2ZqVo8nSWD+sINVEmoB8Z7ocspefGnZvNbSf34XNo6+RE1LoNqfeAsw==
X-Received: by 2002:a5d:588e:0:b0:385:faec:d94d with SMTP id ffacd0b85a97d-38bf57bd65bmr21959293f8f.51.1737546261671;
        Wed, 22 Jan 2025 03:44:21 -0800 (PST)
Received: from localhost (p200300f65f0afb0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f0a:fb04::1b9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3214c5csm16040267f8f.8.2025.01.22.03.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:44:21 -0800 (PST)
Date: Wed, 22 Jan 2025 12:44:18 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nylon Chen <nylon.chen@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <5robb7ipl346daf3lqaqnsi3fcgj3wzmch5dqit2dczdyeknmv@dqft77bhwryg>
References: <20241224093902.1632627-1-nylon.chen@sifive.com>
 <zqkx7cx5nalslfmxeoxdnsjbvrvzajrjybsmsyeyc65a64sntr@gpc5qp6aoyp7>
 <CAHh=Yk-_0rKB=FG6Voif2MDjtRxzUA5vXDP2J-o5=8ru1ewt0w@mail.gmail.com>
 <CAHh=Yk-TosOmwEughfK9mMx-=DgzWK5H_bf6H641SGh1ue8BrA@mail.gmail.com>
 <zneb3qwgf52zitcbq4wz76shnmhwfkabbsts3sussjpc5s5tsz@uneaxdfp4m2f>
 <CAHh=Yk_oTdURhkna_saF6mrA9gDY=+v_j5NoY_7jTDLuZ=EXtg@mail.gmail.com>
 <7bcnckef23w6g47ll5l3bktygedrcfvr7fk3qjuq2swtoffhec@zs4w4tuh6qvm>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tho7z5kisonnoiyk"
Content-Disposition: inline
In-Reply-To: <7bcnckef23w6g47ll5l3bktygedrcfvr7fk3qjuq2swtoffhec@zs4w4tuh6qvm>


--tho7z5kisonnoiyk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 0/3] Change PWM-controlled LED pin active mode and
 algorithm
MIME-Version: 1.0

Hello Nylon,

I took another look in the driver and found another problem:

On Tue, Jan 21, 2025 at 07:12:10PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Tue, Jan 21, 2025 at 04:47:46PM +0800, Nylon Chen wrote:
> > Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> =E6=96=BC 2025=E5=
=B9=B41=E6=9C=8821=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:47=E5=AF=
=AB=E9=81=93=EF=BC=9A
> > >
> > > Hello,
> > >
> > > On Sun, Jan 19, 2025 at 03:03:16PM +0800, Nylon Chen wrote:
> > > > I ran some basic tests by changing the period and duty cycle in both
> > > > decreasing and increasing sequences (see the script below).
> > >
> > > What is clk_get_rate(ddata->clk) for you?
> > 130 MHz
>=20
> OK, so the possible period lengths are
>=20
> 	(1 << (16 + scale)) / (130 MHz)
>=20
> for scale in [0, .. 15], right? That's
>=20
> 	2^scale * 504123.07692307694 ns
>=20
> So testing period in the range between 5000 ns and 15000 ns isn't
> sensible? Did I get something wrong? If the above is right, switching
> between period=3D1008246 ns and 1008247 ns is likely to trigger a
> warning.

The possible periods are of the form

	2^scale * A

where A is constant and only depends on the input clock rate. scale
ranges over [0, ... 15]. (If I got it right in my last mail, we have A =3D
504123.07692307694 ns.)

If you request say:

	.period =3D 3.9 * A
	.duty_cycle =3D 1.9 * A

the period actually emitted by the PWM will be 2 * A. But to calculate
frac the originally requested period (i.e. 3.9 * A) is used. So frac
becomes 31927 resulting in .duty_cycle being ~0.974 A. A better value
would be frac =3D 62259 which results in .duty_cycle =E2=89=85 1.9 * A.
(Depending on A the values for frac might be off by one due to rounding
differences.)

So I would expect that PWM_DEBUG is angry with you if you go from

	.period =3D 2 * A
	.duty_cycle =3D 1.9 * A

to

	.period =3D 3.9 * A
	.duty_cycle =3D 1.9 * A

=2E

Best regards
Uwe

--tho7z5kisonnoiyk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeQ2g8ACgkQj4D7WH0S
/k5U9gf/fa9SUu4MFWKVFQg0xDyHR0a5TFcnhPwNbhsahSrBoKcHfBTJqdyN6LqB
2pRHR7WPTzw3GOt/J51OUGi8BUSHLZzz+5y424M2FZ9FI6Vy4ELuZcr+lR2lJ7nt
Swjft+IqpbS+e9VhWBdzbUerJLyfVXltndFMGGjDHt/C9AFMwAJkhVVhPgNwLSTe
BPG3exdmnflmPh/jmyNBNHdJv0qCVWjM7XGMWr4ssgzjh/8X3VUjhQBjfVeHnNAe
rwP4csAuVk4n2eOGNgixYKYjd2iuH8CecQPZ2tn/OHY2YC92KsnqZDRJddfdUCs6
9aS0PKu/Mzm9nrkM8uD8a4usTzRonw==
=HH4I
-----END PGP SIGNATURE-----

--tho7z5kisonnoiyk--

