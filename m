Return-Path: <linux-pwm+bounces-6207-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FB0ACABE3
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 11:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49B887A43AB
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98501E3790;
	Mon,  2 Jun 2025 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0K0/FwT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC4B1E25F2;
	Mon,  2 Jun 2025 09:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857721; cv=none; b=TfjSWfJIFHUjT1QmlhyWdF7sZp+W0ROpQe59a2MRlkr5r+3jDMioQ+/QyWt+BoOgplNLRQHPVpJVvvnTkzbFe4z46C/HJUbKvhWpQe/wx9y2KNTCKVa2A/8Y9nDwfUYdc19tb+WHEqDt1T1EUJe2DNpPRudOsHsF0DiRRg2IDIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857721; c=relaxed/simple;
	bh=OKeStrGIby2EGi8mJ3mXl/AW4GYR762m/+3o9JFp7m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srR8ox2jMJ2RA1fT5bwBwHRcLOQBbL+DGE0RTZ6d5RDdMGHxsf6iUZKwESAgSeVj/iVdZOe6Pwbt36J5kTelMypTygsPQYXnf8jkirdJc/GeOAZFQhkL6YcSA0aoKwrV1zqtK0a4nvxplrlmbUWmlrgki7URzWQuCpfuYZpuf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0K0/FwT; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87dfeb9d0c9so611657241.3;
        Mon, 02 Jun 2025 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748857719; x=1749462519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu1Khd9CgiQKdcwgPbMeK/RzLAfO2doPW3CBZFxJfBM=;
        b=W0K0/FwTY/FI3dhB1dRqeX9HO10RtYiWsZNFLGKDUeV7Nb0sfMwVH6gHnRqminVh7j
         OG38Al6BxYl0L0UrkB2+hb+IDovEf82zStSj7jIfy3Kzm7RMQmEnq393SLQW3tz1JyRQ
         ormguJK24PSTHzqS7WSj7Ya+UVN0rkytz1dT/lPnS6c75LijoP6HCn5dFtEY0JejGMx7
         AseLdx0i2h6i3Maqstu/tDGqmKwuqxGKOljoQc9GL6TGZlgMAARvjSlYI5q/k9Jk2No4
         kWpp9njx94fogbqooahy/5KeqkDnkLVoBOXtioeaORutwk76jn7rHOIkeMlABm+f5y3A
         TKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748857719; x=1749462519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cu1Khd9CgiQKdcwgPbMeK/RzLAfO2doPW3CBZFxJfBM=;
        b=qRBzKh31BPXh4m/gGrvEhr6XuBAo5Pi3wBOHxbcCllC+EQEZBs2N1IYZVPPCbgi3vK
         IkF+diTgglQ3ikeuEW1ebM8oWuQ9m1u+lRVQ11Gzi6/ylU8jZVEXons/ECHm2YgsptMm
         BHW5vltP6OWo0yiMkuHPem6p/tqvv7L9LYXD0ZBjvuAxT3ELUxbro3igUH2jN6AAJzek
         I2WyH3XaJRpR2d+64cOyo8rlT1VgENYNd9t5cwrQOSCij3LnMwvq7KM8IOosObtdYF8d
         qYSp6pmUS/ILuxl3RYiIg9oIkiMqEeQWrwryKWHYUqf/25/GwzLMlxKNT8q1wsB8zKxl
         yfkA==
X-Forwarded-Encrypted: i=1; AJvYcCV4RnEe2qHphy59ky2TQakL+EhzsilyhFN7nSMR8Ijgoc00ZisbnWnHHeijg6M6Y1cENtZpDqo/XfZV@vger.kernel.org, AJvYcCV8jny1Pn1oOO25ONgTMdUCyImcgKCfAEAi8MXmet0jYPTHjPE1Ht6aTihCL5EO0nX9cZryjJM8S5jm03ws@vger.kernel.org, AJvYcCVDMQfKKS7uairob+6P6sXalcjSHLGqzuP5A+QC/IOS/WV1nRgjUaJdyRTdSPRjEWo1KLtwTCACvmb2@vger.kernel.org, AJvYcCVJoJOVRJqbnCNM+zqdcgZO7GGwS5I3N8nKgT1ynVqBQimBMudBFr+49thaZzlmA3oasRQaec00GY6+@vger.kernel.org, AJvYcCX99jt1x4FLP6iK5MbItUgs4QxHwmd5cxjc5Mh19y9+cMEa3Ukg0488OoZDOii0V8KgBBkRzP2ZtPw8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3lDdtrtA8VcdTqlgp9DY9K5y9W3HvitDNaWbEF4vRB05hB3px
	HR4nyiMfDrq/VsQbIWqEcWo+Ld6XUgCZYDyCj+8m+jJvJnsyL09Ra29W
X-Gm-Gg: ASbGncs21CfoO8PPnEU0eFlOq3CqD67baqMhm/5Ra6T2wnieLc5rxBZeMWzNdNPBwbj
	lL+l8PACgKTGGqJ4DAN4MJ0qyCH2xUlD1EAQqWpTAG76RKY96DZviZ6dT6KRRRonCRoNNPRldCw
	IHnz5K8HX+7+XgowOZhyPmkonpPA8/Fk2+devVC2NTPD7GfbjCTAeuH1ovj8iVzy6+qqxbaA13E
	9GvrB92qbcJuWrwNlLIwbsXNWPzZGl2dOWvWgDbp/4qeza9ueJdd8zfGKz15BLXuIRUCZr3bRqT
	6G7y9fG1MquyzldzxICMSy5ZbcFLl0NAMXbQQyM91TbR2e5iH0AJ0eNKucsjjXJ3EOifQhzKXZ+
	C
X-Google-Smtp-Source: AGHT+IHuPPrU0h5hoopFKW1BD5CeygjjdtkEywfgREUczufl9/6ic34e8Vw+3bJZzrWb+kOFlgD1xg==
X-Received: by 2002:a05:6102:949:b0:4e6:f7e9:c4a5 with SMTP id ada2fe7eead31-4e701ccd25emr4346427137.22.1748857718821;
        Mon, 02 Jun 2025 02:48:38 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1225:ec01:ecf2:8e21:9f0f:159e])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a3b63besm6069305241.30.2025.06.02.02.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:48:38 -0700 (PDT)
Date: Mon, 2 Jun 2025 11:48:26 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: code: mark iio_dev as const in
 iio_buffer_enabled
Message-ID: <o5uaw756dho7v76pzvkn7ukfpsam4vmaryzvmtxmfehu7hnqa7@ppasiqfu44rq>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-2-638af47e9eb3@analog.com>
 <20250426164524.166ce3c8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426164524.166ce3c8@jic23-huawei>

On Sat, Apr 26, 2025 at 04:45:24PM +0100, Jonathan Cameron wrote:
> On Tue, 22 Apr 2025 13:34:47 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > The iio_dev struct is never modified inside the method, mark it as
> > const.
> > This allows to be called from get_current_scan_type, and is useful
> > when the scan_type depends on the buffer state.
> Now I'm confused.   scan type is only relevant when the buffer is enabled
> so how can it change as a result of that action?
> 
> Maybe all will become clear in later patches!
> 
> Jonathan

Hi Jonathan, you are right, this commit will be dropped in v3. The
driver scan type depends on oversampling value, so it has an
has_ext_scan_type, and is only relevant for buffer readings.

My mistake came to fruition from the fact the tool libiio at any context
but local does not support changes to /sys /dev, including scan_type
changes (it scans once at service start), so I kept getting odd
behaviour that led me to the wrong solution.

So, in summary for V3, the widths are set as follows:

* spi_transfer.bits_per_word = scan_type.realbits
* spi_transfer.len = scan_type.realbits == 24 ? 4 : 2
* scan_type.storagebits = 32: Used by tools, such as libiio, to compute
  number of samples.

This ensures the minimum number of bytes transferred in the SPI bus, to
optimize speed, while respecting SPI Engine Limitation of a fixed width
(generally 32-bits). Similar to commit
ce45446e520c85db022 (iio: adc: ad4000: Avoid potential double data word read)

Regards,
Jorge

> 
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> > ---
> >  drivers/iio/industrialio-core.c | 2 +-
> >  include/linux/iio/iio.h         | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> > index 178e99b111debc59a247fcc3a6037e429db3bebf..bc6a2ac6415eccf201e148ea98c0b5982787eb6d 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(iio_device_id);
> >   *
> >   * Returns: True, if the buffer is enabled.
> >   */
> > -bool iio_buffer_enabled(struct iio_dev *indio_dev)
> > +bool iio_buffer_enabled(const struct iio_dev *indio_dev)
> >  {
> >  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> >  
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..88569e1a888bde4d2bfb5b9f030096af1c15d68d 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -629,7 +629,7 @@ struct iio_dev {
> >  
> >  int iio_device_id(struct iio_dev *indio_dev);
> >  int iio_device_get_current_mode(struct iio_dev *indio_dev);
> > -bool iio_buffer_enabled(struct iio_dev *indio_dev);
> > +bool iio_buffer_enabled(const struct iio_dev *indio_dev);
> >  
> >  const struct iio_chan_spec
> >  *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
> > 
> 

