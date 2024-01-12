Return-Path: <linux-pwm+bounces-759-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7FC82BFD3
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jan 2024 13:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EA91C21AF0
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jan 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14C359B49;
	Fri, 12 Jan 2024 12:37:18 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8573059B41;
	Fri, 12 Jan 2024 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TBLZv46Pnz6D8wx;
	Fri, 12 Jan 2024 20:34:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EE9DE140B2F;
	Fri, 12 Jan 2024 20:37:12 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 12 Jan
 2024 12:37:12 +0000
Date: Fri, 12 Jan 2024 12:37:11 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S?=
 =?ISO-8859-1?Q?=E1?= <nuno.sa@analog.com>, Frank Rowand
	<frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-spi@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/13] iio: buffer: add hardware triggered buffer
 support
Message-ID: <20240112123711.0000422a@Huawei.com>
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-6-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
	<20240109-axi-spi-engine-series-3-v1-6-e42c6a986580@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 10 Jan 2024 13:49:47 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new mode INDIO_HW_BUFFER_TRIGGERED to the IIO subsystem.
> 
> This mode is essentially the hardware version of INDIO_BUFFER_TRIGGERED
> where the trigger has the semantics of INDIO_HARDWARE_TRIGGERED and the
> buffer has the semantics of INDIO_BUFFER_HARDWARE.
> 
> So basically INDIO_HW_BUFFER_TRIGGERED is the same as
> INDIO_BUFFER_HARDWARE except that it also enables the trigger when the
> buffer is enabled.

If the trigger isn't routeable to multiple devices we normally don't
make it visible at all.

I'm not yet understanding what a trigger actually means in this case.
Why do you need it to be userspace configurable?

J


