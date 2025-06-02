Return-Path: <linux-pwm+bounces-6206-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B284ACAB3F
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 11:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA31D16DC0A
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Jun 2025 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3611E1DA63D;
	Mon,  2 Jun 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO1sMt5+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9FA13AD26;
	Mon,  2 Jun 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748855874; cv=none; b=aCWH5ssDQtF4tEpazmlQVKlyjsgkhkLLfYbeWjixW166FQTjdWXo/Zc/UV+eWDei1fRcC1EOBswBqp4vWgkZqyaM9fEH+zBuYqFTGyLzEOQQOPsRmDX+1sbrfxCIVQATj1/5P9dBxflAKoeK6Z4BIPC62v2shq0iE26p0Rk6Hl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748855874; c=relaxed/simple;
	bh=p3pVK36eYaUHcAq2nEti5IMb/UfHDM06YJHUt5S2oMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1DaDyzYNlmzMRoE3di0oHzQOqB/pp8f6DXhxRvqgr6reixJLtO4M6OeEcoUyZmUYjzxGpiAZtQRwgd4STDb/ub4objMP1s6+QMLvzYEomBUQ3McxnxVGbmCgnUvvo0r4QYElnI2iZUL4c0QhWWKiMjYTQJlIhz94aJ0mQoRvLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO1sMt5+; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d5e3ddb66so1042782241.2;
        Mon, 02 Jun 2025 02:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748855871; x=1749460671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Foak5GJOvF2qzw/Sdnn9z8LtJHh30NXj00gMeZswR34=;
        b=OO1sMt5+I2h3AYiNYbJd772JHwWQWzY9TxEK6BfpcXOjIozsVWzEgBl+F6szcZVWiU
         H6DKg4IK8CkBcnxPgQu7ulL3UgN/oL2lX+WRdvTZUVuKYRSOJh3tlD+O6Oe4O9du0z0j
         ifbcuLy5baGDXPex9PObchSUdopzbiOIhFVNy0qqIwwJUzjeA28OqbXkGuEfXAM+Aev8
         2B8kKOxEx1+K7XAS/JUyK1gwLcSfU8CnIaVvZ3sKJgezBfxA/Zzyx5bavO36/BWavMKY
         hsVh5/tIn/T5MN3Btp9AnUFpOAy9GMJ3miDz7cc2MiG/Ak3LWla4SvxXw7VX/e8QRm+X
         lXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748855871; x=1749460671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Foak5GJOvF2qzw/Sdnn9z8LtJHh30NXj00gMeZswR34=;
        b=JjId/07qQmTEEs1ItEXXRWeEhrTHGf3Vbl0N58jcauZYA8fewjFEA/kST2o18a8kHD
         sHV3l/0aqcn4ZFalfRFTzvQ8hX4KXFgknnPz7kkk7xVlL/MnO9mjYv9P0QKbb+Qx4uTE
         xr+fQwjbgWLBhFUyxT7nuN8+ImTnmilRW4cAD5r7QSS4RtTwbuoIWJ8Dp5yznjY6+Obc
         HrFmYrsRyxy9O5HRdyQB+HChxz1eRZM3QMjYzyV4NZ1k02bKfr+TmD1ULJ1XiQiH1QAc
         /H4sJ14M9glUy98NBrbX/q2alUpAq0qfBP8slDdW+Wu07+M61qXApC9RrckBh/1TFEMf
         X2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyI+l3O5Imk1/aoRyYZBBBZlJqbkZ7aA1UmrCISV+8ZARYoXZsVULcoyvDzxKZJr8g2h4XayoWK2+M@vger.kernel.org, AJvYcCVGr3OBTgqwaq2NhLulgzXCED26MexlEyIsUS9j2NI+s1MjRnG8euFNXROBE5gqlrwU3mbM8YabQy8z95ql@vger.kernel.org, AJvYcCWOggS7ckXjS8jZNzWtwzYd+eMX/HrOXOcU9ksFg3+pk+jgrmFKCdAmTXTBk5OEcI0DasiJjppErzuB@vger.kernel.org, AJvYcCWfFn5h9IAi+avNK8sexPCc5y1lgke+KHoHNfN10SRMW9vvFm8uvh1VQOJZmHXjTwcjWbOUWvsez2wL@vger.kernel.org, AJvYcCXtCdNUoOZto/C92uONLUr4A2qzm7BCxei31LbKyuqQfgx3Ey2lgE5ybcNwss/k0EqRoeyLu8UCLpQK@vger.kernel.org
X-Gm-Message-State: AOJu0YxlQN7JoTw92IJX7W4Btml2U5nK0qEfKErS8ivKTQapMZcQ9dbq
	wWXhrsJjLJhvBGgOSb7y8xSqDcT7oSGn9xAeTupax8VW6dWP1Q8AAo8Y
X-Gm-Gg: ASbGncuqqqSB4uni60OyW8GVQ3W+Hsrh2kzmYMLDjeTtjx9w69+PDlas+vaMqb4nIK0
	powLiIZX4OO2rV9FtZaFhNTd4CClKc7Ua4cLcbxWbcE9pcT4vNRlh7zlPe1wEBAOPaeVBTFOgnc
	TZs9mpR/u8O+bZ+8cl36FxxUDMh9ITlKWBaKVzg+XdiCsWk8I9TSuIHgcgbEAK4IIMR4I+fEcnI
	BE9XUdPaLJsRFc0IE0UOen5e4M4leywb+/1MNS94yiGB4AC48HFYFGl8KGIYOklAWdeKgpb+W1y
	Ifh19NKNPSbPh/G+YGIY1UvF0sJ9UTYBLR+wA3bTYjcQZ1JsSYospik6sgcETJKhpqHcXhmY9oT
	qwKOUQ3bb9x0=
X-Google-Smtp-Source: AGHT+IFoOchOYbJ+UDHdTg+DkrYs/5KlfIAQRWOe732oHXo514hsBw5BJWreXuIJr/izqnwWxVmW0A==
X-Received: by 2002:a05:6102:509e:b0:4e5:ac99:e466 with SMTP id ada2fe7eead31-4e701bae7ddmr4143247137.18.1748855871236;
        Mon, 02 Jun 2025 02:17:51 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([2001:a61:1225:ec01:ecf2:8e21:9f0f:159e])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e2a2a1622sm5937964241.10.2025.06.02.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 02:17:50 -0700 (PDT)
Date: Mon, 2 Jun 2025 11:17:39 +0200
From: Jorge Marques <gastmaier@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 3/5] dt-bindings: iio: adc: Add adi,ad4052
Message-ID: <vchomz3iazgdmotcs3jskrugi2qmdxyo74t4ruo2fsc7cjwtqb@7rtdmdkxobvg>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-3-638af47e9eb3@analog.com>
 <88a326e7-3910-4e02-b4ba-7afe06402871@baylibre.com>
 <hvexchm2ozsto5s2o6n5j2z3odrkbcamgmg67umd4aehwzmgie@dvtx6anioasq>
 <1b0e9003-7322-46fa-b2ba-518a142616dc@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0e9003-7322-46fa-b2ba-518a142616dc@baylibre.com>

On Tue, Apr 29, 2025 at 10:45:20AM -0500, David Lechner wrote:
> On 4/29/25 8:48 AM, Jorge Marques wrote:
> > Hi David, 
> > 
> > I didn't went through your's and Jonathan's ad4052.c review yet,
> > but for the trigger-source-cells I need to dig deeper and make
> > considerable changes to the driver, as well as hardware tests.
> > My idea was to have a less customizable driver, but I get that it is
> > more interesting to make it user-definable.
> 
> We don't need to make the driver support all possibilities, but the devicetree
> needs to be as complete as possible since it can't be as easily changed in the
> future.
> 

Ack.

I see that the node goes in the spi controller (the parent). To use the
same information in the driver I need to look-up the parent node, then
the node. I don't plan to do that in the version of the driver, just an
observation.

There is something else I want to discuss on the dt-bindings actually.
According to the schema, the spi-max-frequency is:

  > Maximum SPI clocking speed of the device in Hz.

The ad4052 has 2 maximum speeds: Configuration mode (lower) and ADC Mode
(higher, depends on VIO). The solution I came up, to not require a
custom regmap spi bus, is to have spi-max-frequency bound the
Configuration mode speed, and have ADC Mode set by VIO regulator
voltage, through spi_transfer.speed_hz. At the end of the day, both are
bounded by the spi controller maximum speed.

My concern is that having ADC mode speed higher than spi-max-frequency
may be counter-intuitive, still, it allows to achieve the max data sheet
speed considering VIO voltage with the lowest code boilerplate.

Let me know if I can proceed this way before submitting V3.

> ...
> 
> >>
> >> Assuming the diagram at [1] is correct, for SPI offload use, we are missing:
> >>
> >>   #trigger-source-cells:
> >>     const: 2
> >>     description: |
> >>       Output pins used as trigger source.
> >>
> >>       Cell 0 defines which pin:
> >>       * 0 = GP0
> >>       * 1 = GP1
> >>
> >>       Cell 1 defines the event:
> >>       * 0 = Data ready
> >>       * 1 = Min threshold
> >>       * 2 = Max threshold
> >>       * 3 = Either threshold
> >>       * 4 = Device ready
> >>       * 5 = Device enable
> >>       * 6 = Chop control
> >>
> >> Bonus points for adding a header with macros for the arbitrary event values.
> > 
> > In the sense of describing the device and not what the driver does, I
> > believe the proper mapping would be:
> > 
> >   Cell 1 defines the event:
> >   * 0 = Disabled
> >   * 1 = Data ready
> >   * 2 = Min threshold
> >   * 3 = Max threshold
> >   * 4 = Either threshold
> >   * 5 = CHOP control
> >   * 6 = Device enable
> >   * 7 = Device ready (only GP1)
> > 
> > I will investigate further this.
> > 
> >>
> 
> 0 = Disabled doesn't make sense to me. One would just not wire up a
> trigger-source in that case.

Ack.


Regards,
Jorge

