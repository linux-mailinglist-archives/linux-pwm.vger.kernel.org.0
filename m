Return-Path: <linux-pwm+bounces-4441-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B229F96C2
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 17:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8E81887800
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCD221A45E;
	Fri, 20 Dec 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYxnbT1v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECAC21A435;
	Fri, 20 Dec 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712795; cv=none; b=WXVUn8hlEV6pX5eWuk72CbDo0CTEiA/pGKcCiGY2G3tJ3FroALQFHJAK4voZn0pBtEKJzEta2msIVX5z6XXoV+xxyMsnJ7defJF0VOiP15smbWgzKwmNFGDtNf75I7JeWMG4xJAJZ/w3t9JRwkze33L5cgneCn7lLRb2OFe3JYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712795; c=relaxed/simple;
	bh=kmsROndDbyH8jm99K4jfljVJ484U72MZR37Sb/BMsQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8pD04GbHlZMwBcupLocXjd6NzSQx+XzJydL8JAL9b/5ZbM2Bpkjqn0fvczRP/ycmPmFb4pD9PlWfNu4Z4i9TQQhnesFH9Yeg1+TMtsge4OqCLzi63qMWy+8vQ6rPaHpyOcZbsjX7udJr8iyJZ1Osbg2LAMUqLvZOrQ4dwHw2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYxnbT1v; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734712793; x=1766248793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kmsROndDbyH8jm99K4jfljVJ484U72MZR37Sb/BMsQY=;
  b=gYxnbT1vlmjTk3KHjccsIEt8J3IfcQ3cJaItqy7BXucjh9E5GmJojyYT
   7eBIAAAycXjrLcbJfvn9As2M5b8B68yl26YE7hFaHNzrspy0HVy6VrVhc
   FFN0oZwbpxgYjazdKg7fxu8sPcPp8DOXOy3LCwtVaB4+k+aKaPRdw69M3
   4UzKJywUmLk5WMvqeRYLqLVwsiFdYBjRD/3ka1anSx320v2cktsEA6Mw6
   MvH6gVPRSbovsTwGRWQL5QjyhvV72Q4Pv9QkcezoL3uynno4SrWya+pmS
   gi/MRgqwxMlsexbeyqbkIaPYw27nReMrhWMyppc6aoMNfOTJVKr/KGSW1
   Q==;
X-CSE-ConnectionGUID: BcOW1sFRTNSqKKdHTNxeiA==
X-CSE-MsgGUID: 9UN2vs4JRmGT3ORL3j5Ldg==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="35295812"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="35295812"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 08:39:51 -0800
X-CSE-ConnectionGUID: jCunitGgQ7CFeHp3hEWc9Q==
X-CSE-MsgGUID: W/NJ3R13Q3atZN3br0ax1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="98386684"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Dec 2024 08:39:48 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOg2T-0001QB-2p;
	Fri, 20 Dec 2024 16:39:45 +0000
Date: Sat, 21 Dec 2024 00:39:08 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH 5/8] gpio: max7360: Add MAX7360 gpio support
Message-ID: <202412210008.Saks0Eu4-lkp@intel.com>
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
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241221/202412210008.Saks0Eu4-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241221/202412210008.Saks0Eu4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412210008.Saks0Eu4-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/gpio/gpio-max7360.c: In function 'max7360_gpio_probe':
>> drivers/gpio/gpio-max7360.c:370:39: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     370 |         max7360_gpio->gpio_function = (int)device_get_match_data(&pdev->dev);
         |                                       ^


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

