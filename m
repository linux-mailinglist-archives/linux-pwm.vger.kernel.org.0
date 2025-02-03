Return-Path: <linux-pwm+bounces-4761-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA350A25E96
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 16:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A99A188164F
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Feb 2025 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4A6208995;
	Mon,  3 Feb 2025 15:25:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE56204C04;
	Mon,  3 Feb 2025 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596340; cv=none; b=a4B3A9FcFoOz7ngf6wzM+XnUKP1m7+O6P+JilQwNIOU4AjVes2km/ebRAxFfNyrAh5OMdZaDFemG2sORfjR5xoTEtj5czwi86btK168KXetDc0HF+ThNefTjO0llsIxKuVysr9rOkF0/cA0e9U6+zHk+UpDsPGt5G2cMuEpj9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596340; c=relaxed/simple;
	bh=wRpwTEd72M21DmLzOcouJm+GBzjy+8mSBR6J8Uag0h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vl2srzLUxas94VgRiCopb62PPehbV0WifCD8UamATQcKjl21/zlePciePXfyiAbvdTwLo8u39fSjo4j4YqwUXU1PiMNBnfn/azONMtbgP2aOysEqzmsHG5vx5mAewBuGwgcPln92iXkm6xZgbmZLHnqlD06czFjStWilCHRsuq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: UOU1/cmPSEG1CeOwAhLzbg==
X-CSE-MsgGUID: 7MQHIseUQ1aLfSzCo2mMWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="41924711"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="41924711"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 07:25:38 -0800
X-CSE-ConnectionGUID: 1sNiTXNJTde1JCqyHDCYaQ==
X-CSE-MsgGUID: ExALNuoaThe61pnbpGy1jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110128517"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 07:25:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1teyKM-00000007s81-23pH;
	Mon, 03 Feb 2025 17:25:34 +0200
Date: Mon, 3 Feb 2025 17:25:34 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 0/2] pwm: lpss: module namespace fixes
Message-ID: <Z6Df7lmckX_gPgJG@smile.fi.intel.com>
References: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123101110.339337-4-u.kleine-koenig@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Jan 23, 2025 at 11:11:09AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> in (implicit) v1[1] I suggested to move the MODULE_IMPORT_NS magic into
> include/linux/platform_data/x86/pwm-lpss.h. While I still consider that
> a good idea I was overruled and so here comes the variant with the
> explicit MODULE_IMPORT_NS in each module that makes use of the
> respective symbols.
> 
> I don't have a fixed merge plan for this series (assuming it gets the
> expected Acks). Either way (both via pwm, both via pinctrl or the
> pinctrl patch first and the pwm one in the next cycle) is fine for me.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



