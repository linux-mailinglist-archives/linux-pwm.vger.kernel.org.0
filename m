Return-Path: <linux-pwm+bounces-5253-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDAFA69D4C
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 01:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA217B0361
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA821154457;
	Thu, 20 Mar 2025 00:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WgGfDUd3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C892F28;
	Thu, 20 Mar 2025 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742430651; cv=none; b=TLRur3lNbyy62xiTkxGBWODUitUiayj+9YPOKD/maWkNRuJ72rNzUQw4fKfUf7VQgY7copxg3RDdbg8FCm3wXK6SO3Fo6ffq6rqqfexhGxHz+Sr61shI0B0542ETuE4rbYAokxWtN9wq6PpJzFjbpvJMHtQfYTV5tY9HIRiNKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742430651; c=relaxed/simple;
	bh=TSqTPn2zV1wuz0UVtcBTLSVgBIk87jiVeuZ75T61nSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PECoeFlvr6CCLBP02g14CBSCFbj6fkZhXdtveHD8Rr/765aoVDoQmFwEp9+G08iR22SewWIRbRvYheSBvssDNafoTyF+iEZTITDtR8hdu7yNx4X6qw55FY+4vOxO689nzCtW0FR4c6978/TDOKYRFbZDFutAOHrb6BJTvvVKtCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WgGfDUd3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742430650; x=1773966650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TSqTPn2zV1wuz0UVtcBTLSVgBIk87jiVeuZ75T61nSk=;
  b=WgGfDUd3mxoOB84Hxo1YUUtsyENNXYfA41cD2evZVLUAnmj/rRKP4ouc
   IXDNkU1WnBOiyJioq3XRFGFwv6eMBb5aBEnujnBCo4Q6ByK+HYoAsAWck
   lb7eu/eT/A5WoeJutDaDiYkud4VLMgcir+C4/jz3AEA6J+ltSYqvT1e3t
   4gOkN+CoQ7iqn8iDrIpd4d3Lt7Zy/sI3XQhAiKLuSE52kQ1Ic6glCm7rq
   +Q+1nY5snukH/jjZDRBiv5TsJtJ2S4v5CKNZQDQz5gxNd+DDeeMOCDwVR
   IArAqI2LHOjGvNG5PJIqm00EHEVAerCkyE/CHGNfWp1uIxtJCAULYMgDf
   A==;
X-CSE-ConnectionGUID: o8G/qV94RdGU5nyYwVF2Kg==
X-CSE-MsgGUID: H/4opU1TTHeFh9+I0po/6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="69001052"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="69001052"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 17:30:49 -0700
X-CSE-ConnectionGUID: lFtDldXFTw+3zJ3w4kc1Zw==
X-CSE-MsgGUID: TSp3a5+uSDmlYvDyRsFznQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="123044914"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 19 Mar 2025 17:30:43 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv3nr-00002Z-0X;
	Thu, 20 Mar 2025 00:30:33 +0000
Date: Thu, 20 Mar 2025 08:29:26 +0800
From: kernel test robot <lkp@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH v5 10/11] input: misc: Add support for MAX7360 rotary
Message-ID: <202503200825.rmtamLkh-lkp@intel.com>
References: <20250318-mdb-max7360-support-v5-10-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-10-fb20baf97da0@bootlin.com>

Hi Mathieu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a64dcfb451e254085a7daee5fe51bf22959d52d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-mfd-gpio-Add-MAX7360/20250319-003750
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250318-mdb-max7360-support-v5-10-fb20baf97da0%40bootlin.com
patch subject: [PATCH v5 10/11] input: misc: Add support for MAX7360 rotary
config: nios2-kismet-CONFIG_PINCTRL_MAX7360-CONFIG_INPUT_MAX7360_ROTARY-0-0 (https://download.01.org/0day-ci/archive/20250320/202503200825.rmtamLkh-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250320/202503200825.rmtamLkh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200825.rmtamLkh-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PINCTRL_MAX7360 when selected by INPUT_MAX7360_ROTARY
   WARNING: unmet direct dependencies detected for PINCTRL_MAX7360
     Depends on [n]: PINCTRL [=n] && MFD_MAX7360 [=y]
     Selected by [y]:
     - INPUT_MAX7360_ROTARY [=y] && INPUT [=y] && INPUT_MISC [=y] && MFD_MAX7360 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

