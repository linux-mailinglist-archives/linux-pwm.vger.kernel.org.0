Return-Path: <linux-pwm+bounces-3890-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451329B0587
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 16:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F92B261B9
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25461FB8B4;
	Fri, 25 Oct 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I7cryYdS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4FA1FB8A0
	for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865831; cv=none; b=LouA15mTn4Nz/1+bJETF69Ss2qnNQbDJCQMG/r9RAQI5Hy4Y1nEWDj4uLUzXPle3EenDqlNArKtn05u6rurMf2OJMjfVIqCVVqWLv1QvdWQkMhs1i7hvvTInablH8P0x7p6FR2Z17krs3DD7bVWVMzif2ubM6OJdSMIiiYiyIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865831; c=relaxed/simple;
	bh=yJImb6a2TS2WehlIdyKNelcdVYvHH2qOsVQHd/XOEZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4yiO5MFnbZ6Z6VPVzdhNl+4uyY2taFTASuYtUrENUdIReA4slaxXdqfaR4HkXNlFXke68qtY4heqRrHoZR0Ti089AMRIhr+capmZvX6RrUIoped4YXFARpOvoNR77+4A21KeE2AAOcmMLmmfmidq6kXX5udgeWBoupJEweCORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I7cryYdS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so21154595e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 25 Oct 2024 07:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729865826; x=1730470626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCkmnhRivFdKkXUMS/aoyRmM+CvuAf01/s+OUtO/hVQ=;
        b=I7cryYdS3PVbMr/AB7/rVLaawagAothm7zN56WC7sCC6cp+21JCeqa2aLZVyx6U23r
         pdIHOlf7+G8cISKqVtrkt+IvzqsiQQNLj2ZGoFOSgNKKJLIO4bCL3gTQy3FSUVUPHTl3
         QCBXdUcD/k+uA+qZWAehx4E7vc62Kby5EXstWD6vUOR/UzLTb1DuKTE4Y6bkdGVhAkMr
         PX9RcRBW1eM878MDRtindxWWRKnkz7p+/FSyLQBvRu6CMgu4xGcCGd50xNgfXM65xeyA
         eWrFKzZsFFMtnc5cwML+wU5YNvhniCqr7xIEi9B0XWVy7paW7wvBKVYk8TCeK13c1hCS
         gp7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729865826; x=1730470626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCkmnhRivFdKkXUMS/aoyRmM+CvuAf01/s+OUtO/hVQ=;
        b=Z2cFYTIII0JbS7LoEqLx17zYqNIMnNju/+qUbskz9bd1crqn6ctdt2Xny2fXjxKCYp
         kxAT8wcQj7gCD7aQNldw1p2nwfRm3sWTu1j3mDIJFcMK/bTMiv9DGTkn4I7Nj7BGldkT
         yI/CzUG5Bb91kM+nuaxf0x7NprM1nJVd286MZtMBqbiYl/TtAlO9k4+5Ph6ZBNcyBlQw
         US50rTLVG9VyLXXv0g1QuGjwvF8AtSLzfOEUzEMx0YoYcJDOpaqiwZkcDaKoUkIe49G5
         EoQmNLPxmitWabDgW6U8gImo8oUlMmxTsviDQFLigCZdU49dkIu1mFWoQ84/KVvR/loT
         sDdw==
X-Gm-Message-State: AOJu0Yyev3ibl69gV0oceHVsv2UyIo2vcftBnmfRC5Epg3hFSf8L7RpA
	WRHGzIzXN+PBz78yolQvaCX1ctysF1ceDMtUBEwK7/ib+KMGbYqXObue8vaQGY0=
X-Google-Smtp-Source: AGHT+IGp21kobzyg70q9vtrr3vqHctswzyrcr5K4JwE60KGWeg30ptzuiURgtinC5QraibRR/jtN+w==
X-Received: by 2002:a05:600c:1c82:b0:430:53f8:38bc with SMTP id 5b1f17b1804b1-43184211345mr86750195e9.12.1729865826245;
        Fri, 25 Oct 2024 07:17:06 -0700 (PDT)
Received: from localhost (p50915d2d.dip0.t-ipconnect.de. [80.145.93.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1cc0asm1649266f8f.10.2024.10.25.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:17:05 -0700 (PDT)
Date: Fri, 25 Oct 2024 16:17:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] pwm: core: use device_match_name() instead of
 strcmp(dev_name(...
Message-ID: <d7ytkx4ncytkup7pxu4kjxhbh75szwoeafyxg2prem7vfjausj@5ea2nebshemg>
References: <20241024151905.4038854-1-andriy.shevchenko@linux.intel.com>
 <2r7ey7fkt4k3s3kpi2vmesqrfntyd6jt7uf5jmwwbzglgxcohf@lr5gfy3ce2yu>
 <ZxuXU3nTuEwoTFiH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agenko4zrklaplst"
Content-Disposition: inline
In-Reply-To: <ZxuXU3nTuEwoTFiH@smile.fi.intel.com>


--agenko4zrklaplst
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 1/1] pwm: core: use device_match_name() instead of
 strcmp(dev_name(...
MIME-Version: 1.0

Hello Andy,

On Fri, Oct 25, 2024 at 04:04:19PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 24, 2024 at 10:55:36PM +0200, Uwe Kleine-K=F6nig wrote:
> > On Thu, Oct 24, 2024 at 06:19:05PM +0300, Andy Shevchenko wrote:
>=20
> ...
>=20
> > >  	idr_for_each_entry_ul(&pwm_chips, chip, tmp, id) {
> > > -		const char *chip_name =3D dev_name(pwmchip_parent(chip));
> > > -
> > > -		if (chip_name && strcmp(chip_name, name) =3D=3D 0)
> > > +		if (device_match_name(pwmchip_parent(chip), name))
> >=20
> > This theoretically changes behaviour in a few cases. For example if
> > dev_name(pwmchip_parent(chip)) is NULL the new code would crash. Can
> > this happen?=20
>=20
> Please, tell me how
> (looking at the of device_add() and kobject_set_name_vargs() implementati=
ons)?

This is unfair, I intended to let you do the work and you just give it
back to me :-)

=2E.. a bit later ...

ok, willing to merge if you update the commit log to mention that the
theoretical changes (no check for NULL, more lax check (trailing \n))
don't matter.

Best regards
Uwe

--agenko4zrklaplst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcbqF4ACgkQj4D7WH0S
/k6tbAf+NFuIOeiNYrfvCdjgd12qTYzbRWpM6pJGG/uEHAI86ua4rgrUmOUWIEAY
hqhYyuI1fH1synUtxvxkW1fIBDOIteIVBEZMcQCvDHawLTSM60K7Ut0T1BVHyexl
94/SGIjPH4B8UJ3NVLrL3TpUmzai+5qbgMvBRZXV6JKDgK5Zs0FW15RUIrGF1e5d
N71YQLsqrpmEXswS0eJ8wuBEkBnj6OI1qp6rj1SUOGTvfsSCb0DocC6YOp9nzfxz
LSAiulB4ZIVzO1xzkl6YJZuqJRA9GqCV+rRkfSGWNaDDKWLY5d79t11xCcLmarmf
ElRRwTJ0H9tVUnckAarpoMaHQhpESw==
=4bDt
-----END PGP SIGNATURE-----

--agenko4zrklaplst--

