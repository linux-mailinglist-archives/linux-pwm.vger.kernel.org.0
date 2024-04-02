Return-Path: <linux-pwm+bounces-1849-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AD7895AC3
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 19:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDC9B224BB
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Apr 2024 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC6915A49F;
	Tue,  2 Apr 2024 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHCwRBRq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C015A4A3;
	Tue,  2 Apr 2024 17:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079284; cv=none; b=Dk5b4WK70BdMYctH4aGbWfoQ7W9XTHM85ul2S4KXEBX4SPXnjDvecOlhCtUuXJs33KL2dpHNC5IMMPtXqnQsbnY3j9p61R48AUx5scQQpmpFPB9ApZx48Q3WFMlmS1XCaqrj0DUtB1Kqu+yI9sUo7+ttsFGNYK/OrqSXBrk2c1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079284; c=relaxed/simple;
	bh=fNYoNOn5B2vjF3chFRhRaoGkC5J7EsTH2AoQer+/ANQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5Jbw5yXQ+1S5PcWGb4xW1S10t+2SGZHmq4dibHU89JPQaNW061FeHvXIsc2iRRxa9nTlxc4PfzskjxBHERN/kMjMx24haPhgbl1aZ1jYW8/td8Ggf+KebgTL5Ou2yDdliJAq98T7it7ixMwO4icqbcw3ahNHk+N7GSE+U6/o/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHCwRBRq; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712079281; x=1743615281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fNYoNOn5B2vjF3chFRhRaoGkC5J7EsTH2AoQer+/ANQ=;
  b=UHCwRBRq5A6Unz3E8uXorTmwX/IoFdipD6hrn5ECopTriEZN1N9PJa+z
   MQjvlrpwMuJPKp+HLmqmB7332VvdefRDWTpYykqh14yjDsjRzAv7HGu9l
   xJDIzk+Cqb+Fp7J0z2CBlMr2kZu8Pc1uLIrW/C1UzfZ5oPPG4Sw0tetQz
   oJyIGxeAw7vtWQ4ra5I/+swijEOIQO8HjpP9Z1zTVMotGRcriTMEZRfOf
   Zlo0R3+xpOCoCD5RXSSedJ1+tUy3rw/D4i2MDVJ+istj2VB32zXuDJyiE
   /qUQ/XCaxY44XEaGn3lDvBOYvwcU0NiZ3elv3X+X5z5YlBCPHMgOVW4C3
   g==;
X-CSE-ConnectionGUID: 2NqKV760S76UAuUCxZjkJg==
X-CSE-MsgGUID: G2fnHb7XTiWcwYaT12aZAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7136171"
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="7136171"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 10:34:39 -0700
X-CSE-ConnectionGUID: OSeGEsaLQ6G3xhHefXNoRQ==
X-CSE-MsgGUID: kGl3BvEEROiCz1mlLQHR4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,175,1708416000"; 
   d="scan'208";a="18255944"
Received: from lkp-server02.sh.intel.com (HELO 90ee3aa53dbd) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Apr 2024 10:34:36 -0700
Received: from kbuild by 90ee3aa53dbd with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rri1q-0001Lz-0E;
	Tue, 02 Apr 2024 17:34:34 +0000
Date: Wed, 3 Apr 2024 01:34:07 +0800
From: kernel test robot <lkp@intel.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>,
	Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, loongson-kernel@lists.loongnix.cn,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev
Subject: Re: [PATCH v1 5/5] LoongArch: dts: Add PWM support to Loongson-2K2000
Message-ID: <202404030108.rzArK10u-lkp@intel.com>
References: <7214b933ce85f9d030828e9efab7fbeb57eb712b.1711953223.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7214b933ce85f9d030828e9efab7fbeb57eb712b.1711953223.git.zhoubinbin@loongson.cn>

Hi Binbin,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.9-rc2 next-20240402]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Binbin-Zhou/dt-bindings-pwm-Add-Loongson-PWM-controller/20240402-160109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/7214b933ce85f9d030828e9efab7fbeb57eb712b.1711953223.git.zhoubinbin%40loongson.cn
patch subject: [PATCH v1 5/5] LoongArch: dts: Add PWM support to Loongson-2K2000
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20240403/202404030108.rzArK10u-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240403/202404030108.rzArK10u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404030108.rzArK10u-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/loongarch/boot/dts/loongson-2k2000.dtsi:123.19-20 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

