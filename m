Return-Path: <linux-pwm+bounces-4626-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DF4A1079B
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 14:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA3C1887DF3
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Jan 2025 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D5234CEA;
	Tue, 14 Jan 2025 13:20:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0156E236A91;
	Tue, 14 Jan 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860843; cv=none; b=gmJF6qLF94GTtQwOCEczVs0ocuaJT2DNeiQhricVKeilH2QiDHM6M96WMLHNfSgqrhP0HENi+BN13p+GzoT8sFt3dbKJE+7azgXO4yj+nkPseQzCxMjUbaEFC7GbWoiPxKWqLPqsYg9ZY24bJGvamK4pWC9yKUriorPiFaIulzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860843; c=relaxed/simple;
	bh=bNkN2ZUZzkBLdC/17B2gsrYwnzBUqLEOkTEy2z01L6M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7pi+GU3WJVv9RnmCOTTmotpUVTEoCVNU0mgfxx5CTIb59vvCeFK+cGHyRHf6B+iJyL6Z8Or2N7sznKOAdL3JjQJoV9CRYQC9A7/rtEK7i3yj2a2O2TANJyMi/LJPs4GZat0NW9mehaMTewSSe3kI3pvtqGFbO2JJFAoTgo7JYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXV7x4kw3z6LDKb;
	Tue, 14 Jan 2025 21:18:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 54297140B38;
	Tue, 14 Jan 2025 21:20:37 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 14:20:36 +0100
Date: Tue, 14 Jan 2025 13:20:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
CC: David Lechner <dlechner@baylibre.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v9 8/8] iio: adc: ad4851: add ad485x driver
Message-ID: <20250114132035.00004abd@huawei.com>
In-Reply-To: <CY4PR03MB3399F8E7AFA00340321BB2A69B182@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
	<20241220120134.42760-8-antoniu.miclaus@analog.com>
	<37fcda1c-0051-4a8c-b61c-583a1b8faa1e@baylibre.com>
	<CY4PR03MB3399F8E7AFA00340321BB2A69B182@CY4PR03MB3399.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)


Hi Antoniu

For future replies please crop to only the bits you are reply to.
Took me a couple of goes to find the reply, so in some cases
the important parts can be completely missed by a reader if
the rest isn't cropped down.

...

> > > +static int ad4851_set_oversampling_ratio(struct iio_dev *indio_dev,
> > > +					 const struct iio_chan_spec *chan,
> > > +					 unsigned int osr)
> > > +{
> > > +	struct ad4851_state *st = iio_priv(indio_dev);
> > > +	int val, ret;
> > > +
> > > +	guard(mutex)(&st->lock);
> > > +
> > > +	if (osr == 1) {
> > > +		ret = regmap_clear_bits(st->regmap,  
> > AD4851_REG_OVERSAMPLE,  
> > > +					AD4851_OS_EN_MSK);
> > > +		if (ret)
> > > +			return ret;
> > > +	} else {
> > > +		val = ad4851_osr_to_regval(osr);
> > > +		if (val < 0)
> > > +			return -EINVAL;
> > > +
> > > +		ret = regmap_update_bits(st->regmap,  
> > AD4851_REG_OVERSAMPLE,  
> > > +					 AD4851_OS_EN_MSK |
> > > +					 AD4851_OS_RATIO_MSK,
> > > +					 FIELD_PREP(AD4851_OS_EN_MSK,  
> > 1) |  
> > > +  
> > FIELD_PREP(AD4851_OS_RATIO_MSK, val));  
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	ret = iio_backend_oversampling_ratio_set(st->back, osr);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	switch (st->info->resolution) {
> > > +	case 20:
> > > +		switch (osr) {
> > > +		case 0:
> > > +			return -EINVAL;
> > > +		case 1:
> > > +			val = 20;
> > > +			break;
> > > +		default:
> > > +			val = 24;
> > > +			break;
> > > +		}
> > > +		break;
> > > +	case 16:
> > > +		val = 16;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ret = iio_backend_data_size_set(st->back, val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	if (osr == 1 || st->info->resolution == 16) {
> > > +		ret = regmap_clear_bits(st->regmap, AD4851_REG_PACKET,
> > > +					AD4851_PACKET_FORMAT_MASK);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		st->resolution_boost_enabled = false;
> > > +	} else {
> > > +		ret = regmap_update_bits(st->regmap, AD4851_REG_PACKET,  
> > 
> > regmap_set_bits  
> 
> Why? Packet format is two bits wide according to the register map.
> 
> > > +					 AD4851_PACKET_FORMAT_MASK,
> > > +  
> > FIELD_PREP(AD4851_PACKET_FORMAT_MASK, 1));  
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		st->resolution_boost_enabled = true;
> > > +	}
> > > +
> > > +	if (st->osr != osr) {
> > > +		ret = ad4851_scale_fill(indio_dev);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		st->osr = osr;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
...

> > > +static int ad4851_setup(struct ad4851_state *st)
> > > +{
> > > +	unsigned int product_id;
> > > +	int ret;
> > > +
> > > +	if (st->pd_gpio) {
> > > +		/* To initiate a global reset, bring the PD pin high twice */
> > > +		gpiod_set_value(st->pd_gpio, 1);
> > > +		fsleep(1);
> > > +		gpiod_set_value(st->pd_gpio, 0);
> > > +		fsleep(1);
> > > +		gpiod_set_value(st->pd_gpio, 1);
> > > +		fsleep(1);
> > > +		gpiod_set_value(st->pd_gpio, 0);
> > > +		fsleep(1000);
> > > +	} else {
> > > +		ret = regmap_set_bits(st->regmap,  
> > AD4851_REG_INTERFACE_CONFIG_A,  
> > > +				      AD4851_SW_RESET);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	if (st->vrefbuf_en) {
> > > +		ret = regmap_set_bits(st->regmap,  
> > AD4851_REG_DEVICE_CTRL,  
> > > +				      AD4851_REFBUF_PD);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> > > +
> > > +	if (st->vrefio_en) {
> > > +		ret = regmap_set_bits(st->regmap,  
> > AD4851_REG_DEVICE_CTRL,  
> > > +				      AD4851_REFSEL_PD);
> > > +		if (ret)
> > > +			return ret;
> > > +	}  
> > 
> > PD stands for power down, so should we be powering down if not enabled?
> > (i.e.
> > if is missing !)  
> We power down the internal reference if the external one is used. Not sure what is wrong here.
> > > +
> > > +	ret = regmap_write(st->regmap,  
> > AD4851_REG_INTERFACE_CONFIG_B,  
> > > +			   AD4851_SINGLE_INSTRUCTION);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = regmap_write(st->regmap,  
> > AD4851_REG_INTERFACE_CONFIG_A,  
> > > +			   AD4851_SDO_ENABLE);
> > > +	if (ret)
> > > +		return ret;
> > > +

Thanks,

Jonathan

