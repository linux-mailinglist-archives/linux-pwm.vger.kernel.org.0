Return-Path: <linux-pwm+bounces-5246-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0383DA68D4C
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 13:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C544A3AA816
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BFB2561DA;
	Wed, 19 Mar 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAXquBf/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DB2561B7;
	Wed, 19 Mar 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389091; cv=none; b=qQXMHBYWzxahzXaE48WkFTv5inpQ3Psavya9x/8GZcA1qJJr4LpVQqyYAwNzTdItgraZogqjz3mrWPXXMpPrAzkQXSbXDXN05jG0xBADaVMgiC5szSJwueMqMMaoy/HqHqC0XmTum1McWs3GW+8bXoo9eyQ7Kt2YY4TRNdEI+LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389091; c=relaxed/simple;
	bh=B836gvwvbjKEVtbKy2rrwgjFfgNXYIH+bguMRtkbPD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiLlbYEtjBw+cGTrZX7PXGm9iRPlGx55iv/P1AV8ThC4m25GSeK+uatm2L8DJs0AMPWsQbTkFIcF2M/lmo6eFnby00fJ6la6UulaQ959tG7f6cQnJ8x2FpjCmVM7QTorxM2yO/zBIL8FLPk6uVEbRPXa+2H6S15eN9oNdaNP21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAXquBf/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742389090; x=1773925090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B836gvwvbjKEVtbKy2rrwgjFfgNXYIH+bguMRtkbPD8=;
  b=eAXquBf/fNqAXhKn0YdWZTJD6YRgx3S7MBbB93i5tI3utAu954kizXKb
   V60ytQzoAin6MwoECCUr+K6xgBnWO9v9VnrKo9/QZBtnc2V/OKJKtPhPF
   wAiKkNdr9/fjN77dqp4Mo0vPSTpd98bN6Qle/WEwafz2adla9D+l9xpIp
   s1ZdGurESWr9veomKsIIx30zXqCu3oP+s/lnAz3OArhc8zTPfQuojW6eh
   +fd4DVq5ugAtmp3y9SdYGzrQ0dlMhzPV08XPZvqA2cqI8Syrfw2r495o1
   M9I59SrUV8ymzu0wRDv1b+N+V0WYLpJ0uQ5N17MjkXMjMc6elm/zXtEdw
   A==;
X-CSE-ConnectionGUID: P3EzCsfvSo6bir4E3rOi/A==
X-CSE-MsgGUID: m9e5akieSbS0r09WIE+0jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="61104369"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="61104369"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:58:09 -0700
X-CSE-ConnectionGUID: yn0EHMxvQ3Ka099ToVywog==
X-CSE-MsgGUID: Hw6VZvj+S6S7Ib17y23Hqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123545230"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 19 Mar 2025 05:58:03 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuszh-000EgQ-0d;
	Wed, 19 Mar 2025 12:58:01 +0000
Date: Wed, 19 Mar 2025 20:57:48 +0800
From: kernel test robot <lkp@intel.com>
To: mathieu.dubois-briand@bootlin.com, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <202503192044.ICDBVYzc-lkp@intel.com>
References: <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a64dcfb451e254085a7daee5fe51bf22959d52d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-mfd-gpio-Add-MAX7360/20250319-003750
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250318-mdb-max7360-support-v5-4-fb20baf97da0%40bootlin.com
patch subject: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503192044.ICDBVYzc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192044.ICDBVYzc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192044.ICDBVYzc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pwm/pwm-max7360.c: In function 'max7360_pwm_request':
>> drivers/pwm/pwm-max7360.c:41:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
     struct device *dev;
                    ^~~
   drivers/pwm/pwm-max7360.c: In function 'max7360_pwm_free':
   drivers/pwm/pwm-max7360.c:58:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
     struct device *dev;
                    ^~~


vim +/dev +41 drivers/pwm/pwm-max7360.c

    37	
    38	static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
    39	{
    40		struct regmap *regmap;
  > 41		struct device *dev;
    42		int ret;
    43	
    44		regmap = pwmchip_get_drvdata(chip);
    45		dev = regmap_get_device(regmap);
    46	
    47		ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
    48					MAX7360_PORT_CFG_COMMON_PWM, 0);
    49		if (ret)
    50			return ret;
    51	
    52		return regmap_write_bits(regmap, MAX7360_REG_PORTS, BIT(pwm->hwpwm), BIT(pwm->hwpwm));
    53	}
    54	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

