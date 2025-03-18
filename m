Return-Path: <linux-pwm+bounces-5232-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F6A679DF
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 17:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B402189C1BA
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9C211479;
	Tue, 18 Mar 2025 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpnOgXAl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B692101B7;
	Tue, 18 Mar 2025 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315995; cv=none; b=k/s6xpRuJggTaHQt1Xhwp0lVW/qshUpLQvq0pqVXfFQDYsAtJo3GrK7WoQvb3+YoXOngA/zg/ZNva6htW0ccrdvtA25wSUthD38YkvKNL8Bt+B2ebYp/IgGZWn9jWnPGJ97Rgky4QZedAsNGFUQatFNk9ssDVFW/AuwDYjLJ6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315995; c=relaxed/simple;
	bh=VBS24GEiuWv3o6ErdxY76MarUEHIpjVzLn7Bm6leIdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TE29zWJnHI73lIcqXEst5q7iJwhfer/Dj9laaslX1tLEJbpiLWU6n3mqa6uogzcdzBIqPtNNE2NStzIY1YZus2e742KPicUOBS5yykFV6Ia+vBG2ktFcc5Ty/ZzYO9Bjch+91Zjrsitd6sM5ooifgcfunyfvRC2G1RttbCT0ucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpnOgXAl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742315994; x=1773851994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VBS24GEiuWv3o6ErdxY76MarUEHIpjVzLn7Bm6leIdE=;
  b=HpnOgXAlReGxGHq+GLvVCTF6ZgqhT+Ry4C3XdNZPU9UOeA7wnQpLFHVC
   +W/F/tVELUeYjKUMiIgtgEtX6wy1m7FHxjIimlbJ52N7lL8lQlUA1FS6M
   9c5cm+lFFySooUeca8zT6ZymGpfAE31OGodVU/QhP4ePJgSsZdPov6ABI
   N0Gfc87VZ/c2dS/nkbj3JxrRaFCHMZ9Gr0g/ZCX47qx8yLfHF201THV9C
   kiRBxd8K5e5Xs8cvOcAr4QRJdGLlVHwBUxoj/uTBP+3gIfuUXpOt1n5gX
   mUOxIDpzrYxOfxWrsDxPYwoPW5LdgLiUvxe6XB92paX8R+Y2PBoEnD9ZQ
   Q==;
X-CSE-ConnectionGUID: cfCdkMqWQl+maJy5cah6mA==
X-CSE-MsgGUID: Z/zkE/jrQtyrkNneHJaN/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="68820653"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="68820653"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:39:53 -0700
X-CSE-ConnectionGUID: rTvP+T45TuKt6rDL1T9nmg==
X-CSE-MsgGUID: tToL+xKtRnKQMfa/S4I/XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122142935"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:39:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tuZyi-00000003gIk-3XBn;
	Tue, 18 Mar 2025 18:39:44 +0200
Date: Tue, 18 Mar 2025 18:39:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Subject: Re: [PATCH v5 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Message-ID: <Z9mh0ENc1kDFrJlQ@smile.fi.intel.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
 <20250318-mdb-max7360-support-v5-5-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-5-fb20baf97da0@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 18, 2025 at 05:26:21PM +0100, Mathieu Dubois-Briand wrote:
> Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
> provide an IRQ status for each separate line: only the current gpio
> level can be retrieved.
> 
> Add support for these chips, emulating IRQ status by comparing GPIO
> levels with the levels during the previous interrupt.


Some nit-picks below, but either way
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  			default:
>  				BUG();
> -				goto exit;
> +				return ret;

Hmm... BUG() implies unreachable, perhaps just a precursor patch to drop this
goto completely?

...

> +	/* Store current levels */
> +	if (chip->status_is_level) {
> +		ret = read_irq_data(d);
> +		if (ret < 0)
> +			goto err_alloc;
> +
> +		memcpy(d->prev_status_buf, d->status_buf,
> +		       d->chip->num_regs * sizeof(d->prev_status_buf[0]));

Perhaps array_size()?

> +	}

-- 
With Best Regards,
Andy Shevchenko



