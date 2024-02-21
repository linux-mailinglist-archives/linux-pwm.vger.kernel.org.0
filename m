Return-Path: <linux-pwm+bounces-1595-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9D285DFCC
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 15:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 579B628660C
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 14:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A12A7EEE2;
	Wed, 21 Feb 2024 14:34:17 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB569D10;
	Wed, 21 Feb 2024 14:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526057; cv=none; b=HTWfi0ap11HIXY5Z86xy1uBeXtBhi9L8Wf+fmUMKMYJVz4Dauws7OkPB1OkMP1xfg6eeoGPpiVJ7hWQPveRRFaK08sZ2B/ixWt4wMelg8wUXIWfGJAvr1dyReTMttcdipIZwDzuMZqZ5B5Kcrz0thmBOo/tJpxLPV1Eec6yyEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526057; c=relaxed/simple;
	bh=5qghrkmzaw0d79bz1F1aq4Vy3+pNS+s51gwkQO2jOCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ixiXF/iP2zXO0/vDK2J+LduLzOOpoFCLL26w58Vm4dJgY129jIMPYR9SMuSrYaLDHM71mlRZ4dUMhsBGL+Pna15mH8YKoO2w67Pf+v3g9Xt0Q2/1Qo4CB+X7XHRE5stxe4z4ZZuTjG3WcasCoq5nh2+Lk2hUIFSdLz2eyrbBx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2550066"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2550066"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:34:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913315045"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913315045"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:34:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rcnfk-00000006N6c-41vp;
	Wed, 21 Feb 2024 16:34:08 +0200
Date: Wed, 21 Feb 2024 16:34:08 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, robin@protonic.nl, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 01/10] backlight: Match backlight device against
 struct fb_info.bl_dev
Message-ID: <ZdYJ4FhJ9vhzUeiW@smile.fi.intel.com>
References: <20240221094324.27436-1-tzimmermann@suse.de>
 <20240221094324.27436-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221094324.27436-2-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 10:41:28AM +0100, Thomas Zimmermann wrote:
> Framebuffer drivers for devices with dedicated backlight are supposed
> to set struct fb_info.bl_dev to the backlight's respective device. Use
> the value to match backlight and framebuffer in the backlight core code.

...

>  	if (!bd->ops)
>  		goto out;
> -	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
> +	else if (bd->ops->check_fb && !bd->ops->check_fb(bd, info))

What's the point of adding redundant 'else'?

>  		goto out;
> +#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
> +	else if (info->bl_dev && info->bl_dev != bd)

Ditto.

> +		goto out;
> +#endif

-- 
With Best Regards,
Andy Shevchenko



