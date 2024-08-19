Return-Path: <linux-pwm+bounces-3040-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD1D9560F5
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 03:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341422823C6
	for <lists+linux-pwm@lfdr.de>; Mon, 19 Aug 2024 01:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6721BC59;
	Mon, 19 Aug 2024 01:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjYtkH8i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1B98BF0;
	Mon, 19 Aug 2024 01:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724032342; cv=none; b=pugTXofa2sXAsvayoMTKi/aqyKkZ2xsvfVRwQ1y45HB8QD4u3bY2N1Ak7Zvcjo2sr0nhGE8PFv4uCdpjBOyr0Okt7TNDjDqCjTB7+Tqdn2KdH9/5szU3+Cy9tfsbhJsy9Pi3KttlUIiApXOSKT/nuLT8HQSYYIphFA2/VRfiyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724032342; c=relaxed/simple;
	bh=TpC3weBELg5EiRvAejQajZ/JTwMaLarKUde7kE41s3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miqa00nl8bnyzVSjbLGaWWSUowkpfErPH1OdgbRb+aegHPkRDA8glu6HcG7wCRTNq2/yswva2pmosyEo7BC1G04+cSA3W3i9G1DFcHQJfwf9o3+xiVqlxkEcR0ZO0Ze1Tt4isgjQHrUZfMZn6hU1E0DB37ISB4M8QinZ6g/INvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjYtkH8i; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724032341; x=1755568341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TpC3weBELg5EiRvAejQajZ/JTwMaLarKUde7kE41s3k=;
  b=cjYtkH8iTbAUrs7s4LI62RimNd+7w90WV+8Kdou0mdtCmh4dHHJrD7nS
   WCMXyIDBLbC0Wt0CAQ2Fl4myvkHoQUjxTvDL0X4jQXlhxKQzDydh1HCGF
   VT9acpHkrghwWy0NVob7tG3pQECc6VHJMKNY8QvI+gAZypsdQbyq6phzV
   coxdOx4Kdii4YHmf6GjFZs7XmP6GIMJAamYa7UE0l4vmTQgzdPMFtPy/G
   kh/Z/1YlHK9158fzRnQvdaJuq8xdqmli1k7fCOOGTTyVejrOJrTN24CpI
   +VmVW5hiEYBH0/vLSyxoRo1OWnTy89oQ62yhcX4G2iVci2OX11+BIRzwR
   Q==;
X-CSE-ConnectionGUID: FRkvTPjiQMu75OC+2bSxag==
X-CSE-MsgGUID: R0UQ+JglT5udLJW63GeFMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22411767"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22411767"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 18:52:21 -0700
X-CSE-ConnectionGUID: GK9vXamoTGesGgdu/DvJ+w==
X-CSE-MsgGUID: xxReA60TSsSBCJSDeU5Qjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="90982908"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 18 Aug 2024 18:52:17 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfrZ9-0008Yq-1h;
	Mon, 19 Aug 2024 01:52:15 +0000
Date: Mon, 19 Aug 2024 09:51:18 +0800
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
Message-ID: <202408190953.0Ritcb6y-lkp@intel.com>
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
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20240819/202408190953.0Ritcb6y-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408190953.0Ritcb6y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408190953.0Ritcb6y-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/pwm/pwm-airoha.o: in function `airoha_pwm_config_flash_map':
>> pwm-airoha.c:(.text+0xd0): undefined reference to `__ffssi2'
   sh4-linux-ld: drivers/pwm/pwm-airoha.o: in function `airoha_pwm_apply':
   pwm-airoha.c:(.text+0x7f0): undefined reference to `__ffssi2'
   sh4-linux-ld: drivers/media/i2c/tc358746.o: in function `tc358746_probe':
   tc358746.c:(.text+0x1b90): undefined reference to `devm_clk_hw_register'
   sh4-linux-ld: tc358746.c:(.text+0x1b98): undefined reference to `devm_of_clk_add_hw_provider'
   sh4-linux-ld: tc358746.c:(.text+0x1b9c): undefined reference to `of_clk_hw_simple_get'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

