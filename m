Return-Path: <linux-pwm+bounces-3009-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B87894EA21
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 11:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B1FB20D7F
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Aug 2024 09:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF3416DEA7;
	Mon, 12 Aug 2024 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hgH2sTst"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD716D4FC;
	Mon, 12 Aug 2024 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455775; cv=none; b=N9FxpOjmYoofowiKKaY9rN6VIhJ6ziKITd0DgjTmfnzRQDDVlolqwQOP4+9550sI2YFtzmH6q3O4SXbFvBM9b5DFbFVamt9O+CO7lGxwOetl7zRtZPSLDQUb3kgCg4AJ+9DOn3s7cJnjazjFZv/KTyytFHt3yKFVxHLTikLwFvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455775; c=relaxed/simple;
	bh=b4WFeXD8terb5bRxofCiOoA6oxd8/i/orRs8lsnEGCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ln3RvhhNuqhN6fgYy8uEopY83mCEFHk+ZjbnSUbMD+UYdFV5zXBieXLvyMkmedWR7WqT1t3mF89v6bHfRLS3NnSZDcKXxnVDcrCmiChUb+Qd0EJZKo9FYRdvEJqiEDFWZlID/jtThqCezlOMnMXfeRvpVoCAp0Iytst3Dknl3BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hgH2sTst; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723455774; x=1754991774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b4WFeXD8terb5bRxofCiOoA6oxd8/i/orRs8lsnEGCs=;
  b=hgH2sTsteO5F4ifFsA7oSqvYuUigbJubutJpM1LiR+y94iKkDP64by2z
   VzG1MWqQWskrffJx8W6Hk9b5stlQtEcNoH9tMlWb99YhVh6JeqWrujgT2
   xpPvDKH+Kp3/Nc7BN66quO7T17cAGrwJDy1wpTtWg2hEkf0l7jNxfeIx2
   RCDFkyBsfzh7qz2fVFnLczyP0W5IKgMK5POM2A5VgpQq7RB7i+yc3XMyo
   LkXFUL2L7I5MY5TBP4L+PSG2QSVNdiIHQldSh2eNnkL504kPrybxZR3oz
   BpA8chE9OpXxnso+AhyhXoEGV5B8vuUlhVCpUuFgQGcGPracTnybStksg
   Q==;
X-CSE-ConnectionGUID: 1OrnB9EmRK6SSCRgypG/DQ==
X-CSE-MsgGUID: KURjfQ6NT5ia6CefHX7aow==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32704536"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32704536"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 02:42:53 -0700
X-CSE-ConnectionGUID: 5oxjCGDhTZ2//zwBmBSnJw==
X-CSE-MsgGUID: KCbpgNZsTXeUppAeJNfHvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="95716165"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 12 Aug 2024 02:42:50 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sdRZf-000BbD-15;
	Mon, 12 Aug 2024 09:42:47 +0000
Date: Mon, 12 Aug 2024 17:42:25 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pwm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ukleinek@kernel.org,
	lorenzo.bianconi83@gmail.com, krzk+dt@kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com, angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, conor+dt@kernel.org,
	ansuelsmth@gmail.com
Subject: Re: [PATCH v2 2/2] pwm: airoha: Add support for EN7581 SoC
Message-ID: <202408121701.zaN0Tsxg-lkp@intel.com>
References: <d5abef7ee63f2c5df8bf3400c4d8a5ff72c706a9.1723393857.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5abef7ee63f2c5df8bf3400c4d8a5ff72c706a9.1723393857.git.lorenzo@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc3 next-20240812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-pwm-Document-Airoha-EN7581-PWM/20240812-003542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/d5abef7ee63f2c5df8bf3400c4d8a5ff72c706a9.1723393857.git.lorenzo%40kernel.org
patch subject: [PATCH v2 2/2] pwm: airoha: Add support for EN7581 SoC
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240812/202408121701.zaN0Tsxg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240812/202408121701.zaN0Tsxg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408121701.zaN0Tsxg-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/mm/testmmiotrace.o
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/locking/test-ww_mutex.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/mxc-clk.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/clk/imx/clk-imxrt1050.o
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
>> ERROR: modpost: "__ffsdi2" [drivers/pwm/pwm-airoha.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

