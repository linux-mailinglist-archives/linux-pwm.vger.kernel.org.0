Return-Path: <linux-pwm+bounces-3071-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF79672D6
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 19:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26702826C1
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09D96E611;
	Sat, 31 Aug 2024 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SdfP09vQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB062557A;
	Sat, 31 Aug 2024 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725125720; cv=none; b=qfpqlYBbmS0V7AnfF0I51dHC7QsmHadIcGxxcrnvKvyYhcptQlaY274dwKgNZTYkkw+IpZDobr5vW0Z1G+Kj4IZtHnlgojoQZcuatBMyb2n+m8fGSWVbQLC89MVPy9WbrhBFa0hMlpMX1spm8Bq6fHcKA7NqP+VP0dJ7abVt8to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725125720; c=relaxed/simple;
	bh=XN2PsVitdwqyT+0EuFJyx51meuS/idl3glEF5fMYEO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgGL66L1JgwjFkgzvhg7k4keKtlRvUOXfE3E7tFDsrj3kFqdMigsRccQpknhJC/xc4zysUBG346I6Pc61VQFKv/AkGcHWiMhkdPq0wKgJ/LGjUUPrg4K23KlEvBVV++5pm0CVNDeIwX7AqLsVEXKmySG/lfak8CqrdQQrm6IQX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SdfP09vQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725125719; x=1756661719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XN2PsVitdwqyT+0EuFJyx51meuS/idl3glEF5fMYEO0=;
  b=SdfP09vQuoExcpD9inn0lQszbINo8yTg2Ef0L7KGDmnx2nDytYcsLfPm
   jppCZAXhYFKRd7rWn10DPN+NQjF2HP0TeJCVAYLzO/02VSQluosvGjNTj
   bDzlheEdh2/aZPISo4AaYzItckiuI8D+R0xCoU7dBapOFkJkstMGs1w5q
   ngA/6HK+21taVj6dQtCRL2c9cOw3K8jov+5+b1IN6xEKwcGxI8k9fXTvG
   bTAZQpDKWrBUHTG2maTOyWnRFY5OFheebWHmJbtPlFdGQxoBB43hwd/wV
   nTFQSBT0VjgRHGU5P1GvMgd1VvebZxNtQLqtMCi36yMvRC/OOWBwyAtib
   g==;
X-CSE-ConnectionGUID: siq+2CthRASfwtJCQcwUwQ==
X-CSE-MsgGUID: U0SuGwkgQgabUjyyOSw/Lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="46258293"
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="46258293"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 10:35:18 -0700
X-CSE-ConnectionGUID: PT2O5JZcSyCtWNy+z3Irog==
X-CSE-MsgGUID: qyimSlEjTtmy07lmiKhruw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,192,1719903600"; 
   d="scan'208";a="63885974"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 31 Aug 2024 10:35:14 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skS0G-0002yK-0M;
	Sat, 31 Aug 2024 17:35:12 +0000
Date: Sun, 1 Sep 2024 01:35:06 +0800
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
Message-ID: <202409010106.kqFZrO3g-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on defaf1a2113a22b00dfa1abc0fd2014820eaf065]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Bianconi/dt-bindings-arm-airoha-Add-the-chip-scu-node-for-EN7581-SoC/20240831-222958
base:   defaf1a2113a22b00dfa1abc0fd2014820eaf065
patch link:    https://lore.kernel.org/r/20240831-en7581-pinctrl-v3-4-98eebfb4da66%40kernel.org
patch subject: [PATCH v3 4/5] pinctrl: airoha: Add support for EN7581 SoC
reproduce: (https://download.01.org/0day-ci/archive/20240901/202409010106.kqFZrO3g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409010106.kqFZrO3g-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
>> Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/pinctrl/airoha,en7581-pinctrl.yaml
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

