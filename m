Return-Path: <linux-pwm+bounces-1702-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC2F871101
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Mar 2024 00:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C49AB2200E
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 23:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4AC7CF1D;
	Mon,  4 Mar 2024 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S6ylp9g9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5095C7CF0B
	for <linux-pwm@vger.kernel.org>; Mon,  4 Mar 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709594496; cv=none; b=fXSXI1ZT/3XJYVwaR18Heb25sxfLbDnLCue5ALOcsMANNFe7UV17isS6E5l1+pq+i0pcMlBw0/X5nY4ukAubDRem7yQeBsbK6cTrMeIERUneyt7v79isFNGrNCUMdyH6Sq82rGp9jyA7F8q0ojGHrB6U1JJipLWtkn04EAh9lBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709594496; c=relaxed/simple;
	bh=lh1j9mkwmpI2gqFb91geb6fvk73hJ96VT9uC2utdnFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrcdFAETHcwdaSl9F7TDZi7X26c73ZfibYGTzLXpfljLPdDM0ANuZsMLO/IGt6t+JSze1oa4ump+iLbwRCRhqjCccocRD50kAiBH3MPFciuwdzeEMKHK3Ta1jo1nIEyt8AqIuAUFCWUBxm+8mPE3e82DSaes6kUkBNY7Jawb4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S6ylp9g9; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d269dc3575so44331081fa.1
        for <linux-pwm@vger.kernel.org>; Mon, 04 Mar 2024 15:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709594492; x=1710199292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3ZG5nlSne7db2l1bcwU+jExqpiSpjwO/TmBdJh8VJg=;
        b=S6ylp9g982cS6wb4uZ7VPArITV9OTV2DCi/ZCnteBYB7FAczdV0rdgJUhbEuFYFUil
         H/3188cYn++7aCbwWwq2+I0Hzdigeb/t+dFy42VcbMaQQ2Y8pW8mciHZ23VKo9OGCeaC
         F9QMvnf5MfgEkq6XfRq5A7553+nHjvSBkh9I2SEVQ+nAE4mo6hRcdoBT9TkJpApNrJE+
         XbdBT3huYLU2VKAhAj+6CKMdBmLl60y0d+adKiuatm/wrqjtqvGn/MfJ8INZlFlaE47K
         BDcyITVblRBcLvYzWpHvHuMQDlSw1UOYBeQZb6g733BLGNBJk8o/CZxYSibIjb1ZnvHW
         d3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709594492; x=1710199292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3ZG5nlSne7db2l1bcwU+jExqpiSpjwO/TmBdJh8VJg=;
        b=KsdHtqOhess1KTahz3jZJjQOUkh1MEHJW7jl6O6jPv+9REKRpzMdR2yC54d9QwlsFP
         2hPHw54Wpmpy8LpGfq96ye6uSGbBY47XAJ1mtHs90Ql6JLNBw5bCI5VcFGnr5YgxMV2k
         jZk0awGhwcQsgMcacx04ANrbmCqUNo3HTyQ+guKggoyG+Bol14CStm7qbJ1gvNIl33pa
         r+vrp0Pv6gSHAVQ/4yc6BLx25g65iRsQYneLBipg04UZtl0AbjGW4IcltWX/hCYSqTE4
         eMiE1ae1Bs4gaYsxLd41k2FMoMCbLx9pX+Vz35gTtJhazALUPgHGZaelhR9AlRYR61D1
         Y2aw==
X-Forwarded-Encrypted: i=1; AJvYcCWd4NXPqRCfyD8f7uOYXvekjEvne2pXPMw6II9Qw+6xqF07BazTLzbbgk6gq0OFYPeQ7WYdG7ymA5u1i+yyobtrNtRuwTU/159Y
X-Gm-Message-State: AOJu0YyPgKShQEK5R+0xTwxI01kPwqu8rPCLnWYyE0YnvMoCBFxxFDpW
	/VE9yOnWE27a4Rx8ydrnZsZVrswPGnrAgxax/TeDoeUq0fuRSFTk8ddafwVCMENqlTVlAMQTleB
	mj8ldv6Cvjfv8kYChHcQ9/dR79InX6dMIcuAOcg==
X-Google-Smtp-Source: AGHT+IHhkmAMXuI+MFs08V2iullSSxJpLZi8jtE64M56Q68Qh2gmKRxSf52O1/PncRjgbQAB/LiVw+q9XDtozfckFb4=
X-Received: by 2002:a2e:80ca:0:b0:2d2:2c74:ff02 with SMTP id
 r10-20020a2e80ca000000b002d22c74ff02mr87597ljg.9.1709594492412; Mon, 04 Mar
 2024 15:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com> <2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk>
In-Reply-To: <2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 4 Mar 2024 17:21:21 -0600
Message-ID: <CAMknhBHP+x4e0kTmNTn6JNKv=VCosZhBWce1MjjFW4MZ+K2Hcg@mail.gmail.com>
Subject: Re: [PATCH 01/13] spi: add core support for controllers with offload capabilities
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Jander <david@protonic.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Jan 10, 2024 at 01:49:42PM -0600, David Lechner wrote:
> > This adds a feature for specialized SPI controllers that can record
> > a series of SPI transfers, including tx data, cs assertions, delays,
> > etc. and then play them back using a hardware trigger without CPU
> > intervention.
>
> > The intended use case for this is with the AXI SPI Engine to capture
> > data from ADCs at high rates (MSPS) with a stable sample period.
>
> > Most of the implementation is controller-specific and will be handled b=
y
> > drivers that implement the offload_ops callbacks. The API follows a
> > prepare/enable pattern that should be familiar to users of the clk
> > subsystem.
>
> This is a lot to do in one go, and I think it's a bit too off on the
> side and unintegrated with the core.  There's two very high level bits
> here, there's the pre-cooking a message for offloading to be executed by
> a hardware engine and there's the bit where that's triggered by some
> hardwar event rather than by software.
>

...

>
> The bit where messages are initiated by hardware is a step beyond that,
> I think we need a bit more API for connecting up the triggers and we
> also need to have something handling what happens with normal operation
> of the device while these triggers are enabled.  I think it could be
> useful to split this bit out since there's a lot more to work out there
> in terms of interfaces.

Now that we have addressed the pre-cooking messages bit [1] I'm coming
back to the hardware trigger bit. Since the hardware trigger part
hasn't been discussed in the past, it's not so clear to me what is
being requested here (also see specific questions below).

[1]: https://lore.kernel.org/linux-spi/20240219-mainline-spi-precook-messag=
e-v2-0-4a762c6701b9@baylibre.com/T/#t

>
> > +/**
> > + * SPI_OFFLOAD_RX - placeholder for indicating read transfers for offl=
oads
> > + *
> > + * Assign xfer->rx_buf to this value for any read transfer passed to
> > + * spi_offload_prepare(). This will act as a flag to indicate to the o=
ffload
> > + * that it should do something with the data read during this transfer=
. What
> > + * that something can be is determined by the specific hardware, e.g. =
it could
> > + * be piped to DMA or a DSP, etc.
> > + */
> > +#define SPI_OFFLOAD_RX_SENTINEL ((void *)1)
>
> This feels like something where there are likely to be multiple options
> and we need configurability.  I'd also expect to see a similar transmit
> option.

Having something similar for TX makes sense. What other sorts of
options are you envisioning here?

>
> > +int spi_offload_prepare(struct spi_offload *offload, struct spi_device=
 *spi,
> > +                       struct spi_transfer *xfers, unsigned int num_xf=
ers)
>
> I would expect us to just generically prepare a message, then pass a
> prepared message into the API that enables a trigger.  We would need
> something that handles the difference between potentially offloading for
> better performance and having a hardware trigger, I think that might be
> a case of just not exposing the engine's prepare to client drivers and
> then having the core track if it needs to do that when enabling a
> hardware trigger.

Not exposing the offload prepare to client drivers sounds reasonable.
I'm not sure I understand the potential need for an offload without a
hardware trigger though.

>
> > +     /**
> > +      * @enable: Callback to enable the offload.
> > +      */
> > +     int (*enable)(struct spi_offload *offload);
> > +     /**
> > +      * @disable: Callback to disable the offload.
> > +      */
> > +     void (*disable)(struct spi_offload *offload);
>
> I'm not seeing anything in this API that provides a mechanism for
> configuring what triggers things to start, even in the case where things
> are triggered by hardware rather than initiated by software I'd expect
> to see hardware with runtime configurability.  The binding is a bit
> unclear but it seems to be expecting this to be statically configured in
> hardware and that there will be a 1:1 mapping between triggers and
> scripts that can be configured, if nothing else I would expect that
> there will be hardware with more possible triggers than scripts.

For the use case of ADCs/DACs we would want a periodic trigger where
the period of the trigger is runtime configurable (via sysfs). Is this
the sort of thing you had in mind here? What other sorts of triggers
do you have in mind?

>
> I'd also expect some treatement of what happens with the standard SPI
> API while something is enabled.

I suppose it makes sense to return -EBUSY from
spi_sync()/spi_async()/spi_bus_lock() when a hardware trigger is
enabled.

