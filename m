Return-Path: <linux-pwm+bounces-6457-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9612EAE228C
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 20:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD411C243B7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B45E2E8E1D;
	Fri, 20 Jun 2025 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmD5PAnh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3C1FBEA6;
	Fri, 20 Jun 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750445537; cv=none; b=HN4O6WSXVsjx8xHBYwn/6F3+/hOFZ+h1uMfEPnCb29EMrcbxwlNCMOlm4M6BnzDdD+4vjlauUA+fbbBwYQa39xTGRnAdRhT5qFLtczqjw0vlJk9UMpCzkI/YqUtYJFEyLI2myrR3LbAjH4gLWbwRpiNCmhlRNlOjOE8s7l8yi6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750445537; c=relaxed/simple;
	bh=d61578dvdp+7dqnHw6aOy57T/vUq2K6C3ebottvLP48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWYTztVJ8siMjlw/RptzY1kdLJKo1b9+igC6a4KAD8J5rGwv0E+l+pTKjx1vWPd+PZKtHFiZAyJifnHnYQUtW/hG1lQcBn9dyN4srjozEgfrtrMvbdzz7fqs7IakSa3u9NJhLnB1ClMJtiDry6wI6xoStrk6ezKZngeBhyUOnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmD5PAnh; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453643020bdso10073495e9.1;
        Fri, 20 Jun 2025 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750445534; x=1751050334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SuvVprvH+lcp/bEtCacgmv7HR7bf4BfFOrawh5qnz0=;
        b=UmD5PAnhN1FWtTsoi2uEoa5bKnMIRNJ/hpkTweFkaiS1/aWTHG6lgas92Qv6OQVTZy
         QhrrWrTd9GCfOxvXUaa/gjMgaIOw5TCm/1CRoJI9ar/amdowY9oFyCr+U2j3Rimx7329
         ibc9Sxjw5RKXCU6yYAMQ65C4+zdbTpoMFnsgYj8TvP6YUGY+ZKDUZEbZGS/itF2O6QEF
         qNSTcHIlyV026MJR9zJ1+HfgJ3HPnu0fJ7//qunFQc8NqeewhhItExL8F0kdgIuGhlYv
         ua4NDGT4IDFW7VGOD0DRrhyyRoXj5pEijKMIkcnef6j71ACTXyRtvWcZJOVX3ueIL2E6
         Jwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750445534; x=1751050334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SuvVprvH+lcp/bEtCacgmv7HR7bf4BfFOrawh5qnz0=;
        b=vU7FYhSENAiCvZZSg64TVGCYOiKzbYnAoDYhPuhv5u2mX/kbXMEm/r4EIWK4JhdfRL
         s+HOkusbd5nQRSOiyqFF8PId+syJp1lPEeL2mEipXg92a0VLFNQGSaiDJafdLkwoltc0
         fPtZaTGoM3s6EI/GuUKhuzlNczNrf71fMHK0W/q1kx/6+9GvcUSbOmmZ6C47FUmMDcQN
         KVo9SyXHU0f4j+2Yu4ZeVKDwMWjMUHLM4I5D5QWmvvuEcNavlpsoeYiH/NT1x8cKf6iD
         nKXmVC9EAFRnykHg+9S+WcYJuxNeoO/S4AxGdzs1BR8wlF23M6+r7iI9iNgkmdHK7oXA
         RMLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQbuEopdS+pk0Ce8FmoNP/Uawc9Vhk+hQUGsHBtH/99YzdINxJ6rq5CdLzqk4k8ojnDOydLH4E5iPma3Hg@vger.kernel.org, AJvYcCUYXNYH3ByCxlvMqTG/49nBlHMcxKm825gCEuXAoWeECJcxuD9j4Qnr95tPGUkeFmu/7fi+bTLQfoXL@vger.kernel.org, AJvYcCUZ/2BUgUa/eCs7V9DvP4clpxuaBsXL1IK4B773Ccy7O6i7oySaMXyUX3WhAXvuGkVCoUjoC585PeGJ@vger.kernel.org, AJvYcCWVBU8T0M+zj3eEKOEfMT8zXamRfvw2M4FEPXZ73BV2B3JZovYFdln1DmBA2TIiXBknXSzkworfa+q+@vger.kernel.org, AJvYcCWw/OCPwxtMEOnpcyuSAhWcV9OJLhrUODOYqeHRjLnnUxtCf0M5smGIJSQg831xBjMKoDWNeziOneA4@vger.kernel.org
X-Gm-Message-State: AOJu0YycEPjU4rG1G0irUlBmpeerXp1HoI+N9R+4P5ACivxlFNAHG4RH
	fZHLxXW+0NL9RRx5hh3UoDbngv+zMMNbf7R+l3/ttFp83xS2QUkZHg78
X-Gm-Gg: ASbGncuEAyR99lhafaCx4HtmbEQ294b1t71FYNMrxQregrzI+VjIQdW0JlxBeghI+aE
	wTT3u1hanicjp550+AdGunmdGfjvuUxgSgEsxwPUCT7n8Qfa7eeiAurCzOQEl7G7DPGagH4EDp6
	fqja3N2HL8hNi7mL+F3ZJPdrfneNc9V3tC5CIKTEkWYunUYLXZ9OhXAae+Rc+uAvscJzJImWXE2
	ZopYJvfuoUb/B87BCGENQ3BXk1xYvauYYpNdmvw/OYGEGDFZSu3MhcSFT4dlV7eeeNV0GDynXJQ
	zBfdhRcYac+4UoTeRnpnRi4rFaOhF0RwISvc90JBkD3QVB+PuMDvW+Yqf0UlzEMRDCdvCNLOVCu
	w4VMyeVNojvQ1bdEcajaVYzyJ/oMMQDsuBaGP4WXmuCAc+Kh0ysbySnxtv2qrhhvQZmv/gWcZ2A
	==
X-Google-Smtp-Source: AGHT+IFyJDFhnRLMDV+Vtu5Y/1Vd85itLGHwRZWROszXt6mNgeAMTKnEZ8wy1wyvkiYXDy+Ydv3bFA==
X-Received: by 2002:adf:9dd2:0:b0:3a5:39bb:3d61 with SMTP id ffacd0b85a97d-3a6d1322a3dmr3100604f8f.27.1750445533322;
        Fri, 20 Jun 2025 11:52:13 -0700 (PDT)
Received: from HYB-DlYm71t3hSl.ad.analog.com (dynamic-176-002-177-020.176.2.pool.telefonica.de. [176.2.177.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c073sm2777413f8f.58.2025.06.20.11.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:52:12 -0700 (PDT)
Date: Fri, 20 Jun 2025 20:52:10 +0200
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
Subject: Re: [PATCH v3 6/8] iio: adc: Add offload support for ad4052
Message-ID: <hdwuh3ouw4gzpbj7u7dtzaphdjonecls2xuu7p4nmi7wwrcmye@jhhhqvdlbuv3>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
 <20250610-iio-driver-ad4052-v3-6-cf1e44c516d4@analog.com>
 <20250614112022.24bf9212@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614112022.24bf9212@jic23-huawei>

On Sat, Jun 14, 2025 at 11:20:22AM +0100, Jonathan Cameron wrote:
> On Tue, 10 Jun 2025 09:34:39 +0200
> Jorge Marques <jorge.marques@analog.com> wrote:
> 
> > Support SPI offload with appropriate FPGA firmware. Since the SPI-Engine
> > offload module always sends 32-bit data to the DMA engine, the
> > scantype.storagebytes is set to 32-bit and the SPI transfer length is
> > based on the scantype.realbits. This combination allows to optimize the
> > SPI to transfer only 2 or 3 bytes (depending on the granularity and
> > mode), while the number of samples are computed correctly by tools on
> > top of the iio scantype.
> > 
> > Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> Minor comments inline.  I think they are all follow up from comments on
> earlier patches that apply here as well.
> 
> > ---
> >  drivers/iio/adc/ad4052.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 242 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
> > index 842f5972a1c58701addf5243e7b87da9c26c773f..7d32dc4701ddb0204b5505a650ce7caafc2cb5ed 100644
> > --- a/drivers/iio/adc/ad4052.c
> > +++ b/drivers/iio/adc/ad4052.c
> > @@ -11,6 +11,8 @@
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/gpio/consumer.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/buffer-dmaengine.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/interrupt.h>
> > @@ -23,6 +25,8 @@
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spi/spi.h>
> > +#include <linux/spi/offload/consumer.h>
> > +#include <linux/spi/offload/provider.h>
> >  #include <linux/string.h>
> >  #include <linux/types.h>
> >  #include <linux/units.h>
> > @@ -111,6 +115,7 @@ enum ad4052_interrupt_en {
> >  
> >  struct ad4052_chip_info {
> >  	const struct iio_chan_spec channels[1];
> > +	const struct iio_chan_spec offload_channels[1];
> 
> If there is only ever one of these drop the array.
> 
Hi Jonathan,

It is hard to predict if no other similar device will have only two
channels. But I would say most drivers end-up having more channels.
> 
> >  
> > +static int ad4052_update_xfer_offload(struct iio_dev *indio_dev,
> > +				      struct iio_chan_spec const *chan)
> > +{
> > +	struct ad4052_state *st = iio_priv(indio_dev);
> > +	const struct iio_scan_type *scan_type;
> > +	struct spi_transfer *xfer = &st->offload_xfer;
> > +
> > +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> > +	if (IS_ERR(scan_type))
> > +		return PTR_ERR(scan_type);
> > +
> > +	xfer->bits_per_word = scan_type->realbits;
> > +	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
> > +	xfer->len = scan_type->realbits == 24 ? 4 : 2;
> 
> Same question on length vs bits_per_word applies here as in the earlier
> patch.
> 
To be able to optimize the SPI message, len must be a multiple of 16
bits. To achieve maximum throughput, no extra bits (and therefore SCLK
clock cycles) must be transferred during the SPI transfer. This is set
by bits_per_word, 24-bits means 24 SCLK.

Finally, storagebits is the number of bits actually used to store the
reading, and for the offload channel is the DMA width, always 32-bits.
An abstraction to obtain the DMA width should be created, so the 32-bits
value is not hard-coded into the driver, still, for this series, it is.

> > +	xfer->speed_hz = AD4052_SPI_MAX_ADC_XFER_SPEED(st->vio_uv);
> > +
> > +	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
> > +	st->offload_msg.offload = st->offload;
> > +
> > +	return 0;
> > +}
> > +
> >  static int ad4052_set_oversampling_ratio(struct iio_dev *indio_dev,
> >  					 const struct iio_chan_spec *chan,
> >  					 unsigned int val)
> > @@ -838,6 +873,87 @@ static int ad4052_write_raw(struct iio_dev *indio_dev,
> >  	return ret;
> >  }
> 
> >  static int __ad4052_validate_trigger_sources(struct of_phandle_args *trigger_sources)
> >  {
> >  	switch (trigger_sources->args[1]) {
> > +	case AD4052_TRIGGER_PIN_GP0:
> > +		return trigger_sources->args[0] == AD4052_TRIGGER_EVENT_EITHER_THRESH ?
> > +		       0 : -EINVAL;
> >  	case AD4052_TRIGGER_PIN_GP1:
> >  		return trigger_sources->args[0] == AD4052_TRIGGER_EVENT_DATA_READY ?
> >  		       0 : -EINVAL;
> > @@ -903,14 +1092,45 @@ static int ad4052_validate_trigger_sources(struct iio_dev *indio_dev)
> >  	int ret;
> >  
> >  	np = st->spi->dev.of_node;
> > +	for (u8 i = 0; i < 2; i++) {
> > +		ret = of_parse_phandle_with_args(np, "trigger-sources",
> > +						 "#trigger-source-cells", i,
> > +						 &trigger_sources);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = __ad4052_validate_trigger_sources(&trigger_sources);
> > +		of_node_put(trigger_sources.np);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	return ret;
> 
> I think this is always 0. So return 0; preferred to make that explicit.
> 
Well, this whole method is deleted for v4 due to the trigger-sources
discussion. Per following David suggestion, gp0 is assumed drdy and gp1
threshold events, unless the parent (spi offload) trigger-sources says
otherwise (gp1).

Best regards,
Jorge
> > +}
> > 
> 

