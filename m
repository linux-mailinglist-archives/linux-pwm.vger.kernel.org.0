Return-Path: <linux-pwm+bounces-3001-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5398894DF6C
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2024 03:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87841F215CF
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2024 01:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB25522A;
	Sun, 11 Aug 2024 01:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bd/zs+97"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A725223;
	Sun, 11 Aug 2024 01:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723338984; cv=none; b=nbHRbXMi6WYTsY+qFR2m0jR/Bi6FyCqRSA4b2v5PanBV2rA3pElRF8w2NzG+B/JuMltL7pgZmMGbt3I2OJx3hnYKWNjTQXJhd3TAWE3WCnntLjCKBxbknw3c5izsIsd9Jp0rTwwstuqRpWiWN8EBvbkxv1zac9JC9zmR9diBhdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723338984; c=relaxed/simple;
	bh=3TC40Bj7SfvFrdCPW3F0lPZBq4YcUtzaKyXJ1rYP0II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7/GmKp9tQWSxj+J9z8x5rInOVbutbVqt41KN0HtkXxCRRf+s+OJSzKXLMYn1KJcfFrLb0/Qzwcxkp3WW7N1DXbSdoIcvIucAtYIR96YzYArmA7HTzrrZ218V7UXerOG7R2Tbdf36QdCZFAH78rdmVN8jcIIA9uZPjcICL65ZKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bd/zs+97; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723338983; x=1754874983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3TC40Bj7SfvFrdCPW3F0lPZBq4YcUtzaKyXJ1rYP0II=;
  b=bd/zs+97G8cH4Vz9IT9x1hPd2Sum2fwMU22MpPXd3DAxFmwTGLIwD4qP
   iW3RW1yChBGmh4qJ29NathtqEm9oBoSrc7fpDKM8DV5N9IoSx0c0quOg9
   IVLRbCndOA28STmArWjCImyfbH5+xxptRfRJCi3iJUeH/ooFX71LzS18F
   DOf/LZuNxsHJB43wJK01QTHmP8A1WLVU+lgyZlpciz4gflG0vVDwyfh70
   be7LabcJoXHaSVGKKosWd+TOQLHAvTNmYcxkxw90NWpFqOvsYjXvhAIlU
   CAzOllRdo3y43E32xXxvmlZZq99AS/LOHuu2beLJ98ExutWPyANw3/2KX
   A==;
X-CSE-ConnectionGUID: Kh+7mC/HT+K96CsBoJCFMA==
X-CSE-MsgGUID: RE7H/62ySKeHPmKrWvsKtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="21289868"
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="21289868"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 18:16:22 -0700
X-CSE-ConnectionGUID: xeTS7v2OSYGPJ3Y8wISTDA==
X-CSE-MsgGUID: r+CI+Az8TjmyOGPYlCSUwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="81144904"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 10 Aug 2024 18:16:18 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scxBw-000ASL-0R;
	Sun, 11 Aug 2024 01:16:16 +0000
Date: Sun, 11 Aug 2024 09:15:37 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pwm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ukleinek@kernel.org, lorenzo.bianconi83@gmail.com,
	krzk+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: Re: [PATCH 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <202408110920.KEW33sRE-lkp@intel.com>
References: <a03f5ea9291e39eab303696eb03fdd44cf04e8d9.1723264979.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a03f5ea9291e39eab303696eb03fdd44cf04e8d9.1723264979.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master thierry-reding-pwm/for-next v6.11-rc2 next-20240809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-pwm-Document-Airoha-EN7581-PWM/20240810-143716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/a03f5ea9291e39eab303696eb03fdd44cf04e8d9.1723264979.git.lorenzo%40kernel.org
patch subject: [PATCH 2/2] pwm: airoha: Add support for EN7581 SoC
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240811/202408110920.KEW33sRE-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408110920.KEW33sRE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408110920.KEW33sRE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pwm/pwm-airoha.c:7:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-airoha.c:7:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-airoha.c:7:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/pwm/pwm-airoha.c:239:19: error: call to undeclared function '__bf_shf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     239 |         val = (period << __bf_shf(mask)) & mask;
         |                          ^
   drivers/pwm/pwm-airoha.c:271:24: error: call to undeclared function '__bf_shf'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     271 |         val = ((index & 7) << __bf_shf(mask)) & mask;
         |                               ^
   6 warnings and 2 errors generated.


vim +/__bf_shf +239 drivers/pwm/pwm-airoha.c

   231	
   232	static void airoha_pwm_config_waveform(struct airoha_pwm *pc, int index,
   233					       u32 duty, u32 period)
   234	{
   235		u32 mask, val;
   236	
   237		/* Configure frequency divisor */
   238		mask = WAVE_GEN_CYCLE_MASK(index % 4);
 > 239		val = (period << __bf_shf(mask)) & mask;
   240		airoha_pwm_cycle_rmw(pc, REG_CYCLE_CFG_VALUE(index / 4), mask, val);
   241	
   242		/* Configure duty cycle */
   243		duty = ((DUTY_FULL - duty) << 8) | duty;
   244		mask = GPIO_FLASH_PRD_MASK(index % 2);
   245		val = (duty << __bf_shf(mask)) & mask;
   246		airoha_pwm_flash_rmw(pc, REG_GPIO_FLASH_PRD_SET(index / 2), mask, val);
   247	}
   248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

