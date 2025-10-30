Return-Path: <linux-pwm+bounces-7564-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E5BC2282C
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 23:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442EC188AA5A
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Oct 2025 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C6032D0E2;
	Thu, 30 Oct 2025 22:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XqcxcQzZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001FD315D33
	for <linux-pwm@vger.kernel.org>; Thu, 30 Oct 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862027; cv=none; b=tYF+BNU+dZIjmXmJ2RiS72udtm9Kjz0ntYIT2J2CZBKQk48nqzlfcmKxJXxAmIBpNksDg47XI1/LgmQzK1NoMM4sYd+kdIhR3rFxnSvXp7DPIPdOf2M5ce4dJx2/ETPBQtkhRvFNfwjs+fcbumfQM3UAt8C8mAKMKdvLkLA+78g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862027; c=relaxed/simple;
	bh=cM5UgoO7go2rE7T8BZEbNJTCGD0wetmJNdz4fRUhSBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/sVVHjLllxautILtyO4BK6lQlzVKfRXpk6rY73kBRqRaMXM+B/u9t+kiwD1V09URoqkgS8MLMxAyMctmmBsSvee6ZzlRyKXXpR4ryDMhJozmjrg8YsBoAdwFNDsGZpRYCxWhremqeq0dVauMOX2ybyVMU0BVwk9sQP34gxCCBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XqcxcQzZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b27b50090so261732066b.0
        for <linux-pwm@vger.kernel.org>; Thu, 30 Oct 2025 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761862021; x=1762466821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R7VDAtmUsZqMlwI/PTPaPA8FAzUrtYhiM6kTYyXudhE=;
        b=XqcxcQzZsIuF7Z9eY4vu6l/8cFSBnhsnRxUbbvAdHglPqdzjfa0UYrAKvQuHo5iSGn
         bW3sA2LgtZUMQ2JXh989ZA7H/qo2pCKYEgmxtxnt9j5eEGS6UeTNnUYWlz6po54Q6oXN
         wpSHUkPCwKxWio2aUryhQdncZgg/TlesguQxf0joioAuwNDQQCn2K08kmapjAuK29HH0
         /8MTLGXZucXTyXXR/4BRbdxyhSS1tjKfefMaMCnMzcVfWu3UF8AnsmcMl7+JRwuuIXlJ
         YSymN/MAHTbI3ma1ShhxWyyAhxwHRawP334oXYXsakp6m+I65NTLWdoKwypM2TkUSBnR
         YaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761862021; x=1762466821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7VDAtmUsZqMlwI/PTPaPA8FAzUrtYhiM6kTYyXudhE=;
        b=aCm1cdzL1SwAHa1X3IsjxgGBOtl3o9qza/3q76yKAf/nVWOzT+dzCaiYr6wC4cKovJ
         R98+jJGAUUIktkaQqtdwebrtZhiCfQDDBTqCTLAydphU6eaPDuvCW1Y0WcfxKyL1LU47
         G+LiYrL3fqZCFDxY2oc00AgmEdoBnaVUb6WHtIMA+qS0PNxA70PmcUfrFwXcxw1AWsvv
         4x1pMxvriNIDeAJpUjDx3bNeyjvkC6iXSA04UiZcdKsxO4e1xhs3AbUB5IjYVI30sTyy
         A1qfRZh7b4NVa6zunFLUcCPDGJgFR9W7VrkMJlEBP1QMD9IYGCPf2jy5DeRWtFuRzrxD
         hwLA==
X-Forwarded-Encrypted: i=1; AJvYcCX1nxcEJXf5M7JYDq4cA4Rrmpz+LxPNVDylse63FpzC55L7Op0pMTra7wFsolIk1EliO6lMjIL8wCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDypA0H7s5itn6EYeCrPg5VPXLhPK71KscA3nRC+kEWKt7Ew4M
	aJkSxKe2H6Iz1OxzYt4EtnK+f9xTyuTtElrxdbTIT5TXg37CwYY5x7k5utqMeKTslYY=
X-Gm-Gg: ASbGnctObz34kTOQ09wnivRqKL5DuA8cNm5SoRDcvv605FoDdfcwy4Y8pUVTP5MFSPI
	IDun7/G3wIRbP5AKSc1S8LVIytarOIk2RMi0d7Bv5lFOcH1uOEWMTxdchRSJ1DQtrRfB/1Uz+Le
	1u6iADVip3DDLkRYE7T64tgjr90SbeYA7gWhM257JDJz/cSDPXXqixQ/y48rH+lnTIn36S8NCxd
	Gbw5kFkhGhX7tK83E/ywgNmaNxbTW8n2pDhanjDAXZoEQINohTP9lFAgTDBVqS8anLq84LU9Jb0
	QJ2DNBGjcvvgN1p2dFFd/FGKF//3IQhZWasutTOaq9m+H/c87BjM0lVZ089mYFkqbocTIVBT40Y
	9cjWzZYrkd/Ub3RRvTQBrNPwZoog1zartpBBuFEco/PmAUzOA4hC+KUvUEVWLnyCaH4KHNW6m/g
	3/Xq/k2A==
X-Google-Smtp-Source: AGHT+IH9eCQJTs+bhi7CI6SroWMhn/3mdEfGkB2E7DEbuVLquzoetKoSMx33oHVxd2NAWHRemdfmPQ==
X-Received: by 2002:a17:907:8693:b0:b6d:2f32:844a with SMTP id a640c23a62f3a-b7070188912mr115508366b.22.1761862020683;
        Thu, 30 Oct 2025 15:07:00 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6407b427fb9sm41824a12.23.2025.10.30.15.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 15:06:59 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:06:55 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Michal Wilczynski <m.wilczynski@samsung.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-pwm@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Subject: Re: [PATCH] pwm: fix broken intra-doc link
Message-ID: <7e4oucjmnxaike4jnjmsdvwnc6hif4koww7al6cxeymccb3rn6@5blaoo4k5pfh>
References: <20251029181940.780629-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hug6oxx7fhrrhezp"
Content-Disposition: inline
In-Reply-To: <20251029181940.780629-1-ojeda@kernel.org>


--hug6oxx7fhrrhezp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: fix broken intra-doc link
MIME-Version: 1.0

Hello Miguel,

On Wed, Oct 29, 2025 at 07:19:40PM +0100, Miguel Ojeda wrote:
> `rustdoc` reports a broken intra-doc link:
>=20
>     error: unresolved link to `Devres::register`
>        --> rust/kernel/pwm.rs:722:11
>         |
>     722 | /// via [`Devres::register`]. This ties the lifetime of the PWM=
 chip registration
>         |           ^^^^^^^^^^^^^^^^ no item named `Devres` in scope
>         |
>         =3D note: `-D rustdoc::broken-intra-doc-links` implied by `-D war=
nings`
>         =3D help: to override `-D warnings` add `#[allow(rustdoc::broken_=
intra_doc_links)]`
>=20
> Thus fix it.
>=20
> Fixes: a3d5a2b8da94 ("rust: pwm: Add complete abstraction layer")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

I don't consider my tree stable, so if you still want to send review
tags, I'll add them.

Best regards and thanks,
Uwe

--hug6oxx7fhrrhezp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkD4X0ACgkQj4D7WH0S
/k4eFQf/ZjsorP2D+YGhhk8euCCluVFbuQEubtS0Z3Je2gFlkvzRE0D18hod09MU
TwAYRoSCd2wfs2EEB2EKgUBhXF8pJS/19uXB6SaM8pMR3FSgd2QSB5ciZXB3qtH3
edtBZAhbnVOXdT4bNRC/qUXXtXKFjZdJXTDkuREy8pA5NX6r5qRdOcgodUGXyCpA
Jv4uUNhZnAlUsRgcHmg6bFmPFSlW2rEEpfEH5dTViBFp3SsdkLROP85EL+n0fX5W
Mc3ETvq6/pbBddJH6IJ/lHj8BGryCPxlp88e4LGC0FD+X3utOfjZWt2IR0A3k4Ds
+9crP6VCHVDWLH9EFTgTAUFRpjOy0A==
=SgWV
-----END PGP SIGNATURE-----

--hug6oxx7fhrrhezp--

