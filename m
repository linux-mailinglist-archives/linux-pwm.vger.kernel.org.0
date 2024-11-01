Return-Path: <linux-pwm+bounces-4011-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347319B9964
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 21:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D983D2821A2
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117E81D63E3;
	Fri,  1 Nov 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFr5gNK3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D21D130B;
	Fri,  1 Nov 2024 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730492705; cv=none; b=D5WDHgYNiovUKphtz7n2kQaU5UPKE6XQbwAdGZTE+47r8Aqe7Tp3hJKrfdzJEg780IggJKonBcMNopbezwBCa197tvW0xW8KwYnI6RyG7Dsz0bOH8xf07hSR48TAEKuAc/0HGXGHR0Q/hErkt+TZbH1WX0hwQ4yUZ6xNCaWuiOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730492705; c=relaxed/simple;
	bh=bjW/NCoam4Vnhany8p1O01mp0aqm+EOKnkh+sbXImR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFOtBk+WJZh31YOvPS9S1pN6NJ881mQ5zCn78IuuMwY6Po4mdKSuIUl1mSQW4USxpWMaKilbSWNQ2+DMkJBPjrTkMZfAh70q56UcipbJDJAzxRykfSIkbrCkx79V/T4pV2nd4+g/awJNbZrsL+mqA84SZ4JEyGu5SYD0RN7uPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFr5gNK3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730492703; x=1762028703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bjW/NCoam4Vnhany8p1O01mp0aqm+EOKnkh+sbXImR4=;
  b=nFr5gNK3qwUE75vyYt/oO9uqnhORSUFUeO0B0Ol1XFKVM/r9KRd7c6nP
   oTnE1kM8tlYPjqqA7lcIYS0g1e0vRfmEuCSdW2OH7E7h3/YCigLC3nk0Z
   OYs8kwHFVsXGPOJHBq9qU5d+KnG+D/+YSamXxBTWDoOTiC7Jc3u7QrAzL
   vOOpescNbE6wXyIHVcuJv/UZMFTKjuOf5kcE3esO7a/Ax+pqnOfqDorPu
   F1+p+R8sEDngbKJ40FnJUor/4TAXolzPxXUmavPORDaom63bLpICmWz1z
   RZ7qcQnOlDrGTZvTS8ypNEf5KMANler5g25UdAXPcW/F1WOUdrjaosSmw
   A==;
X-CSE-ConnectionGUID: v3CbH+HaT8m2Rz4u1vBn+w==
X-CSE-MsgGUID: n0q/YNyhSmy5Fp9Xl8JM+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47720865"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47720865"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 13:25:02 -0700
X-CSE-ConnectionGUID: X5qYRDRrQ1uEsmAEOs6W1g==
X-CSE-MsgGUID: 5vrLubZPSsG4Mh/qtxgQuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="87841658"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 01 Nov 2024 13:24:59 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6yCW-000i0Y-2D;
	Fri, 01 Nov 2024 20:24:56 +0000
Date: Sat, 2 Nov 2024 04:24:01 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Guillaume Stols <gstols@baylibre.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
Message-ID: <202411020416.BsBZy5XU-lkp@intel.com>
References: <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6fb2fa9805c501d9ade047fc511961f3273cdcb5]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/pwm-core-export-pwm_get_state_hw/20241030-052134
base:   6fb2fa9805c501d9ade047fc511961f3273cdcb5
patch link:    https://lore.kernel.org/r/20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230%40baylibre.com
patch subject: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
config: i386-buildonly-randconfig-004-20241102 (https://download.01.org/0day-ci/archive/20241102/202411020416.BsBZy5XU-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020416.BsBZy5XU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411020416.BsBZy5XU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/adc/ad7606.c:17:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2225:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/adc/ad7606.c:765:9: error: call to undeclared function 'pwm_get_state_hw'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     765 |                 ret = pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
         |                       ^
   drivers/iio/adc/ad7606.c:765:9: note: did you mean 'pwm_get_state'?
   include/linux/pwm.h:127:20: note: 'pwm_get_state' declared here
     127 | static inline void pwm_get_state(const struct pwm_device *pwm,
         |                    ^
   1 warning and 1 error generated.


vim +/pwm_get_state_hw +765 drivers/iio/adc/ad7606.c

   733	
   734	static int ad7606_read_raw(struct iio_dev *indio_dev,
   735				   struct iio_chan_spec const *chan,
   736				   int *val,
   737				   int *val2,
   738				   long m)
   739	{
   740		int ret, ch = 0;
   741		struct ad7606_state *st = iio_priv(indio_dev);
   742		struct ad7606_chan_scale *cs;
   743		struct pwm_state cnvst_pwm_state;
   744	
   745		switch (m) {
   746		case IIO_CHAN_INFO_RAW:
   747			iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
   748				ret = ad7606_scan_direct(indio_dev, chan->address, val);
   749				if (ret < 0)
   750					return ret;
   751				return IIO_VAL_INT;
   752			}
   753			unreachable();
   754		case IIO_CHAN_INFO_SCALE:
   755			if (st->sw_mode_en)
   756				ch = chan->address;
   757			cs = &st->chan_scales[ch];
   758			*val = cs->scale_avail[cs->range][0];
   759			*val2 = cs->scale_avail[cs->range][1];
   760			return IIO_VAL_INT_PLUS_MICRO;
   761		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
   762			*val = st->oversampling;
   763			return IIO_VAL_INT;
   764		case IIO_CHAN_INFO_SAMP_FREQ:
 > 765			ret = pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
   766			if (ret < 0)
   767				return ret;
   768			*val = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
   769			return IIO_VAL_INT;
   770		}
   771		return -EINVAL;
   772	}
   773	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

