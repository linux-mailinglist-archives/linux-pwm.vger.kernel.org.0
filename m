Return-Path: <linux-pwm+bounces-5596-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF2DA9479A
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 14:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370DA1729B8
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F441E98E8;
	Sun, 20 Apr 2025 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUDDoo7F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355FD1E5B60;
	Sun, 20 Apr 2025 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745150987; cv=none; b=KQguXOvO3u5GNNL6Hpav7tIshnTW++ExEB8S5FOw7xopQl2EkVuzKss1l5lCc4BGbivHEOaFI/sYWDYTbnlHqDyeJI31YTaChQ+QG6KB2l6G1EqYKzLLQTMOdqcfrAk4yaSYlfOt4evdVqhGixGVXUteGeIWKKDjwYEboYkSX9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745150987; c=relaxed/simple;
	bh=NFlaEuLIw0Zajlp8jpqXN2CskXo/XnjXuoyqH9AEvhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpKHtfP6BGNH0udKwfmQW3LrD4hjoThT+3MzQwbgS/qaFSDyS2eXh42CZQ1H0evTuOQXF6UEDQuISojWAEWjRpVYhflqnrrE/2Rwvh/mS4UGjw3qb0hoGiBAf1Dy4CZgdbfBIpraNlaygakCk96B9Sag8hayX0Pfb+E+5iGIk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUDDoo7F; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745150985; x=1776686985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NFlaEuLIw0Zajlp8jpqXN2CskXo/XnjXuoyqH9AEvhw=;
  b=dUDDoo7FnOLuE+xfhUIdUgvkjoctfMHJFeDGghrfInX0BPERkwjC2Rvb
   rMc2zBpnxJ4aDjer993c3Qhlasxn3iXLOtNuxExkoXTwbR/bRQbnZJk2Z
   9VFmlwAybz/CN4CUpUil85CwsJE3hwKFkPe6aqy2fwLieduAnaaBxGS4w
   JbGMj0xpKYJ7RmA/+LGcEgbP8qYN+eFhb9ZmWU4PDqAek5SRE6MWtx8jX
   CJ2QKTOOzCMJBepAGrKs8k3FvKFAQrAYgPFijE0ds8cKgPkzXFk4o6zpl
   YgmLqIq5y0ySG2mjx+em/Gfj6ccHwEmyQI8hlrvBCXKuJvF2kyFc5nRtm
   Q==;
X-CSE-ConnectionGUID: t4JGrh9HTDerezSDnJA2gQ==
X-CSE-MsgGUID: tgWMZ4mIRK2Mh/BDUvXaZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="72095980"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="72095980"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2025 05:09:45 -0700
X-CSE-ConnectionGUID: QUR9/X0LQLKchS+BDV4HsQ==
X-CSE-MsgGUID: SUTGsSbdSOu5YWkRvUIDYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="135582954"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 20 Apr 2025 05:09:39 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6TUP-0004cL-0v;
	Sun, 20 Apr 2025 12:09:37 +0000
Date: Sun, 20 Apr 2025 20:09:13 +0800
From: kernel test robot <lkp@intel.com>
To: Guodong Xu <guodong@riscstar.com>, ukleinek@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com,
	inochiama@gmail.com, geert+renesas@glider.be, heylenay@4d2.org,
	tglx@linutronix.de, hal.feng@starfivetech.com,
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, elder@riscstar.com,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, guodong@riscstar.com
Subject: Re: [PATCH v2 3/6] riscv: dts: spacemit: add PWM support for K1 SoC
Message-ID: <202504201920.P8LBocr2-lkp@intel.com>
References: <20250420070251.378950-4-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250420070251.378950-4-guodong@riscstar.com>

Hi Guodong,

kernel test robot noticed the following build errors:

[auto build test ERROR on spacemit/for-next]
[also build test ERROR on spacemit/fixes robh/for-next linus/master v6.15-rc2 next-20250417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Guodong-Xu/dt-bindings-pwm-marvell-pxa-pwm-Add-SpacemiT-K1-PWM-support/20250420-150635
base:   https://github.com/spacemit-com/linux for-next
patch link:    https://lore.kernel.org/r/20250420070251.378950-4-guodong%40riscstar.com
patch subject: [PATCH v2 3/6] riscv: dts: spacemit: add PWM support for K1 SoC
config: riscv-randconfig-001-20250420 (https://download.01.org/0day-ci/archive/20250420/202504201920.P8LBocr2-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project f819f46284f2a79790038e1f6649172789734ae8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250420/202504201920.P8LBocr2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504201920.P8LBocr2-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/riscv/boot/dts/spacemit/k1.dtsi:532.27-28 syntax error
   FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

