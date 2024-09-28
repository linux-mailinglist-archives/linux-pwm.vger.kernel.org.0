Return-Path: <linux-pwm+bounces-3387-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629A19890D0
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 19:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1489E282512
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Sep 2024 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D32A44C7C;
	Sat, 28 Sep 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwN0Pl6T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477794A1B;
	Sat, 28 Sep 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727544658; cv=none; b=PRA4KzNdj1REe3iWImwC8JpwmoPOavNOUlN67jw5nLf3m/cJiGFlyp1/JeNObdajYj6W2WUDn8W9Zz+HZLulcMjGwh01AWnDHT4rev7NiShz/smtuxA/5GILhKVU2OgV3IXHoUho9Dt6mKU7RR5ze6beUmLva37fp7XgSHB/t/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727544658; c=relaxed/simple;
	bh=80g3VB7ymcP4o5bdyASaEWZt5LokbcFwtG2z1YFgtO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uatfsNdluvM9jVjvAnuggEFWrnNdz3464V2qwFSNx82Z1teR5t26HqArt7X8jaX11gifNDgZE7cInoWMfXyMxRzZEKKKeqPWT5YeB9OuKLSQ+hkSyr5DD/iVLle2mbt9GwmrpEFjHoy+ltwaKvIao5cUe4zB00eHr3B6DiPH6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwN0Pl6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9074C4CEC3;
	Sat, 28 Sep 2024 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727544657;
	bh=80g3VB7ymcP4o5bdyASaEWZt5LokbcFwtG2z1YFgtO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LwN0Pl6T/VFUfW/7MbsJDM7ALWcbG7B0p+yzUVk/wJycvV4GO6bhqoNwdPp67ZoVU
	 oMNaok1W0FarPcWw58OaPJ7BPEexm4xItgeG0kUIlK+g++U+Dv52TJQyAJW8xTEdWf
	 2axKhf2I0zMdtg4rFazD/N9KnFXkavAfAjrjaZNaCbhlGFfJopM5pCeO1/iQZNIf7I
	 ry9ApzIcxY0fXWhfLpysZQwUXfCRcLnl/okGqxzQZXinjRtI00mzluavmIsiguhuhR
	 DRcI0sQZ6EKFJYs7YNXVQIk6weDeFw32PcRStftkckfItxbvu0lZ63Lz5Y+Yrx5Bxl
	 3i6rnEir3EkIg==
Date: Sat, 28 Sep 2024 18:30:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29u?=
 =?UTF-8?B?w6dhbHZlcw==?= <joao.goncalves@toradex.com>, Mike Looijmans
 <mike.looijmans@topic.nl>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Message-ID: <20240928183044.0b5ea2e0@jic23-huawei>
In-Reply-To: <CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
	<20240923101206.3753-7-antoniu.miclaus@analog.com>
	<CAMknhBHRfj7d8Uea8vX=t+y+9dqoPABQSzsgNhBMTK-8-f6L7w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> 
> > +static struct iio_chan_spec_ext_info ad4858_ext_info[] = {
> > +       IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> > +       IIO_ENUM_AVAILABLE("packet_format",
> > +                          IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
> > +       {},
> > +};
> > +
> > +static struct iio_chan_spec_ext_info ad4857_ext_info[] = {
> > +       IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> > +       IIO_ENUM_AVAILABLE("packet_format",
> > +                          IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
> > +       {},
> > +};  
> 
> Usually, something like this packet format would be automatically
> selected when buffered reads are enabled based on what other features
> it provides are needed, i.e only enable the status bits when events
> are enabled.
> 
> (For those that didn't read the datasheet, the different packet
> formats basically enable extra status bits per sample. And in the case
> of oversampling, one of the formats also selects a reduced number of
> sample bits.)
> 
> We have quite a few parts in the pipline right like this one that have
> per-sample status bits. In the past, these were generally handled with
> IIO events, but this doesn't really work for these high-speed backends
> since the data is being piped directly to DMA and we don't look at
> each sample in the ADC driver. So it would be worthwhile to try to
> find some general solution here for handling this sort of thing.

We have previously talked about schemes to describe metadata
alongside channels. I guess maybe it's time to actually look at how
that works.  I'm not sure dynamic control of that metadata
is going to be easy to do though or if we even want to
(as opposed to always on or off for a particular device).


