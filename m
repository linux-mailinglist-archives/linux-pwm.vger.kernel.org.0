Return-Path: <linux-pwm+bounces-3072-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C155496767C
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Sep 2024 14:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6671F21CED
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Sep 2024 12:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A244117DFFA;
	Sun,  1 Sep 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DKEn9Pco"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F7817CA1B;
	Sun,  1 Sep 2024 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194869; cv=none; b=JsAb+3kAt6XAUTgbasNk6S15oInABCRZRUTb/PHkKeyqKM6l5jAvuYtOc3pGGprX80EaI0ljzHX6rimNkBu8QLQ7zGqzi+sLgWWOooZ9xQW5j4ZSgstLmMQ2/4b2C6Zdn3fj36fFG/e6Ph1MVl4BAmUk1QiIbpV+SLy5N8IXUUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194869; c=relaxed/simple;
	bh=KXwHXFoVbUQo0mmA9L6Z11g75Iq0m11E3mtjvkPEV3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/hy2hPV7pvP3/X12Zy8mHIuc/Rp/5t7Dix9wOFns7TF4JXQ59OamYSVvjjpba4fU4NmvlAuUEphOAlcTU5LamQd+7nQ2aj0X0KTBO5mvWdTA6CiPPUpyNX6EhlTk2tchUJnt6gGaSeH2JCv49o0KYxfXvKvy5fQdmBmMfNb9ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DKEn9Pco; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725194868; x=1756730868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KXwHXFoVbUQo0mmA9L6Z11g75Iq0m11E3mtjvkPEV3M=;
  b=DKEn9PcoEgsFgN5jXxPOOlIxHkQdEKEusb4r3RI3vLiVLb8xDuGjIi1k
   hdSoECYDyRH0E463Yu9aDD2xB0bURIZNQu1mSkIqQqVXPznfu5KzhQ1Mn
   ufVSAzZRI1JSMCbMQ1RgJ8YoAXzQuFHn/dfvq7rYcEj/vE5FKrVd2W/Of
   4CyHJpCZt+0WhQq/FjXVfgjMvfgVVMSwkNwlTrehqwXUk81Sn50oDmU3q
   R0JPDylX85dWjII109I2KHdpWUcI7hlt0NZKRkl9UJbn2AgJxhCq7J0S7
   felfkbB0lNFqWFjmsFmTPMI6o31NBK4nopBWNaOABlEzXjLgTjqw+28FK
   w==;
X-CSE-ConnectionGUID: IrJjNvFHRXyyP0JMIFf4/w==
X-CSE-MsgGUID: NtGbxCZPSGGVXZA+ZkNzRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="13318153"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="13318153"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 05:47:47 -0700
X-CSE-ConnectionGUID: qEuxH4RrTvO4hmLSQ1NkKw==
X-CSE-MsgGUID: JvFphALFQW66W/hQzhpDaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="68739433"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 01 Sep 2024 05:47:43 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skjzZ-0003dq-0C;
	Sun, 01 Sep 2024 12:47:41 +0000
Date: Sun, 1 Sep 2024 20:46:43 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	benjamin.larsson@genexis.eu, ansuelsmth@gmail.com,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/5] pinctrl: airoha: Add support for EN7581 SoC
Message-ID: <202409012015.isPMHBiL-lkp@intel.com>
References: <20240831-en7581-pinctrl-v3-4-98eebfb4da66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831-en7581-pinctrl-v3-4-98eebfb4da66@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on defaf1a2113a22b00dfa1abc0fd2014820eaf065]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-arm-airoha-Add-the-chip-scu-node-for-EN7581-SoC/20240831-222958
base:   defaf1a2113a22b00dfa1abc0fd2014820eaf065
patch link:    https://lore.kernel.org/r/20240831-en7581-pinctrl-v3-4-98eebfb4da66%40kernel.org
patch subject: [PATCH v3 4/5] pinctrl: airoha: Add support for EN7581 SoC
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240901/202409012015.isPMHBiL-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409012015.isPMHBiL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409012015.isPMHBiL-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/ch341.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb_debug.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/mxuport.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/navman.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/qcaux.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/usb-serial-simple.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/usb/serial/symbolserial.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_simpleondemand.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_powersave.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-aspeed.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-ast-cf.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-scom.o
>> ERROR: modpost: "__ffsdi2" [drivers/pinctrl/mediatek/pinctrl-airoha.ko] undefined!
ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
ERROR: modpost: "devm_of_clk_add_hw_provider" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "devm_clk_hw_register" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "of_clk_hw_simple_get" [drivers/media/i2c/tc358746.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

