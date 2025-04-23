Return-Path: <linux-pwm+bounces-5669-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E25A98589
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 11:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847431B657AD
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Apr 2025 09:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E072566DF;
	Wed, 23 Apr 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w3ty2l1e"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3481E1F30A9
	for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 09:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745400653; cv=none; b=XRlaBH1vhclO1VMwLPrh0Llffroq8GqjeE6798znpyk+ASm8e1LJ7H8dbYD2r+0M1xmDnyXeI2gHCD+VdNfLnY9tIHs1XS5Zz/Tr0n8w0ybQRe3VBd/W4bPaXt+BP+JUA9e/jR5ql4NfA8jbFMJN+H1Y/+/aM6G5nyKR0cIOw4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745400653; c=relaxed/simple;
	bh=zc2MpuZxPkZe2TmeryHW7kMkIaIoao0VsaUCv0wGt0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4Q4TTHhihiCj5xUzyafbT2QcU2vVBD/a7hrPbFjlZo9Onz1UsUQHWX13Po+e35qfNkPLAuatLRllDTHEprB+uSZvp66bGX9+wfwobyvdobj1nznkxo7J6wUY0X4QMHlsYuA0J5jQaezMh511Ss63le4hrbxGNSouzKJtMMsTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w3ty2l1e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0618746bso46853165e9.2
        for <linux-pwm@vger.kernel.org>; Wed, 23 Apr 2025 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745400647; x=1746005447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zc2MpuZxPkZe2TmeryHW7kMkIaIoao0VsaUCv0wGt0Y=;
        b=w3ty2l1eCTaxcf1SRcZW8b1fKDc+2Y34kqEDnWT/ktV/egVYu/88/pLxkdK/xqgVMd
         UdbvsLgjL9QbKWTM5eoM94DMS94BhIciVJ3rw6XOhuQN/BaejshvB2BEPYsuwoNA32Z8
         qUetHSrvAq3RmjGPcpqVmLbENf/1XCPF7mzSXZKb1YPIBd2l5qL4lcaUuMa4cR//dCq7
         1eR4Jq5zhBLKJvskr7SLBUT7AuVZ/4ldx6nrXvVR9smj9+R+KuNuNP7FRezSf1jjosYI
         uP6bn9XF0nzF45KSS3j4jHemLDwFmbdM3p9TrylZTRCcd/ofDMFuh0h2s3Yc/XLUH3av
         Zc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745400647; x=1746005447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc2MpuZxPkZe2TmeryHW7kMkIaIoao0VsaUCv0wGt0Y=;
        b=Tz3fbeOx4k52uQNeAb4eGCjBZNRlV4njaipILi2c2hn8LfwG7Grk0ki16Grz1Uj6Hi
         yrzE/abkCW34lNsUw2Vsao6moRopwAUDHVQABfWZi5yndVlnSrTo/i2dPcZv3+RFLQYR
         mqjX0isPfJrv8vJHMr4zR9eO3vKPRi8fS0+Mi5nBGVZsRL/GpEECm6/1S9MCWg1aNcak
         XKsJNUPI+i6uLQOxuKBP9BfFy+wwnroTBhhvZBgS79iU8HVGMDEJAstoRGyeICukpxmM
         kDB/yc4FbV4hSjrO5B+kt48510x7xmCeez3Q1uRAzoxtlXGxPhVOEx4MID32iPkXyR1f
         4fxA==
X-Gm-Message-State: AOJu0YxQTfiJtNswWu5iVLP/22SnGrF0LzSHC+T45K7PbkE7ClN49kI4
	beY1Ogwik2xrZy/YyCCllubKPrndYCq3cg6pAd6yH1kUuWxKBI3cVI7p9aTwufY=
X-Gm-Gg: ASbGncvBpCQtm4/h2KhhcCcrpZKyN5hhZO/7cyNF48hZloLjOqjXs9CgWzy53WamCrF
	0b1ajslWk5g5Xg3HVgQZAXV2/AsIW0kriFYvivxgtpPH9e3wwnz1ZBD534jeKyrev852VTezaHh
	3shD3pdXyxFZcn16SwyxojTooZDNFxuy0OQrMiuBIvpk8vIqr2gfMuCKln1Fryt+s+ZOWdwCm+L
	uikvh1XoG6jLBLUd+rcbTuXAPhFb0Nj55hdqb5W4aulcfyHeUb1747WG0EcEf85Y924D4YrVBMS
	Tf2Bf0C1h+M2osBlZKo2R1o6r06eHlynOj1tjnDwP4njIYv7/gT9V3ILJrJKGRgTiDhN76dMbDy
	pFL7Nt9s=
X-Google-Smtp-Source: AGHT+IGYIRlaO8pPs6VOM1lbH32BnRzuDrN5uMW+rN4dGUiqnfcKg1oyd237URbM2+ibr1QQs7FIDw==
X-Received: by 2002:a05:600c:4e8f:b0:43d:47e:3205 with SMTP id 5b1f17b1804b1-4406ab99521mr154772095e9.11.1745400647431;
        Wed, 23 Apr 2025 02:30:47 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-44092b0a4b5sm19262045e9.0.2025.04.23.02.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 02:30:46 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:30:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Fix various formatting issues in kernel-doc
Message-ID: <sctvatvjz2wf73nunz6lrp6z52qw26bkbeb5yeq5yfz5vwpv5i@gfaxoo67dcr2>
References: <20250417181611.2693599-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="264cylunhiihawgp"
Content-Disposition: inline
In-Reply-To: <20250417181611.2693599-2-u.kleine-koenig@baylibre.com>


--264cylunhiihawgp
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: Fix various formatting issues in kernel-doc
MIME-Version: 1.0

Hello,

On Thu, Apr 17, 2025 at 08:16:11PM +0200, Uwe Kleine-K=F6nig wrote:
> Add Return and (where interesting) Context sections, fix some formatting
> and drop documenting the internal function __pwm_apply().
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next

Uwe

--264cylunhiihawgp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgIs0EACgkQj4D7WH0S
/k4omggAkZzdVzAoG/HbIWHoh9BD931ApKqoWmJNziXZWSpOiYDPgzZvtfRcYzsy
TWbnv6sqRQExDd611KHQWsgRttwGqTLGRggkz91PbxE0l8Hlyx1Bva8GY6fC0NSx
Q3Jl9O81y54ydQEUM2cxmxJS8xOjCxEoWA0d9698fPDN/aDEdcHmDupqCN0KSjOi
+hX1VMkV11byKq3WbdM3uUhz9BdbFNTq5DXyAeNn5Hg6dO0MdX/vb1A+IP8M0T+n
ahuctCxXpWp26zio3ZwXxEZ5iWOx+FmH50ScSMEcOlDnfIxSaxgH0a3sIzcqvIHn
M8GpwlkX6vQcWzY5awzdGT7n6kOj8A==
=dB7L
-----END PGP SIGNATURE-----

--264cylunhiihawgp--

