Return-Path: <linux-pwm+bounces-3149-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0D99706EC
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Sep 2024 13:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0318EB217F5
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Sep 2024 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D4153BEF;
	Sun,  8 Sep 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EFwy3C4i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66881537D8
	for <linux-pwm@vger.kernel.org>; Sun,  8 Sep 2024 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725795176; cv=none; b=WjU7DtSu/m0qdI2Rfx9j3fDBd/G7t6V89vFdexl0UzjDW0KzuutOblQQUGFF7is6p25pDWM/nK7Ir1/b4G9jMmKhMe3ckePfTQaEYLHgIfl94wMFIlxijhfvrZfVwPBKRucQur97wlQUuO15LLomqkySJg3yBE+bwRObIRYDr4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725795176; c=relaxed/simple;
	bh=KvqLjXTwKzMKqFeCGpgcy44fOKDu0uQ3e0/7LUuPFak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Td3C1+PG5NYUHMGHlXKJ9NAMiqorVuWkxLayhMSExGilQe3tnw9VxPTZfsOFIasWyALN5H+hVHE8QEG4nswBcU0JOTm/CKBxu1lMqVxyO6ePRrWLotokWUY45wVp/gB+s0Ofh/uIUo4kuqjj2QmQzEHWrX7hSXU4kxBwc9wE6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EFwy3C4i; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53653682246so4101345e87.1
        for <linux-pwm@vger.kernel.org>; Sun, 08 Sep 2024 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725795172; x=1726399972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr39MxCa3Ig2XJlwouThex9PYkaXy3rMiTg4IK35S54=;
        b=EFwy3C4iqgpu+BJHdoDdBRcJvvWuFCP70rVQ8WWaQgiczi9b0pwMdXR220Yu0jAYHO
         N21U4Yr61DgziyzPaQZvIejdVyHQDkUAYfzHgvdIVznrDgF9jrrHJG50kxXNpx8E4dpM
         6JLXKgyPlQjO4NBTElKww875l5UOKnjpKevNZnYecH9gWtjCD8PJQm3ORwdyiqOon5BO
         XSv2YKBL5uRBqR8Wg/XoNVTT9kTyv8b/9IvqSllsgpErMMOPD8h2qiOBlefrU5bRg/PG
         rhMuhTBu5Oqj1qK+c6TULuWudNb9i9l73tgBwBBUlzkTIcS5A00MquvQJAQrW0WQMhvZ
         f8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725795172; x=1726399972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vr39MxCa3Ig2XJlwouThex9PYkaXy3rMiTg4IK35S54=;
        b=kuGZ2QhVjYrG0QingZ4p7yTH2Z/x9B0Zpjc+MtrmEMcm22YfK7Yl8YQrkYxMzgBMXO
         3ZRoN4eC3lpHjl2BfFKuFtOLM/c5mYP8rJ/rwgFGLnCJ83aYHDsCTuSDVgBPO4ryAdM1
         GGSVLjBeKtiSC+cmjv5UxQU3Aon3PEUgrQ1p6ziKrSivtYmcktIJQTz8Zg1HBEc61xVj
         jqohhJ44s8R+Bi2BNIBbd5V+d0KCi1er2CAS5dFoDqejeWQoxKA3fIwAvW0ulqlRv3IK
         f5RZt4si+MoQ9+vCGeo2kXwHv/H7gRCgX7vHjeflmc83VV932V+0AcYg7Xr2WoxnWKYX
         tyng==
X-Gm-Message-State: AOJu0Yzg3FtVeoBSxyWVNt3On7n2QVxLZiaGE9X647yrRnqtc46HbAUd
	N6XaWsIaFXd2IQLPiu4MiR9EQ6f90m1GOhxVPxNbctKr/9lKdPFPtYVsbNsYFwc=
X-Google-Smtp-Source: AGHT+IHgvbkne/FsPILazfWzkr9nHWvXt2VUPiGpwfZdijLsiNZyLWjCKQoepTDmG6n4QB1XaDqcvA==
X-Received: by 2002:a05:6512:33cb:b0:536:55a3:70ad with SMTP id 2adb3069b0e04-536587aaa07mr5784554e87.22.1725795171426;
        Sun, 08 Sep 2024 04:32:51 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:a029:f6b8:fc85:4519])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d2597ac96sm191678366b.73.2024.09.08.04.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 04:32:50 -0700 (PDT)
Date: Sun, 8 Sep 2024 13:32:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-stm32@st-md-mailman.stormreply.com, Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v4 0/7] pwm: New abstraction and userspace API
Message-ID: <wzk5h5knkitt6ocp5dtnyx2vhazei7lgkhpdbft56mbmzbqcxr@jyhwdm65p5dl>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <6e4b7ef4-19c7-477c-b753-d4d59ed38e3a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2bzw6j5f7wjbafhs"
Content-Disposition: inline
In-Reply-To: <6e4b7ef4-19c7-477c-b753-d4d59ed38e3a@baylibre.com>


--2bzw6j5f7wjbafhs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Fri, Sep 06, 2024 at 02:06:18PM -0500, David Lechner wrote:
> On 9/6/24 10:42 AM, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > here comes v4 of the series to add support for duty offset in PWM
> > waveforms. For a single PWM output there is no gain, but if you have a
> > chip with two (or more) outputs and both operate with the same period,
> > you can generate an output like:
> >=20
> >                ______         ______         ______         ______
> >    PWM #0  ___/      \_______/      \_______/      \_______/      \____=
___
> >                  __             __             __             __
> >    PWM #1  _____/  \___________/  \___________/  \___________/  \______=
___
> >               ^              ^              ^              ^
> >=20
>=20
> While working on an ADC driver that uses these new waveform APIs, we came
> across a case where we wanted wf->duty_offset_ns >=3D wf->period_length_n=
s,
> which is currently not allowed. [1]
>=20
>                 ______         ______         ______         ______
>     PWM #0  ___/      \_______/      \_______/      \_______/      \_____=
__
>                                __             __             __
>     PWM #1  __________________/  \___________/  \___________/  \_________=
__
>                             ^              ^              ^             =
=20

I restricted to waveforms with .duty_offset_ns < .period_length_ns
because the signal you want is only periodic once PWM #1 begins to
toggle. Given that the pwm subsystem is about periodic signals and has a
wide range of behaviours at the moments the configuration is changed, I
think it's little sensible today to consider reliably implementing
offsets bigger than the period length.

Does your hardware really behave like that?

> We worked around it by setting:
>=20
> 	wf->duty_offset_ns =3D DESIRED_NS % wf->period_length_ns
>=20
> Having PWM #1 trigger too early just causes the first sample data
> read to be invalid data.
>=20
> But even if we allowed wf->duty_offset_ns >=3D wf->period_length_ns,
> this offset wouldn't matter because there currently isn't a way to
> enable two PWM outputs at exactly the same time.

Yup, that's another challenge. Up to now it's even special knowledge
about the used pwm chip that with configuring two pwms with the same
period, the period starts are synced and you don't get:


                   ______         ______         ______         ______
     PWM #0  _____/      \_______/      \_______/      \_______/      \____=
___
                  ^              ^              ^              ^
                 __             __             __             __
     PWM #1  ___/  \___________/  \___________/  \___________/  \___________
              ^              ^              ^              ^             =
=20

> >  - The functions pwm_set_waveform_might_sleep() and
> >    pwm_round_waveform_might_sleep() have an unusual return value
> >    convention: They return 0 on success, 1 if the requested waveform
> >    cannot be implemented without breaking the rounding rules, or a
> >    negative errno if an error occurs.
> >    Fabrice rightfully pointed out this to be surprised by this and
> >    suggested to use at least a define for it.
> >=20
> >    I couldn't find a decision that I'm entirely happy with here. My
> >    conflicts are:
> >=20
> >     - I want a constant that now and in the future only means "cannot be
> >       done due to the rounding rules in the pwm framework". So the
> >       options are:
> >         * Introduce a new ESOMETHING and return -ESOMETHING
> >           I think that's hard to motivate and also myself doubt this
> >           would be sensible. As below, the question for a good name is
> >           unresolved.
> >         * return 1
> >           This is what was done in the earlier revisions and also here.
> >=20
> >     - When keeping the return 1 semantics (and also for a new
> >       ESOMETHING):
> >       I agree that a name instead of a plain 1 would be nice, but I
> >       couldn't come up with a name I liked. Given that this can be
> >       introduced later without breaking anything, I don't consider that
> >       very urgent.
> >       My candidates were PWM_REQUIRES_BROKEN_ROUNDING,
> >       PWM_REQUIRES_FORBIDDEN_ROUNDING and PWM_ERR_ROUNDING.
> >       These are too long or/and imprecise.
> >       If you have a good idea, please tell.
>=20
> To avoid using the return value for status flags, we could introduce
> an optional output parameter. Consumers where best effort is good
> enough can just pass NULL and consumers that care can pass an unsigned
> int to receive the status flag. This could even be a bitmap of multiple
> flags if it would be useful to know which rule(s) could not be met.

Which rule couldn't be met is obvious when you look at the resulting
waveform because the lowlevel driver is supposed to give you the
smallest possible value for the relevant parameter if rounding down
doesn't work.

So if you request

	.period_length_ns =3D 3000
	.duty_length_ns =3D 2
	.duty_offset_ns =3D 10

and your hardware can do 3000 ns period but the smallest duty_length is
10, it is supposed to write

	.period_length_ns =3D 3000
	.duty_length_ns =3D 10
	.duty_offset_ns =3D 10

in the waveform parameter and return 1.

My intuitive reaction is that (another) output parameter is worse than
the return value semantics I came up with. After some more thought I
wonder if the wish to have something PWM specific is the problem, and
just picking one of the available error constants (ERANGE?) is the nice
way out. Alternatively return 0 in this case and let the caller work out
themselves that not all values were rounded down?!

Best regards
Uwe

--2bzw6j5f7wjbafhs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbdi14ACgkQj4D7WH0S
/k7qpAf/Y5ssufaf6K1aaX1b8DvdvTR9ZtYP4d2qMkbRPEmh0ttEd77LiJKYAPYv
8+cMq81ISOARc2fARWJUyFOKnLI1mn4AR5L8pPPCx/9MPT/hcTLTDQ4yYian5/6M
3AtSIVl/FK4+dXzYsQP8QIWaFlWA7sH4HVwvh5o2HGAtFFl1vkzu3iYk5adKUYWR
OX0fUsg8YX94x8CqRxdc0xezbg1yBqXJ/oxOrYbv8SArDVuJf9nWEiQiI5DRa3aO
vLCCW0EGjgRiDP3uUF0CxTcrQJPBorId6FQPnqeGyb+NEMXcWz0Elnp9tz5XRuXN
NI2fsiSzpOi4pzYa5f89EbLfFAgIEQ==
=Z0Bq
-----END PGP SIGNATURE-----

--2bzw6j5f7wjbafhs--

