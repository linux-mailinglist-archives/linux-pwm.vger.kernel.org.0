Return-Path: <linux-pwm+bounces-4440-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4469F95DD
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 16:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26535167A68
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D6D218EA8;
	Fri, 20 Dec 2024 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MMV73hYt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC38216397;
	Fri, 20 Dec 2024 15:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734710089; cv=none; b=pKzlaQ1be8JEWkwsAGMWm7etPoqmoeYmEL0P3NRDa0XULm8s9zh8Q5Wc2w7T96AuSJIUGvsLyOV3/gQvBKc08XgyvT7hX6PjI2Oyab0QtV90iTy8p/eT7jPmWU/b55C2zRUty27Ms947Jmq5ekzD6UST45IQv5Qa2Lj0KKvhtaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734710089; c=relaxed/simple;
	bh=nBCegtq0A5NfOXgKUOhNhCAdUczJYCehEj8+f1RmnXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUglM5KmFApbCxmtme8/iDegPe3ipwUYLyRQSJApr3E1Q0McG3Tq4LJx72ykfkafMATHa+MqAjzlLaa8B12lyafxK8s1kP4D9YK0jmDRQYXfGGtDOKFmh/FPzLBucBI5jDnHILvjfnbSj98H+guiGW2EOoS36TDiwCoEMi+M7l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MMV73hYt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734710087; x=1766246087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nBCegtq0A5NfOXgKUOhNhCAdUczJYCehEj8+f1RmnXY=;
  b=MMV73hYtvK4oR6hzBzJRKlICAak7zzmIhaGaR4ktnmAZ7ZOU5BuwwKg6
   zapF0JFVkabwoppUCaqbzuoJTiWZtFQbRVf8xH2jnYy8PbJV/FJG4+UO7
   8aW/ZjfmGmJqe9oKv2cXgULgxAeSm0npGTVlQKEUtSquJqbwgqHz5VQQI
   Nl+N1JR7j8cOEKo7q63JCuavwekZ8o1FiIL3ZVmRLFsJzbfMM6hL1CLUE
   LTh+YyaTnhJLGx1xTPlLECT9wOkXTxbbO1fL4G6eWbU2iyXLSQVIb0JxJ
   upirvbJfcpcOWVfBjLG/dYGmXoYjogyUE4byo/aNowu2syiUtaD1q8xgC
   w==;
X-CSE-ConnectionGUID: T53sJChwQDWv6KkKUU2HGQ==
X-CSE-MsgGUID: O55e9k4sTMqF/zPhzBXfwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46269703"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46269703"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 07:54:46 -0800
X-CSE-ConnectionGUID: 5jkc7+XRS2S1jemaFJJbBw==
X-CSE-MsgGUID: kb9btt2NQViRmPqhqw+FLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="98603535"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 20 Dec 2024 07:54:42 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOfKp-0001MN-2E;
	Fri, 20 Dec 2024 15:54:39 +0000
Date: Fri, 20 Dec 2024 23:54:33 +0800
From: kernel test robot <lkp@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH 5/8] gpio: max7360: Add MAX7360 gpio support
Message-ID: <202412202337.8jOygMaK-lkp@intel.com>
References: <20241219-mdb-max7360-support-v1-5-8e8317584121@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-mdb-max7360-support-v1-5-8e8317584121@bootlin.com>

Hi Mathieu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-Add-MAX7360-MFD-device/20241220-002541
base:   78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
patch link:    https://lore.kernel.org/r/20241219-mdb-max7360-support-v1-5-8e8317584121%40bootlin.com
patch subject: [PATCH 5/8] gpio: max7360: Add MAX7360 gpio support
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20241220/202412202337.8jOygMaK-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241220/202412202337.8jOygMaK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412202337.8jOygMaK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpio/gpio-max7360.c:57:41: warning: variable 'val' is uninitialized when used here [-Wuninitialized]
      57 |                         "failed to set value %d on gpio-%d", val, pin);
         |                                                              ^~~
   include/linux/dev_printk.h:154:65: note: expanded from macro 'dev_err'
     154 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                                        ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                                     ^~~~~~~~~~~
   drivers/gpio/gpio-max7360.c:42:18: note: initialize the variable 'val' to silence this warning
      42 |         unsigned int val;
         |                         ^
         |                          = 0
>> drivers/gpio/gpio-max7360.c:370:32: warning: cast to smaller integer type 'int' from 'const void *' [-Wvoid-pointer-to-int-cast]
     370 |         max7360_gpio->gpio_function = (int)device_get_match_data(&pdev->dev);
         |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.


vim +370 drivers/gpio/gpio-max7360.c

   333	
   334	static int max7360_gpio_probe(struct platform_device *pdev)
   335	{
   336		struct max7360_gpio *max7360_gpio;
   337		unsigned int ngpios;
   338		unsigned int outconf;
   339		struct gpio_irq_chip *girq;
   340		unsigned long flags;
   341		int irq;
   342		int ret;
   343	
   344		if (!pdev->dev.parent) {
   345			dev_err(&pdev->dev, "no parent device\n");
   346			return -ENODEV;
   347		}
   348	
   349		max7360_gpio = devm_kzalloc(&pdev->dev, sizeof(struct max7360_gpio),
   350					    GFP_KERNEL);
   351		if (!max7360_gpio)
   352			return -ENOMEM;
   353	
   354		if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
   355			dev_err(&pdev->dev, "Missing ngpios OF property\n");
   356			return -ENODEV;
   357		}
   358	
   359		max7360_gpio->regmap = dev_get_regmap(pdev->dev.parent, NULL);
   360		if (!max7360_gpio->regmap) {
   361			dev_err(&pdev->dev, "could not get parent regmap\n");
   362			return -ENODEV;
   363		}
   364	
   365		max7360_gpio->dev = &pdev->dev;
   366		max7360_gpio->chip = max7360_gpio_chip;
   367		max7360_gpio->chip.ngpio = ngpios;
   368		max7360_gpio->chip.parent = &pdev->dev;
   369		max7360_gpio->chip.base = -1;
 > 370		max7360_gpio->gpio_function = (int)device_get_match_data(&pdev->dev);
   371	
   372		dev_dbg(&pdev->dev, "gpio count: %d\n", max7360_gpio->chip.ngpio);
   373	
   374		if (max7360_gpio->gpio_function == MAX7360_GPIO_PORT) {
   375			/* Port GPIOs: set output mode configuration (constant-current
   376			 * or not).
   377			 * This property is optional.
   378			 */
   379			outconf = 0;
   380			ret = of_property_read_u32(pdev->dev.of_node,
   381						   "constant-current-disable", &outconf);
   382			if (ret && (ret != -EINVAL)) {
   383				dev_err(&pdev->dev,
   384					"Failed to read constant-current-disable OF property\n");
   385				return -ENODEV;
   386			}
   387	
   388		    regmap_write(max7360_gpio->regmap, MAX7360_REG_GPIOOUTM, outconf);
   389		}
   390	
   391		if (max7360_gpio->gpio_function == MAX7360_GPIO_PORT &&
   392		    of_property_read_bool(pdev->dev.of_node, "interrupt-controller")) {
   393			/* Port GPIOs: declare IRQ chip, if configuration was provided.
   394			 */
   395			irq = platform_get_irq(pdev, 0);
   396			if (irq < 0)
   397				return dev_err_probe(&pdev->dev, irq,
   398						     "Failed to get IRQ");
   399	
   400			flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
   401			ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
   402							max7360_gpio_irq, flags,
   403							"max7360-gpio", max7360_gpio);
   404			if (ret)
   405				return dev_err_probe(&pdev->dev, ret,
   406						     "Failed to register interrupt: %d\n",
   407						     ret);
   408	
   409			girq = &max7360_gpio->chip.irq;
   410			gpio_irq_chip_set_chip(girq, &max7360_gpio_irqchip);
   411			girq->parent_handler = NULL;
   412			girq->num_parents = 0;
   413			girq->parents = NULL;
   414			girq->threaded = true;
   415			girq->default_type = IRQ_TYPE_NONE;
   416			girq->handler = handle_simple_irq;
   417		}
   418	
   419		ret = devm_gpiochip_add_data(&pdev->dev, &max7360_gpio->chip, max7360_gpio);
   420		if (ret) {
   421			dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
   422			return ret;
   423		}
   424	
   425		return 0;
   426	}
   427	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

