Return-Path: <linux-pwm+bounces-3039-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728EB956084
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 02:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA46E1C20D90
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 00:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5C6DDC3;
	Mon, 19 Aug 2024 00:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vv+HInz3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704D012B8B;
	Mon, 19 Aug 2024 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724026822; cv=none; b=YE7PvugimNRK0vi5e+er4iJqiqTUC9ET3hYYKvWz5tnPhFoq7AvlYair5FGmWulljKlpf+9Oc9tPvUCZOeGso2HvzVhHbyZUFH3T0MyBgdRSbVw76yFuWjyPX3wnQQdrRGvkGp0mdWj17Bb8ZZ+XMIgJNcVjkg1tdQKdYpdPSOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724026822; c=relaxed/simple;
	bh=8/7h4yWUHLOS3Dxz4kcPx6UmWCCvIANrAv7OszQXFl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USZvoYXlL5IxaVrDy4QggYUDyHDhT4rCY5dHSPe46S6OnR9edXOO6mbAsNlAt2lwRdAMQcL+lRygTNp3TyOZPdH9oL3gNFnkmfP8U+VqwP404j+5eYxajxGyig6joKTPSqr2IezTKqHBitVVxWmtvY3tOKjgBNziedCwaWhnAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vv+HInz3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724026819; x=1755562819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/7h4yWUHLOS3Dxz4kcPx6UmWCCvIANrAv7OszQXFl4=;
  b=Vv+HInz3dhDiwOaxCHSFAHuYxMPOK8Nvq/BlNuHOBzlU5J06lR4SwejJ
   7xUe/6ED4B5S9BEihKL26pCwMHcW67s/BbKlxd/3QZ70yqVzycScao+gy
   4EjJyDLYUVUFUE+LUnzJZzxB2CdvYApp85Tq0UXxBAW+mZerEmYRdSSlx
   fo5jwxiwYhJSQkM3DfwbP/WabKulQrKqvu3450BYR3w8qV4pAnx6A/vKC
   V/aID/t6Uc1N3bW4g9XJpQlMjd/LhrkaNIlQTbq6GXzN/5UXY+HwxGK+V
   t8zFF24Li4Z5d1RjPbIBN9Eg8N65a6nbkksxwQpghDT0TCLiNd9Lg8t+e
   A==;
X-CSE-ConnectionGUID: sYDR52zwQR6j6jV3CN8vjg==
X-CSE-MsgGUID: 7rqBbsAYTwyZVmE/DxQ1/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22423671"
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="22423671"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 17:20:19 -0700
X-CSE-ConnectionGUID: IedP3kaBTFmPOtbx9vzvew==
X-CSE-MsgGUID: cDI/KTFSTDuHTPB6J4XmlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="83428527"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 18 Aug 2024 17:20:15 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfq85-0008WU-21;
	Mon, 19 Aug 2024 00:20:13 +0000
Date: Mon, 19 Aug 2024 08:19:42 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v3 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <202408190759.z1PdIIZb-lkp@intel.com>
References: <20240818-airoha-pwm-drv-v3-2-e398f3e41916@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818-airoha-pwm-drv-v3-2-e398f3e41916@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8400291e289ee6b2bf9779ff1c83a291501f017b]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-pwm-Document-Airoha-EN7581-PWM/20240818-200409
base:   8400291e289ee6b2bf9779ff1c83a291501f017b
patch link:    https://lore.kernel.org/r/20240818-airoha-pwm-drv-v3-2-e398f3e41916%40kernel.org
patch subject: [PATCH v3 2/2] pwm: airoha: Add support for EN7581 SoC
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20240819/202408190759.z1PdIIZb-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408190759.z1PdIIZb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408190759.z1PdIIZb-lkp@intel.com/

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
>> ERROR: modpost: "__ffssi2" [drivers/pwm/pwm-airoha.ko] undefined!
ERROR: modpost: "__delay" [drivers/net/mdio/mdio-cavium.ko] undefined!
ERROR: modpost: "devm_of_clk_add_hw_provider" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "devm_clk_hw_register" [drivers/media/i2c/tc358746.ko] undefined!
ERROR: modpost: "of_clk_hw_simple_get" [drivers/media/i2c/tc358746.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

