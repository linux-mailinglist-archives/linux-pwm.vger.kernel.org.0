Return-Path: <linux-pwm+bounces-735-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4846C82A3F7
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jan 2024 23:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8121F2318B
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jan 2024 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242D1E4B6;
	Wed, 10 Jan 2024 22:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RhtSbEQ2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632A23FB3D
	for <linux-pwm@vger.kernel.org>; Wed, 10 Jan 2024 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd81b09e83so6337701fa.2
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jan 2024 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704925896; x=1705530696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AS+5B9ThhaWkAjgY4ZusJxzHDo4f/Ncehb81K13Thlw=;
        b=RhtSbEQ2pDbAJjP8epFlqhplpGm4Mme0r5BX/edUmaS+ugJSn3OMPa/2F7ygoVEYvc
         ZKSohjK5rYgep1BJQ5o9qYVPVfSXeTIIGtI9hwnSDktPySJWl3rmxB8YaKsa0O8E0mFl
         vM2nAl982Qpwot/sHL/GlHihWBnjr2rzStZpBJi8BmKOsWjVF1nOufQ+Yh4/vUoCWGSa
         n0Mt74GrBNunIMrO5hMeP1LSNImux6lTQI0X1gP5PX7SYD5CaNsIWY7wCK5iotvU6lmV
         5Lpa2CzewCQNBo7h9cG+CmHfD3V2E4w3aDBG/ofxaFrOxe7tLaqaDrNOr++1jrZWKflo
         g77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704925896; x=1705530696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AS+5B9ThhaWkAjgY4ZusJxzHDo4f/Ncehb81K13Thlw=;
        b=SoOypyLHwADGewezsrXPOZ4jUOdh/NUefJt28UIvdQ+4ULhVMclqT7+1FIpgvne9mU
         Qcb+CV4+hxcarcTxksqa7azDAoVVQ+Nmy3P23qfo+oe0q5UX50hg5BJPzlSVrah0MYTe
         rNLd7NttZ+69RT9JBfvwtddkFzLj44eChac8cVSIOb39DjjDCb/Lnlx6Clafs9h0gc32
         rMBKVIZ954zaPyn4wkh9DIV6ScdYqmRHV54J0fepqGo8qjjCFT4gD57a9BQ3nzOdRaF0
         a9qbiOsUV+YUHw4L5ljb7jWfokhXmmkFeHFNgaaGqAz4OstYclJ9UtO18roE9tg5JMvi
         8taA==
X-Gm-Message-State: AOJu0YzDQmhU3CFwCAOXfIFbfDE+iCVMuF0kj54MAUIH5b7XVYv5sWym
	knE5M30L9kX/4yZH5vxPUlFPW1ToGrqPOy9tZHNG0nGqmfhqeg==
X-Google-Smtp-Source: AGHT+IHqjv12pJuJlKgUzfhn+rZJBcMZrf90giph4Z8Bbrvz4o2mzp5/HSLxK9wehcakpm9DT0mJjwm01PT7H0i8d6E=
X-Received: by 2002:a2e:9290:0:b0:2cc:e9be:90c7 with SMTP id
 d16-20020a2e9290000000b002cce9be90c7mr64793ljh.179.1704925896373; Wed, 10 Jan
 2024 14:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-5-e42c6a986580@baylibre.com> <a94d7aae-3d5c-4204-83f6-5374c3166f58@sirena.org.uk>
In-Reply-To: <a94d7aae-3d5c-4204-83f6-5374c3166f58@sirena.org.uk>
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 10 Jan 2024 16:31:25 -0600
Message-ID: <CAMknhBEEC4F2_hpJ_405bfrb3KNkAYpjDoJbnmOFXodp8yLACg@mail.gmail.com>
Subject: Re: [PATCH 05/13] spi: axi-spi-engine: add SPI offload support
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Hennerich <michael.hennerich@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 3:39=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Jan 10, 2024 at 01:49:46PM -0600, David Lechner wrote:
> > This adds an implementation of the SPI offload_ops to the AXI SPI Engin=
e
> > driver to provide offload support.
> >
> > Offload lookup is done by device property lookup. SPI Engine commands
> > and tx data  are recorded by writing to offload-specific FIFOs in the
> > SPI Engine hardware.
>
> Glancing through here I'm not seeing anything here that handles DMA
> mapping, given that the controller will clearly be doing DMA here that
> seems surprising.

In the use case implemented in this series, the RX data is going to
DMA, but in general, that doesn't have to be the case. In theory, it
could get piped directly to a DSP or something like that. So I left
the RX DMA part out of the SPI controller and implemented as a
separate device in "iio: offload: add new PWM triggered DMA buffer
driver". The SPI controller itself isn't aware that it is connected to
DMA (i.e. there are no registers that have to be poked to enable DMA
or anything like that).

