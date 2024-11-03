Return-Path: <linux-pwm+bounces-4018-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383889BA7EB
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 21:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4779B1C20322
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2024 20:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5A18A95B;
	Sun,  3 Nov 2024 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oyZsnxVg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED4140E5F
	for <linux-pwm@vger.kernel.org>; Sun,  3 Nov 2024 20:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730665469; cv=none; b=QeVAIL483UFcBG9+BFzH24rQAMjzKfuC2EtOmpe4J9JRJywnAclapVvJTs/BNAoDAju9SnT4FdiQDwgpJ5u3xcI2GYRjZjI8htJq2z0pGogdzQ8b9b0QwmGD4qXshQE2S4s7IFOY0V1wA+4O/SrOa+HEW3sRgHy4AkUm/jjX440=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730665469; c=relaxed/simple;
	bh=+IuVaiSHVBtyyhgrrn4thrcTjVD/nWVrVaIQ5nYlKpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH74wDt4tTf/+31uj5LHzlyHJJteojF91VNNVJNugXD1ujXc9G1ecwYhe5Ohx7aUTSPcxq9EaGLT8JWnbLIDM14pGIGUJ+uPZGuYT1aWkoODNy21aCZAKtjIbQrxfIWAqXa92vxQq5hivvIfzs111PJno4gUZ/COHJlfqtNWE5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oyZsnxVg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e71401844so297044066b.3
        for <linux-pwm@vger.kernel.org>; Sun, 03 Nov 2024 12:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730665466; x=1731270266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbLucy1vznAm/L7ME+S69Mz2iLBOGTcx7R6cx9WeRk0=;
        b=oyZsnxVgTB1unlJJCuZF+5BNQrXk4fTI3XkFL2mGqO0MwVoLErO7lOvjL21LSv7Qh3
         2rU8jhXvDLrvB9ev+WapZD6j3Sf8LblqbLwQ5ZQ+l/LtoZ9ZIMLudJCvIjqPERI9MIKK
         RjG4uLquCIchfDK5fdm/w7b8cEE5HoQksN/6CBYn/fyBJc8lUBgZGtRc7gA0IQlvk3Nj
         qgiKd+rEYH3oga+Id3fYUtjnLrhUeWkHy0Gj7cAbOiYmx2SG5saOSqcxMZpO4PjESFM4
         6PkLdpV/gRDUW6ZHKJ36fLOi/p7ydhwLtBu2tOgSp/1GRurOv5veheINjYmMme4Rj68i
         LJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730665466; x=1731270266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbLucy1vznAm/L7ME+S69Mz2iLBOGTcx7R6cx9WeRk0=;
        b=mx6EZ1U2sE3Z3Cx75F5+LsgQfm3AuYXkggBTfbmNj9UIwS/K+9ENCPAPE6uZFRHEIF
         a7Qwi7Ej6SRDEAwza+vzFlsHdiiij8BRjTXf+MP20/0wGW2eTkmSyGBY3LNGk8VC+bwL
         fZWT6YR+IUxUg9QKY3dKoAmYkDus+p2haHw4vyZeL0z7MUd8mPl3vBmEBIA5dylZRbbU
         4JkPVsRrCBUuSc2simU+KRkbsHvnKuEP1TSB69zqcB8QnJUi455pqWDN1uM8fkJcOmkk
         Xf6tVdiPqr3YcINwEcOWz+CQRwJYLRO6UYmkDF1F+QeSQphMH07K/1W6JYj7gejK9IWv
         hXsw==
X-Forwarded-Encrypted: i=1; AJvYcCUXQ6FTxEFmbqBZJo7J4QlLD3VIhVSRsSuvbMlikrAKowAQUMdU26+yKcVePN7I2ldDMFirzsuMdcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV6jt91CzOOQ2CVgWTJ7HII4AR4afgU0ufFaxn4tFP6PpL+kYd
	Q1UJJX7LgVwaaUzmWQDG2jWHsrh1/55ZWFwAkQQ8zE/2MVSxoRq6n6dhZo9ox0s=
X-Google-Smtp-Source: AGHT+IHIlVtG5Rh5KjMK9FRTNAdhyoVG02VD9/dw3U9OPVj6iEGlEmzj0nuvnJG8VTlgktXo97a9ug==
X-Received: by 2002:a17:907:7fa8:b0:a9a:1bb4:800c with SMTP id a640c23a62f3a-a9e508aace0mr1403350166b.4.1730665466154;
        Sun, 03 Nov 2024 12:24:26 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:711f:c21d:28dc:9f01])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564cc430sm461284066b.88.2024.11.03.12.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:24:25 -0800 (PST)
Date: Sun, 3 Nov 2024 21:24:23 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Stanislav Jakubek <stano.jakubek@gmail.com>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
Message-ID: <ielio4ys77kgo5qsvrbbqfg6yzlit33yun4leei2giplbedsc4@5qmkwgvqe6xl>
References: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w5kjnyt6erghd2zh"
Content-Disposition: inline
In-Reply-To: <ZyH-JASRcpMXYsmH@standask-GA-A55M-S2HP>


--w5kjnyt6erghd2zh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH] dt-bindings: pwm: sprd,ums512-pwm: convert to YAML
MIME-Version: 1.0

Hello,

thanks for your patch, looks fine for me.

On Wed, Oct 30, 2024 at 10:36:36AM +0100, Stanislav Jakubek wrote:
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>

An Ack from (at least one of) them would be great. I see Baolin Wang in
the recipients of this mail, but with a different address. Does the
maintainer entry need updating?

Best regards
Uwe

--w5kjnyt6erghd2zh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcn2/AACgkQj4D7WH0S
/k4o2Qf9GDLGUusJ6j8lnQsZtz0p4dM9bgK5TBtjFfMNViYS3m42wb1dyY01JK9V
9el6EJfM4hxSiRXy2xfUZucDL24iBW1cNuLSoHaSDl8QqwigBsoZWS4N0WmZXrfy
gD46prwESmWEGeC674kzn1LXzUgTdk4ltNy8CJOZdKknu6IVmoYKi4TjEBmv5k3d
ABFeyT8A3fKRz2FdcCQo6WpXZ59MPewenPKZRaJco31M+c6B6aEuWrN/7DX+Jn3B
d+JP/OpUo6ltk2A7T5PHJOqPNNlyWhqvUG9p5KpxqvkL4md3iZhRk77+0cjnFTU+
eKacDeel68acKHq85vClumTmMIa4gA==
=631T
-----END PGP SIGNATURE-----

--w5kjnyt6erghd2zh--

