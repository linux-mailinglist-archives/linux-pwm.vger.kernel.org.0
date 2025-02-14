Return-Path: <linux-pwm+bounces-4908-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA842A36162
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4103ABE9F
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB534266EE0;
	Fri, 14 Feb 2025 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eftJfU1C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5D266B4D;
	Fri, 14 Feb 2025 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546308; cv=none; b=a0knkq46tv03i2gGRsHYqiaE2PQzrwjNxAqyy/Yy+PMn4fgu75M+yGpZfS+bLA9O7/OlznxDVI+poS70gojmDfx2iedGsEHh5xzEsyk2awqj94aD13E4HwGQS1CsSKFn18pKRT3Hgd5KxdJwv7vufw4DYntVj80+iouxHcR+0ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546308; c=relaxed/simple;
	bh=Ccy4yBddiH1ImFNY9Pm+Nr1mImwwalRXFCXZ00/riwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3iBTCEU+JBmD24aaCWv7Us03n5QC3Wmttvrnu7oHbEyTKubIF610/QcJXptXcFRNyA9TIHhFHD10kDAu3Go4SLbEK9bx7fa6640Pis8cMrFmYMnn1bBVpvUMj/tnkpW8QsU4htwVwmixO1cwaNVI8J7sIcccFR5Wao3J+Oy0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eftJfU1C; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739546308; x=1771082308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ccy4yBddiH1ImFNY9Pm+Nr1mImwwalRXFCXZ00/riwg=;
  b=eftJfU1CIxY8uPbX6x7NhsIFqunEcl6hNEdssPGBkuzhA3bkHnYTqvvn
   erMrvZe78odwlNFz7G1WjmpqO+X/deGRSLVbRNRvA4pbpU0IeulXln1mz
   tYLtt4c1rDFTU9ehTxOUNFppAW78adOwPY5q7DghctUmY9kAQ/8PSU1t+
   uT2eYu+nqgvWoUe1jWxkQ9sEC60YhfzA6T5gW1Oo2WhUIyIdwK4GFQUxs
   oujue67UNyv4jnm2PJAEEdoPd2btwGjADsDVC9ss8bcueGgmRA9+FMev5
   4+tJyFkiHjt81ZiB+CYl33lM3Sr2ruT7HRCosuiUe3K7TSNNGuXh7KQpU
   Q==;
X-CSE-ConnectionGUID: vPXqW9CPSue6iAuCMCSGMw==
X-CSE-MsgGUID: RSpD4nYjTiKgqmGet3/zog==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40005253"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40005253"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:18:27 -0800
X-CSE-ConnectionGUID: 12OXvvsISZ6LDtN9Vlx7Jw==
X-CSE-MsgGUID: dG/E/93STyKP7B6gt/kBaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113970982"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 07:18:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tixSL-0000000BWmd-40hj;
	Fri, 14 Feb 2025 17:18:17 +0200
Date: Fri, 14 Feb 2025 17:18:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 06/10] regmap: irq: Add support for chips without
 separate IRQ status
Message-ID: <Z69eue2dV37vw61v@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-6-8a35c6dbb966@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-mdb-max7360-support-v4-6-8a35c6dbb966@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 12:49:56PM +0100, Mathieu Dubois-Briand wrote:
> Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
> provide an IRQ status for each separate line: only the current gpio
> level can be retrieved.
> 
> Add support for these chips, emulating IRQ status by comparing GPIO
> levels with the levels during the previous interrupt.

Thanks, this will help to convert more drivers to regmap
(e.g., gpio-pca953x that seems use similar approach).

...

> +static irqreturn_t regmap_irq_thread(int irq, void *d)
> +{
> +	struct regmap_irq_chip_data *data = d;
> +	const struct regmap_irq_chip *chip = data->chip;
> +	struct regmap *map = data->map;
> +	int ret, i;

	unsigned int i;
?

> +	bool handled = false;
> +	u32 reg;
> +
> +	if (chip->handle_pre_irq)
> +		chip->handle_pre_irq(chip->irq_drv_data);
> +
> +	if (chip->runtime_pm) {
> +		ret = pm_runtime_get_sync(map->dev);
> +		if (ret < 0) {

> +			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
> +				ret);

Can be one line.

> +			goto exit;
> +		}
> +	}
> +
> +	ret = read_irq_data(data);
> +	if (ret < 0)
> +		goto exit;
> +
> +	if (chip->status_is_level) {
> +		for (i = 0; i < data->chip->num_regs; i++) {
> +			unsigned int val = data->status_buf[i];
> +
> +			data->status_buf[i] ^= data->prev_status_buf[i];
> +			data->prev_status_buf[i] = val;
> +		}
> +	}

...

> +		for (i = 0; i < d->chip->num_regs; i++)
> +			d->prev_status_buf[i] = d->status_buf[i];

Hmm... Wouldn't memcpy() suffice?
But okay, this seems to be not a hot path and the intention is clear.

-- 
With Best Regards,
Andy Shevchenko



