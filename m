Return-Path: <linux-pwm+bounces-4864-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23346A3208C
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 09:03:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67E8162E51
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 08:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5D2046BF;
	Wed, 12 Feb 2025 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XbYso5MR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CCF26AEC;
	Wed, 12 Feb 2025 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347407; cv=none; b=G+RQIwQiNM0MZjNHUP3H5LtiuylsGaK8WIniqu5OI9SayXKZF30IiAoJkzksOEaki93v06OEGmnySCyyhOyD8MCPTqXisAmrlh3Iczb+tD/CIms5Kbve+L9O2w8R70ii9ME1r8+anYRNBgW78/bHheY1YkqCKvaZQD1gXev9QrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347407; c=relaxed/simple;
	bh=pO031soeAN2xTZUcwq6yyzqPBbAKgf77wG9z2Co6OAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE8PIVzURGR6/2ZQfiupkOwLwtNwE85DOomzDvVlZddyqKI0IxOBVHtG1PdgVsriJgPKBDvQiGEQFiG3j72N8V2jvWXAf9///Hsf6jeLQPfmYr9FnrsF8iQPsc3YBplJrf49P7ICcOaq1SiLFq60Lb3KhcG6TilzjqGkhr5COWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XbYso5MR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739347405; x=1770883405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pO031soeAN2xTZUcwq6yyzqPBbAKgf77wG9z2Co6OAQ=;
  b=XbYso5MRmNLCb1dQeLGQ9DmwQ72bgjp4OGpl6q5yNkpb9BX4WPj9V1a2
   HZF4esuZKWbdfG8TURw4H44bpqFmET2UQit+U0FCP0DR5akf4SNAiIACj
   q9amjsG8BY6bax/gT5jlajmuACrfmrgUYnhH5+a59q6yuHt4HW8Cgr5v3
   ZV8EmjKDaIBcC/KoD4+I2RaE2WGODi20xAurZ4AHhns0mYvILQ0T4Gzf7
   F+3OfmJcy7ub9acjntmGoV9B/KrlieoYpPfpzekQ+Giti6Wqknf4fdA/4
   DHlKHUQXmL/pLsHaa0YXoGcsmQvDO3YMUdkTOz4+YRi7eB4yLfAEcz08B
   w==;
X-CSE-ConnectionGUID: PTtOYggZTTaQOILKZKVrXg==
X-CSE-MsgGUID: xUZsNhcKQhKrnLE3dK7GyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51384806"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="51384806"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:03:24 -0800
X-CSE-ConnectionGUID: FFGiGoEsRq+bQBfIANicbw==
X-CSE-MsgGUID: RXhg/U3zReqi686kTX0hrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117929688"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2025 00:03:22 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti7iJ-0015L9-1O;
	Wed, 12 Feb 2025 08:03:19 +0000
Date: Wed, 12 Feb 2025 16:03:10 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Bamvor Jian Zhang <bamv2005@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Keerthy <j-keerthy@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/14] gpiolib: make value setters have return values
Message-ID: <202502121512.CmoMg9Q7-lkp@intel.com>
References: <20250211-gpio-set-retval-v1-1-52d3d613d7d3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-gpio-set-retval-v1-1-52d3d613d7d3@linaro.org>

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on df5d6180169ae06a2eac57e33b077ad6f6252440]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpiolib-make-value-setters-have-return-values/20250211-201426
base:   df5d6180169ae06a2eac57e33b077ad6f6252440
patch link:    https://lore.kernel.org/r/20250211-gpio-set-retval-v1-1-52d3d613d7d3%40linaro.org
patch subject: [PATCH 01/14] gpiolib: make value setters have return values
config: i386-buildonly-randconfig-002-20250212 (https://download.01.org/0day-ci/archive/20250212/202502121512.CmoMg9Q7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502121512.CmoMg9Q7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502121512.CmoMg9Q7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/leds/leds-aw200xx.c: In function 'aw200xx_disable':
>> drivers/leds/leds-aw200xx.c:382:16: warning: 'return' with a value, in function returning void [-Wreturn-type]
     382 |         return gpiod_set_value_cansleep(chip->hwen, 0);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-aw200xx.c:380:13: note: declared here
     380 | static void aw200xx_disable(const struct aw200xx *const chip)
         |             ^~~~~~~~~~~~~~~


vim +/return +382 drivers/leds/leds-aw200xx.c

d882762f7950c3 Dmitry Rokosov 2023-11-25  379  
d882762f7950c3 Dmitry Rokosov 2023-11-25  380  static void aw200xx_disable(const struct aw200xx *const chip)
d882762f7950c3 Dmitry Rokosov 2023-11-25  381  {
d882762f7950c3 Dmitry Rokosov 2023-11-25 @382  	return gpiod_set_value_cansleep(chip->hwen, 0);
d882762f7950c3 Dmitry Rokosov 2023-11-25  383  }
d882762f7950c3 Dmitry Rokosov 2023-11-25  384  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

