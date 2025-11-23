Return-Path: <linux-pwm+bounces-7664-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0399C7DC31
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 07:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685D83AB460
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Nov 2025 06:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E846273D77;
	Sun, 23 Nov 2025 06:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bBVzQqXI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0786272801;
	Sun, 23 Nov 2025 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763879646; cv=none; b=pXn0otyoHzGUJc4AgJfNmtUDofsbhQKY+3HgAs1ET/82LGgkyyu7hM9mC/dwrOYIqDrJxyd+YBtmK7sjHiZfwxH2L5fSvBeem1oz6Ga63nVtBrSXJadkVhNzFuCRIHhldPUtduU0+gxQkSOgElBgVLAAtpZBCZoxClj1Ji1gcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763879646; c=relaxed/simple;
	bh=akx3FvBr6GvB3MVzDH+m/yO3t0ilYRRNHVVUnoTgWv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwR7FZTlS0dtJZDUmYD5PMrq+X0Yr+6FQVNsZ4r5mWOmR9Lh9B/CHDUM+3ND8DjZFZrZ6G9iAW3fVH6ofArYxq1Q82iW6c+9uccDBtbF12SdoIkO1goUHmxkH0rqW5mbizgCwVppZGDJehZGLvcR39VuQL78w70Ks6RelEiHbH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bBVzQqXI; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763879644; x=1795415644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=akx3FvBr6GvB3MVzDH+m/yO3t0ilYRRNHVVUnoTgWv8=;
  b=bBVzQqXIJGUiadyW153dlyjKtGLVna5S7drrYN8uGPOJkK2Lmi6H/iF5
   /M27zz0VHe27FQjBM8V8fkuRTgKjOiDxDopsDol7Dn1fJu8BC24CrZGM4
   3/dyOAfvgqXWrVX+UX1iWMhJ5oi44MwTtPzFMQDLekwtR1jmWVjBxKejF
   vMRPKPGjFVqSHAEGFfxh2K0QE0DfmqltFUBNmN1jxvgIsINT3fYpVeFha
   tjDZuruvhuRfBloTe2ibxpprdcbDNqRtTZxyJOx02V+FTS6EIEXBupTaI
   v4AVpLRLeDv/u+1GMv8Kt4oq+t6sS/4eZrRR0AamF2d1ocqzomcOGscK/
   w==;
X-CSE-ConnectionGUID: GsJvzUGZR1Wwlikd7r7cUw==
X-CSE-MsgGUID: AAVLAt0jRjeF/29WkJMhcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11621"; a="65100910"
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; 
   d="scan'208";a="65100910"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2025 22:34:03 -0800
X-CSE-ConnectionGUID: ZopYkFVrTNK+R8A1VXgBEw==
X-CSE-MsgGUID: EyJttbKzSKmNlHNk99DZFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,220,1758610800"; 
   d="scan'208";a="192072057"
Received: from lkp-server01.sh.intel.com (HELO adf6d29aa8d9) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Nov 2025 22:33:59 -0800
Received: from kbuild by adf6d29aa8d9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vN3fZ-00085z-0v;
	Sun, 23 Nov 2025 06:33:57 +0000
Date: Sun, 23 Nov 2025 14:33:31 +0800
From: kernel test robot <lkp@intel.com>
To: Biju <biju.das.au@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [DO NOT APPLY PATCH v8 14/15] pinctrl: renesas: rzg2l-poeg:
 output-disable request from GPT on dead time error
Message-ID: <202511231456.D6amN8I5-lkp@intel.com>
References: <20251121160842.371922-15-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121160842.371922-15-biju.das.jz@bp.renesas.com>

Hi Biju,

kernel test robot noticed the following build errors:

[auto build test ERROR on geert-renesas-drivers/renesas-pinctrl]
[also build test ERROR on linusw-pinctrl/devel linusw-pinctrl/for-next geert-renesas-devel/next linus/master v6.18-rc6 next-20251121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Biju/dt-bindings-pwm-rzg2l-gpt-Document-renesas-poegs-property/20251122-001415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git renesas-pinctrl
patch link:    https://lore.kernel.org/r/20251121160842.371922-15-biju.das.jz%40bp.renesas.com
patch subject: [DO NOT APPLY PATCH v8 14/15] pinctrl: renesas: rzg2l-poeg: output-disable request from GPT on dead time error
config: loongarch-randconfig-002-20251123 (https://download.01.org/0day-ci/archive/20251123/202511231456.D6amN8I5-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251123/202511231456.D6amN8I5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511231456.D6amN8I5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pinctrl/renesas/poeg/rzg2l-poeg.c:97:3: error: call to undeclared function 'rzg2l_gpt_poeg_disable_req_deadtime_error'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      97 |                 rzg2l_gpt_poeg_disable_req_deadtime_error(chip->gpt_dev, chip->index, true);
         |                 ^
   drivers/pinctrl/renesas/poeg/rzg2l-poeg.c:97:3: note: did you mean 'rzg2l_gpt_poeg_disable_req_deadtime_err'?
   include/linux/pwm/rzg2l-gpt.h:38:19: note: 'rzg2l_gpt_poeg_disable_req_deadtime_err' declared here
      38 | static inline int rzg2l_gpt_poeg_disable_req_deadtime_err(void *gpt_device, u8 grp, bool on)
         |                   ^
   1 error generated.


vim +/rzg2l_gpt_poeg_disable_req_deadtime_error +97 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c

    87	
    88	static void rzg2l_poeg_config_irq(struct rzg2l_poeg_chip *chip)
    89	{
    90		if (test_bit(RZG2L_GPT_OABHF, chip->gpt_irq))
    91			rzg2l_gpt_poeg_disable_req_both_high(chip->gpt_dev, chip->index, true);
    92	
    93		if (test_bit(RZG2L_GPT_OABLF, chip->gpt_irq))
    94			rzg2l_gpt_poeg_disable_req_both_low(chip->gpt_dev, chip->index, true);
    95	
    96		if (test_bit(RZG2L_GPT_DTEF, chip->gpt_irq))
  > 97			rzg2l_gpt_poeg_disable_req_deadtime_error(chip->gpt_dev, chip->index, true);
    98	}
    99	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

