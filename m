Return-Path: <linux-pwm+bounces-5252-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F8A69C1B
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 23:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34D5A175C6A
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50AF21B9DE;
	Wed, 19 Mar 2025 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/cnx18F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20C921859F;
	Wed, 19 Mar 2025 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423683; cv=none; b=rn2r7lk3p5/Ap3uBsVfV+PSQ5mzuQ8wmPp7PFJSGdlvj/FD95S0ua+5T6zzx0h6VwYekLul035YZXn6NOSuw3EuaOjPxm2PhnrM9IdaDCzwJ+3VWzUwOSVJ9cQoYjN+jjEvpsuxvjn8bs7U1+nePYyl2Oznh8qTJ/Yvoalq6juw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423683; c=relaxed/simple;
	bh=KCy7t8Yz0VMqKbVcqZL+O6hHMwl4B/WS992u8Lny0Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqGjJgewvBlt+rIYzGQ9aAejSdaQ8N5VKeElbm8XzNPnNjVojq9jXSq0nYw/gWjQebCEZ1cJiNlioRsjk1HlfcrTUMqYagkFUjFtgpsCwu6sIFdKTznlcVq0Yfuf3Ahqx5Fmmle/50J86MNyl+Cxv4MyjqLqOKtqaOPD0bae9R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/cnx18F; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742423681; x=1773959681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KCy7t8Yz0VMqKbVcqZL+O6hHMwl4B/WS992u8Lny0Kg=;
  b=I/cnx18FPa1ChEEgs9fJJeUywZoIyt+KC1X9nQwl7LEL24aP124qu0i+
   Ny+8l9wyUiHSCrIVr41AGeDikF8ZvHQiI/5LEzqN/sQA1+9K4g8P5ojED
   VN/ndewqzb42CGW0apJGZDh4DlamC9bae0xwQJlPc8p2LBRcTm8RPNImL
   p+aJPC9ZnSK+lT77DkiGiQ7srAKNdSjCyU7XTRtVGIDa1IHll0QjM4iy+
   o2uYjucb3pMuY7io8NF0Y6jHA0B46P/FDekbiG+uOQimQMPkyFTq+kX0p
   ecwCVGij3N0Z3GSVLkTEy4i3NIgIqowOnlJlB9pTpfGkRZUxAAes/u3me
   Q==;
X-CSE-ConnectionGUID: piZcfzYoSyOkzVXxH7ZO/Q==
X-CSE-MsgGUID: 87U0rLZ2S6KOFWy30P5aQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="47291528"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="47291528"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 15:34:40 -0700
X-CSE-ConnectionGUID: kICRZPFERJ2rAPiyNjOawA==
X-CSE-MsgGUID: b+aJhSqARFSmGqGIMsFwgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="122823583"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 19 Mar 2025 15:34:34 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv1zc-000FiY-07;
	Wed, 19 Mar 2025 22:34:32 +0000
Date: Thu, 20 Mar 2025 06:34:05 +0800
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
Subject: Re: [PATCH v5 08/11] gpio: max7360: Add MAX7360 gpio support
Message-ID: <202503200617.h8re2FlY-lkp@intel.com>
References: <20250318-mdb-max7360-support-v5-8-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-8-fb20baf97da0@bootlin.com>

Hi Mathieu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a64dcfb451e254085a7daee5fe51bf22959d52d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-mfd-gpio-Add-MAX7360/20250319-003750
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250318-mdb-max7360-support-v5-8-fb20baf97da0%40bootlin.com
patch subject: [PATCH v5 08/11] gpio: max7360: Add MAX7360 gpio support
config: nios2-kismet-CONFIG_PINCTRL_MAX7360-CONFIG_GPIO_MAX7360-0-0 (https://download.01.org/0day-ci/archive/20250320/202503200617.h8re2FlY-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250320/202503200617.h8re2FlY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503200617.h8re2FlY-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PINCTRL_MAX7360 when selected by GPIO_MAX7360
   WARNING: unmet direct dependencies detected for PINCTRL_MAX7360
     Depends on [n]: PINCTRL [=n] && MFD_MAX7360 [=y]
     Selected by [y]:
     - GPIO_MAX7360 [=y] && GPIOLIB [=y] && MFD_MAX7360 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

