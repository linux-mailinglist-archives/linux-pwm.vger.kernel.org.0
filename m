Return-Path: <linux-pwm+bounces-3948-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D889B36C5
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 17:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4992833CE
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 16:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E71DED59;
	Mon, 28 Oct 2024 16:39:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135591DE2BF;
	Mon, 28 Oct 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133555; cv=none; b=hWLWW3eiU0fHAkT4USi8bUkcbV+oAsYAQ8P4jiB1DIdSRC3pQueo6KU7y7ZmiLc6q2RqhwfRJrEYmLe5GLSQFucGBCgu4Ksixd6qY9BQp42WnZIDTwjri9s6RO14hQmZkZ64fCDOMtFF/+HS9ccEJaPItJTZwYRfSP3FNXGXpDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133555; c=relaxed/simple;
	bh=jeqOaqJuFOoxOEWYmX6WO8I6UoLf98HeNqbukHCZ4qU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUx52C7YG4+a/7JS9ISfIlhgn2l3mQPK9w/plvbQXEwFJAEtx7sBXcU/PAsZxkshe95yAyIveK5wEAwg1SBKHNMmnHESCIpf2AnzRfvKqfpM5ga84TuWqMlL8R/FOcmriYPSbZnffIM9zw+tidbfuTS4HLrbiSlVEQg8KGO+NKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xcf9T3pWzz6LDXM;
	Tue, 29 Oct 2024 00:34:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E8BE91404FC;
	Tue, 29 Oct 2024 00:39:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 28 Oct
 2024 17:39:09 +0100
Date: Mon, 28 Oct 2024 16:39:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<ukleinek@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
	Martin Sperl <kernel@martin.sperl.org>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH RFC v4 15/15] iio: adc: ad4695: Add support for SPI
 offload
Message-ID: <20241028163907.00007e12@Huawei.com>
In-Reply-To: <2679570d-6255-467b-8312-117e553a52b4@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
	<20241023-dlech-mainline-spi-engine-offload-2-v4-15-f8125b99f5a1@baylibre.com>
	<20241026170038.4b629cff@jic23-huawei>
	<5a090847-ee53-41be-ad28-b7604cf9020a@baylibre.com>
	<20241027091244.2fe3c0ad@jic23-huawei>
	<2679570d-6255-467b-8312-117e553a52b4@baylibre.com>
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
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 27 Oct 2024 14:52:17 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 10/27/24 4:12 AM, Jonathan Cameron wrote:
> > On Sat, 26 Oct 2024 19:01:53 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 10/26/24 11:00 AM, Jonathan Cameron wrote:  
> >>> On Wed, 23 Oct 2024 15:59:22 -0500
> >>> David Lechner <dlechner@baylibre.com> wrote:
> >>>     
> 
> ...
> 
> >>>     
> >>>>  static int ad4695_probe(struct spi_device *spi)
> >>>>  {
> >>>>  	struct device *dev = &spi->dev;
> >>>>  	struct ad4695_state *st;
> >>>>  	struct iio_dev *indio_dev;
> >>>> -	struct gpio_desc *cnv_gpio;
> >>>>  	bool use_internal_ldo_supply;
> >>>>  	bool use_internal_ref_buffer;
> >>>>  	int ret;
> >>>>  
> >>>> -	cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
> >>>> -	if (IS_ERR(cnv_gpio))
> >>>> -		return dev_err_probe(dev, PTR_ERR(cnv_gpio),
> >>>> -				     "Failed to get CNV GPIO\n");
> >>>> -
> >>>> -	/* Driver currently requires CNV pin to be connected to SPI CS */
> >>>> -	if (cnv_gpio)
> >>>> -		return dev_err_probe(dev, -ENODEV,
> >>>> -				     "CNV GPIO is not supported\n");
> >>>> -
> >>>>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> >>>>  	if (!indio_dev)
> >>>>  		return -ENOMEM;
> >>>> @@ -1002,8 +1374,13 @@ static int ad4695_probe(struct spi_device *spi)
> >>>>  		return -EINVAL;
> >>>>  
> >>>>  	/* Registers cannot be read at the max allowable speed */
> >>>> +	st->spi_max_speed_hz = spi->max_speed_hz;
> >>>>  	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
> >>>>  
> >>>> +	ret = devm_add_action_or_reset(dev, ad4695_restore_spi_max_speed_hz, st);    
> >>>
> >>> Why do you need to put it back in devm? What happens after this but without
> >>> a driver restart that uses that faster rate?
> >>>     
> >> I should have added a comment here as this was a weird bug to trace.
> >>
> >> The core SPI framework sets the initial value of spi->max_speed_hz
> >> to the minimum of the controller max rate and the max rate specified
> >> by the devicetree.
> >>
> >> The SPI device lives beyond this driver, so if we bind the driver
> >> and set spi->max_speed_hz to something other than what the SPI core
> >> set it, then the next time we bind the driver, we don't get the
> >> the max rate from the SPI core, but rather we changed it to when
> >> the driver unbound.
> >>
> >> So on the second bind, the max rate would be the slow register
> >> read rate instead of the actual max allowable rate.
> >>
> >> So we need to reset spi->max_speed_hz to what it was originally
> >> on driver unbind so that everything works as expected on the
> >> next bind.
> >>
> >> (Or we call this a SPI core bug and fix it there instead).  
> > Definitely a question to ask.  Directly accessing spi_max_speed_hz may
> > be the fundamental issue as I don't think the driver is generally
> > expected to touch that in a dynamic fashion.  Should we be instead setting it
> > per transfer for the ones that need it controlled?
> > 
> > Jonathan
> >   
> 
> The problem is that we are using regmap and that doesn't have
> a way to specify the max frequency for register reads that is
> different from other uses of the SPI bus (i.e. reading sample
> data). So we could fix it in the generic SPI regmap (not exactly
> trivial) or we could write our own regmap read/write callbacks
> in this driver that properly sets the per-transfer max speed.

Custom read / write callbacks seems the best approach at first
glance, given this is pretty rare thing to do. 

> 
> 


