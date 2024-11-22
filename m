Return-Path: <linux-pwm+bounces-4123-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF399D6413
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 19:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F4B1611A1
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2F41DF995;
	Fri, 22 Nov 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sxuc5hLi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DFD1DED76
	for <linux-pwm@vger.kernel.org>; Fri, 22 Nov 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299583; cv=none; b=JZ9SvVjRDJ8RgyphyWM5cp88iemybgdhZW/ZepMjKIbhEd5kUS+JrKTG2Poumo7ai4hBV4waU+GhCXvE0ty7IvW8wxbpxoV89qLVKB6IU5hFzgROwa51kGByhJu/Rhh5wgsXhOgYIVL3fOcXulzYdz9zXJyPlw5Hcl+zrrmBYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299583; c=relaxed/simple;
	bh=Y/szpWo/ys5eOgrnr/yCWl5Q/XYjOwfcIY1LSn3QnO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVgDv60bw2Ay8ekbuoC2It6NqInx9upDmRY/d0hU9hWXJ2TGtHIjancCAY+WkAymesuibg5npBzoOXeWCV6KPaKsJlD4EM4NbLh7zaQRHdZsrOajmZCrpv2VQMOIrlRIrmGLntGoIbfya13+mvkrdNKXEt8hW8MWpu5K6IK45/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sxuc5hLi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso27962895e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 22 Nov 2024 10:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732299579; x=1732904379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/szpWo/ys5eOgrnr/yCWl5Q/XYjOwfcIY1LSn3QnO0=;
        b=sxuc5hLizFRGzYrNpnpdQYCFmaCjPmH7/F1f47k5NNb+liw4i4SV1n7zH0GwCMqTvK
         w5a6OPiRFHRZOBsS9qeM6SjYYgaz1FVAjPa19qKY4jfzLEkuy+4BOsDje8+9jmWJaGMt
         pX29lw8J8R1GN7UGURV6rdnBW2F5CdU7gOuLhVXClgnfQ9XEZXLe0aHWRH3JSZfWU72U
         K3VNyX9eCjnMpedIdvbthN+QgQ0mfJ7xoBEbaJhMCqjyzfd2aEiIE7ihxZXx9TtU/XSz
         St6yG0fNmjOl22DHM6SOD/s5UPlvNT9Hir7SvcNO5Qbz8Di3xM1PTgBGmVS2p20OrKLi
         tE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732299579; x=1732904379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/szpWo/ys5eOgrnr/yCWl5Q/XYjOwfcIY1LSn3QnO0=;
        b=i6TznPN866Szvgn/K6P71AKHIHtQgYDeitW+JcvFKgH2R7W4uDrwUqynOgvOLOm+qR
         Y8cffTEOcWTOf+eL9uZO66nNUtgsLLhw8rBqOuwGMKbSxVZOswBGsU63dKu+yOp8rk1t
         i5u7FOaiF6nIQrnW5fgBYuiZva7P41WrJYvUwrzwS3+EKEv4l846+RzH99dXoQA57mzJ
         PV7Txhx55oDxrFHQ+8jvwxlmA81QYBWqeL84gxJOtmYZUkf0QXRSrULBSTiuhzwy5pWT
         cEbT+vG6ZmCsWCkZz3zr6pUpMh2O28iq/uEVoFegGq7fh8xrPlMN5Xwud/Osc25qNXiA
         IEAg==
X-Gm-Message-State: AOJu0YwZw2g9d3qbZVH7e5jawHhLGb3IjXplrv4nPUSc38ncop1ENsyR
	vk1GflttBJcLqg0gmEKPuWFeDUnr90N1nMlmjqGyxBkp95TmE1dcvZTMoxonUsA=
X-Gm-Gg: ASbGncuE7KCeYeXEyewP2NBZPGN2IQ34il7jYEEX97feoWbRaEgOZ8+pN0A6Gxk29Zh
	BMWVLCviBoW2B7wmOq1yncEwEPAFrSKCnDo/hJlYxqk6t4AYlnU665osTP6bsyrx5xTFrq/ACCs
	WqkwLPvBGFQotrxL7Pil4rTOOaRWy/q57Rn9Uuy9iVVCQ7d0ukgiiZ3yT/sc7KFfu6armvUpNg/
	BalWfCaaA4rtcaKWM8Ic/zAnKtw5e3yiWbiCrW7k09pVjCbCsHMicZs+SD+Jbcq6pCAqGbk33A+
	VFc=
X-Google-Smtp-Source: AGHT+IHYgqyxcn7ucR1MIiQZTgSIh6mW4ccnkdqYQzi0krIec0OTdQIPnvkbAwgUxoudmZsboq/NBw==
X-Received: by 2002:a05:6000:1a8d:b0:382:5141:f63d with SMTP id ffacd0b85a97d-38260bda2bamr3775937f8f.53.1732299578845;
        Fri, 22 Nov 2024 10:19:38 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825faff9cdsm3040747f8f.28.2024.11.22.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 10:19:37 -0800 (PST)
Date: Fri, 22 Nov 2024 19:19:36 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: marvell,berlin-pwm: Convert from txt
 to yaml
Message-ID: <nluphhnqls27ebacfskxed77lcxtvoinzd3kozjqbgxsjl23vr@rl6vbrskuoce>
References: <20241029160837.590199-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwaoxzgjpu3vrxek"
Content-Disposition: inline
In-Reply-To: <20241029160837.590199-2-u.kleine-koenig@baylibre.com>


--cwaoxzgjpu3vrxek
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: pwm: marvell,berlin-pwm: Convert from txt
 to yaml
MIME-Version: 1.0

Hello,

On Tue, Oct 29, 2024 at 05:08:36PM +0100, Uwe Kleine-K=F6nig wrote:
> the only addition is the list of maintainers. I optimistically added
> Jisheng Zhang and Sebastian Hesselbarth as they are the maintainers for
> the platform containing this type of device. Please speak up if you
> don't want to be listed.

Objection perioded terminated and applied to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

as 6.14-rc1 material.

Best regards
Uwe

--cwaoxzgjpu3vrxek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdAyzUACgkQj4D7WH0S
/k7gDgf/XeAncYRqGT88fPlHqsOX01CaslhpkRoAcl9yAaABozqPs5H1dix/F7lA
5KiOcAzSuYfTdVuke7YK58uTyvLd21PuPFUyXkMEGzOzH4QdxmLdN7Qt7DG4uyxf
Ru13E9zAr+j5C8XBzQgu2OwZqkAq9Vhxt5tzVu2DbhkA/fEyxcqzkjjLqk+7MTGJ
LG7mIFNElJ5XQBKprhALxqG8Z6ZTMofnWvcZ6Jf5nPNFmMV48AOS872nCeNF3teb
5juYTkOHGFt11caUGofNHuIGYYp3tQYLOx60XluY/NL6mbW+tVFC4Q1pzpm5y9Rf
rnvA6L+T8gNItKdp/lFYYZuiXUKXHw==
=mtGB
-----END PGP SIGNATURE-----

--cwaoxzgjpu3vrxek--

