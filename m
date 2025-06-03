Return-Path: <linux-pwm+bounces-6233-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6CFACC137
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 09:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87CC0188E067
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500DA26982E;
	Tue,  3 Jun 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC2XM8Av"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900526981C;
	Tue,  3 Jun 2025 07:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935778; cv=none; b=hzLmzwFkGYaMSlVLmBWBsPO/ZqIS5kGZOkfBK3hDJ0BtZogl2HgXghrPi4n1zlQE9rUGmiEaMCk26Yl1GqiG70xSyHA2j4lnnfmWMpZHj7rWRM9KE7gAwgDq9LnyJjciSeqbla+DOmaBQpp4GVYqjNOB4lJFNcmlJ3uxxSrRd1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935778; c=relaxed/simple;
	bh=D9mDCibXbWWfbom+IVcLmQuJzP9JNt8OgAUfssS+g9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtlxneMt/8S28wh4vwwfpEm/BQ+sUSmNks+YX6KgUl2+6nASIc7veWP2X2TgQLodInAlsTZ6UwdmHs2GqHmS/DUUGH8v7Zx65ih7APSDsyOgr3VnOlbTN7nEPLGkL1tEi5ISJbGxsSR7YeLRvNRua5bquVzYO3teNJLA2DEppWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fC2XM8Av; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a0ac853894so4937456f8f.3;
        Tue, 03 Jun 2025 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748935774; x=1749540574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+0drIHoAyZoGAlkQm5JvZx6iEUNhrBv6oQQ7O47bVI=;
        b=fC2XM8AvAIDWAITtJDAcsSTo7jsC451AH7KNrklxi2hbSRebsCmexFsnzX8JeNeiuO
         oR4nq8S5COHX0oDBxOnZIvA0DlLDAiVqy2z9j4FogTCYeyKLcOeXhTsBIQvPy3MV/R0Q
         XyGZAfbILmYKini4eDvyO6rUbFCT8BF3rFoZWtlru7Me4Q1D2358fvntU9+lVijXrSfO
         /EuaOaO21qyXOWKnOVBEqH8x/vfzETXdMltiwXJ8VeDnuD2JvugrDfds5j3IkAkON7R5
         SF39AFC8GjHvO0MDCK1HXH76u3Ttv+1nrSx6p3yGX1/LDwHmOFYE0TtzuuNioHTRPCtR
         cW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748935774; x=1749540574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+0drIHoAyZoGAlkQm5JvZx6iEUNhrBv6oQQ7O47bVI=;
        b=tu7L06/1Z74AcI0R3JtEdtxTPSXlYRkZcNSSQI/fwpyBIayGIjlcRZGlOWl34tvAzj
         g7DbLGxpNPHy/PMipQRnW7L4GA0esG41iVGQCBJn/uEXLFLz0EKwHkWxw5P9BvE/A9/+
         t1G09BYM1BAaUSZSMV/inH8zUy3bZDMNyhiTt/Ee8ljDgZfDN0wAxLo+J1JdQaFpSk+2
         mU2sHVVbTsqsk+y3mVX5Ajoq/8F75K6IrAqJxM/RHLnxvcirE5YPrmQHKToMG9XL7WnO
         q44FqpMcTvw7tBMroZkTOXaxmG+1k51NRLWwRobATod1ZFzwx3DywzByZlWDMOvTyvMv
         X3Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUW4mWSmjdYTrW4Qct23kUCcLydguMbUqZzoXiKABVIbyrELS+pkNII6Cay0ghkv7IwIVXsUuLraqD9@vger.kernel.org, AJvYcCV/uNEvu8p59jxfo8T3ZbwAPtyd1jJhq8nzZGsUa8v8b84Gx1omAMha5BzzteGe/xm7pqHMtuzRdA3S@vger.kernel.org, AJvYcCVb++udFBWDx+yu3BQkjvLX0/cshn3u3rrvHixS7piyrMLXtSYNCpXN+jPKAoH2Py+Y2BnAblMqslFI@vger.kernel.org, AJvYcCWAnIOcVo8tnafK4JqgwecJ1KTDfZMPz8x5np30gTE5KhiLS39dNetXlZ7sTK4oGPJuPQnRcUNnY7OT3sJ0@vger.kernel.org, AJvYcCWsKt+VxuHZNnu4Wu3tSixi4DQISQI8+vmY6M/ef2abt6tcl5lkohWF6BmKgM0Z57UBPZy8xCNvP/gD@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9yKMjCIkXuhISCj7LRJYQVUy7F2vTdYrB1eIHCCIm0Nfrx/J
	aZRaxtyCEjNRNXayGkc0k9gW/MsAi9DaCRQL7eqK6ssjD12aUcEnOM5n
X-Gm-Gg: ASbGncsahKX3v+gfhTZUUl8y5Wgsqdh77qiM16FWZ8zSZSMuxbnYn74T3hTdD9H5WIw
	yUx70TOvNxqvaxDDaWUeU65qfnmWjwkGXwTE+dy8ZILpmXHDMVHjjgtPQUCtVxicy7/5MAm5a0u
	GvU9cMjeCGqRf7WLBcz7zfY7aTmwgZgnp0yb8aXqTCSMbN7FKRbxiRvNuGdbig10QQoO8nlRLbx
	6bj8k2DgphM3dcweY0weyxOzHLvbu3RhTzA6qFfWHr5B2GvnONNxGybMJr4tGyXONj9n/QYvFaJ
	hqVDK+GWADqb8UYMpNhsVfiXnZX/vkob7fpIroyVLTvS13uPE1Qb0E6A0BgdSjmmUvJ4na4=
X-Google-Smtp-Source: AGHT+IFwLH0nIqI1FwsSQ0ReEAbBwzxHWkTVup5SaANYJucLwWpPOUjNEwECalY8pm5oxSxYcji3Sg==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:cfbf:519b with SMTP id ffacd0b85a97d-3a4fe395783mr8605356f8f.44.1748935774273;
        Tue, 03 Jun 2025 00:29:34 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com ([137.71.226.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b8a8sm17075181f8f.5.2025.06.03.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 00:29:33 -0700 (PDT)
Date: Tue, 3 Jun 2025 09:29:29 +0200
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
Message-ID: <65m4itn5xp3ytc7hvpskuk4kmu54wznk4m2odt7d5a5k35vy26@ekjxegpjy5wq>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
 <20250422-iio-driver-ad4052-v2-3-638af47e9eb3@analog.com>
 <88a326e7-3910-4e02-b4ba-7afe06402871@baylibre.com>
 <hvexchm2ozsto5s2o6n5j2z3odrkbcamgmg67umd4aehwzmgie@dvtx6anioasq>
 <1b0e9003-7322-46fa-b2ba-518a142616dc@baylibre.com>
 <vchomz3iazgdmotcs3jskrugi2qmdxyo74t4ruo2fsc7cjwtqb@7rtdmdkxobvg>
 <a6f62963-5776-47e4-bdac-78e921a6e476@baylibre.com>
 <a6cguahvrbqjv2wtisvgg2wvm2tj3awmn7omo6ebfpts6v546o@4xzpj353vlsx>
 <fca1e8c7-2c1c-4244-a109-f674940d6030@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca1e8c7-2c1c-4244-a109-f674940d6030@baylibre.com>

On Mon, Jun 02, 2025 at 12:23:40PM -0500, David Lechner wrote:
> On 6/2/25 11:32 AM, Jorge Marques wrote:
> > Hi David,
> > 
> > On Mon, Jun 02, 2025 at 10:17:18AM -0500, David Lechner wrote:
> >> On 6/2/25 4:17 AM, Jorge Marques wrote:
> >>> On Tue, Apr 29, 2025 at 10:45:20AM -0500, David Lechner wrote:
> >>>> On 4/29/25 8:48 AM, Jorge Marques wrote:
> >>>>> Hi David, 
> >>>>>
> >>>>> I didn't went through your's and Jonathan's ad4052.c review yet,
> >>>>> but for the trigger-source-cells I need to dig deeper and make
> >>>>> considerable changes to the driver, as well as hardware tests.
> >>>>> My idea was to have a less customizable driver, but I get that it is
> >>>>> more interesting to make it user-definable.
> >>>>
> >>>> We don't need to make the driver support all possibilities, but the devicetree
> >>>> needs to be as complete as possible since it can't be as easily changed in the
> >>>> future.
> >>>>
> >>>
> >>> Ack.
> >>>
> >>> I see that the node goes in the spi controller (the parent). To use the
> >>> same information in the driver I need to look-up the parent node, then
> >>> the node. I don't plan to do that in the version of the driver, just an
> >>> observation.
> >>>
> >>> There is something else I want to discuss on the dt-bindings actually.
> >>> According to the schema, the spi-max-frequency is:
> >>>
> >>>   > Maximum SPI clocking speed of the device in Hz.
> >>>
> >>> The ad4052 has 2 maximum speeds: Configuration mode (lower) and ADC Mode
> >>> (higher, depends on VIO). The solution I came up, to not require a
> >>> custom regmap spi bus, is to have spi-max-frequency bound the
> >>> Configuration mode speed,
> >>
> >> The purpose of spi-max-frequency in the devicetree is that sometimes
> >> the wiring of a complete system makes the effective max frequency
> >> lower than what is allowed by the datasheet. So this really needs
> >> to be the absolute highest frequency allowed.
> >>
> >>> and have ADC Mode set by VIO regulator
> >>> voltage, through spi_transfer.speed_hz. At the end of the day, both are
> >>> bounded by the spi controller maximum speed.
> >>
> >> If spi_transfer.speed_hz > spi-max-frequency, then the core SPI code
> >> uses spi-max-frequency. So I don't think this would actually work.
> >>
> > Ok, so that's something that may be worth some attention.
> > 
> > At spi/spi.c#2472
> > 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
> > 		spi->max_speed_hz = value;
> > 
> > At spi/spi.c#4090
> > 	if (!xfer->speed_hz)
> > 		xfer->speed_hz = spi->max_speed_hz;
> > 
> > So, speed_hz is max-spi-frequency only if xfer->speed_hz is 0 and
> > not bounded by it.
> 
> Ah, OK, my memory was wrong. It is only bound by the controller max
> speed, not the device max speed.
> 
> 	if (ctlr->max_speed_hz && xfer->speed_hz > ctlr->max_speed_hz)
> 		xfer->speed_hz = ctlr->max_speed_hz;
> 
> It does seem odd that it would allow setting an individual xfer
> speed higher than than the given device max speed. I suppose we
> could submit a patch adding that check to the SPI core code and
> see what Mark has to say.
>

Agreed, the patch itself would be simple:

 	if (!xfer->speed_hz || xfer->speed_hz > spi->max_speed_hz)
 		xfer->speed_hz = spi->max_speed_hz;

But I wonder how many drivers rely on this behaviour
> > 
> > Then at spi-axi-spi-engine.c:
> > 
> > 	static int spi_engine_precompile_message(struct spi_message *msg)
> > 	{
> >   		clk_div = DIV_ROUND_UP(max_hz, xfer->speed_hz);
> > 		xfer->effective_speed_hz = max_hz / min(clk_div, 256U);
> > 	}
> > 
> > Where max_hz is set only by the IP spi_clk. If at the driver I set
> > xfer.speed_hz, it won't be bounded by max-spi-frequency.
> > 
> > The only that seems to bound as described is the layer for flash memory
> > at spi-mem.c@spi_mem_adjust_op_freq.
> > 
> > For the adc driver, I will then consider your behavioral description and
> > create a custom regmap bus to limit set the reg access speed (fixed),
> > and keep adc mode speed set by VIO. And consider spi-max-frequency can
> > further reduce both speeds.
> > (or should instead be handled at the driver like spi-mem.c ?)
> 
> It would be more work, but if it is common enough, we could generalize this
> in the core code. For example add a spi-register-max-frequency binding (or
> even a more general spi-max-freqency-map to map operations to max frequencies).
> Then we could bake it into the regmap_spi code to handle this property
> and not have to make a separate bus.
> 
> FWIW, there are also some SPI TFT displays that use a different frequency
> for register access compared to framebuffer data that could potentially
> use this too. Right now, these just have a hard-coded register access
> frequency of e.g. 10 MHz.
> 

I implemented the custom regmap bus for this series.
With a `spi-max-frequency-map`, the regmap bus can be removed.
I don't want to include this regmap spi patch to this series.
As I see it, struct regmap_but first need to be extended to add
a max_speed, e.g.
  
   @max_speed: Max transfer speed that can be used on the bus.

regmap_spi.c would then look for the devicetree node to fill the value
and on regmap_write/read fill speed_hz.
In this case, it could be called "register-frequency" or
"regmap-frequency"
If instead it is up to spi.c to read the devicetree node, then a way to
differentiate "regular" transfers from "regmap" transfers would be
necessary.

About submitting v3, should I submit only up-to the base driver, or can
I submit also the add offload support and add event support commits?

Regards,
Jorge

