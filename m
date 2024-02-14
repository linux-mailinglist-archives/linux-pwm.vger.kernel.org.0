Return-Path: <linux-pwm+bounces-1488-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E6085497C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 13:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C741C214EC
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5BB524DB;
	Wed, 14 Feb 2024 12:47:13 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183DD1CD12;
	Wed, 14 Feb 2024 12:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707914833; cv=none; b=XvsaHeq0Wdc8Dw7zyiOy6UtNWn1685RfXdWEKg0ZhhWwwHo+x2kLqOrghCBX3mq4J2EKvgQpttVE9JwgueASbTV748S8qmUA11z2QXNxzEv9OiDG+PiBreXf0sxaHVBDwbJuEy3PHeYulaX9ppBvC96Z3kStFE1CklzhSu6VDpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707914833; c=relaxed/simple;
	bh=tHbO3A6mx4RTUftXJJG+TOoZZn+bAlVD03qTchhovEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm5lzBR/+PXJYHTtHOohi/htrzYNw/dyEcDUOILqFaTpnuLrGIctP+m2LOYlD2TDnyManohTey7Bw+KFB3PtCIKyxIrCYKsM+8d1X2fnNmtkXdPHlK0p96+YHUWq4nkFpw3ztH5veoT7Cb2LeoWVicnGO9MVEu+sukQ8r87JO1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="13351599"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="13351599"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:46:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="912083820"
X-IronPort-AV: E=Sophos;i="6.06,159,1705392000"; 
   d="scan'208";a="912083820"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 04:46:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1raEeX-00000004UVC-42BS;
	Wed, 14 Feb 2024 14:46:17 +0200
Date: Wed, 14 Feb 2024 14:46:17 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	kernel@pengutronix.de, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v6 067/164] pwm: lpss-*: Make use of devm_pwmchip_alloc()
 function
Message-ID: <Zcy2GbkjX7N6buB9@smile.fi.intel.com>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <b567ab5dd992e361eb884fa6c2cac11be9c7dde3.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b567ab5dd992e361eb884fa6c2cac11be9c7dde3.1707900770.git.u.kleine-koenig@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 10:31:54AM +0100, Uwe Kleine-König wrote:
> This prepares the pwm-lpc drivers to further changes of the pwm core

lpc --> lpss
pwm --> PWM

> outlined in the commit introducing devm_pwmchip_alloc(). There is no
> intended semantical change and the driver should behave as before.

...

> -struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
> +struct pwm_chip *devm_pwm_lpss_probe(struct device *dev, void __iomem *base,
>  					  const struct pwm_lpss_boardinfo *info)

Missing indentation amendment for the second line.

...

> +	struct pwm_chip *chip;
>  	struct pwm_lpss_chip *lpwm;
>  	unsigned long c;
>  	int i, ret;


Please, keep reversed xmas tree order in place.

	struct pwm_lpss_chip *lpwm;
	struct pwm_chip *chip;
	unsigned long c;
	int i, ret;

...


With the above being addressed,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



