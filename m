Return-Path: <linux-pwm+bounces-5250-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8538FA6950A
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 17:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A362189DE3A
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6591DE881;
	Wed, 19 Mar 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRHYq0R9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094F1C726D;
	Wed, 19 Mar 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742401905; cv=none; b=NFxHGZKUtMN0bbSQgn8+bXJlX9Dw770GDB4+PejaLRQ+GAF62ykDmuOzmxTw5e+O0fk66ZVI5MLacE6AFmsDRdlaUGm57e6TL5E4gn3jxyKzhsWcqPoMVN4RGjBljorgNsH19weDVD/72ZeKK6ezCxI4hqRZQQxBb0UPjMeC2b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742401905; c=relaxed/simple;
	bh=5TJ0rtcSY5de4do08OX/lkAVedG/eYjSVbj4z4U3TjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUIj3pnI8gnf0kfDTkuvVXcme9XMQZqYwUe1kx6p8lAC8U0E8JNhgfW6Ajr5Vnsbpb4nfmgfV2kxltKco4bpOGp9R/zCMowecUlnUz0c+deyQJ2L7uPPUApHZ15L37GMRVkEnJboTZgyOu9LSLI+4N4z1LYKWcPQf92nFesUE8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRHYq0R9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742401905; x=1773937905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5TJ0rtcSY5de4do08OX/lkAVedG/eYjSVbj4z4U3TjU=;
  b=BRHYq0R96w7UOiqRohwGFOTQcpybRUebNoq4MljFhQToaBNe2RYlFuSv
   y4JtD8Z1KCjhxPHxpDQJ+YnntN4UZBR7JsGrrc6VykZsmbtqiYbSUkgbC
   EMs6c7syjKJb05HYqug5d3UEkAG8k47w8OEfUHKeKHKwmz9D+XtG6/20C
   qrRfmbbE7iou2UNzY/KP1zN7H7FbaNdk4mDKBvOhcGrht0uRWjarim5QV
   QvhdaiGbGP3wPhScNKnDfEsTBWRYnqiqCyXXMU5uCe1QJw+sKue5/9iuD
   unzvY94p3AJVN88YyeKsBlVzDUZWf3855SdTlLWDpMq4cDUPRtfOuloDw
   Q==;
X-CSE-ConnectionGUID: MdEmPuusTl+m5WSIneVFdg==
X-CSE-MsgGUID: AsUf4cPDT7ObulZBQpGZww==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43522556"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43522556"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 09:31:44 -0700
X-CSE-ConnectionGUID: pJHe7nX9Qwe7Wi4H8O6+gA==
X-CSE-MsgGUID: 6VOIypOxRoms1ZnQK1Q4qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123204650"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 19 Mar 2025 09:31:38 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuwKN-000FWY-1w;
	Wed, 19 Mar 2025 16:31:35 +0000
Date: Thu, 20 Mar 2025 00:31:16 +0800
From: kernel test robot <lkp@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH v5 10/11] input: misc: Add support for MAX7360 rotary
Message-ID: <202503192326.KOCnEkdj-lkp@intel.com>
References: <20250318-mdb-max7360-support-v5-10-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-10-fb20baf97da0@bootlin.com>

Hi Mathieu,

kernel test robot noticed the following build errors:

[auto build test ERROR on a64dcfb451e254085a7daee5fe51bf22959d52d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-mfd-gpio-Add-MAX7360/20250319-003750
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250318-mdb-max7360-support-v5-10-fb20baf97da0%40bootlin.com
patch subject: [PATCH v5 10/11] input: misc: Add support for MAX7360 rotary
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503192326.KOCnEkdj-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192326.KOCnEkdj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192326.KOCnEkdj-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/input/misc/max7360-rotary.c: In function 'max7360_rotary_hw_init':
>> drivers/input/misc/max7360-rotary.c:58:8: error: implicit declaration of function 'FIELD_PREP'; did you mean 'EV_REP'? [-Werror=implicit-function-declaration]
     val = FIELD_PREP(MAX7360_ROT_DEBOUNCE, max7360_rotary->debounce_ms) |
           ^~~~~~~~~~
           EV_REP
   cc1: some warnings being treated as errors


vim +58 drivers/input/misc/max7360-rotary.c

    52	
    53	static int max7360_rotary_hw_init(struct max7360_rotary *max7360_rotary)
    54	{
    55		int val;
    56		int ret;
    57	
  > 58		val = FIELD_PREP(MAX7360_ROT_DEBOUNCE, max7360_rotary->debounce_ms) |
    59			FIELD_PREP(MAX7360_ROT_INTCNT, 1) | MAX7360_ROT_INTCNT_DLY;
    60		ret = regmap_write(max7360_rotary->regmap, MAX7360_REG_RTRCFG, val);
    61		if (ret) {
    62			dev_err(&max7360_rotary->input->dev,
    63				"Failed to set max7360 rotary encoder configuration\n");
    64			return ret;
    65		}
    66	
    67		return 0;
    68	}
    69	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

