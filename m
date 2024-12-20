Return-Path: <linux-pwm+bounces-4442-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC49F97E7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 18:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D60B1666E1
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 17:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8022D4C9;
	Fri, 20 Dec 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FHipeApC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52B22CBEB;
	Fri, 20 Dec 2024 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714778; cv=none; b=p4XeeOFnTruPXBjqol2s2yDdtQ7N+svIeCNqoXPyL3waKwEQlFAZVncoGC2L2DMcaHnYsMMejJ0k/iztZSNr4LWniAbAqukX4j/qI9QAghflSSugunnKjSiQzKYr0o6ou77LTPZVsa+tQBYwfHYll9V/wLUx26/K5/UralN47uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714778; c=relaxed/simple;
	bh=Qwmp8wqL9A+1QQCDa/upZTodhGWIHHVa7b1koKq2w0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJ/D8OV83HIrT+JVLqZ0jNqTzyPp9USsT3CdYLCaLTEQ2NwLvqbtbKrBajp08Xu0kGo8tNp0oMP7Ml1aT5rivFHf8HUoQeyW8uTpl+FDuuNK/1Q5qbECUPUgU2ZTldx/PkseCVVb8CMflhAEtHFHkHGih5HoBeBzrUyY1wgUuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FHipeApC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734714777; x=1766250777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qwmp8wqL9A+1QQCDa/upZTodhGWIHHVa7b1koKq2w0U=;
  b=FHipeApCThsC8JWN5W57zlBQo3qby6wWgh0T+l1z+q0zFztJC+zUJM+m
   vYFisPvq+hVD4MFh/02fD30M8Colg2HTS29yWlBnXKUEQk/7AfyKZGhM3
   i041AQeq3Kt0rmPnBRqyM633arWRZZ65hrTN9WmAMUqcYvoZmc1rbD++H
   Pkf9/jJ5FeYRrAVarH4/1MGK269Xw++vy4uXB4rfzgOtBCtvVu3hnmuRO
   eCkJ7CxPlXQ5NvP45MUq/GRyY69roWKn38wjh/c+QzK//ksELcjAqHRbC
   N/TGgsHI+ZmOcgqFFI3cz590KxLpAzaeBixzcJrJR5zYFKK5KuAVCFrHi
   A==;
X-CSE-ConnectionGUID: QbimFEhrRLa+oItTwu0WiQ==
X-CSE-MsgGUID: 1iWvkrRQRfWQOPu2FIWoJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="52793325"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="52793325"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 09:12:56 -0800
X-CSE-ConnectionGUID: 97ZJ116TSJuZWBgIdnOBcw==
X-CSE-MsgGUID: +aNlGvqQSGuGgXVkVow3bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103174620"
Received: from lkp-server01.sh.intel.com (HELO a46f226878e0) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Dec 2024 09:12:51 -0800
Received: from kbuild by a46f226878e0 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tOgYT-0001St-1C;
	Fri, 20 Dec 2024 17:12:49 +0000
Date: Sat, 21 Dec 2024 01:12:11 +0800
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
Subject: Re: [PATCH 6/8] input: keyboard: Add support for MAX7360 keypad
Message-ID: <202412210024.DavK6KEl-lkp@intel.com>
References: <20241219-mdb-max7360-support-v1-6-8e8317584121@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219-mdb-max7360-support-v1-6-8e8317584121@bootlin.com>

Hi Mathieu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-Add-MAX7360-MFD-device/20241220-002541
base:   78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
patch link:    https://lore.kernel.org/r/20241219-mdb-max7360-support-v1-6-8e8317584121%40bootlin.com
patch subject: [PATCH 6/8] input: keyboard: Add support for MAX7360 keypad
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20241221/202412210024.DavK6KEl-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241221/202412210024.DavK6KEl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412210024.DavK6KEl-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/keyboard/max7360-keypad.c:105:24: warning: implicit conversion from 'unsigned long' to 'unsigned int' changes value from 18446744073709551487 to 4294967167 [-Wconstant-conversion]
     104 |         ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
         |               ~~~~~~~~~~~~~~~~~
     105 |                                 MAX7360_CFG_SLEEP, ~MAX7360_CFG_SLEEP);
         |                                                    ^~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +105 drivers/input/keyboard/max7360-keypad.c

    95	
    96	static void max7360_keypad_close(struct input_dev *pdev)
    97	{
    98		struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
    99		int ret;
   100	
   101		/*
   102		 * Nobody is using the device anymore: go to sleep.
   103		 */
   104		ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
 > 105					MAX7360_CFG_SLEEP, ~MAX7360_CFG_SLEEP);
   106		if (ret) {
   107			dev_err(&max7360_keypad->input->dev,
   108				"Failed to write max7360 configuration");
   109		}
   110	}
   111	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

