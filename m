Return-Path: <linux-pwm+bounces-6294-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A88AD5A3D
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 17:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927E23A48C4
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A781991B8;
	Wed, 11 Jun 2025 15:18:19 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC901714AC;
	Wed, 11 Jun 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655099; cv=none; b=pw/S3cgCnQGfwc5v1VY4LH02I62DWMc+hTIAupQFChGIoN4Kbb1xfuUKaCQjth2zqYSaQ8HeEjOcFkBh79gyy2gZ1SWSEaOzTtfnvj1IxbsiTcgNKbx1yOORbl0rFAux+XroVuzJN9gFJKhfgvs3UykplJki8dZ5vQejT6cd/os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655099; c=relaxed/simple;
	bh=uEsItBPGgeCWoFaCt1VlZRMS1vfKbhl7qPQIzFhVU0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lq52U1y2Acc0trQ91cRPOrefr0TEyWvdP2bLh4pL/u4D6/bCAmPaKTz0sn473SIx1uvw2Qj3sGH8D5B0hX8whh1vNZs2pYlCZZtys2ubtzLgVFKQ+q+zughwxBMT4SqGSemSDoDxhQzGLsygIXMRQqRfCqB6Otwcv3BWqw3BMAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: ct7uZHPfTUSIxt9QhA0/FA==
X-CSE-MsgGUID: DEFYsMHtS2+1DgZ1J2HoKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62839536"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="62839536"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:18:18 -0700
X-CSE-ConnectionGUID: wJ16Cb+nRaC7FDUPLS4m5A==
X-CSE-MsgGUID: mdZBOygwSXumz5p8Y8VXaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="148128870"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 08:18:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uPNDM-00000005gLk-42DS;
	Wed, 11 Jun 2025 18:18:08 +0300
Date: Wed, 11 Jun 2025 18:18:08 +0300
From: Andy Shevchenko <andy@kernel.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Keerthy <j-keerthy@ti.com>, Vladimir Zapolskiy <vz@mleia.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Heiko Stuebner <heiko@sntech.de>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
	imx@lists.linux.dev, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] gpio: Use dev_fwnode()
Message-ID: <aEmeMOW5e3q9TrUu@smile.fi.intel.com>
References: <20250611104348.192092-1-jirislaby@kernel.org>
 <20250611104348.192092-6-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611104348.192092-6-jirislaby@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jun 11, 2025 at 12:43:34PM +0200, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.

Thanks for this change. See my nit-pick below.

...

> @@ -436,10 +436,8 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
>  	struct device_node *np = dev->of_node;
>  	int err;
>  
> -	priv->irq_domain =
> -		irq_domain_create_linear(of_fwnode_handle(np), priv->num_gpios,
> -				      &brcmstb_gpio_irq_domain_ops,
> -				      priv);
> +	priv->irq_domain = irq_domain_create_linear(dev_fwnode(dev), priv->num_gpios,
> +						    &brcmstb_gpio_irq_domain_ops, priv);

In cases like this, I would rather see something like

	struct fwnode_handle *fwnode = dev_fwnode(dev);

just near to the respective of node extraction. This will help to reduce churn
when converting the rest of the code to use fwnode instead of of_node/np.

>  	if (!priv->irq_domain) {
>  		dev_err(dev, "Couldn't allocate IRQ domain\n");
>  		return -ENXIO;

Other than that I appreciate the series!

-- 
With Best Regards,
Andy Shevchenko



