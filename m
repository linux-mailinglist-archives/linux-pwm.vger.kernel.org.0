Return-Path: <linux-pwm+bounces-3150-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA67970728
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Sep 2024 14:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7008282280
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Sep 2024 12:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2604F14A624;
	Sun,  8 Sep 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RHYlNl5o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02F4206B
	for <linux-pwm@vger.kernel.org>; Sun,  8 Sep 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725796893; cv=none; b=l9WpcC7gFj9q6wiWxvtiya2dTzWKwSucUn5da2wgl5Oc4ywJ6+5MRkBZtBh87k7eYglS7cT+oocpF17+umKUWfrKweOGWVC7sI9DlYbNqzGJTOCTFubcIWFAdEZQeM8IMcr5zCTDJUb/NPNVcPqgfFXQIMcBmlsKyUoCFN7Y3bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725796893; c=relaxed/simple;
	bh=FnpVizQVolHM3B0v4w5SMLxXNKRjJNN+/1ySs8xzErk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdOX7dWd0ory9RkGNbTLEu1YJ5LWO0iGCae2VY/gIfnX8E5/+67HuQ4tvtcqjSpPxYhleBgQ+W80213gFn5EHqQXRNTKjPAdeWACkGVnZIpa8OWDgeUZVTclwQMWEipiPI8LRo61pB2XNAgySBLqa66UkHVvNs+0Xzo0iR+ZVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RHYlNl5o; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86883231b4so159218966b.3
        for <linux-pwm@vger.kernel.org>; Sun, 08 Sep 2024 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725796888; x=1726401688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v+JzFPWcGoJwDSHZn/oanq1yjSwWf+hkwkNonzc4X8g=;
        b=RHYlNl5oP334Ps18s9DIv4ZJBPUmzkrmL7vjt+MSV/FSuJznBOblgPox9qJwopVpa3
         mItlT+kizwK2itzl+CemBma9l36hV7u8j94Eb3EnC03/DI6R7OtzEOx/ajESgyHAJYyg
         7TsFOVr/8aYllhEBLn2o2L+bxy4r6GHxS6AYJA5MhPMOmwCYuEN16Xl1QmGYK3Y8/9LG
         OHftUo/0NcOYWT2gorZXN3k7nO/IlI0F6MVIjx2r1zG5mmlXECZvWR6NAoH+4B4gdA2g
         LjZ8ZhcqglEw76piZYhQtLYtju7q9XoZSRc8kCGHPvHFBApw4EakXKKnsykTBqO01luN
         bIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725796888; x=1726401688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+JzFPWcGoJwDSHZn/oanq1yjSwWf+hkwkNonzc4X8g=;
        b=fak/sj2sWzpljLQ/tSmUd9WMWhuL03AyQtPGS7qq6MUgSO8pg8WibyBnQmOY6Okg6O
         MXLXGStbTyIc5T1dsyRoZ+ZqS6LGJ3uQK+3/drAAdtu/OHNSpkyeOzweQ7XChdTJlBZL
         y61zk1tfawDcKz++MFIleeX+XgHjvuqw4KLfwOvcQ/1XBz00Exw9yGuonN0GP4n6uuVw
         7k8qARrZ5gVJbVl9zXUKvvB0Tv9WrLthYn/695Q+5FIidTJoKQnUAlU5d/RAgvKuQ9gL
         zJMqyglR502OznyAEUjT3+a4s+X+5j8bB0Z4UPpeRGuSuK1VzlLUJpqQHZKbwypgl2ul
         iI5w==
X-Gm-Message-State: AOJu0YwSvqG/o6vGO2eX+czAxL2+Aq3VfAkte3RMsYbldb41meZePD2b
	jmqJivsHZ/S7e9KdtVZrzH6GZiebjxnbaQJ4A+ntlO+n74bB6i925DA4ZwR552M=
X-Google-Smtp-Source: AGHT+IHvCMYQGFTL1m96ums75aLWY/VVQ8TdqpKf33FvQH+a4cE3rqYFAUv/NNTCksv5gqivad/sWw==
X-Received: by 2002:a17:907:7ea1:b0:a8b:6ee7:ba2c with SMTP id a640c23a62f3a-a8b70ee9409mr421795266b.16.1725796887582;
        Sun, 08 Sep 2024 05:01:27 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:a029:f6b8:fc85:4519])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a073b1sm192357766b.82.2024.09.08.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 05:01:27 -0700 (PDT)
Date: Sun, 8 Sep 2024 14:01:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v4 3/7] pwm: Provide new consumer API functions for
 waveforms
Message-ID: <7it2ln5asxcunvtoa6qahdbop5apsii4p5r2gyaqwccf5fkxdr@qfvdjoaiq2z5>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <857ae911c23a474e6de4a1ba0b224bc8d982d624.1725635013.git.u.kleine-koenig@baylibre.com>
 <e1dfca79-a267-4c91-b504-b3f222dacc24@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pcpf7kfgli4sftam"
Content-Disposition: inline
In-Reply-To: <e1dfca79-a267-4c91-b504-b3f222dacc24@baylibre.com>


--pcpf7kfgli4sftam
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Fri, Sep 06, 2024 at 04:22:42PM -0500, David Lechner wrote:
> On 9/6/24 10:42 AM, Uwe Kleine-K=F6nig wrote:
> > Provide API functions for consumers to work with waveforms.
> >=20
> > Note that one relevant difference between pwm_get_state() and
> > pwm_get_waveform*() is that the latter yields the actually configured
> > hardware state, while the former yields the last state passed to
> > pwm_apply*() and so doesn't account for hardware specific rounding.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > ---
>=20
> One thing I am wondering about is how to implement rounding up instead
> of down. For example, I we need a >=3D 10 ns duty cycle.
>=20
> Here is my attempt...
>=20
> #define MIN_DUTY_NS 10
>=20
> int some_func(struct pwm_device *pwm)
> {
> 	struct pwm_waveform wf =3D {
> 		.period_length_ns =3D 400,
> 	};
> 	u64 trial_ns =3D MIN_DUTY_NS;
> 	int ret;
>=20
> 	do {
> 		wf.duty_length_ns =3D trial_ns;
>=20
> 		ret =3D pwm_round_waveform_might_sleep(pwm, &wf);
> 		if (ret < 0)
> 			return ret;
>=20
> 		/*
> 		 * ret =3D=3D 1 could be either because duty or period
> 		 * is not attainable. In any case, we have to wait
> 		 * until the last trial to rule out earlier trials
> 		 * failing because of too small duty since we try
> 		 * again with larger duty. Maybe this check isn't
> 		 * needed though since pwm_round_waveform_might_sleep()
> 		 * should fail when trial_ns > wf.period_length_ns?
> 		 */
> 		if (ret =3D=3D 1 && trial_ns =3D=3D wf.period_length_ns)
> 			return -ERANGE;
>=20
> 		trial_ns++;
> 	} while (wf.duty_length_ns < MIN_DUTY_NS);
>=20
> 	return pwm_set_waveform_might_sleep(pwm, &wf, true);
> }
>=20
>=20
> 1. This seems like it would waste time trying each 1 ns increment
>    compared to being able to tell the low level driver which way
>    we want to round.

if you do

	struct pwm_waveform wf =3D {
		.period_length_ns =3D 400,
		.duty_length_ns =3D 10;
	};
	ret =3D pwm_round_waveform_might_sleep(pwm, &wf);

and the hardware can do handle .period_length_ns =3D 400 (i.e. supports a
period less or equal to 400 ns), then wf.duty_length_ns holds a value
that can be implemented in combination with the returned
=2Eperiod_length_ns.

This bit lacks documentation, but the two converted drivers have this
implemented.

And then the rounding up could be implemented more effectively:
If 10 doesn't work, duplicate the value to test in each step (i.e try:
10, 20, 40, 80 ...) and if say 80 is the first value that could be done
-- with say .duty_length_ns rounded down to 67 --, try 66 to check if
something else between 40 and 67 works. (You need to repeat that if 66
can be rounded down.) This is more complicated that your approach, but
should involve less calls to pwm_round_waveform_might_sleep() than your
approach for any actually existing hardware.)

> 2. Even with this, we could end up with an actual period of 9.5 ns
>    which is < 10 ns but have to way to know since the returned value
>    will be 10. Probably not likely that 0.5 ns is going to cause
>    something to malfunction, but you never know.

The only thing that helps here is to increase the precision (i.e. make
the unit picosecond instead of nanoseconds). That's something I don't
want to do without deep thoughts and knowing exactly that the increased
precision is actually used.

The alternative to shift semantics and declare that .period_length_ns =3D
10 means [10,11) only shifts the problem (and makes the per driver
implementations more complicated).

> 3. Handling ret =3D=3D 1 seems kind of messy since it could be caused
>    by multiple different problems.
>=20
> Maybe we could consider including a rounding direction (up/down/closest)
> for each of the waveform parameters and pass that along to low level
> driver to avoid much of this? Or at least have these parameters for
> the high-level pwm_round_waveform_might_sleep() so each consumer doesn't
> have to try to figure out how to do the rounding right?

One thing that I want to prevent for sure is that each lowlevel driver
has to implement all possible rounding wishes individually. The
requirements are already complicated enough as is.

> > @@ -145,6 +192,220 @@ static int __pwm_write_waveform(struct pwm_chip *=
chip, struct pwm_device *pwm, c
> > =20
> >  #define WFHWSIZE 20
> > =20
> > +/**
> > + * pwm_round_waveform_might_sleep - Query hardware capabilities
> > + * Cannot be used in atomic context.
> > + * @pwm: PWM device
> > + * @wf: waveform to round and output parameter
>=20
> It would be helpful to spell out in the description below that @wf will
> be modified upon non-error return and what the modified values will
> actually be. (Or refer to the other functions where the values are already
> documented to avoid duplication.)

ack, the rounding behaviour needs documentation.

Best regards
Uwe

--pcpf7kfgli4sftam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbdkhIACgkQj4D7WH0S
/k7RGwf9ESkf+BMJs1xq5LV+8XBO81U8uTjnY5eakarPgglnPyzU3cdYt7Wlu/wv
nb5w1x8dqi+NsjwbFoSJkX8AjenMuFICOXjn/TFbOnWlyimGoa4Jo9ztY6f4/FOt
BL67AmRvxMHP86cpYCtb71v1LdPib+LzU/TWZ+wvHQy7uMrpLwGEot6Dl3m3wBFp
FnABunJu/81Eb5wsjWwiIfBFABBqfCqFyHOTr1l8WDXXFYAMQFZnDlb8Wf5sPrBn
jg9VNss8l6t5cBJmi/5awQVLcvh0O/Od0P2ulwLZCjeYLTuk/6cxZbTzNOSv8OEg
MVAmybyK7YKWkImINorhkoiH2y3LmA==
=VqvV
-----END PGP SIGNATURE-----

--pcpf7kfgli4sftam--

