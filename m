Return-Path: <linux-pwm+bounces-2709-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C942C9286B8
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 12:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3C91F23DBF
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jul 2024 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621514658F;
	Fri,  5 Jul 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sD32wygm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231EE576
	for <linux-pwm@vger.kernel.org>; Fri,  5 Jul 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175057; cv=none; b=QzcCFORQ8ntR/iuHYZ+g9Q5S1Sp1mA1QAuFPM0DO8NZM2IWteeGn9qjbwbzIAPvRZPmjwGy84SUWpug0d8S3MuUbKuGMQbpJ20OsFZhivW48ce+8+cJZfeF6X9Mwbi7jDK7DA1prHMXxfGht07yZTKaumVi+vTIdJJsoTLpN6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175057; c=relaxed/simple;
	bh=P1nA1h6YOIbEnYGcIW2Ke6Rh04m/vOPb/zX43OeAYOw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9JyXdQufhmULa0xpxmWpKKX1S/cN44lMeciIp2sC3e5DfNq4jbqB98eXma3cmysGJleCWv5Mb7/ZWxAGvUIEqP4lKDrcAXMxB8gRznsr2POyDZ9RPoPKVGNRI0zXfzv9qBHcwwBvacZMuKUzYVAP0EKxQOP3cm/AMpNm1BD9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sD32wygm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a72988749f0so200081066b.0
        for <linux-pwm@vger.kernel.org>; Fri, 05 Jul 2024 03:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720175053; x=1720779853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vut5Som8NiXgZ4rQxUUsqKPoLtpmIn0mBcuKAT2Zubs=;
        b=sD32wygmoh6WPCzRCR7xjnVM1lxrqkmGGSBRYT1qRaWlHlD7XNVwB/y0GBYjfHRNRc
         Lj2BusTn2RDKg+fRESd3WI3QrruBwZE1MZREu0VQ4xW7OadAqOoM+YcJ2QJHcN7HE8jg
         CuBs5+rGfF4TrU8gvl3RPpll/vVdeNpOAl7qndGaZHKvX+5cYl4+9PVGVvk15B/0y7Ei
         fnu2/nGgToyVKTH1/udntmoT/ejrkmTMdXVFea5zTW3sRhRDj4ExjacTJnJKEEBEUCOV
         Q/GzBi/VSSF/95N9EyjuRKeiK2WIBxVfMkhbtmF7n15FwzkQAm6Q64/xIz0kMYhhuiOD
         MDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720175053; x=1720779853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vut5Som8NiXgZ4rQxUUsqKPoLtpmIn0mBcuKAT2Zubs=;
        b=M1m1hiuO1zmIUnYkmv19mxZN/794MqwrIDHHCg48ekz2kuAABRzY8rUP0ijveCMSLB
         Zkvb2izvio8X2+Ms/DdEWIMThShsqLhWIVUn2qreUskTKMA46PriTrn64IDV1DnWb1QH
         btCIzCSpMAkpAjVf3QUxwMxZ8WmkZA/VNQsWt61Enuozy6SCyHbTofP3cN1nUSTkjqa5
         hId6HJ32jXJfFH4U4oEWlzxXhrlOpClCtbPg9/XoCKH7KS04pld3cK3lPrXj10JlS4m8
         5rOEGjijxLbU6ErkbVZwhaQLWhRHyQxzuryGC4bPIZFQg2knMmm0LSofG7K/0kn2K/L7
         xfnQ==
X-Gm-Message-State: AOJu0YxDScQp1jw5k+eCv0YNYu8hM7rY5EpHRVGi1M4GiogLv5ekV/3Q
	kdPJshBHe+ODFgGQlsZEkoO01IUam9CHJjXVAITKG1QYdwdcVafXhCF1M14Xco9w7N+rcgnY/lf
	2
X-Google-Smtp-Source: AGHT+IGGI6ibTe9MT8WtwCGyev7cismVExOZV1jVs7L/Cph795gtegB8Hl+IN+4F52tMvcoMuhK+tw==
X-Received: by 2002:a17:906:ae47:b0:a72:4b31:13b5 with SMTP id a640c23a62f3a-a77ba7099bamr293701766b.54.1720175052594;
        Fri, 05 Jul 2024 03:24:12 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a77da4d20e6sm12348566b.182.2024.07.05.03.24.11
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:24:12 -0700 (PDT)
Date: Fri, 5 Jul 2024 12:24:11 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Subject: Re: [PATCH 0/3] pwm: Use guards instead of explicity mutex_lock +
 mutex_unlock
Message-ID: <kc5g5dg7pakgy4n6clb4a665vo3eyyuwt6uwbdt2nuydtvjfai@sgh33ljymsre>
References: <cover.1719520143.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d7bx635jlr4yx4rh"
Content-Disposition: inline
In-Reply-To: <cover.1719520143.git.u.kleine-koenig@baylibre.com>


--d7bx635jlr4yx4rh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 27, 2024 at 10:31:18PM +0200, Uwe Kleine-K=F6nig wrote:
> I consider this a nice cleanup. It makes the code more compact and it's l=
ess
> prone to error, because you cannot forget an unlock in an error path.
>=20
> Best regards
> Uwe
>=20
> Uwe Kleine-K=F6nig (3):
>   pwm: Use guards for pwm_lock instead of explicity mutex_lock + mutex_un=
lock
>   pwm: Use guards for export->lock instead of explicity mutex_lock + mute=
x_unlock
>   pwm: Use guards for pwm_lookup_lock instead of explicity mutex_lock + m=
utex_unlock

I applied the series to my pwm/for-next branch.

Best regards
Uwe

--d7bx635jlr4yx4rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaHycMACgkQj4D7WH0S
/k4jZggAlFtgs3v01s7sXgX7DZlddYHClZz5k7m/H4dTmDJER1M/2KqJ3apEuwXt
MLh3uHsJgtZ0qTLrccN54LroBBRA625OEk/aHc3gLHLsK5XHLrXQQp4lhxcnKT44
HjMO1n6uU8WtDl/+e4q8/4fWpt3xoFuNIFS42Wu7aNnpKjv+Kpztw+aXFsd4Wo5T
POFNQrOdbNMOIOJf8drOQsVebxv1jcO2RnocQLKLXQ4j+TTvfrQWGLg2Jh87GEZs
Q9vcJT7R0iTKAWj7Ko7mRLE/A8ytCBYLTSLUWzLW1684krfoA94wRf7TlHqf2+nX
MCwIqyx62oIzmyFr7ewehHkZ2nJsRg==
=KhQ6
-----END PGP SIGNATURE-----

--d7bx635jlr4yx4rh--

