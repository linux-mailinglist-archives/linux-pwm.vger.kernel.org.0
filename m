Return-Path: <linux-pwm+bounces-6470-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 856A8AE32F6
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Jun 2025 01:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F937A47C8
	for <lists+linux-pwm@lfdr.de>; Sun, 22 Jun 2025 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBA92185B1;
	Sun, 22 Jun 2025 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0YFAydG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6C735977;
	Sun, 22 Jun 2025 23:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750633553; cv=none; b=Wi75Ie2BsoV1K3jkiu2f/6HplA1WRshoJr3hZexvEvjWLiy9RnB8TntWhGQaul3YwqpoY2lY1y0VyMbSMp4zI44GREmV9aHLkoNwh930HWhY8ItIIwvZoNiuSCgFvizWrEsb4TewrnzGvK0sEmzgtaSxzGKyX+wX7u3/3j0u72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750633553; c=relaxed/simple;
	bh=PseveSieBkz6aK3pTCE1wpNXkrVYYBVptg5kuZ6+eEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6YKlfsTvTqjO97bN1kZ6RZMr6dyzY/P89bjMjcWoiquYiscWA6UC5k2U1n68kcCrK4irwoB/kDd3lvCSqbgcJEmrPw7CkiIaK/1g7ap4avU/1VFZN6ZGzGt/87TZjUXixjUOdXY9GZpDxCc6iFFQA/xq3PAuLmEopEwTvCNsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0YFAydG; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750633552; x=1782169552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PseveSieBkz6aK3pTCE1wpNXkrVYYBVptg5kuZ6+eEU=;
  b=I0YFAydGOVCAYUl825p/0UdWUGtRc+Dr8bu1cu7DiOeRgZ2P2ECyPBfI
   e3Uhk6zp4nSGSrBbkILP11XL8Zutf7ytMpnExZhtVkZefifYql6F44v3r
   SjZC9KwcbC8wfxyKz35yCyWdrhjgiPnjye+Nn0FwGMlXWNNrj6FDz9uaq
   f7YZX6I6Fe8tUesVJMd4NGgFQFIp7cEeuIcLU7EjpbCummXzvFPXKZrLD
   ya70GEbXtqb5DIWcX7li2SfeToiGetf5GB7+vTRX88ZF0z3txX3LwqjtW
   NRNjCNq9m32yWEknFJdYc+8gPJs91ySX1o3llZCe3hmGvlUlSGhkynDWM
   A==;
X-CSE-ConnectionGUID: YKGn7i6ETVWF5jIc+em+lQ==
X-CSE-MsgGUID: k+ZA7U2ETXmwXKqOszE/6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="56496755"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="56496755"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 16:05:51 -0700
X-CSE-ConnectionGUID: L2Sd27kZS5C0EmD94BmUIg==
X-CSE-MsgGUID: fa9dnmWJTvqs+4ig8zOW8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="150909124"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 22 Jun 2025 16:05:49 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uTTkw-000NZG-1h;
	Sun, 22 Jun 2025 23:05:46 +0000
Date: Mon, 23 Jun 2025 07:05:25 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v14] pwm: airoha: Add support for EN7581 SoC
Message-ID: <202506230615.9m8ZE43C-lkp@intel.com>
References: <20250616201532.29047-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616201532.29047-1-ansuelsmth@gmail.com>

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.16-rc3 next-20250620]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/pwm-airoha-Add-support-for-EN7581-SoC/20250617-042042
base:   linus/master
patch link:    https://lore.kernel.org/r/20250616201532.29047-1-ansuelsmth%40gmail.com
patch subject: [PATCH v14] pwm: airoha: Add support for EN7581 SoC
config: m68k-randconfig-r072-20250623 (https://download.01.org/0day-ci/archive/20250623/202506230615.9m8ZE43C-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250623/202506230615.9m8ZE43C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506230615.9m8ZE43C-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/pwm/pwm-airoha.o: in function `airoha_pwm_apply':
>> pwm-airoha.c:(.text+0x8f8): undefined reference to `__umoddi3'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

