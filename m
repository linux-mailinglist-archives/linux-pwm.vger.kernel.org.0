Return-Path: <linux-pwm+bounces-2394-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D76B901CF9
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 10:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DEC282546
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Jun 2024 08:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11620DC4;
	Mon, 10 Jun 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hSIUhmu3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AC3BBC5
	for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008340; cv=none; b=pENpqrSRLEBrhrDcB1NeyHKnZcCvDv+yvT5he8s8NLAZEeAF8/gr5VSJoH4wO+2180Qb8rlV5cF3u+0ZsX/8cJ0Yj+lblJ3foLZKfnGo/II9beqQd68lpLDDjbdMHxO768gBToLY0h5GzOPJWsMVq/wySDD/N/uGrpSw1IMKcas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008340; c=relaxed/simple;
	bh=OZcMP8jRgvhG50434K0ONb3cSto4ejikyvDSbOnsm5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SSNENuj6H0fJ+V+KoWTcfQ518i3cmRUu0M1g6f8CTu1KUr3nnMmaCoOGfKogPIHQ8mksQeol8PHUA9/ZBa7PzlNdQMVt+Pbx9IpzkXYCvq0l056ibf1YflWCpKeU20WtK232j2BArNoXxl2AdpLVEZrYTIqHx83mHHE1lOOU584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hSIUhmu3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so176613066b.3
        for <linux-pwm@vger.kernel.org>; Mon, 10 Jun 2024 01:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718008335; x=1718613135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WX/Vx7EBSJrzXQUrtok1/HgTo16NBIRFlutecMp/P1g=;
        b=hSIUhmu3RufuvzcivQNDj9NWIcElmoT1oZbZg88Zaq/vR1P1rH0d+FNIv7hhcnoXeU
         8+OE6gmZxVyaWzB/KlEZXivXxcwh1Rvxvob0Ca0k4ZsEAbwdYyskEHlNQK4aflxzX3Ym
         SC7j3pIxEc27hhQWGQ/rvkDr8RONaAmM4jFIVD5buNgNICOl7Un1i9x6amIfDeP6oAQI
         E1WsVJEyDxQZqoizoB7ODM0KYra3FTG+vuRJPeIQRBvHgUlGvkW28WbxSs6uLZ7AAg2p
         F9a4wEG/i2wAGw2FL81qhKrxyq4opa1Rr2xZM7idA7vVOqnGwJBOFjHwL6MIXM0GG0Bx
         KwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008335; x=1718613135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WX/Vx7EBSJrzXQUrtok1/HgTo16NBIRFlutecMp/P1g=;
        b=ZvSGuqWamIrxg/8IwGW+66Mv67MJk4iYVsmanIXCMpKB85r0wJy15ZkKFRgFtz4L+u
         0On/AsragE2xPJBUNAk5ryh4sekNW7Ov6UB1cldO4U02cT6nNQfzm5v35VdQ4Jx2qS0I
         NOSPM2vy95OXTHD/erKp1q1gOiREAJkHcpu2gtgFv5kbOCcWdic2BZPupgS9sUqQYYbO
         0whbg4nzSWnYgXvOgLxSw2no23C6uni1C3xHNcwEe3XLBNBPfNX9Vi6Jq71/qgPDeZJ7
         N5781qJBmwQOwvgSw4xjDYUBa/miqoLi5seB0gk7f9NyL8pw6zfvzv7QRKgXt8Z/hAJU
         MY6g==
X-Forwarded-Encrypted: i=1; AJvYcCUvsqlMfjXdTZ1YtEUJQ6Qp7DgtO02o6/08HCTyscz8ilk/DFF5R6z1TV+49/zXrn5IbJ0ANtyvR2KeuXeBTAoJXMuVig+SGN/t
X-Gm-Message-State: AOJu0YyyR7fngJc1L8s2HGDR9LUiwRo3WkR0ZcdbMQqvzLbjHUPxssh4
	FWalUxUuK1zhCJTHWGBNfK2l/4sZJTzJHsr7Dznpam8liC1cQKu0HlxxGpAgmEk=
X-Google-Smtp-Source: AGHT+IGRKxsgz8C5mlemAWMn1O1o01tr5cPUn/RpWa2/o4eUl75dUXn4q6EhzhfZcl00v0VdiC7lnQ==
X-Received: by 2002:a17:907:94c1:b0:a6f:18ed:254f with SMTP id a640c23a62f3a-a6f18ed25f6mr202175466b.58.1718008334558;
        Mon, 10 Jun 2024 01:32:14 -0700 (PDT)
Received: from localhost (p509153eb.dip0.t-ipconnect.de. [80.145.83.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1e099418sm121482966b.72.2024.06.10.01.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 01:32:14 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:32:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Michael Hennerich <michael.hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: axi-pwmgen: Make use of regmap_clear_bits()
Message-ID: <56jdqmach5s4vkv72mpg6pdz5vr5j3fixmjpzyf5vt74ijvmaw@lt6c2icqf5rj>
References: <20240606164047.534741-4-u.kleine-koenig@baylibre.com>
 <20240606164047.534741-6-u.kleine-koenig@baylibre.com>
 <3755faec8dc7048da880ef6b924ed2e5a224bfef.camel@gmail.com>
 <no6gyqovcjrzcior5lym6qtb7ya4abgcspe2mebpvfc2bl3f4i@h3x64l7pomhf>
 <20240610-fineness-discern-e8b21551e149@wendy>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vajg4hw2pq6jiag"
Content-Disposition: inline
In-Reply-To: <20240610-fineness-discern-e8b21551e149@wendy>


--4vajg4hw2pq6jiag
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 09:00:53AM +0100, Conor Dooley wrote:
> On Mon, Jun 10, 2024 at 07:53:33AM +0200, Uwe Kleine-K=F6nig wrote:
> > Hello Nuno,
> >=20
> > On Fri, Jun 07, 2024 at 08:40:32AM +0200, Nuno S=E1 wrote:
> > > On Thu, 2024-06-06 at 18:40 +0200, Uwe Kleine-K=F6nig wrote:
> > > > Instead of using regmap_update_bits() and passing val=3D0, better u=
se
> > > > regmap_clear_bits().
> > > >=20
> > > > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>
> > > > ---
> > >=20
> > > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Thanks for looking at the patch. When I apply it (using b4) I get
> > however:
> >=20
> > NOTE: some trailers ignored due to from/email mismatches:
> >     ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >      Msg From: Nuno S=E1 <noname.nuno@gmail.com>
> >=20
> > I'll add it anyhow, but it would be great if you fixed your workflow to
> > have the sender match the address in the tag.
>=20
> I'm curious, given I do this all the time, do you not see similar issues
> for me?

Never noticed that for you. Maybe that's a new check in b4? I recently
reinstalled my devel machine, so I likely have a new version even if the
upstream change is a bit older already.

Best regards
Uwe

--4vajg4hw2pq6jiag
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZmuggACgkQj4D7WH0S
/k7jmAgAslneKkoS5XKmIM1ccpLb3n53vjkq/KdvY8SzqFh2huIuNLqvlJIRO185
ofwRcfL89afilBX+Md962SIn6qsHk73sQZ3KhhpTx7IMcOO4jb6v7nFWbnGLc9v6
exDrJrDHwyc2Nh0BtecduIiGk/iJ/ADwLRmTrwXGxjnULQwbtf9RjNCI1ajWorLJ
4WkzGbl8F+FTnauTvZ6UkH/Le6/ZwGT8eQFmHcCJWSCXd2AwXQCdnZnJvYqD7rS6
5eR21OnT4ulU1jb4tt8MmbrBfvSX2RdcoTEEp9m/AASPo/2xJRrskHARTBcXCmBw
N4BCns0Yhqerz6bMAFDhAerf1EFMRQ==
=SH3T
-----END PGP SIGNATURE-----

--4vajg4hw2pq6jiag--

