Return-Path: <linux-pwm+bounces-7770-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD02CAA86E
	for <lists+linux-pwm@lfdr.de>; Sat, 06 Dec 2025 15:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 329C43033729
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Dec 2025 14:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE7C2F9DB2;
	Sat,  6 Dec 2025 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG0KP76J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0582E199FBA;
	Sat,  6 Dec 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765031103; cv=none; b=QTNpnhJl/kF7rCewc1gvLng080Lu9pg+yccBSGknKyLxB4/jTcwwbY+ZxuqcYx9jTzCbkJIr3dLFZGVWOVS4T/OCZuQV1d9lfUe5R5xRu9EAk92GQ2NcXPOepI6vrCWflED3xu1bWZWyK9BJSb6QKX1pEYYkt0Wt4PTazd9sXXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765031103; c=relaxed/simple;
	bh=rhJy0MuZoX1IN0c3VNkXR9OgQWBNKyzexnJsWC4tqmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jW+vcjcqtAXIMbEqMMPkzXkp/ycr5Gyvu1pCbQg3YmcK9BjoFQ8EKBfGQqc5+bVX5L67FI17Fy+yhtpJBnrl+qoBgERN8JGq6myKZa4/0qNd17TOsrk0ycC/blQTtcNGeQmC1i7NRp0/2kHmjSn3Z5w95JqfDWDV2l3L9ZgMaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG0KP76J; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765031102; x=1796567102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rhJy0MuZoX1IN0c3VNkXR9OgQWBNKyzexnJsWC4tqmk=;
  b=MG0KP76JFA0fi4G+ZjZ9VYFvMTG2TsPPLJhpdavNfiUzHhPKDmz2y4UA
   8pvk1eF46Nazr482y9pWioqxFJiiENSQaPfI9eJYjqrBJG01wvLgE6zg+
   XmLy4RSFW5ONp3dNre1centzm2WoPdTxYT121/w9lK29ttITAM43XSF8R
   62lvaYbZUSW24F/K33omMbF2MRLwHgXXGM9pmEsPn9BBQ0124VZloWetQ
   Xhfh3NrQkaqpCxzpHd6I0dA9d21IeSl1h085gfau0dyAwatT1iC/req3n
   jJ2NldcW5YPwEqyCz4sk4fjyQZszEm0rRqBsg+0SCAQIKz8j5NIzdzJgC
   g==;
X-CSE-ConnectionGUID: iNNEAcddSiOtbpZ4a9e3pQ==
X-CSE-MsgGUID: Z1lwnMGDSvyVCb/MHYDReA==
X-IronPort-AV: E=McAfee;i="6800,10657,11634"; a="66041583"
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="66041583"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2025 06:25:01 -0800
X-CSE-ConnectionGUID: fBohExo1RaaxqdrSlmEprQ==
X-CSE-MsgGUID: leGyjN9HS1KwkpMGCoe/dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,255,1758610800"; 
   d="scan'208";a="199982689"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 Dec 2025 06:24:58 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRtDT-00000000IEv-25PT;
	Sat, 06 Dec 2025 14:24:55 +0000
Date: Sat, 6 Dec 2025 22:24:34 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Genoud <richard.genoud@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [PATCH 2/4] pwm: sun50i: Add H616 PWM support
Message-ID: <202512062245.KFjCln1y-lkp@intel.com>
References: <20251205100239.1563353-3-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205100239.1563353-3-richard.genoud@bootlin.com>

Hi Richard,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6987d58a9cbc5bd57c983baa514474a86c945d56]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Genoud/dt-bindings-pwm-sunxi-add-PWM-controller-for-Allwinner-H616/20251205-214804
base:   6987d58a9cbc5bd57c983baa514474a86c945d56
patch link:    https://lore.kernel.org/r/20251205100239.1563353-3-richard.genoud%40bootlin.com
patch subject: [PATCH 2/4] pwm: sun50i: Add H616 PWM support
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20251206/202512062245.KFjCln1y-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251206/202512062245.KFjCln1y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512062245.KFjCln1y-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pwm/pwm-sun50i-h616.c: In function 'h616_pwm_get_state':
>> drivers/pwm/pwm-sun50i-h616.c:76:41: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
      76 | #define PWM_REG_DUTY(reg)               FIELD_GET(PWM_DUTY_MASK, reg)
         |                                         ^~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c:452:30: note: in expansion of macro 'PWM_REG_DUTY'
     452 |         tmp = NSEC_PER_SEC * PWM_REG_DUTY(val);
         |                              ^~~~~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c: In function 'h616_pwm_calc':
>> drivers/pwm/pwm-sun50i-h616.c:79:41: error: implicit declaration of function 'FIELD_MAX' [-Wimplicit-function-declaration]
      79 | #define PWM_PERIOD_MAX                  FIELD_MAX(PWM_PERIOD_MASK)
         |                                         ^~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c:493:54: note: in expansion of macro 'PWM_PERIOD_MAX'
     493 |                 freq = div64_u64(NSEC_PER_SEC * (u64)PWM_PERIOD_MAX, period);
         |                                                      ^~~~~~~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c: In function 'h616_pwm_apply':
>> drivers/pwm/pwm-sun50i-h616.c:78:41: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
      78 | #define PWM_DUTY(dty)                   FIELD_PREP(PWM_DUTY_MASK, dty)
         |                                         ^~~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c:577:23: note: in expansion of macro 'PWM_DUTY'
     577 |                 val = PWM_DUTY(chan->active_cycles);
         |                       ^~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c: In function 'h616_add_composite_clk':
   drivers/pwm/pwm-sun50i-h616.c:666:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     666 |                 mux->reg = (u64)mux->reg + reg;
         |                            ^
   drivers/pwm/pwm-sun50i-h616.c:676:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     676 |                 gate->reg = (u64)gate->reg + reg;
         |                             ^
   drivers/pwm/pwm-sun50i-h616.c:686:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     686 |                 rate->reg = (u64)rate->reg + reg;
         |                             ^


vim +/FIELD_GET +76 drivers/pwm/pwm-sun50i-h616.c

    70	
    71	/* PWM Period Register */
    72	#define PWM_PERIOD_REG(ch)		(0x64 + (ch) * 0x20)
    73	#define PWM_PERIOD_MASK			GENMASK(31, 16)
    74	#define PWM_DUTY_MASK			GENMASK(15, 0)
    75	#define PWM_REG_PERIOD(reg)		(FIELD_GET(PWM_PERIOD_MASK, reg) + 1)
  > 76	#define PWM_REG_DUTY(reg)		FIELD_GET(PWM_DUTY_MASK, reg)
    77	#define PWM_PERIOD(prd)			FIELD_PREP(PWM_PERIOD_MASK, (prd) - 1)
  > 78	#define PWM_DUTY(dty)			FIELD_PREP(PWM_DUTY_MASK, dty)
  > 79	#define PWM_PERIOD_MAX			FIELD_MAX(PWM_PERIOD_MASK)
    80	
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

