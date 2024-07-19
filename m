Return-Path: <linux-pwm+bounces-2851-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09727937451
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 09:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DD91F22A5E
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 07:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A15502BD;
	Fri, 19 Jul 2024 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CKwA7xE7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A64D8A7
	for <linux-pwm@vger.kernel.org>; Fri, 19 Jul 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721373648; cv=none; b=eo/J7dl5SKlkjqAvPizABUsl/T9mVdH2bUs3WkiC5cAl9Huw9s8cblGjJAMZZYi6R9eOWEiUsQLtKB++qLMIzGjHI4n6XLrEZwU9EAHLlSSRpiYJBxa+qxgS360oY+s/yUWqE1yxEBT2Y30oFu/d5e+9d+sgcxld6n/YD3RmDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721373648; c=relaxed/simple;
	bh=snCOMfSAIZ7BN7SEbXap79VN++oHgdcE3AI+lBWfejI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=At863lWLCrh7a1UqRd1n2cXI+BcGurMPTwYdwDecwzxtu0ORo5t27Iv31o61087EbXsRVwpm6qJHFO+LfzTOyL1ICUrjlOGMPAKutYLunemHsDU+c5734ZKY7boqcSa2B23MhpkzEDaMA5PoAyvAr7BGAhAGpWILxO6lC+GPaxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CKwA7xE7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf989so228706a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 19 Jul 2024 00:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721373644; x=1721978444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=snCOMfSAIZ7BN7SEbXap79VN++oHgdcE3AI+lBWfejI=;
        b=CKwA7xE7/Ff/gcwjddW+QvFZ38IRkEJiatecI+IzqMYs0f3/b7sLIxH6TWvuEiX0mS
         Ytr5+0OM8CEW6WOBz/oUyU6nFm/i3cR/MtiFmj/TQQvmUPHgdusADDIzJKMbuDHd6Ute
         XRdNosgpmvYeVqyZM2g+67KjHukPvy6EU/wGlYoo8JNaXIEsZkBhAs7FVq7LYmx0akTx
         2e50+c/MMSIjeAm47Babd1Qzw3Sr94aBqfF0XZkipI/U1iGT8PIO6E+vbw1nTY1FN6j+
         723YvUPeyPseHkUQZ5SIdTki+czF5jkeLfg0CozCs3CcbTUgze78iSFN9mtWHAXRHso3
         90cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721373644; x=1721978444;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snCOMfSAIZ7BN7SEbXap79VN++oHgdcE3AI+lBWfejI=;
        b=EPNXBGLKRcPBymT+fX2bWZL3cw5BWZJ/+xFkGoIgxCKWN+MrX8t4ZWL7kMC5ddFBLn
         VCDiH5IzbpOFstPuKVi137PbIXScqkRq4NZcZYHrDZb/CtAWmFZm2L4cDjgtozhdVmaH
         A6MrEThBT+YtlnuAoZcZv2cp8NFPKqE1K0FfEH/bcpxTUBcfSZqmsmgVOWUnzj4IkBZV
         6LuO9F0oG/D1N1kXFBpnGOnUwMOLRDE2k3P5ywLetNtQUnGpecESLq5m0j174lMlLmS+
         A1rP5lCdeOIbD+iAjmK2FfWnOdSdi79/8/PfJH1kb42qEsDCkMDib1XGYCDIx7dPGpuC
         WMhA==
X-Forwarded-Encrypted: i=1; AJvYcCXL/MyMTNjTGPfHwOxOZ9msL24v4qVI14Am7rME2rM6W59gezcuerU/z5bB7eUjh3aD+m9ZbFh7lVZEPAF+qfU6ZLKUa/W+4e/7
X-Gm-Message-State: AOJu0Yy82Od1jP+gMi5k6V76OREA4O7XWAvoUAp/Yl/C4On2qaZ/lDxJ
	4vNQY2jZ69GN4z1J/oyLFAVJav+EhmWcUu0CXGlTfGQmHpk29b3gi5NeoUklZnY=
X-Google-Smtp-Source: AGHT+IHSnMJiPqKXQFc7TqXz25zzG8NVyoXNnDQ32Bkv6V9d4Cr9qVr7e/wI2y2FwvE11QdoZJJXTA==
X-Received: by 2002:a50:d682:0:b0:57d:46f4:7df5 with SMTP id 4fb4d7f45d1cf-5a05bfaa613mr3897320a12.23.1721373644032;
        Fri, 19 Jul 2024 00:20:44 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d30a0sm669323a12.83.2024.07.19.00.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 00:20:43 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:20:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: George Stark <gnstark@salutedevices.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	neil.armstrong@linaro.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	martin.blumenstingl@googlemail.com, jbrunet@baylibre.com, khilman@baylibre.com, 
	linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@salutedevices.com, hkallweit1@gmail.com
Subject: Re: [PATCH v4 0/3] pwm: meson: add pwm support for A1
Message-ID: <bp3hbxl6zs6lwomfdj6edhq35pde3gr5i2qizgdf2varke2eai@weeodo6gacd7>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
 <52e2e211-a0b7-47b1-a451-34c304028097@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a4mrqcrkf7uvtgvq"
Content-Disposition: inline
In-Reply-To: <52e2e211-a0b7-47b1-a451-34c304028097@salutedevices.com>


--a4mrqcrkf7uvtgvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello George,

On Thu, Jul 18, 2024 at 04:09:04PM +0300, George Stark wrote:
> Excuse me, should I fix/improve anything on this series?

The known issue with this series is just that it's one of several patch
series that I didn't come around to review yet. I tackle them one at a
time, usually in a FIFO order as listed on
https://patchwork.ozlabs.org/project/linux-pwm/list/ .

Best regards
Uwe

--a4mrqcrkf7uvtgvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaaE8cACgkQj4D7WH0S
/k6nDgf8D5F2Na4nH6HLwiqFon8plnLTpbHNktSH8KoKVdGii8LxI9VwSaFm625x
7TRIUvuD6Ss2nW8Wyy5XN+Jj7GjFT4l2A6YOTtbPYqpnAKryKUPmu5QPFLE/UrH6
HqoABIBLJsFFFFLHN8DSJm6EwHOLyfqmhtYt3ReQLYvu9flXIht4E+JCUnZSrxRM
dw1WSK1yJBMhDcnIMcFZ48C+ymj4t3bzImEt8mjoExdlFC/sUzsZr2853Dme9QJk
Gqi3tjsgTHFBMq1CpjXdJNBTnQaqRECKVvrEntWW66s8ocdF4Q5Ib3M8TeOY2WLg
EpCoY/o9x4O2xTSQ0Y0C7kRbNln1rw==
=tWvy
-----END PGP SIGNATURE-----

--a4mrqcrkf7uvtgvq--

