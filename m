Return-Path: <linux-pwm+bounces-5365-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9018AA7E4B4
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 17:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F5D16C886
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Apr 2025 15:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EA21FFC7D;
	Mon,  7 Apr 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlLIx2Wo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303811FF7DD;
	Mon,  7 Apr 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744039859; cv=none; b=XlrPpL6jLgp3j6j26fj2FBqsnP2Lica1C/fWGmCr8TDn5v4/Edy51/CqvPPhdyW6zIkWePiseEt+fYaC5mFWKGgG7SCzm6VLAB2nCPnHn2mkmuXsRZM5mxXhWNnNNioN/eTsGFcMfUZH6L44XIoym9IRZBa4GJNp7Ufdnb7fGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744039859; c=relaxed/simple;
	bh=vtlccTfM9VZZD5m8j+ndF1OOWgDstqM5TbodR3i3Obw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m45IxKjsUR+rDcqLt03bfG81kQQgJpBJuZAhU57LRJqx6/quV3twJzFx9LDTQRwYbsLEKQwKj8Y7w1TuEyXV0UXhyjwLTMA96Iz0CXjm0WTv3ApIZvK3VMVwqvL5esWdo8FSEyv2sahA5cLzHPmuis3ASGMKKFAaO1H92DsyEC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlLIx2Wo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744039857; x=1775575857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vtlccTfM9VZZD5m8j+ndF1OOWgDstqM5TbodR3i3Obw=;
  b=VlLIx2Wo6+c4lTWy3f8FkOf9c92tDB5PzplZVisvMSeQTGgtmW4UfEO6
   DJrNwYYN8VKsT4pq6Wl9X9Fd4fgEOJeJV+q3VZO4qNIlKLNx6tT7Saz0D
   RTZUEeldwwFGTxFQolZel3LfI7DvFzLpzCxQpyGj0/j0uQ4671hoihlAp
   /y6jYXb/dH0roYPVbLIvKVFILZ3MrT1ZQjmiHv0S3OFHqJA17Z0Wsyx9A
   +hcA50Iq0ZxggGEyIcg2DWepBJAbnubmmXCVKx0YJmVak5iVzLLKlsqhw
   XSUjARBZURDUqfRsBKCizQUUpOrmo+I4z7JZ/fz30cwZWvk/hjrU9Z6rP
   A==;
X-CSE-ConnectionGUID: PVKrfdw9RkWV8fxwBiFX+g==
X-CSE-MsgGUID: itEg0/dpQ82svsEYSO330g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="62980319"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="62980319"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 08:30:56 -0700
X-CSE-ConnectionGUID: OyF2CGuLQrO3ZJ0HpvmNeQ==
X-CSE-MsgGUID: oCBZlUSSSnKQsmNOxl09Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; 
   d="scan'208";a="127869350"
Received: from lkp-server01.sh.intel.com (HELO b207828170a5) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Apr 2025 08:30:53 -0700
Received: from kbuild by b207828170a5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u1oR0-0003Wh-0P;
	Mon, 07 Apr 2025 15:30:50 +0000
Date: Mon, 7 Apr 2025 23:30:33 +0800
From: kernel test robot <lkp@intel.com>
To: Longbin Li <looong.bin@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: oe-kbuild-all@lists.linux.dev, ghost <2990955050@qq.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for SG2044
Message-ID: <202504072300.KCXJcmJK-lkp@intel.com>
References: <20250407072056.8629-3-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407072056.8629-3-looong.bin@gmail.com>

Hi Longbin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on krzk-dt/for-next]
[also build test WARNING on linus/master v6.15-rc1 next-20250407]
[cannot apply to robh/for-next sophgo/for-next sophgo/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Longbin-Li/dt-bindings-pwm-sophgo-add-pwm-controller-for-SG2044/20250407-153334
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git for-next
patch link:    https://lore.kernel.org/r/20250407072056.8629-3-looong.bin%40gmail.com
patch subject: [PATCH 2/2] pwm: sophgo: add driver for SG2044
config: arm-randconfig-003-20250407 (https://download.01.org/0day-ci/archive/20250407/202504072300.KCXJcmJK-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250407/202504072300.KCXJcmJK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504072300.KCXJcmJK-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-sophgo-sg2042.c:57: warning: Function parameter or struct member 'lock' not described in 'sg2042_pwm_ddata'


vim +57 drivers/pwm/pwm-sophgo-sg2042.c

    47	
    48	/**
    49	 * struct sg2042_pwm_ddata - private driver data
    50	 * @base:		base address of mapped PWM registers
    51	 * @clk_rate_hz:	rate of base clock in HZ
    52	 */
    53	struct sg2042_pwm_ddata {
    54		void __iomem *base;
    55		unsigned long clk_rate_hz;
    56		struct mutex lock;
  > 57	};
    58	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

