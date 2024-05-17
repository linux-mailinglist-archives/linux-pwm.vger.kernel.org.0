Return-Path: <linux-pwm+bounces-2177-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75318C7F5E
	for <lists+linux-pwm@lfdr.de>; Fri, 17 May 2024 03:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0AB1C209E8
	for <lists+linux-pwm@lfdr.de>; Fri, 17 May 2024 01:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8415A7E2;
	Fri, 17 May 2024 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3STPNMZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37278622;
	Fri, 17 May 2024 01:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715908017; cv=none; b=VTHP0L6WN3i64nGwEXiH+2WSm8IAtDNCH8Cw3BwevQUkeEIk4vVMif44xlc1ITjuJlC0P5bwEVo2qC26hkqDW8Kas+6qFggXifBucmb1VHK8xZDeNKKpA9HvN42Y9tgYPBYFZ6XlS84od1OJVVrvYcETZ/jdowhlO8BnhV3jRJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715908017; c=relaxed/simple;
	bh=6n1sbF7/4b4JqOGlapOQrVWAyJBowv28nqLWZTDggdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ+/gh0F/hqKm/U81sKwAC9qoPelsbQKxvvPLRYYORuXybMvYdYGceqVPfZH++fxRb+m+5gek8ZqKOx7/bWL0Wh0ZWJDHhUldjEtiG0izMOj/w3dAVTuRqF+QToeWd44lQT+VKSIAO8KTDXZPxdfhsA6qE9h4hRmb5h7dc08+Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3STPNMZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715908016; x=1747444016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6n1sbF7/4b4JqOGlapOQrVWAyJBowv28nqLWZTDggdI=;
  b=L3STPNMZNoFWV03iCyfh544sVZGJ/6KiGoeXjpfFl9fPRSoZ9RI2P811
   cgBIqyP7Dq0tt5WQXk75DnosebAywNkfa/M0YlvnR8UV26R5srGwvVXjg
   ykeozIov04MNxV7X2ki0nosTU1vwtRMNCSeOjS6/kCuXaKI4JANTWduw6
   WmF4uv/hY3NCZAgaOivuUWbXbSZX/gHMKl8KEk65PelPuBeF81Rz7lQV9
   G8WCp2VADJUljuL29Wu0EUL04/GkyFK6+EMODD1U9q+nPbFninzqeBFYS
   Z+nHRcd0jrPaCk/aedyyKsAtaCyPkODM3Up+Aqemz5BLaTmiLZgKnU4xb
   A==;
X-CSE-ConnectionGUID: PIAIjC6sSba+uuAVe2JyNA==
X-CSE-MsgGUID: i+Eppp3zT3K0z2TpQKk24w==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="11565762"
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="11565762"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 18:06:55 -0700
X-CSE-ConnectionGUID: qZIvFWG3R+C/Nq/b3q1eVA==
X-CSE-MsgGUID: TtATRyHEQ5iGQX4TsjsseA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,166,1712646000"; 
   d="scan'208";a="31628614"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 16 May 2024 18:06:52 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7m3e-000F3x-06;
	Fri, 17 May 2024 01:06:50 +0000
Date: Fri, 17 May 2024 09:06:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Dimitri Fedrau <dima.fedrau@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pwm: add support for NXPs high-side switch
 MC33XS2410
Message-ID: <202405170826.pUFGJfD7-lkp@intel.com>
References: <20240515112034.298116-3-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515112034.298116-3-dima.fedrau@gmail.com>

Hi Dimitri,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.9 next-20240516]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dimitri-Fedrau/dt-bindings-pwm-add-support-for-MC33XS2410/20240515-192237
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240515112034.298116-3-dima.fedrau%40gmail.com
patch subject: [PATCH v3 2/2] pwm: add support for NXPs high-side switch MC33XS2410
config: arm-randconfig-r121-20240517 (https://download.01.org/0day-ci/archive/20240517/202405170826.pUFGJfD7-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240517/202405170826.pUFGJfD7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405170826.pUFGJfD7-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/pwm/pwm-mc33xs2410.o: in function `mc33xs2410_pwm_apply':
>> pwm-mc33xs2410.c:(.text+0x3c0): undefined reference to `__aeabi_uldivmod'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

