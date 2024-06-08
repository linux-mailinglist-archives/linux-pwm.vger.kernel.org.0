Return-Path: <linux-pwm+bounces-2388-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C629901201
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2024 16:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66411F2166A
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2024 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C603417A933;
	Sat,  8 Jun 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RryReEsD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993FF17A920;
	Sat,  8 Jun 2024 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856701; cv=none; b=pbYQDFRu7jjZ7xKWX8e7IlQcEsGFiarl9tFr6HxVEE1bfqg/X+4OT9h7XFdsInV1ZxTMqer0TlDGAvnY9DVbq1TBzfNK5Nul1yMXeaQ3uleBmFJGUXcpXv5iKudBKOXLlBxq1p2L/SL9l3+b0XRX1At1y4Pbe/MF1lNbewqq2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856701; c=relaxed/simple;
	bh=rlC8MSGnb6YA01DoUOnDbXDIu1BbNuO1qPii8soutYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyFxEhFjv+EP1ZTJOpJd85muY2qLJTdQ1GheM01SL8y0ba92hsUhZUxMpAglERo2M2F5f/SekaoHj7pEdcr9mRBtG+ZSW0Czju+Z9cTvM/ugkx63NxtItVrHOlvjFxf7HkJmiPIOyLRG+BiM2xUD9a45dhMfUv0/enHz9O2Uh6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RryReEsD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717856699; x=1749392699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=rlC8MSGnb6YA01DoUOnDbXDIu1BbNuO1qPii8soutYw=;
  b=RryReEsDvLT4lzCCkDlBOj1ew5Dm0l+HIgaKOaiJsxDmJcyv/W+nRkuE
   nVQ446Nr74QU4ALeP2oeK/uoMyA6nwcSTiPo530exjcgv3sMSPSByAp+7
   1UU4HtvJ00KJ56YKKH72Sh+sjgFcD0INbw5gRoo9+x8q4+4rS0BMhf+fU
   EjqhPlfNsFAihqi6muzLYfno41wVYxtPqqm6BqJLGJnBSw6eVFXigcAw6
   72smYIgdFOZnJ+ZR6mh+PRT6gy2q4Se1dKooAWu7SrB6OA1h1llZDRzdD
   zzdd3h1VCWbHQ4JC1tpxcPf2ayoJDtkGBNfpl+ZFla/GCODAVg3zT7PIY
   w==;
X-CSE-ConnectionGUID: kB8I2w7MTLCbd67QT+sd2w==
X-CSE-MsgGUID: XbEm6xjHSK2Pk5q7znAadQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="14726828"
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="14726828"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2024 07:24:59 -0700
X-CSE-ConnectionGUID: 08A8MsLfQq2uUBz6UiXTFQ==
X-CSE-MsgGUID: 8j2cGZ7nTMC2JfPsGBkgKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,223,1712646000"; 
   d="scan'208";a="38547777"
Received: from lkp-server01.sh.intel.com (HELO 8967fbab76b3) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 08 Jun 2024 07:24:57 -0700
Received: from kbuild by 8967fbab76b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFx02-00001W-2M;
	Sat, 08 Jun 2024 14:24:54 +0000
Date: Sat, 8 Jun 2024 22:24:05 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@baylibre.com>,
	Benson Leung <bleung@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
	linux-pwm@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: cros-ec: Don't care about consumers in
 .get_state()
Message-ID: <202406082139.KG4VcZiF-lkp@intel.com>
References: <20240607084416.897777-6-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240607084416.897777-6-u.kleine-koenig@baylibre.com>

Hi Uwe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/pwm-cros-ec-Don-t-care-about-consumers-in-get_state/20240607-164747
base:   1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
patch link:    https://lore.kernel.org/r/20240607084416.897777-6-u.kleine-koenig%40baylibre.com
patch subject: [PATCH 1/3] pwm: cros-ec: Don't care about consumers in .get_state()
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240608/202406082139.KG4VcZiF-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240608/202406082139.KG4VcZiF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406082139.KG4VcZiF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-cros-ec.c:28: warning: Excess struct member 'channel' description in 'cros_ec_pwm_device'


vim +28 drivers/pwm/pwm-cros-ec.c

3d593b6e80ad2c Fabio Baltieri   2022-04-28  17  
1f0d3bb02785f6 Brian Norris     2016-07-15  18  /**
1f0d3bb02785f6 Brian Norris     2016-07-15  19   * struct cros_ec_pwm_device - Driver data for EC PWM
1f0d3bb02785f6 Brian Norris     2016-07-15  20   *
1f0d3bb02785f6 Brian Norris     2016-07-15  21   * @ec: Pointer to EC device
3d593b6e80ad2c Fabio Baltieri   2022-04-28  22   * @use_pwm_type: Use PWM types instead of generic channels
82adc1b2688b02 Uwe Kleine-König 2023-07-05  23   * @channel: array with per-channel data
1f0d3bb02785f6 Brian Norris     2016-07-15  24   */
1f0d3bb02785f6 Brian Norris     2016-07-15  25  struct cros_ec_pwm_device {
1f0d3bb02785f6 Brian Norris     2016-07-15  26  	struct cros_ec_device *ec;
3d593b6e80ad2c Fabio Baltieri   2022-04-28  27  	bool use_pwm_type;
1db37f9561b2b3 Thierry Reding   2019-10-17 @28  };
1db37f9561b2b3 Thierry Reding   2019-10-17  29  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

