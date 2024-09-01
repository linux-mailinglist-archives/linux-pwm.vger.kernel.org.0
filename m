Return-Path: <linux-pwm+bounces-3073-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30259967699
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Sep 2024 15:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1BCC2815E6
	for <lists+linux-pwm@lfdr.de>; Sun,  1 Sep 2024 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46A517E005;
	Sun,  1 Sep 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rcz6cVzZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D2516F265;
	Sun,  1 Sep 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725197330; cv=none; b=ESh2GTcJp7Y9sAA+ABPKtF5mypAFh48AaU4JZjudGL7CQ1Ie4ZuC1C/WPY2pzCA9fd216gTGRhEpGXrpQ9VTYXfcyNRv/5Kl8SNXSg0/tl+a8wrHrL5m5tihOfA9hcHWpiUHOdAMEVJuDK1iuVdEbLPlP7MHj0B5O1kw6FKefEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725197330; c=relaxed/simple;
	bh=B1Ym6T0bBnsNcRUf8vZAOZRZpf/YLk3MxfySZOJtVwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiX8D5FBCHFj+1p51yhGQLwTBS4pQKChtYA5Ph+mrPRLCzrNW2WsAmoN+jTwDf7KSjUK3kMzsTuRpoVJJD7a/B3knXtREWy37aSr34TypZlkfR8/sUMb7CGeNHpmdpewIdBwA9QtBR5vGFYZDddToKTmQBLL0cYArfeD4YUpt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rcz6cVzZ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725197329; x=1756733329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B1Ym6T0bBnsNcRUf8vZAOZRZpf/YLk3MxfySZOJtVwY=;
  b=Rcz6cVzZSFtzt5bdu9pKMYBjdH5VbR1C1SeHbO8is4gwv80l9IwVfovU
   bUP42m15p3EXXMGzFpFXTg0ehlRHbtUO2xZgEy5i1XR/au/P6pnSngC72
   6vifkzCh+BLp1ADKBEjeohok8LEXL4h09J4zrzULfdrUQmulnQICrpHUw
   lyVUNVfrr6r/Uqz6OtmhiP9QsE3eaITsHkg0GhIc+v27Of1D1lkNGeVBE
   vhCJL6tVB5syedzad00xSySBhtAeAoPi1QsURw7fozB73HWBMgkMxP4ww
   ozPBIHu0PjWs6HgRMTNIlha79FauFeghyqDFiN2EbD4FZqoNclz/HpuXP
   Q==;
X-CSE-ConnectionGUID: i57buahxSianayOv9tEdiw==
X-CSE-MsgGUID: ng1R93gPQq6Eh8f2XwQKIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="34446837"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="34446837"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 06:28:49 -0700
X-CSE-ConnectionGUID: N7yVSMzrQCWOdRkFLSXZvg==
X-CSE-MsgGUID: IjNOdIuCTVue7+VsX/XmMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="64388335"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 01 Sep 2024 06:28:45 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skkdG-0003gf-2L;
	Sun, 01 Sep 2024 13:28:42 +0000
Date: Sun, 1 Sep 2024 21:28:15 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com,
	benjamin.larsson@genexis.eu, ansuelsmth@gmail.com,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/5] pinctrl: airoha: Add support for EN7581 SoC
Message-ID: <202409012045.91oDLtEE-lkp@intel.com>
References: <20240831-en7581-pinctrl-v3-4-98eebfb4da66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831-en7581-pinctrl-v3-4-98eebfb4da66@kernel.org>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on defaf1a2113a22b00dfa1abc0fd2014820eaf065]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-arm-airoha-Add-the-chip-scu-node-for-EN7581-SoC/20240831-222958
base:   defaf1a2113a22b00dfa1abc0fd2014820eaf065
patch link:    https://lore.kernel.org/r/20240831-en7581-pinctrl-v3-4-98eebfb4da66%40kernel.org
patch subject: [PATCH v3 4/5] pinctrl: airoha: Add support for EN7581 SoC
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20240901/202409012045.91oDLtEE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409012045.91oDLtEE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409012045.91oDLtEE-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/pinctrl/mediatek/pinctrl-airoha.o: in function `airoha_pinconf_get':
   pinctrl-airoha.c:(.text+0xa7a): undefined reference to `__ffsdi2'
>> m68k-linux-ld: pinctrl-airoha.c:(.text+0xb5e): undefined reference to `__ffsdi2'
   m68k-linux-ld: pinctrl-airoha.c:(.text+0xc2a): undefined reference to `__ffsdi2'
   m68k-linux-ld: drivers/pinctrl/mediatek/pinctrl-airoha.o: in function `airoha_pinconf_set':
   pinctrl-airoha.c:(.text+0xf84): undefined reference to `__ffsdi2'
   m68k-linux-ld: pinctrl-airoha.c:(.text+0xfda): undefined reference to `__ffsdi2'
   m68k-linux-ld: drivers/pinctrl/mediatek/pinctrl-airoha.o:pinctrl-airoha.c:(.text+0x10b0): more undefined references to `__ffsdi2' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

