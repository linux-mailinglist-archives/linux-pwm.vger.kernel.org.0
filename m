Return-Path: <linux-pwm+bounces-4869-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 934A2A327CC
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 547521624D3
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Feb 2025 13:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFCC20E6F2;
	Wed, 12 Feb 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbyeaJX5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31EE20E315;
	Wed, 12 Feb 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368682; cv=none; b=NzbEEXIEf15r1E20WxLglIYeehqObNxBLQYmksPU+WJLk/m585kji2Iy/LghesK+kqRJCoFgttEV5F8vq71gxBnBiYsVT8GOGJMnIwNiNdpaQnVKqRWxuoFe/NCQZLeHmJYNWAUFV0fI04MdD2ojJfsa40XWgw9bwuhzMoU8RF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368682; c=relaxed/simple;
	bh=96pdxkWjw6GsLVtvNftdKd10yxyF39mB6biRnC42Ps4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVbiQ3UKoGXp8AGQSAg+69N/jE2HBPF6J2RohyJ4yskPj9UgDa6yeV8E7R678FaOQIoijgNl6oTl6xq7m6JCFCftsHlN3SxiMVa33Rmvl5m1S8M5mKYhnTpa1et8OPx5XPJjFPKYcl33MRr1CFAcFULglGGGrX0a7qA/DfXTxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbyeaJX5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739368681; x=1770904681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=96pdxkWjw6GsLVtvNftdKd10yxyF39mB6biRnC42Ps4=;
  b=nbyeaJX5ch9dNu3ABwc0Co7IgMmiTqMgnit9HXNCmb7ECkDzqiXuwwht
   S6zpV9eLcMlcSzmKDRuVDF6kLxxbatnbWqK8aB04kFWcjrhGo/NZy42k2
   tBV+eq72F0kxYWfwPeM+/jJMg8ie+sVXoREkGVTljaQqEc2m02xQqQpzb
   EUSwfht2W8o289ceE9C+/zO/Y0g/d2XDGpdItXRK3rARMc3Tw4aUqcubz
   jyu9vVeWVyersFVbW9DB5fepZIJSiOZcZ8YBi7UIZiZ6nM5dFcZmjWjse
   0bG0ZXCxPXFJDwmUW5CBoIOFSz+1JZgR2vNtcU+JAncqijHQADGdZDHl/
   w==;
X-CSE-ConnectionGUID: vDt1JB/NRUay7pN6os1fWQ==
X-CSE-MsgGUID: y+JegSPrTy6nMnhPyFQWTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40145853"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40145853"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 05:58:00 -0800
X-CSE-ConnectionGUID: RRVwHANLSeakNeJ9W2v9ow==
X-CSE-MsgGUID: e1wjcWhhQPWqIcbWUmrUxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112686345"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 12 Feb 2025 05:57:56 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiDFT-0015gJ-0T;
	Wed, 12 Feb 2025 13:57:55 +0000
Date: Wed, 12 Feb 2025 21:57:45 +0800
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
Message-ID: <202502122100.xnayNYRg-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on df5d6180169ae06a2eac57e33b077ad6f6252440]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpiolib-make-value-setters-have-return-values/20250211-201426
base:   df5d6180169ae06a2eac57e33b077ad6f6252440
patch link:    https://lore.kernel.org/r/20250211-gpio-set-retval-v1-1-52d3d613d7d3%40linaro.org
patch subject: [PATCH 01/14] gpiolib: make value setters have return values
config: sparc-randconfig-002-20250212 (https://download.01.org/0day-ci/archive/20250212/202502122100.xnayNYRg-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502122100.xnayNYRg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502122100.xnayNYRg-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/leds/leds-aw200xx.c: In function 'aw200xx_disable':
>> drivers/leds/leds-aw200xx.c:382:16: error: 'return' with a value, in function returning void [-Wreturn-mismatch]
     382 |         return gpiod_set_value_cansleep(chip->hwen, 0);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/leds/leds-aw200xx.c:380:13: note: declared here
     380 | static void aw200xx_disable(const struct aw200xx *const chip)
         |             ^~~~~~~~~~~~~~~


vim +/return +382 drivers/leds/leds-aw200xx.c

d882762f7950c3d Dmitry Rokosov 2023-11-25  379  
d882762f7950c3d Dmitry Rokosov 2023-11-25  380  static void aw200xx_disable(const struct aw200xx *const chip)
d882762f7950c3d Dmitry Rokosov 2023-11-25  381  {
d882762f7950c3d Dmitry Rokosov 2023-11-25 @382  	return gpiod_set_value_cansleep(chip->hwen, 0);
d882762f7950c3d Dmitry Rokosov 2023-11-25  383  }
d882762f7950c3d Dmitry Rokosov 2023-11-25  384  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

