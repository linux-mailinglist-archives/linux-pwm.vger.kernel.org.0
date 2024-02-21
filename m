Return-Path: <linux-pwm+bounces-1596-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EDB85DFD2
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 15:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E031F24CFE
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Feb 2024 14:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB178B73;
	Wed, 21 Feb 2024 14:35:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544869D10;
	Wed, 21 Feb 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526124; cv=none; b=Lc1qgNr1W27BwqiiRUElCTDSeRmPa2nFyFrGjmH5ScOw4bBhSUrodeZWytLXYWuxxXK1+vbvovcJZ9ZXWXeLZz4KcHgM80pSCVOBRVRHeAivZIdHvC//DEAqbcrFp8uQ66f+npILxNTMpNYYiS/l87WN9Dakw7T6tSkFtbTT39A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526124; c=relaxed/simple;
	bh=7kJff6uenqtMcG+oABWOgdnozgZWzTpO/XafjFTGPRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cy9hT8JkO+EkXCXjdlPKJsZ0wBReAh/pZesRtgRQs0hnn8DWNSqgykvv4ruAcxvSaosbnO24ESHPyn0qkzBaPtSBSXZz6vFGBZVH9NKCwyvL1xujBC4ALzg6rCjZlw3CDIG4aQWhvgvvzZ8oLThlQdCu5HwP35seQQZqpLdqGHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2550153"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2550153"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:35:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="913315192"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="913315192"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:35:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rcngp-00000006N7Q-44Cd;
	Wed, 21 Feb 2024 16:35:15 +0200
Date: Wed, 21 Feb 2024 16:35:15 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
	deller@gmx.de, robin@protonic.nl, javierm@redhat.com,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 02/10] auxdisplay/ht16k33: Remove struct
 backlight_ops.check_fb
Message-ID: <ZdYKI_DOWetWHrRm@smile.fi.intel.com>
References: <20240221094324.27436-1-tzimmermann@suse.de>
 <20240221094324.27436-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221094324.27436-3-tzimmermann@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 10:41:29AM +0100, Thomas Zimmermann wrote:
> The driver sets struct fb_info.bl_dev to the correct backlight
> device. Thus rely on the backlight core code to match backlight
> and framebuffer devices, and remove the extra check_fb function
> from struct backlight_ops.

check_fb()

Acked-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



