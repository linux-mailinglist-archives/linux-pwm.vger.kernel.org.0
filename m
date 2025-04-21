Return-Path: <linux-pwm+bounces-5630-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52802A95388
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 17:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC171893F99
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Apr 2025 15:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6601C863D;
	Mon, 21 Apr 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3GFh0q0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392BD1494D8;
	Mon, 21 Apr 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745249022; cv=none; b=NKZNEMiNxlmTJH0gQJ4jevw0Oi8QEnJ+8SgsLkFvbRXZuJaso4X7IPzbcTWhSPe/0UnhZSctoL3I9lh4UoH/5cjK3SKyKuEvt5tFgKHZOQJwUFSFO2w/NYx6CC6w0mjUN7woONR39SH1t2ZDFn989wXYuFJ3B1ILkT+8I7/C61A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745249022; c=relaxed/simple;
	bh=vJPOq/jtYR3O8m4x/saV7Lfzl0TMxKs1hSTnn1MH0/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPfHUUMJcGpQZBQvhJBdQWJP0XvXiMf2+MqMvwIkL3mC99+w3yGaeBEXQdJJFocXS+ncwvb3LgXRFEmJJq3K8sUl4dXR0SCi+Mq9gHLzW14JNBszLc5KOLSRF6pLnebaf4NtdyY3g5isTqYsGXYtXAFpe/MT7AN1VGMHR/IUYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3GFh0q0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745249020; x=1776785020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vJPOq/jtYR3O8m4x/saV7Lfzl0TMxKs1hSTnn1MH0/Q=;
  b=J3GFh0q0+Xo4hZsYg/Pw1Fe4W/+XqWPhK3DPCNA9FDuoITAhCe4WF+JG
   WOTHmMZF5ovv2HAt7wTYr/sQRKJw/G/0sBEmYFUgfz9lj7+1Hx4FH+Swy
   of9frH5qJXQNeqS+bpKH0Uo81WR5STSN1r3ekHhuEQaImrNRI1RtMeNP/
   +zJ3blSmyhDp9TylZDhxjHI/4YaAN00+P97lF0oxU/3LCQpQi92kOI+9D
   4cZXMWjAeA68cuOOvId7WoeY9kcLGJq2G+krR5mWdP+7/dMmkGHMiQCob
   24sqbMqotbj5dfzXd3cQfbqVC1l9+tLPp7yKH9CeQjlepD4RdV7QuKlTM
   A==;
X-CSE-ConnectionGUID: fqifmB24S8SgltuoGFJZxA==
X-CSE-MsgGUID: HwVjsAJPSI2kIig6RsbjeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46018344"
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="46018344"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2025 08:23:39 -0700
X-CSE-ConnectionGUID: qYxPlAo5T1q0ooVmsIMlWQ==
X-CSE-MsgGUID: Spq369kLR+qDitQqo2fORA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,228,1739865600"; 
   d="scan'208";a="136707842"
Received: from lkp-server01.sh.intel.com (HELO 050dd05385d1) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 21 Apr 2025 08:23:35 -0700
Received: from kbuild by 050dd05385d1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6szd-0000Bh-0Y;
	Mon, 21 Apr 2025 15:23:33 +0000
Date: Mon, 21 Apr 2025 23:23:12 +0800
From: kernel test robot <lkp@intel.com>
To: Nylon Chen <nylon.chen@sifive.com>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>, Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v11 4/5] pwm: sifive: Fix rounding issues in apply and
 get_state functions
Message-ID: <202504212351.Aa9tPMsO-lkp@intel.com>
References: <20250421095521.1500427-5-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421095521.1500427-5-nylon.chen@sifive.com>

Hi Nylon,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.15-rc3 next-20250417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nylon-Chen/riscv-dts-sifive-unleashed-unmatched-Remove-PWM-controlled-LED-s-active-low-properties/20250421-174716
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250421095521.1500427-5-nylon.chen%40sifive.com
patch subject: [PATCH v11 4/5] pwm: sifive: Fix rounding issues in apply and get_state functions
config: i386-buildonly-randconfig-003-20250421 (https://download.01.org/0day-ci/archive/20250421/202504212351.Aa9tPMsO-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250421/202504212351.Aa9tPMsO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504212351.Aa9tPMsO-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/ucs2_string.o
>> ERROR: modpost: "__udivdi3" [drivers/pwm/pwm-sifive.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

