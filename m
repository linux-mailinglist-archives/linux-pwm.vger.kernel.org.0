Return-Path: <linux-pwm+bounces-5063-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E67A4D781
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 10:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32553AED05
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A021FCD03;
	Tue,  4 Mar 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5YWoQqx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D51FBE8F;
	Tue,  4 Mar 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079302; cv=none; b=g1oQALgx/Wyp2B+RB2qWR4tE9r42gKkozON85TVc5GMPooq763BUjKdD/ZyHkuK5qOFjvHnpOXKJ9mbyvyxSHCfYRBtTxqHgnslpOTu35i7z7hkYk/OENXHTLPM8ZhoKuUd0bhZ3dg2ee93B8k7QwBaeZ9unVCl2rpqC8LIue0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079302; c=relaxed/simple;
	bh=GXuRz06hDfIRTVBK7Y7J5u3Fy/4jNuBeBSyafYInY64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/cZzi8OqTe4B9IAJukfVM6gzu6jtX1b65QCnwH4oVyB0LRBGfDzt5Y9mK/9srSp6HZUg9BEeOXetQs2QXURq8e8GKe88EVcRdaFeA+o7rebW5Sk1IlMTXYmIpbAb+U6OP9L+tyFzuLsNKphLhH5W0GCNV+FuQ/iiO0G14+L0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5YWoQqx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741079301; x=1772615301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GXuRz06hDfIRTVBK7Y7J5u3Fy/4jNuBeBSyafYInY64=;
  b=C5YWoQqxrFlXBnJEqCviSGlZtU8sxMyRIAW943RjN6TT4Bi21kWkOoq+
   AUEvs/KInq6bXX5ztwZpcNd8KE4QTpT2r2SAhUtiXcgziNnoQw58KBVZt
   QZOAxmtwCGtrVetQKwwGQG7epPV9V4a+7ee+YMRP+fuCJqqO2FcMr4QVq
   dPJq3kFf0bJ9rPzsyRKoj9IaM2H+9a1ZtMlRS8mYTtYOtgdthKrrF8OEZ
   kA3eAi1Yxf96TABpxbzniUcw0/BiqmQWvZ7nCfCdyhXr3ktREU8hWxIhi
   whQWkf8boBjYSuUUSpA1rcIZjjRx9Vq7PwEd3KwgG/2I3lkY2K050TRtT
   Q==;
X-CSE-ConnectionGUID: Mpr7xC91TPevwqb2m+Q6sw==
X-CSE-MsgGUID: e4DmfpB+R/majPQjySI6hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53391440"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53391440"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:08:20 -0800
X-CSE-ConnectionGUID: WsdSvD8kQSqq8xlLa15QJg==
X-CSE-MsgGUID: wBNumz0fSaSG5Y1WNX0q2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119230033"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Mar 2025 01:08:16 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpOG5-000JWI-26;
	Tue, 04 Mar 2025 09:08:13 +0000
Date: Tue, 4 Mar 2025 17:07:44 +0800
From: kernel test robot <lkp@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mun Yew Tham <mun.yew.tham@intel.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, patches@opensource.cirrus.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 02/15] gpio: adnp: use lock guards for the I2C lock
Message-ID: <202503041612.G8O0Bdrg-lkp@intel.com>
References: <20250303-gpiochip-set-conversion-v1-2-1d5cceeebf8b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-gpiochip-set-conversion-v1-2-1d5cceeebf8b@linaro.org>

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9778568dede2166c7bd124d473f9ec365f782935]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-74x164-use-new-line-value-setter-callbacks/20250303-212738
base:   9778568dede2166c7bd124d473f9ec365f782935
patch link:    https://lore.kernel.org/r/20250303-gpiochip-set-conversion-v1-2-1d5cceeebf8b%40linaro.org
patch subject: [PATCH 02/15] gpio: adnp: use lock guards for the I2C lock
config: x86_64-buildonly-randconfig-001-20250304 (https://download.01.org/0day-ci/archive/20250304/202503041612.G8O0Bdrg-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503041612.G8O0Bdrg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503041612.G8O0Bdrg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpio-adnp.c:241:8: warning: variable 'isr' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     241 |                         if (err < 0)
         |                             ^~~~~~~
   drivers/gpio/gpio-adnp.c:265:14: note: uninitialized use occurs here
     265 |                 pending &= isr & ier;
         |                            ^~~
   drivers/gpio/gpio-adnp.c:241:4: note: remove the 'if' if its condition is always false
     241 |                         if (err < 0)
         |                         ^~~~~~~~~~~~
     242 |                                 continue;
         |                                 ~~~~~~~~
   drivers/gpio/gpio-adnp.c:235:25: note: initialize the variable 'isr' to silence this warning
     235 |                 u8 changed, level, isr, ier;
         |                                       ^
         |                                        = '\0'
>> drivers/gpio/gpio-adnp.c:245:8: warning: variable 'ier' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     245 |                         if (err < 0)
         |                             ^~~~~~~
   drivers/gpio/gpio-adnp.c:265:20: note: uninitialized use occurs here
     265 |                 pending &= isr & ier;
         |                                  ^~~
   drivers/gpio/gpio-adnp.c:245:4: note: remove the 'if' if its condition is always false
     245 |                         if (err < 0)
         |                         ^~~~~~~~~~~~
     246 |                                 continue;
         |                                 ~~~~~~~~
   drivers/gpio/gpio-adnp.c:241:8: warning: variable 'ier' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     241 |                         if (err < 0)
         |                             ^~~~~~~
   drivers/gpio/gpio-adnp.c:265:20: note: uninitialized use occurs here
     265 |                 pending &= isr & ier;
         |                                  ^~~
   drivers/gpio/gpio-adnp.c:241:4: note: remove the 'if' if its condition is always false
     241 |                         if (err < 0)
         |                         ^~~~~~~~~~~~
     242 |                                 continue;
         |                                 ~~~~~~~~
   drivers/gpio/gpio-adnp.c:235:30: note: initialize the variable 'ier' to silence this warning
     235 |                 u8 changed, level, isr, ier;
         |                                            ^
         |                                             = '\0'
   3 warnings generated.


vim +241 drivers/gpio/gpio-adnp.c

   225	
   226	static irqreturn_t adnp_irq(int irq, void *data)
   227	{
   228		struct adnp *adnp = data;
   229		unsigned int num_regs, i;
   230	
   231		num_regs = 1 << adnp->reg_shift;
   232	
   233		for (i = 0; i < num_regs; i++) {
   234			unsigned int base = i << adnp->reg_shift, bit;
   235			u8 changed, level, isr, ier;
   236			unsigned long pending;
   237			int err;
   238	
   239			scoped_guard(mutex, &adnp->i2c_lock) {
   240				err = adnp_read(adnp, GPIO_PLR(adnp) + i, &level);
 > 241				if (err < 0)
   242					continue;
   243	
   244				err = adnp_read(adnp, GPIO_ISR(adnp) + i, &isr);
 > 245				if (err < 0)
   246					continue;
   247	
   248				err = adnp_read(adnp, GPIO_IER(adnp) + i, &ier);
   249				if (err < 0)
   250					continue;
   251			}
   252	
   253			/* determine pins that changed levels */
   254			changed = level ^ adnp->irq_level[i];
   255	
   256			/* compute edge-triggered interrupts */
   257			pending = changed & ((adnp->irq_fall[i] & ~level) |
   258					     (adnp->irq_rise[i] & level));
   259	
   260			/* add in level-triggered interrupts */
   261			pending |= (adnp->irq_high[i] & level) |
   262				   (adnp->irq_low[i] & ~level);
   263	
   264			/* mask out non-pending and disabled interrupts */
   265			pending &= isr & ier;
   266	
   267			for_each_set_bit(bit, &pending, 8) {
   268				unsigned int child_irq;
   269				child_irq = irq_find_mapping(adnp->gpio.irq.domain,
   270							     base + bit);
   271				handle_nested_irq(child_irq);
   272			}
   273		}
   274	
   275		return IRQ_HANDLED;
   276	}
   277	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

