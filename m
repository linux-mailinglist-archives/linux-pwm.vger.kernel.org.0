Return-Path: <linux-pwm+bounces-4003-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7619B96DA
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 18:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50BA42826FD
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8CE1CCEE9;
	Fri,  1 Nov 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmDtsvTa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8614885D;
	Fri,  1 Nov 2024 17:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483456; cv=none; b=LWeBmQOroXiJufclDKfQXqZdgg/pcwPqyCsE6WrEJDhJmmG6SLZjmfueAtG04XOgSalUJFZFJYf8NsVD0w53iiqORNp66e1ZeRAb5jXxsoQax2K06iZ2pOQ4iuxKLF/yGseLvB8B/B//SZbrjDN2cxbDyhaKovjRyZfSNUs8+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483456; c=relaxed/simple;
	bh=8z76fWUIrMQ8Og3lj5xj4kQZ1y/oAsRmPurPzMj0fyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUwzdZF48G+0Gu0DOWBWqzC7ok/eT7SaaBm+7bWdKDDOaRu4IR/i1AlkeXn5qZFzNiKF8dX1OPWPPiNvurDBBd+dESECbyrnrVf4aZKlWoEORWhjM7jJeAbwTbeK0OVF2Sk3qoKmPKyN5GrjAZBm5+fdAFHyEU/CCRebBqzmiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmDtsvTa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730483455; x=1762019455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8z76fWUIrMQ8Og3lj5xj4kQZ1y/oAsRmPurPzMj0fyk=;
  b=BmDtsvTaHB4UFvEN15o4QxTrWzOUGmvr1VjNx1xrRkYdY10ey38m4Q3V
   REG83ZLu2s53Vjkl9m8nc8bezZc/1mLwyhFedo6ZtKwHdTbnSiKuIsSKk
   5J0JkWL4vcIUDRkHQH47MLdA5S9UgqbAydcnQwQWsHXzSpDGT9z2dOIEi
   Fw5Kl7JdKYR9TaVv5yBc7U1QjTCGY5aKsh83VQHq2N39wVFiPLYZjib7c
   EZNACAzj70uFcajVj/nz5wVzHigtBiGkXe/ryT7exwU2KddGhFvRZ1qgm
   6K2P+vWtLdhIlv5qCeogEt/390Kh14sbHKJQN1TADMk+p72HK6BbLf8IZ
   w==;
X-CSE-ConnectionGUID: nm5YB/sfRdyK5TzKb25wxw==
X-CSE-MsgGUID: qI0XPKs6Rj+RbU3hEkTWiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30109489"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30109489"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 10:50:54 -0700
X-CSE-ConnectionGUID: silh1jIvQxCkBqRXrjE8cg==
X-CSE-MsgGUID: 3W1UfGhwT/6TyULh72D0mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="82555071"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 01 Nov 2024 10:50:51 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6vnN-000hqB-2c;
	Fri, 01 Nov 2024 17:50:49 +0000
Date: Sat, 2 Nov 2024 01:50:35 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Guillaume Stols <gstols@baylibre.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
Message-ID: <202411020101.5Hs6MkwQ-lkp@intel.com>
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
config: i386-randconfig-141-20241101 (https://download.01.org/0day-ci/archive/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241102/202411020101.5Hs6MkwQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411020101.5Hs6MkwQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad7606.c: In function 'ad7606_read_raw':
>> drivers/iio/adc/ad7606.c:765:23: error: implicit declaration of function 'pwm_get_state_hw'; did you mean 'pwm_get_state'? [-Werror=implicit-function-declaration]
     765 |                 ret = pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
         |                       ^~~~~~~~~~~~~~~~
         |                       pwm_get_state
   cc1: some warnings being treated as errors


vim +765 drivers/iio/adc/ad7606.c

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

