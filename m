Return-Path: <linux-pwm+bounces-754-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F06882B6AD
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jan 2024 22:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9716B2361C
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jan 2024 21:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAC058132;
	Thu, 11 Jan 2024 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SAdxbYhC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BEE58200
	for <linux-pwm@vger.kernel.org>; Thu, 11 Jan 2024 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd64022164so53736301fa.3
        for <linux-pwm@vger.kernel.org>; Thu, 11 Jan 2024 13:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705008785; x=1705613585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rXEcrMIKY136eAr01BLhG0ifqP2uNjw5FBfAFBAlWTU=;
        b=SAdxbYhCji37tRTe3O0IqN89vR6Fn6JrkrGNJQOkycNFlos2vQUS5/fYGArilviyzn
         eeTqpuxx8GWmd/WBe0PW3wamDWP5iCnK/WB+YmNfHb+JVgOr0CWLoXUWLoUnAvO8KtPN
         m9MX0rQlyfHcUFdGH+XByCdXt5y1RNgbTs8g8ABwR+cXpbwDZrgZJvFS+v28w7qu3tN2
         UfZkd7W00S+0Wml6BRRoVaL0hdJDBB4BGBEXgAnktXslt4pDNmbg7ptsHvQqYFjjlgvC
         M5XxC6M/3LzsgBSAxrN4fKXWUG7Nh6/nj1ZEzQnEX2kSoCYgVjh8rTLdcwhQyinetpCg
         1f2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705008785; x=1705613585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXEcrMIKY136eAr01BLhG0ifqP2uNjw5FBfAFBAlWTU=;
        b=GZGiQTwPt0+DgUVY2llbc7foKDOo3aOLyowKwDjAQogpUwBPx5kOJ38/XqhJzofyPi
         1/ZRqzOw6pWjxsaJIUOQDRqOOV6Ta7vlNh2shzQtSfbcCRiSHvOUTj+/bnOI1pYs+7Mx
         8GfpjxPJ4WNnHwG1uJnEv2vvrSvAfMVQ3GHWMKEeI/t4DNx1l7NUUn78J5acHXKK2e7V
         t/aWYx3MjTj+tbHq4Kv3F6MAuD2VlQvv8FMxAUO56Y7B/PJ7FyEJzPiXC/VGpSrlYfWz
         aQOuQ5pLIg6t79Df0LE4YnOOJOK0A/EcOcOHv+FjD/bAIR0H6aCrk2GAFA5hNZOOHbIC
         f7ig==
X-Gm-Message-State: AOJu0YwPD2CcJlwfsio23OooQ/9nBLRemuhHNZZL8idxWI6Wgb2R5MGB
	jy9Wh2Z3uT1Ap8CVTOlLwEVyafqkZnIi4fpZy0WmAuZA/J2R3Q==
X-Google-Smtp-Source: AGHT+IFGmqb45qZF2axvgk+XA0ZAOMDPiIdg9YizyevHnBKP86gzsAWFIIMO/wbrlD7NksDk5L7CHDOFdGG9gnXQOSQ=
X-Received: by 2002:a2e:8696:0:b0:2cd:80fb:82d7 with SMTP id
 l22-20020a2e8696000000b002cd80fb82d7mr194320lji.89.1705008785109; Thu, 11 Jan
 2024 13:33:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
 <2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk> <CAMknhBGMRed9vDrDAuPJ5DnEe6MyHzd0VBebp5OaLX2Q+AyhMQ@mail.gmail.com>
In-Reply-To: <CAMknhBGMRed9vDrDAuPJ5DnEe6MyHzd0VBebp5OaLX2Q+AyhMQ@mail.gmail.com>
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jan 2024 15:32:54 -0600
Message-ID: <CAMknhBE-1Khe9J-n5WQnH=mFnN0ukiq7=F-SEOU6J-2_u-R0bw@mail.gmail.com>
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

On Thu, Jan 11, 2024 at 2:54=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On Wed, Jan 10, 2024 at 3:36=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > On Wed, Jan 10, 2024 at 01:49:42PM -0600, David Lechner wrote:
> > > This adds a feature for specialized SPI controllers that can record
> > > a series of SPI transfers, including tx data, cs assertions, delays,
> > > etc. and then play them back using a hardware trigger without CPU
> > > intervention.
> >
> > > The intended use case for this is with the AXI SPI Engine to capture
> > > data from ADCs at high rates (MSPS) with a stable sample period.
> >
> > > Most of the implementation is controller-specific and will be handled=
 by
> > > drivers that implement the offload_ops callbacks. The API follows a
> > > prepare/enable pattern that should be familiar to users of the clk
> > > subsystem.
> >
> > This is a lot to do in one go, and I think it's a bit too off on the
> > side and unintegrated with the core.  There's two very high level bits
> > here, there's the pre-cooking a message for offloading to be executed b=
y
> > a hardware engine and there's the bit where that's triggered by some
> > hardwar event rather than by software.
> >
> > There was a bunch of discussion of the former case with David Jander
>
> I found [1] which appears to be the conversation you are referring to.
> Is that all or is there more that I missed?
>
> [1]: https://lore.kernel.org/linux-spi/20220512163445.6dcca126@erd992/
>
> > (CCed) a while back when he was doing all the work he did on optimising
> > the core for uncontended uses, the thinking there was to have a
> > spi_prepare_message() (or similar) API that drivers could call and then
> > reuse the same transfer repeatedly, and even without any interface for
> > client drivers it's likely that we'd be able to take advantage of it in
> > the core for multi-transfer messages.  I'd be surprised if there weren'=
t
> > wins when the message goes over the DMA copybreak size.  A much wider
> > range of hardware would be able to do this bit, for example David's cas=
e
> > was a Raspberry Pi using the DMA controller to write into the SPI

For those, following along, it looks like the RPi business was
actually a 2013 discussion with Martin Sperl [2]. Both this and [1]
discuss proposed spi_prepare_message() APIs.

[2]: https://lore.kernel.org/linux-spi/CACRpkdb4mn_Hxg=3D3tuBu89n6eyJ082EET=
kwtNbzZDFZYTHbVVg@mail.gmail.com/T/#u

