Return-Path: <linux-pwm+bounces-4215-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD29E2FF7
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 00:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF3228339F
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Dec 2024 23:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30492205E1C;
	Tue,  3 Dec 2024 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FqBCAjZE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17606202F84
	for <linux-pwm@vger.kernel.org>; Tue,  3 Dec 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269138; cv=none; b=PYcfgNaEihC9B6s7bfIxEEBEqGxDm2hz5VKNk9ihn6AcrqbMJDIpJokjY9INleqOJr3up4F1h9+HKTvE0WzRaec84x7RELHJlPkXmPPA6rl4sXJsVRIQGSajLswb7xlZohBTjrV/af5IWhn7MhvAhcUttWhvV4BHR7GvPk/odFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269138; c=relaxed/simple;
	bh=UU13fn7nt6xoZkWlgnt4+4WP4vd8weydC4Wn3qT41N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdO70GFOLkvDRHyXra/MnrSHnGDeNj+wb5hIl/3Vk6rLbRnPCZcCvn0l1LmNFtC4KufMfIaakCEnDdniZ9UhohTPgy+1P5/FQCY11KhWqM4wz5TdcpV3f0MdLYm0ndFgZTJbjdexvPr5Tbyv3MllSp7PruhWhX3xQHB9emnU4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FqBCAjZE; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so56623965e9.0
        for <linux-pwm@vger.kernel.org>; Tue, 03 Dec 2024 15:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733269133; x=1733873933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UU13fn7nt6xoZkWlgnt4+4WP4vd8weydC4Wn3qT41N0=;
        b=FqBCAjZEpf6zJtytEIM83XJBfMQlpQOYCszVf0/4RHS6/Xej+wkf0CWzPAkXQPuena
         avt2hje+15aSj68qnyEnjfqQgXd6bYXkY6NHFOrGLcOUiCXQR2k7HgwTSxesWl5JuJYk
         m1d7e1ZPdND+44xMmDapapu26+vgrXbKiKe+tro+tGm6gAfbEmTx2o+oykt8eoLcxLis
         0wKIw2OaJ/BuZaAH4eHHKNooRIsT6N5gJxBpmKiO09L39drtBfws8LPVSc7WLDJS9KWn
         Yvc0k5v+aLtqoMUtJ3UaqejRTLT+gevj2tSZ/DTUEY3DbvRbns+VNSVeAQSWwawwFgIp
         I0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733269133; x=1733873933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU13fn7nt6xoZkWlgnt4+4WP4vd8weydC4Wn3qT41N0=;
        b=L0tH2mWrUXcPWSlg6j5qH/P/ucwyxh+ZyYAW0G0Jn1fGbGkjamEwizN4usUd/oNA7D
         DQdxjR8RIRcxYqHXb/SyNy2lxp1RCPVPZnIKWCrA+ox+mwQCBjIIvsRZosj3GgFEtcvQ
         q0iAmZfS6oITW4lAZRw0JdLUMQoog1bobEy7fAR7DSy3Zwf8m9vvZsdLJpNGEm1Ln8UT
         FLo4C8zWNZE2fbc93YI2OWljfRAUauN2suraMc/h24igaICuGTPO5y/8a7NUxJPiSFYN
         NEusvILBpvSQntEmgMoZNr3OhB/cN6W0q4aWHSEIFJ51Csu2WaCIHY2eSWph4m5SxRrl
         z+/g==
X-Gm-Message-State: AOJu0YxbQTvKYLpuhlW+6hfv0w4hzHD1Gg2Sw+Gk9C1KeKrvsiMH/ER3
	mQYf5U38w3GTikMkurBpTD9LBj5JiBE814wKaVqy7butUFiJXvBTvkpyLxwFcEY=
X-Gm-Gg: ASbGncu9YGjYl+IYG56KsJNrxGnX/K0b6knRdS0gZCIUtrSFYoMgTDQ4Bz+o6iWVa2g
	jSXfG8g/fRUHZtVo//fFRA4ZNV3BwQ3DANzn9Dd0jHTefYAjPgh39iQAtNW1K/Z4wwi3VpFEOyI
	S3MKoUKKMDBODqCX/3J6gxu5Z3zxD5ZAYsp9sFIRJwvgp8GoYjsP4i/Ea9HnNM82WP6gMn3JQGg
	xkMzMvsqLkT807cHYVIh4Y9orXKJ8KSQeY5Njs9PagYyrGzdGLxiks=
X-Google-Smtp-Source: AGHT+IF1n0aWtSZhQrPQw84WzzUQKvMMAeGM8D1j5A3JArqc3nmxU/9vXo2PYpREJAk0xUZ8cbZwoA==
X-Received: by 2002:a05:6000:2704:b0:385:f7d2:7e55 with SMTP id ffacd0b85a97d-385fd3ceb0bmr2595180f8f.19.1733269133048;
        Tue, 03 Dec 2024 15:38:53 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:36f3:9aff:fec2:7e46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52b6854sm3480545e9.42.2024.12.03.15.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 15:38:51 -0800 (PST)
Date: Wed, 4 Dec 2024 00:38:49 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 1/2] pwm: lpss: Move namespace import into a header
Message-ID: <6bjnfjell3jyr2f5v7wvvqg6lq2w2xuqhavdom4epjr6liluw5@p7cbkwwvpe43>
References: <cover.1733245406.git.ukleinek@kernel.org>
 <3a99048a52aeee356d01dbf7f2f06e6e0826ed78.1733245406.git.ukleinek@kernel.org>
 <Z09YJGifvpENYNPy@smile.fi.intel.com>
 <6fjduueg7r3nctg4ivevvk7kopax4ynm32prxacrieq5gpbcgx@zhrgpx2loulp>
 <Z0-GB4tQAz2gfmUN@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t3uffdjtovofyfac"
Content-Disposition: inline
In-Reply-To: <Z0-GB4tQAz2gfmUN@smile.fi.intel.com>


--t3uffdjtovofyfac
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] pwm: lpss: Move namespace import into a header
MIME-Version: 1.0

Hello Andy,

On Wed, Dec 04, 2024 at 12:28:23AM +0200, Andy Shevchenko wrote:
> On Tue, Dec 03, 2024 at 10:32:17PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Dec 03, 2024 at 09:12:36PM +0200, Andy Shevchenko wrote:
> > > On Tue, Dec 03, 2024 at 06:16:14PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > Each user of the exported symbols related to the pwm-lpss driver ne=
eds
> > > > to import the matching namespace. So this can just be done in the h=
eader
> > > > together with the prototypes.
> > > >=20
> > > > This fixes drivers/pinctrl/intel/pinctrl-intel.c which failed to im=
port
> > > > that namespace before. (However this didn't hurt because the pwm-lp=
ss
> > > > module namespace isn't used; see the next commit.)
> > >=20
> > > I disagree on this change, I think it had been discussed already.
> >=20
> > Who discussed this? If I was involved, I don't remember. So if you have
> > a link, that would be great.
>=20
> Sure, https://lore.kernel.org/linux-pwm/20220908135658.64463-1-andriy.she=
vchenko@linux.intel.com/
> you were a participant there.

Ah that. When I read "it had been discussed already" I expected a
discussion with an agreement in the end. Let me note that you chose the
more complicated way back then (and I let you) and the result is that
the pinctrl driver didn't get the (up to now not yet) needed import.

> > > The header must not provide any module importing features as it effec=
tively
> > > diminishes the point of namespace. Any (ab)user can include just a he=
ader and
> > > be okay with that.
> >=20
> > Huh? Any abuser can also just do the IMPORT_NS statement? Module
> > namespaces are not a safeguard against bad code? So I don't see why
> > making it simple for the regular users should be the wrong choice.
> >=20
> > Actually I think this is very elegant because this way all needs to use
> > these symbols (i.e. prototype and namespace) are in a single place and
> > users just do the #include and get all the preconditions.
>=20
> Recent LWN https://lwn.net/Articles/998221/ article describes in more det=
ails
> what I implied under abuser here.

Ok. But I don't see how this supports your case. Independent of where
the import for a given namespace happens, you can see the used
namespaces in modinfo and that is the only place where suspicious
imports can be noted reliably. And MODULE_foo isn't relevant here as the
namespace of the pwm-lpss driver combo is used in several modules.

I thought the point of namespaces is grouping of symbols and reduction
of the set of globally available symbols to speed up module loading.
I didn't have "duplicate IMPORT_NS statements to make it harder for bad
out-of-tree code" on my radar and that shouldn't be a motivation if the
price is that in-tree code faces the same constraints IMHO.

And I'm pretty sure, we won't prevent a bad actor from successfully
using a symbol they should not, just because they need an include *and*
an import.

Am I missing something?

> > > Besides that, you should have based this on recent changes in the NS =
area of
> > > the module symbols, i.e. module namespaces needs to be provided as st=
ring
> > > literals.
> >=20
> > I coordinated my patch set with the pwm maintainer and he is ok with it
> > :-) That's why I wrote "This conflicts with
> > ceb8bf2ceaa77fe222fe8fe32cb7789c9099ddf1 that is currently in Linus'
> > tree. I'll take care about that." in the cover letter.
>=20
> Other subsystems simply backmerged those changes. Note, at any time one m=
ay
> consider origin/master as an immutable (at the point of a given change).
> It might be better (if no urgent need) to wait for rc2 and merge it before
> doing other changes.

I'm well aware of my options. Thanks
Uwe

--t3uffdjtovofyfac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdPloYACgkQj4D7WH0S
/k4BxQf9FI1whVubg7wYdmBeUqaVvzJnZejOylN+G1azJkCz0tvy6lAmQstlvkrZ
VbOX8G2sLncoHw7J3/rV4z1j4FYbdLmqgcPGwbjdHEflG2/5kBTb8Wfk6ctVbuPN
gMf1RsBGk6AjGUuwlZJGsXs83Q71tWPKex5BKaf1Yhy51zhUHsnIPdzxA46jW0Wp
85Nm3EOIi/AUYuCU52TZa5sjaGnle3Wz920FWHfvyigAmU4VKUfsAezC0m1lC5yq
mubCv3L0x04KwKqe/oD08Ka3q8W0w0CmL6X3A3GdZBkjSc3ppQFOH2ZHJTcVABBX
U+GJlYwB2l/ghhjhfLGaCMYxcZS1Ow==
=upTP
-----END PGP SIGNATURE-----

--t3uffdjtovofyfac--

