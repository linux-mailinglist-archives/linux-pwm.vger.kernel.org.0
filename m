Return-Path: <linux-pwm+bounces-3941-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB9A9B3150
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 14:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0CFB20F9C
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFA51DA309;
	Mon, 28 Oct 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C+jjuECn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBCE1D95AA
	for <linux-pwm@vger.kernel.org>; Mon, 28 Oct 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730120886; cv=none; b=ooFPC1FygXjauan2+/AY4CNzkGx6BeU3F+usf8clsPLl4p7AawRUeyDatq/2mjkFoctvi4oMyNFzxz3M0IlnQBOycQ/jILZH3qYUs6RUQaZekZjUgzVdj4JvedV1ivCuHkPplFcbvkiSp9Zj0tJaLKZeRqECTGfJTC6U5kwTVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730120886; c=relaxed/simple;
	bh=qrfgcmlgq2nwjvLUZHk0QF5MhUKcagiHjzeFXdD2voM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUTj73RAcdzytkWVzhH+/AlkY/1WXQFKD1BCDc4Y+ebC03iESOBvViFvBmm0pL6h6kxc1SGX0/jXw5DJcSNEZ5OsFnbt59ZUyOyezzYKGDouLURbD4pSkcKTbfFAzXkyjDVcQh6iaiJ6TdSZxbOAQs3Gk+TvTJnKmbSRuFaJZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C+jjuECn; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d41894a32so3261592f8f.1
        for <linux-pwm@vger.kernel.org>; Mon, 28 Oct 2024 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730120883; x=1730725683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+T7kefxIcxHT5VtFPJByZMRUMBbn6MI/AgPWzYijHAE=;
        b=C+jjuECn+6zUhqlMgJL1hYpsULJGTLvPvqnhGhsx2T+v36OxoaQX8gkFNvSzSB+xf/
         87Fvqtu+eHkacXAfAkNaX1nGVRtZhVRc2GXdh8bR+K3MH3uZx4zLLm1r8t3H6W25S7e/
         gtswR7mFNnzfeGZ86t+VS3wHXwA8+VEEQa0C+AC4VDNHxhtu7miKjLvp7yUFxNKib76T
         OYCXKoMftP7PGaO2p9z7ex/N/RGJqmdh8DrDAVQmL6pnhAQgvmYECjKkTnKOmeETJeAW
         wjAEMH0I2lYsNUZY+h5YoG+2t1M93kogEWhICbQkqbroZ0aRRh1/FKa9Sp+70mwOTARD
         WBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730120883; x=1730725683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+T7kefxIcxHT5VtFPJByZMRUMBbn6MI/AgPWzYijHAE=;
        b=ku8QBObkDy6EGS77mk0UJQgBk/7vw8BxSPBBIQgDwjZOGddFxv+PWzPFmqgV/jjjc4
         mhRdhNROOanCWkk9wJvF8Fibmxn3OIOBftYcsOCrq9rAfqmagPvc8O+aLt86/PewMzlw
         Z1m0y7WUJfJdcXWeQj+Kb+iU3CeOJC8ZihPDcxNDponDlUfNXF7zYM/MM+ciBNGpZ2WP
         d5xsrxaqxLMT244zpxQTnYuCSOk6QLx8gIvLOYoKixv2BIeLTgXtIoM+VsYruNodbMa2
         rnFUxpRTxRp65jFzfwwWsxcHNFVsII7/+mZii9MB85jTOYt4QHqwgRHFeRBkoifFRphM
         ZKcg==
X-Gm-Message-State: AOJu0YzXzqBW0A2d0YXvUYQRiyIqZNgETqpD+XZ0mb1w85+iAayOs0e4
	DS5Cauysz9Gpdx9QxFk5kbS7LKznjawjMoQjTLWbAomcD12JEGhnQWbN5dk38oZeYPMFosdSXCL
	S
X-Google-Smtp-Source: AGHT+IEU2OFu3aj/0ozNTK3c+xrNgMRBRp2IE0b0eX1QcboM3Gmhr/4icgfYzcHKNdhK4qvH58vGnA==
X-Received: by 2002:adf:e602:0:b0:37d:43a8:dee0 with SMTP id ffacd0b85a97d-3803ac7d59bmr11767486f8f.17.1730120882962;
        Mon, 28 Oct 2024 06:08:02 -0700 (PDT)
Received: from localhost (p200300f65f0c3200f401bf2b6011cd64.dip0.t-ipconnect.de. [2003:f6:5f0c:3200:f401:bf2b:6011:cd64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b55f5e1sm141214135e9.14.2024.10.28.06.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 06:08:02 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:08:00 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ben Zong-You Xie <ben717@andestech.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pwm: add atcpit100-pwm
Message-ID: <tzgdcu5mzzzbzof7b255ehcabelvcwhe5ictautm4ancid3lrz@vm6wt3ssbair>
References: <20241028102721.1961289-1-ben717@andestech.com>
 <20241028102721.1961289-2-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vcocot65xyvxal4y"
Content-Disposition: inline
In-Reply-To: <20241028102721.1961289-2-ben717@andestech.com>


--vcocot65xyvxal4y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 1/2] dt-bindings: pwm: add atcpit100-pwm
MIME-Version: 1.0

On Mon, Oct 28, 2024 at 06:27:20PM +0800, Ben Zong-You Xie wrote:
> +  "#pwm-cells":
> +    const: 2

Please use 3 here.

> +  andestech,clock-source:
> +    description:
> +      Clock Source for each PIT channel.
> +      0 - external clock
> +      1 - APB clock.

Is this something that could better be represented by
assigned-clock-parents?

Best regards
Uwe

--vcocot65xyvxal4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcfjK4ACgkQj4D7WH0S
/k6wGgf/Y6+wBX5NXoJLLY0Eq1ftscnATj5cUM/HeG3R+IF84rxI83jqlTCxo9ZB
6vrmxQVZl2B4MhvpWUQPufkPD3fWBYfwuiSotXU7QLn5jwy4njuNdNjIHEhkfPGp
s7EpUwwx3oAZkLx7T3qVPP88uefGrs4LN0BxlGpC+biUT6J0cVZ6rml+CC2qlYO2
1kOC3dcD4AN89EjwxeLGUj/bVChzxePag39mfLuxK7DHH2FN6eA5bf7cx9seDc6M
wNDxFfR0zLXV3rh/KWmtu8EysvHpQusHnTGKlakFwaq78N0X6dtFS7/oKNt1GNwh
OU2ZydtMZCcI7zIx90biTk/T+vpMFQ==
=Pptk
-----END PGP SIGNATURE-----

--vcocot65xyvxal4y--

