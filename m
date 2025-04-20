Return-Path: <linux-pwm+bounces-5587-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36A1A94677
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 04:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053721765BD
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Apr 2025 02:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2356F30F;
	Sun, 20 Apr 2025 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BwESSD6l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9635946;
	Sun, 20 Apr 2025 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745115709; cv=none; b=Cwnq4Q+lDCYrAeuIZCzrKYU9dJn/cg9Ea9FuKVjyOacb6uPNsA4CAL6R/pzpu4b5IpmQgNSaBNSCMZMxkQ4MOen7rHq+A4hOmE/b/XhxidraYpek+WQn3SHHF977iRu3JTXojFbTUp8JnjIrzN4wLZiLZQu9uUc3ZvybTYE1bHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745115709; c=relaxed/simple;
	bh=S2qG97NYouj37jOehp9hrQYtd5QhRNH6vXMDLSxVO1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhmyznBD8YXvfSEUISqO/jchvMVXmMOgrXeRzypz50A4z0SS8dHYL6aucFgTvSMYmXQ3nhhjFzc9QeVkxTAmvEmYVc9PRHeTI+J4wrv9mA+j0fQIVr97paPSDi6pFoMe7wwLuYAzDuhAbalhe7XAFH11a3WAtJVGaJws9R13sCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BwESSD6l; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745115708; x=1776651708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S2qG97NYouj37jOehp9hrQYtd5QhRNH6vXMDLSxVO1A=;
  b=BwESSD6lXSXLET6k/8X7qu5IalMDbJgOvC1L98oeI7ly02F4Yj2RbCFJ
   cLBg7y9O25z4oWXJtHci8bMlN66KXNT5U2VzNaPif2NkiWRLQz1zhyY/W
   cJXONPutqZ2Md9yvwf1PX7WexYGc6gAUaKoWqhMIs3COLuBWbYm/viNbd
   cV5b/f7EamwtFhpyRSIBbAse7O8soUU6ale/gBzsLST5+bXZu/iHhCDmI
   poxLR5NEZGO5dJ3tnqo/GbCHwc9M5OmMsP1nyKp8QqZT8o2qSOqAhP6AD
   zvvzmor/ZFr/q0PjoDI5dEjGLrwqc7+hTyW/XDgTu3FDCUrbJPfESsP6A
   g==;
X-CSE-ConnectionGUID: qZg8dISxREqH6ikJEHnDIQ==
X-CSE-MsgGUID: YMadNgLWRzG847AgjMCmGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="46583973"
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="46583973"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 19:21:47 -0700
X-CSE-ConnectionGUID: BCen5bskTb+oZo+xMNn8YA==
X-CSE-MsgGUID: tgU5JMTuRCaq9U4zInUKDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,225,1739865600"; 
   d="scan'208";a="168621082"
Received: from lkp-server01.sh.intel.com (HELO 61e10e65ea0f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 19 Apr 2025 19:21:45 -0700
Received: from kbuild by 61e10e65ea0f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1u6KJT-0004Kz-06;
	Sun, 20 Apr 2025 02:21:43 +0000
Date: Sun, 20 Apr 2025 10:21:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, ukleinek@kernel.org
Subject: Re: [PATCH v2 1/1] pwm: tiehrpwm: ensures that state.enabled is
 synchronized in .probe()
Message-ID: <202504201050.o3m04RP6-lkp@intel.com>
References: <20250206031852.64853-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206031852.64853-1-rafael.v.volkmer@gmail.com>

Hi Rafael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.15-rc2 next-20250417]
[cannot apply to thierry-reding-pwm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rafael-V-Volkmer/pwm-tiehrpwm-ensures-that-state-enabled-is-synchronized-in-probe/20250420-075200
base:   linus/master
patch link:    https://lore.kernel.org/r/20250206031852.64853-1-rafael.v.volkmer%40gmail.com
patch subject: [PATCH v2 1/1] pwm: tiehrpwm: ensures that state.enabled is synchronized in .probe()
config: arc-randconfig-001-20250420 (https://download.01.org/0day-ci/archive/20250420/202504201050.o3m04RP6-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250420/202504201050.o3m04RP6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202504201050.o3m04RP6-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-tiehrpwm.c:105: warning: expecting prototype for The ePWM hardware encodes compare actions with two bits each(). Prototype was for AQ_CLEAR() instead


vim +105 drivers/pwm/pwm-tiehrpwm.c

    97	
    98	/**
    99	 * The ePWM hardware encodes compare actions with two bits each:
   100	 *   00 = Do nothing
   101	 *   01 = Clear
   102	 *   10 = Set
   103	 *   11 = Toggle
   104	 */
 > 105	#define AQ_CLEAR  1
   106	#define AQ_SET    2
   107	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

