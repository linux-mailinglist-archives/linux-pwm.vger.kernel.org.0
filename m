Return-Path: <linux-pwm+bounces-6542-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF2AEB1D3
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 10:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F318996D1
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Jun 2025 08:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9D280325;
	Fri, 27 Jun 2025 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mRGV3oVP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AC727EFE2;
	Fri, 27 Jun 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014692; cv=none; b=aFGzvJ4vdjm9jwfYNOWhfo9OaHo8zGV3qCizrLFpEDiC9NSPj/fGYcnEUmU40aJyJJ2NEyGUaajYurmFBzqYsbGR/Dob12KUQYYSMXcJkhnCj3+BNt0EB0EDEFUzffSDZxILVxThct5IqhhmXihOwTTDEB036aKaRgfjzgiBePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014692; c=relaxed/simple;
	bh=nbuhWX5emK/YLqNw/+CpsP9Pgd7XXNY62ss/pevIhXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRInDIZs3+QhD4dFjlUI1+HWFis7sNe7eDXhpKrqNu724/JC3FZ4rmfM5JjAiP58pgrOaK9vC6nh3gKrmzPNt0gQdw6J67/qonh6voyjvLLnFzJeyEcx2mY5SRGOeSUbZZJ+sd8tl6Dv/yxgP31LHq3+UJCwAAcbd5mWsr+irpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mRGV3oVP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751014691; x=1782550691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nbuhWX5emK/YLqNw/+CpsP9Pgd7XXNY62ss/pevIhXg=;
  b=mRGV3oVPneel35oJYfDoas7T3hm90+/LXpOzhRBQ+oxCOXsa+TcoD48X
   eZGPc0TltxXJhmoSHas/CjgM1a2rC1IQYGorzFrImunYzKeH2k4IeNNu9
   zuy/G25lpzdmsBEPVutCJ+UEr2nTIs2VoL0EycIVAgY+LbSx/2Gty2963
   OkjC+8izyq7s7MT/5WffRIsHClT3ArXk0CKvKkrrSpR4abs/tdcLpG9dh
   HyAO/BphYEzTLfPOoN2VBR2Jj6Vv+JTeMk0JuiTC5QRams9MGrxXHHxze
   uOpS93Zu5I8ruNzsP9Pltz7MXpCRwPfARPViG3q+OOSKWCy8WQyn7Yglu
   A==;
X-CSE-ConnectionGUID: WI6vdy4wQhG4hNedDxvVpA==
X-CSE-MsgGUID: Yr6Flw8nRhOV8HwIp/54LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53405410"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53405410"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 01:58:10 -0700
X-CSE-ConnectionGUID: wwio2xF1QRiPH1MFGu7XYg==
X-CSE-MsgGUID: q9JSefTxRVy52YZ8ho543Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="158485292"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 01:58:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uV4uK-0000000AQp5-369i;
	Fri, 27 Jun 2025 11:58:04 +0300
Date: Fri, 27 Jun 2025 11:58:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v18] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aF5dHDr8yDSKlp5j@smile.fi.intel.com>
References: <20250626224805.9034-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626224805.9034-1-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 12:47:53AM +0200, Christian Marangi wrote:
> From: Benjamin Larsson <benjamin.larsson@genexis.eu>
> 
> Introduce driver for PWM module available on EN7581 SoC.

...

> + * Copyright 2025 Markus Gothe <markus.gothe@genexis.eu>
> + *		  Christian Marangi <ansuelsmth@gmail.com>

I'm not sure you can change the copyright line like this. I would rather expect

 * Copyright 2012 Markus Gothe <markus.gothe@genexis.eu>
 * Copyright 2025 Christian Marangi <ansuelsmth@gmail.com>

(Sorry, I forgot the exact original year there, but you got the point)

...

> +	/* Global mutex to protect bucket used refcount_t */
> +	struct mutex mutex;

This makes a little sense. Either you use refcount_t (which is atomic) or
use mutex + regular variable.

...

> +	/*
> +	 * It is necessary to explicitly shift out all zeros after muxing
> +	 * to initialize the shift register before enabling PWM
> +	 * mode because in PWM mode SIPO will not start shifting until
> +	 * it needs to output a non-zero value (bit 31 of led_data
> +	 * indicates shifting in progress and it must return to zero
> +	 * before led_data can be written or PWM mode can be set)

Missing period at the end.

> +	 */

...

> +static void airoha_pwm_disable(struct airoha_pwm *pc, struct pwm_device *pwm)
> +{
> +	/* Disable PWM and release the bucket */
> +	airoha_pwm_config_flash_map(pc, pwm->hwpwm, -1);
> +	airoha_pwm_release_bucket_config(pc, pwm->hwpwm);
> +
> +	clear_bit(pwm->hwpwm, pc->initialized);
> +
> +	/* If no SIPO is used, disable the shift register chip */
> +	if (find_next_bit(pc->initialized, AIROHA_PWM_MAX_CHANNELS,
> +			  AIROHA_PWM_NUM_GPIO) >= AIROHA_PWM_NUM_GPIO)

This can be rewritten as

	if (!bitmap_read(pc->initialized, AIROHA_PWM_NUM_GPIO, AIROHA_PWM_NUM_SIPO))

(seems to me that the above code is buggy and has to have a check against the
 full size of bitmap).

> +		regmap_clear_bits(pc->regmap, AIROHA_PWM_REG_SIPO_FLASH_MODE_CFG,
> +				  AIROHA_PWM_SERIAL_GPIO_FLASH_MODE);
> +}

-- 
With Best Regards,
Andy Shevchenko



