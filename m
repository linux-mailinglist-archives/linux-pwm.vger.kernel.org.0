Return-Path: <linux-pwm+bounces-5766-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892FAAA0DB6
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 15:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6F71A86348
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98482C108C;
	Tue, 29 Apr 2025 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3rOBk7p"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCBC130A54;
	Tue, 29 Apr 2025 13:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934432; cv=none; b=K6e4ykV681kfi4v4CF2Y7PPiGnKVTm/WeWRkXNDK8P9T/4ISeny7Km4m+5qefzFyc4i/z5bFJEJyW33p38rlRkNHcOolBD3ow9RLOKnru0nmtau14yTDgCYwQSTsvllX+CwHVWrxd21SaPXDNEzVJP9Ba8jt9l4Cvl5MEVMEsug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934432; c=relaxed/simple;
	bh=b9HRJbXHVqg9fyqM/LuA/aGw1XEM/SvavfXDmB/s9qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BWGCGwfOYRlJH2QjpBJP8COj0jni4dmc9evxdv3N5D87L20Lke/SbTcXHeaGnURGVo5TPdEazRDkzm3W2II8N/OsR+8161/GN67WFlRST5ZQ9ieucw2IEMqfvF5cgSRWKrBYVT5bpzkZ8S62HZDrYcWdh3x3jUnTohoKlsX1/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3rOBk7p; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acae7e7587dso889085466b.2;
        Tue, 29 Apr 2025 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745934429; x=1746539229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rCJ2y+IzV97uI1iWhvjpnjuLzl5mRMft1CF8GMaXK5I=;
        b=l3rOBk7pXgn/v713yeQ54mhy4HGMHv9hrZa0JWIUSQKaedtnvFzCFdPBgPgpdbF3SM
         Yu9VXJ4jXXG1aF8FNq/P69FyrHwtC438qqnisWfGy76Bxs6F8tsRr7I8DlIqSp+6Btem
         9FJTzbcvGl7uVMp4iWzflow094Trx4EzaHg7ofD6p9OGSgu94veIOthODDzYIixCRyu7
         ryggqVsoOp55NBimqo/cXvEUzH48xdQRizHTjp4l5fMHopR+5fQLMYSccYjaz7DJ9jjq
         Ndn7oNZIQorJyiKmqxWgE5mlvinTFdI63SH0WepcSRTCZjR0m9XOi+XHuQTSE6z4Y/b3
         taoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934429; x=1746539229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rCJ2y+IzV97uI1iWhvjpnjuLzl5mRMft1CF8GMaXK5I=;
        b=iI8giSB8RP9clhf1IEKIA5pJggNPXlPDYdqDMP5tJc/Zjc/sIVzDy4j/+6zdUgJVnI
         Pi825ABrtapWogj2A/6GtVB7syXFBlWkkTV0ANMa5a60tBfKsuGQYJoxjVQHciGte6zn
         e93O6RjWZZLXA2YqWruvIvDfi0/ECF5wDoULgYtRPHZj12FosYY/YMISgP60CHaeK/e1
         wBIBN2MORImLGgsfmAlpPF1QsM55+ubApBYl9aIz9Kv/nGzqoy7gAPE/SdwNjpDmbLRS
         7mCdrAv80iyJYh9eKl5vpHy66DXrVfU1fmdhmnAiDoePZbVei2CDV7ARINPv6Crc9JfI
         nLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI5dn6sN+3JaXSuTWS8xOZq7HsI5imPi4YJvCAcSkcTV0gdyMXd0oWvfMDTC7KC4DKhLcQ3kxIvP4D@vger.kernel.org, AJvYcCVntQpQXtiLKE++67Htnwy8sKH1LtphJb1TJaT+BB8Gaa4QxYiw5HESYcDiYEji6QY3VTJX1wdBrMSy@vger.kernel.org, AJvYcCW8luXyRUgMhmMfB74+1NzqDsU6g+j/B9cm+DpxD8BAe9kAtrCw67Sy+H8ZtcvJswlRaTgCoaer4HfOutpH@vger.kernel.org, AJvYcCX2H2ZIM8BSlUQGLDGI7GBU7HHH3pXl+OQMI5d+8jTxXF0BuwIuru1za7c9YyMiAQ3tYz+FUZiQKXka@vger.kernel.org, AJvYcCXJ0Ldxlyaih+74PmKZQDFGBdVPGLQZSEv/Vw/gF0Hz2azHFD3uhecgq3QDMYCeE5kHUGdsWbpHmq76@vger.kernel.org
X-Gm-Message-State: AOJu0YyldgoX+oOv6gD6laJcyQpaVkxDpfcC1a6hTwWnuzXvD/U4lS/0
	AAmb3BVQCEEET+IBE6H7FiJsylzmjBva3OBPshC6r1R5Q3o4gBMY
X-Gm-Gg: ASbGncu8JrL2JGXFFLHxZy8B05T3s+57k7BJ5jFWELrZx0BDq4eLdiOb+B4+e/sB9Ws
	TGJuSXrs5DBcGG1GAAfd8m82x8LEZrThTr18FSYddjY1B6psCR/FcowBQbE2/TRsKkqfOyVk5eb
	NiWgnK+4tOClIXwOvo0mesM6oAmYVcnCAUMIrlg2FC0QnRNAGb+X12wDAV6cFWzh+n+53Z6kR/8
	205KMbRYh/Hfdddb8bFRn7RMlJTG/VhbDQoNGg9+5iAlVz3/AhkxftY7wymY/7cqRVetSJx3mJ+
	X4/FeykuqmllgEb+fbrEIr+W+6xLH7yaCrhIEYOPoCDTMktE9Dc7A3+pngx49JEDVDs=
X-Google-Smtp-Source: AGHT+IHw4QwSUbJu5FO5FlEpnmeGm++bjQVOauZeSS/SbI2JGiaYCiVzqACbtNyNlRVSpQYsOLnm/g==
X-Received: by 2002:a17:907:6e8a:b0:aca:b45a:7c86 with SMTP id a640c23a62f3a-acec4b41481mr360717866b.1.1745934429100;
        Tue, 29 Apr 2025 06:47:09 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2a02:3033:26c:ba50:9d5c:4d3e:be76:7564])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed64fc5sm779707666b.129.2025.04.29.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:08 -0700 (PDT)
Date: Tue, 29 Apr 2025 15:47:05 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <c3i7g273lgvx7rpihzq6r7exxxnglbwrqwfryyz6ciqo52tszf@cvi7pz4bmkvq>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-1-638af47e9eb3@analog.com>
 <aAe6u6NhAsgjaL5_@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAe6u6NhAsgjaL5_@smile.fi.intel.com>


Hi Andy,

I agree with your suggestion, and in this case the appropriate kernel
version is 3.10.

On Tue, Apr 22, 2025 at 06:50:19PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 22, 2025 at 01:34:46PM +0200, Jorge Marques wrote:
> > Some devices have an internal clock used to space out the conversion
> > trigger for the oversampling filter,
> > Consider an ADC with conversion and data ready pins topology:
> > 
> >   Sampling trigger |       |       |       |       |
> >   ADC conversion   ++++    ++++    ++++    ++++    ++++
> >   ADC data ready      *       *       *       *       *
> > 
> > With the oversampling frequency, conversions are spaced:
> > 
> >   Sampling trigger |       |       |       |       |
> >   ADC conversion   + + + + + + + + + + + + + + + + + + + +
> >   ADC data ready         *       *       *       *       *
> > 
> > In some devices and ranges, this internal clock can be used to evenly
> > space the conversions between the sampling edge.
> > In other devices the oversampling frequency is fixed or is computed
> > based on the sampling frequency parameter, and the parameter is
> > read only.
> > 
> > Devices with this feature are max1363, ad7606, ad799x, and ad4052.
> > The max1363 driver included the events/sampling_frequency in
> > commit 168c9d95a940 ("iio:adc:max1363 move from staging.")
> > and ad799x in
> > commit ba1d79613df3 ("staging:iio:ad799x: Use event spec for threshold
> > hysteresis")
> > but went undocumented so far.
> 
> So, it was no documentation for the nodes this change describes, right?
> 
> ...
> 
> > +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> > +KernelVersion:	6.15
> 
> Then why don't you put the real version of the first release that has it?
> 
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Some devices have internal clocks for oversampling.
> > +		Sets the resulting frequency in Hz to trigger a conversion used by
> > +		the oversampling filter.
> > +		If the device has a fixed internal clock or is computed based on
> > +		the sampling frequency parameter, the parameter is read only.
> > +
> > +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
> > +KernelVersion:	6.15
> 
> Ditto.
> 
> > +Contact:	linux-iio@vger.kernel.org
> > +Description:
> > +		Hardware dependent values supported by the oversampling
> > +		frequency.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 

Best regards,
Jorge

