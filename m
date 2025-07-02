Return-Path: <linux-pwm+bounces-6706-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18710AF63A5
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 23:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C84F3A9D01
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 21:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AD31AF0C8;
	Wed,  2 Jul 2025 21:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrvHPqnS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34102DE712;
	Wed,  2 Jul 2025 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490027; cv=none; b=XzvANJV6hjd51x3FppuDiLLOtpzPwxR4eh3Z5CTSUjnYnh6hyaGKur+bCBWG5y7aHcSYzimWdGNIxzQqep8KN6CNsoOAda8gUj2ALiSvCrekhBxpIIaGfuvBfgIhGeppfaPGQml8V/EqKi5j/enGcU8snn8TXJtt6EkY8wWaZfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490027; c=relaxed/simple;
	bh=bg34YmmeS70FFPT/uwXB8HPdNMd9xBbgYpLNVAACqC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdaBdbaf88cOVXuGUn2r3PoGpiTiKat6zIgQA0gBbCcbcfB2XCypiFI9SGJSXGT3MYtCT8QBq1pKDXzTjLQEQTMX+tN/MrOblBCQ8N/+xJ/vkVCzwazSpCU/RF7Xny7mQa2x9hb3kBFbDdNM2LSUklVCb5AQZdTBtVP6V6OqNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrvHPqnS; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235a3dd4f0dso45998005ad.0;
        Wed, 02 Jul 2025 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751490025; x=1752094825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2xfvGPO1Ksya3OuQDaPHkRfGmdWKE6WGfobY/qdxMtI=;
        b=QrvHPqnS1ZRpWm7etXR9jCNbAyZQ50luAIs33QsLySSclzKIch7SavfsmKCIt6hFRn
         u6mCuxMK3t/UuxhqpH6P4nr22rINj60EBMnUou+JhYefXr2BLeyaFcv3tZmxh6UbJrIb
         fa/Ct3NnLMKa64CwKgmh6+mQejkldoBU3nUslXHw+y3ZmjCQNGyRnAGFLPYDxiI85125
         dCvkedHIYyLddEDmTeDky0WeHKi2XzJH8PeMZS/GcfcrQmHswKJBkHZ6OgGt/l3XufTZ
         HMyXl6PWebwODkk2S4H4BcTUT5SoJETo4F2IHZ8lLAFv9WFY3OaJXJ08vLLWC23kFJKp
         fzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751490025; x=1752094825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xfvGPO1Ksya3OuQDaPHkRfGmdWKE6WGfobY/qdxMtI=;
        b=Be/rCIuUb6Kx4CL7hY5MZEQd/66/jSQLH6Gj++SIX2hdJHEeYeb1KH8tOfaHRWwc4O
         bBjti7FmnMQ0RiB9MPSnkeSNmDLqItzyMT6lq6dT2MPLoqHWPy6js1XBOXdvFV8Mi1CI
         yYSIVR/2T0ibPEbkSTwaC+uy9UaHpsU9NP+ulkeyHthYneWu2Ya+yrK+9WpsXy4D9K7m
         nCBomnVw8uLYE2RejgMPByQUJS7dWynw5KKnW7Hpx59VM7wGhOxVJHEejAHxazZo+USS
         FPRiRrE65JMd0o7JXD894DkGhW4ZZ7v15LhvJ83fBiHApniaGopxWJxNf7jPvYjIMhxp
         hN7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHEgCtFLxQmIVGoNxM04OhoUNAJqtcv7wMuCMKVKEcJHJJcWlxc8pemRUsENyzW8FAs/CWH4IRdHqW@vger.kernel.org, AJvYcCVG+8sOTxIF/uRquN7F4Hwd6M1+uMxHD0A2S9SKd+hyVsF8bUttHorXULGJiorgp+Gz/uzRA5EaCy0k@vger.kernel.org, AJvYcCW8hK+o4zfFn/X03gQqR1p69BLzjRlz4ImYDraI7mdWU/nmNBPsN2heXnXYNvphyrmFx3zT7HcgHEIiyQ==@vger.kernel.org, AJvYcCWnIMIrDaWDQSSmBc1/EVcAaYZfKRnKKBh2fSe03x1yBvj9zubJb1AbdZ5KlB0aHUcoL1VZfGWUXaS/6Koe@vger.kernel.org, AJvYcCXSwUWUaAtxQFEVa9RBTK1YrTI/nVa00t3SLO4KPdrLvtTcO/rItQkpx2oUZbbcIKdUmbvnw44wNssan2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0fHFkAio/W+nywhXEE16H9XpP3SlD+Ov4yDXg1k5MNoY2fvK
	O3kMmNVEvmbaWCgX+uewh9Ikc6hv4YrreFDnMprCpuSKWS9XQnLOYYv1
X-Gm-Gg: ASbGncv7j++xsmb4wWXLjImTaY1mZSuPaaX6RK0S3wq/qHRj2MM9MHqnQpFrafvQY3K
	O7ewbhIs1m1NdDIZ8AINF8Xa57+vXXUFBk+DsOA+t3pX1H8GdxC32tJl6FU/hlSeUt6uh7d3TVh
	E7HV6AbF/oGCBEmcKAanNlUhPEMFHe3ZON65lsp6bPfv/7izq3IedsNRsh+5cCglLUtkN5w3uIY
	/1Fiv+SRQoop/SWIZroNsKAYGMJgld2kvdtt8Lh6adTB9hF7RSsu2T8zsiOKALYtkdaleHWlUwq
	eSL6HQ96OLN9Rlv/gM2D734JcCYn+swTtf078DAkLc23ChZ5lDrcgAxD/WgiOBc=
X-Google-Smtp-Source: AGHT+IFwtUIm+14PZZznaUVeBL4d9kvfMJHlGFaNbp2ss/KcjJLiMnWF42EXMssj52lvwKsLwDaCgg==
X-Received: by 2002:a17:902:e54b:b0:223:4d7e:e52c with SMTP id d9443c01a7336-23c6e4d683cmr74426775ad.5.1751490024982;
        Wed, 02 Jul 2025 14:00:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:918b:9ece:525a:9158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3c4b2esm143163835ad.211.2025.07.02.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 14:00:24 -0700 (PDT)
Date: Wed, 2 Jul 2025 14:00:19 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-pwm@vger.kernel.org, 
	andriy.shevchenko@intel.com, =?utf-8?Q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v10 09/11] input: keyboard: Add support for MAX7360 keypad
Message-ID: <uibf7p6niiljlymzp24h2sk5dzhw5xschaqxj6wfpgge6b7hdo@czpfchjl7pvw>
References: <20250530-mdb-max7360-support-v10-0-ce3b9e60a588@bootlin.com>
 <20250530-mdb-max7360-support-v10-9-ce3b9e60a588@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530-mdb-max7360-support-v10-9-ce3b9e60a588@bootlin.com>

Hi Mathieu,

On Fri, May 30, 2025 at 12:00:17PM +0200, Mathieu Dubois-Briand wrote:
> +	if (!in_range(max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN,
> +		      MAX7360_DEBOUNCE_MAX - MAX7360_DEBOUNCE_MIN)) {
> +		dev_err(dev, "Invalid keypad-debounce-delay-ms: %u, should be between %u and %u.\n",
> +			max7360_keypad->debounce_ms, MAX7360_DEBOUNCE_MIN, MAX7360_DEBOUNCE_MAX);
> +		return -EINVAL;

Is it inclusive of MAX7360_DEBOUNCE_MAX or exclusive? Do we need + 1
here?

Anyway,

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

