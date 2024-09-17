Return-Path: <linux-pwm+bounces-3285-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA47197B366
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Sep 2024 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AE51C21DA2
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Sep 2024 17:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12ABD17A58C;
	Tue, 17 Sep 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iVTW/PqX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854E14BFA3
	for <linux-pwm@vger.kernel.org>; Tue, 17 Sep 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593063; cv=none; b=KJci4Jaz32Yv4PfCyd6FOxe//7rY7RnzNRKfrgQMLkKk/hOkIhiofTvvEuN6W3huttI9dBeL0eTgHlYTHSzzqzYckiHAHuj93UZUXVQoTESYdOYxIrwV+qy/7tOAlr3wwSeeF6UcQx5W9stNS529Q7oHImaQYPVxkgR2n2RtBpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593063; c=relaxed/simple;
	bh=E3KvqP0ed9dzHkR4rncdHKMpYsjTZqucxNAvQoMznDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=baD/9fh8UmYal8lv8trYv0JMVIREBvIiJer+CL9EewPYqm/RIePCQu+nWNp+YpHL4gF525gyOMZY7v1/6nJghAz6+PXcRh/FUnroMnZ1QJcVMZ/efzJouYDDalIedpPuXAktQ0uSspJyu5vOwMoKbIDLAfklW92A9rm4GtjxKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iVTW/PqX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso872898666b.0
        for <linux-pwm@vger.kernel.org>; Tue, 17 Sep 2024 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726593056; x=1727197856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phzeY0RMQOfIuB02JprNSb+a7VNMw7BqrmvQx9aTn6s=;
        b=iVTW/PqX98WV/X06j4nY7R4X85plyHBAQSN/sisPO6u5cnFyIzb4TjkbhX3uWK9J+B
         PgTquUBHD4wysLPL8eGbyZF4qNfDmLXoHql0pI/4KqG5ZSP/u3l7EgIXo69zBulB7oeQ
         Fo1EmFPcAt4xS7sxsef5vBp88qmvF4m7yJDjDii2rNI1Op6ip894E7EW3wgqqfigfqbP
         zMCiUHZIbTprGVub5wZR/OEZeqgd/yH5ZpGZDnU6mrPzE4NEChGbzX3SxXr5fse/F8vO
         7j3cnqVyz/47ZkrLxcppC6saEttmVc/TIE4zep38yTwIFj0goPymoiMQ33bsUW5p79tr
         AaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726593056; x=1727197856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phzeY0RMQOfIuB02JprNSb+a7VNMw7BqrmvQx9aTn6s=;
        b=OgytqLA7rcyyMujFFp36eURX237oOgUeqWF0f7LDO8CBBtO8q2RhBEF8wZdZRUcwRE
         c8NNDvrfMrkzLmD8efps98wzCApPzGsqekEp9tRAgxznz7njj75SgtHoVVFumbXIQk+K
         DIRHl4SOnBYxCqsF20w4Amhilcn/WyBp+Je5W7S48uTCMjvfiwP3iIggOVo8dY6MX5Q7
         d0TEyucGWmyWayHhbNVj5IcTvJT/e0qLjTN7dlkeIuDAVNAg3KA7yzNvQG1TmHzDL2ON
         0f+q0U9sa3CffMT1TtXnbvwBzb7v+CPE2zmwiVZxVow7WpzzoWlkt7gc+Ickhp9HB5Pd
         2umw==
X-Gm-Message-State: AOJu0Yx8nWZveDo98GApTOay3irTXSGmRuwcVNeirnFx53zXmiJcVJER
	7NgKrydR04HI07/aMW7MT6WXKDJ8FgYVcEV5WH2Pmfqi0aqnoDhfrnoMCy3xBCA=
X-Google-Smtp-Source: AGHT+IF8nn3H2IzRr8qUIMc7ZSFla+niF/O7S+98zJT6WwRzI0mANlXncBELhJgCcu4bOcuxqVIf/Q==
X-Received: by 2002:a17:907:7210:b0:a7d:a453:dba1 with SMTP id a640c23a62f3a-a902a5c502dmr2140114566b.20.1726593056263;
        Tue, 17 Sep 2024 10:10:56 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096a3fsm475719666b.15.2024.09.17.10.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 10:10:55 -0700 (PDT)
Date: Tue, 17 Sep 2024 19:10:54 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Kent Gibson <warthog618@gmail.com>
Subject: Re: [PATCH v4 4/7] pwm: Add support for pwmchip devices for faster
 and easier userspace access
Message-ID: <i22iwa6rwscdbnrrfk5vvyjy6bgwblb53ovpjbpozn7237u33p@hcvoyf5lnvwr>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
 <00c9f1181dc351e1e6041ba6e41e4c30b12b6a27.1725635013.git.u.kleine-koenig@baylibre.com>
 <7acc85f6-69e9-4e44-ab04-88eaf2ffa291@baylibre.com>
 <5qrct3wt2e544vfoxaaacdifxcc7k243hnlrs7rki5nkbki4os@vfss2f2g4hvu>
 <37e84d8f-f7bf-47e6-811f-50a6e71f8810@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qizmxgpjjvdwac2d"
Content-Disposition: inline
In-Reply-To: <37e84d8f-f7bf-47e6-811f-50a6e71f8810@baylibre.com>


--qizmxgpjjvdwac2d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello David,

On Mon, Sep 09, 2024 at 03:53:11PM -0500, David Lechner wrote:
> On 9/8/24 9:59 AM, Uwe Kleine-K=F6nig wrote:
> > On Fri, Sep 06, 2024 at 05:26:46PM -0500, David Lechner wrote:
> >> Maybe a potential problem here with multiple requests.
> >>
> >> Suppose an applications does:
> >>
> >> // main thread
> >> fd =3D open("/dev/pwm0", ...);
> >>
> >> // start some threads
> >>
> >> // thread A
> >>
> >> ioctl(fd, PWM_IOCTL_REQUEST, 0);
> >> // in kernel, pwm_device_request() is called and
> >> // cdata->pwm[0] is assigned
> >>
> >> // does some stuff - OK
> >>
> >> 	// thread B
> >>
> >> 	ioctl(fd, PWM_IOCTL_REQUEST, 0);
> >> 	// succeeds since cdata->pwm[0] is assigned
> >>
> >> 	// does some stuff - messes up thread A
> >>
> >> // does some stuff - messes up thread B
> >=20
> > If two threads share a single fd for a given pwmchip char device, it's
> > in the responsibility of the application to not shoot in its own foot.
> > There are similar problems if two threads write to the same fd
> > corresponding to an ordinary file or directory. I think behaving
> > differently here isn't a good idea.
>=20
> Yes, applications should absolutely not be doing what I did in this
> bad example. :-) So, that is why it would make more sense to me if a
> second call of the REQUEST ioctl using the same fd would return an
> error instead of succeeding without actually doing anything.

Yeah, I understand what you mean. So the semantic isn't "take control
over the PWM line" but "ensure control over the PWM line". This also is
simpler to handle: Iff the request ioctl fails, you don't have control
over the PWM line. That's (I think) what an application cares about. It
wants to *have* control and doesn't care what is needed to reach that
state. And the request routine returning an error if *taking* control
fails because it was already taken before is an annoyance that makes
error handling more complicated.

But I agree and admit this is all very subjective.

> >> 	// cleans up after itself
> >> 	ioctl(fd, PWM_IOCTL_FREE, 0);
> >> 	// pwm_put() is called and
> >> 	// cdata->pwm[0] is set to NULL
> >> =09
> >> // does some stuff - kernel has to call pwm_device_request()
> >> // again, which may fail? e.g. if sysfs stole it in the meantime
> >>
> >> // cleans up after itself
> >> ioctl(fd, PWM_IOCTL_FREE, 0);
> >>
> >> Maybe we should be more strict and only allow one requester at a time?
> >=20
> > From the POV of the kernel code, there is only one requestor, identified
> > by the opened file. Handling that in a different way isn't a good idea I
> > think.
> >=20
> >> Or maybe we just don't need the REQUEST and FREE ioctls?
> >=20
> > The idea of the REQUEST ioctl is that an application can make sure it
> > can access all PWMs it needs before starting to change the
> > configuration.
> >=20
> Ah, I had not considered that case.
>=20
> But if it is required in some cases, I feel like it would be better
> to just make it required in all cases. Otherwise, it feels like there
> are too many ways to do the same thing if all of the other GET/SET
> ioctls implicitly call the equivalent of REQUEST if it was not
> explicitly called. It is one less decision to make for me as a user
> if there is only one "right" way to use this interface.

I'd hope you as a user would use libpwm or at least use it as a template
for your code. :-)

And to argue honestly: I see an advantage in keeping usage simple and so
I think it's nice that if an application doesn't care about requesting a
PWM line, it doesn't need to and the kernel just cares enough about
these details automatically to still make the operation safe.

But again, this is subjective and somewhat expected that tastes differ.

Best regards
Uwe

--qizmxgpjjvdwac2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmbpuBsACgkQj4D7WH0S
/k6DuwgAuL7f88HPafKG7b+XsAmoN2Yx0+EYIJ7YxvVl+/aJUIexSk0+llZ1Q9pq
NQcnp+vseqFi58xrOP/OpXXKXxZDXoAFbsIAPBvOfjxYf8wgXQmY4YbCwi0RynVd
SXwVL4QIoIoDKJ2gb/AJd+z8cNNHaTaDXmmuX+T/NENprJ98esJI14g/K1KdRVEv
neXRnV8hXhu/diQ3qCnHJlbDNXMxHm+WGTh/a2SCmj9yq9FSu+kgoUGJ+uw2IIPW
L2c/Rtxk2CL53aOiW3P7eUVVa9TC9zye1fcgY+wmomSJUcgYYe7hNkXtPQLbK8Wn
p9T4hFQrfLOg0cBy16WUpeSuA1ndmg==
=hHBT
-----END PGP SIGNATURE-----

--qizmxgpjjvdwac2d--

