Return-Path: <linux-pwm+bounces-8370-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAwqOZAFxGnOvQQAu9opvQ
	(envelope-from <linux-pwm+bounces-8370-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 16:56:00 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65742328840
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 16:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4702B3418BF1
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFA33F9F31;
	Wed, 25 Mar 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5qtIkjM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643D22E3E9;
	Wed, 25 Mar 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450924; cv=none; b=AwZJa55mZa87IFUp2ZA3fbrAWG9SJZsaoaQRSyf9dqoi4AZbhrtk5FTYTFJySCYs73q9jL2pN77dNzN0167QhuvO4qTUzsAXa14bbIMg5lQf8D0IKN/klLVSQdAjE39iAhBmNfW8XD9rsniwCapgNH3qshjmkqF2NHJI2U42Hao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450924; c=relaxed/simple;
	bh=gIUfeBRRWBa0s/P/ovRzF4jBgBesrI0Q2uvAtRlUSL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i51GRu2oidwcCdKhphGYGjLO03LmKsC+4jmT3qcjNuJl32LgmChiyqVgVvwYtSJ2DL1PX+NLG5+sP4AF2k7Rul9DgYVw/qWVxlbUedv4d8lrwnQ2B+EesesQUrZtfBD2WIOSk/qckV7eDuDArGnIChRh2/DdsHsBQwli8HP57g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5qtIkjM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774450923; x=1805986923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gIUfeBRRWBa0s/P/ovRzF4jBgBesrI0Q2uvAtRlUSL8=;
  b=B5qtIkjMAZpsDE68/3NKZpe9WBe7Xhp0foPie7FiLojMFCQaicRqaG9w
   G/3CZ8DFm5PSkwk5Zc9KMQ4516ShY9/14g1GEYiFtGeEoBYdp0jILLXW7
   IdBvR+X7TsYZdmCmkp436XzDRmxHmOkZkkn00laoB4I7Pit9+cHtfxHqM
   mZxzgde5m1U4FX711LfcT678edu1JtXKi/IXVFqGYLkK9TWGXw/OFkzlE
   3GvxnxjqWsBWdcWqIxxsowX4Mql76g5nWh8yiT3X3debo+uRqWtdXaePZ
   XT7lRgdoyrXFtVccyzBE9co7llAvgpSuyAG7IdnDRk0+4wr9tPiC8V0BI
   Q==;
X-CSE-ConnectionGUID: wHIfhkybRWSa5KcSdqkm8w==
X-CSE-MsgGUID: rNSZ0KuySQWcZRZzR/h1NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75395806"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75395806"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 08:02:02 -0700
X-CSE-ConnectionGUID: 73C6AkAaTH+hmQJStSXH5A==
X-CSE-MsgGUID: wzCUs5cJQuy8BEO4N6nDLg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Mar 2026 08:01:57 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5Pk2-0000000074z-3dZS;
	Wed, 25 Mar 2026 15:01:54 +0000
Date: Wed, 25 Mar 2026 23:01:15 +0800
From: kernel test robot <lkp@intel.com>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691
 family
Message-ID: <202603252241.8UAUrLG4-lkp@intel.com>
References: <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181@analog.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8370-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,metafoo.de,analog.com,baylibre.com,gmail.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 65742328840
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Radu,

kernel test robot noticed the following build errors:

[auto build test ERROR on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Sabau-via-B4-Relay/dt-bindings-iio-adc-add-bindings-for-AD4691-family/20260314-040740
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260313-ad4692-multichannel-sar-adc-driver-v3-2-b4d14d81a181%40analog.com
patch subject: [PATCH v3 2/4] iio: adc: ad4691: add initial driver for AD4691 family
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260325/202603252241.8UAUrLG4-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603252241.8UAUrLG4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603252241.8UAUrLG4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   drivers/iio/adc/ad4691.c: In function '__ad4691_set_sampling_freq':
>> include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_418' declared with attribute error: clamp(freq, 1, st->chip->max_rate) signedness error
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:687:25: note: in definition of macro '__compiletime_assert'
     687 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:190:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     190 |         BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),                          \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:195:9: note: in expansion of macro '__clamp_once'
     195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
         |         ^~~~~~~~~~~~
   include/linux/minmax.h:206:28: note: in expansion of macro '__careful_clamp'
     206 | #define clamp(val, lo, hi) __careful_clamp(auto, val, lo, hi)
         |                            ^~~~~~~~~~~~~~~
   drivers/iio/adc/ad4691.c:419:16: note: in expansion of macro 'clamp'
     419 |         freq = clamp(freq, 1, st->chip->max_rate);
         |                ^~~~~
--
   In file included from <command-line>:
   ad4691.c: In function '__ad4691_set_sampling_freq':
>> include/linux/compiler_types.h:706:45: error: call to '__compiletime_assert_418' declared with attribute error: clamp(freq, 1, st->chip->max_rate) signedness error
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:687:25: note: in definition of macro '__compiletime_assert'
     687 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:706:9: note: in expansion of macro '_compiletime_assert'
     706 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:190:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     190 |         BUILD_BUG_ON_MSG(!__types_ok3(uval, ulo, uhi),                          \
         |         ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:195:9: note: in expansion of macro '__clamp_once'
     195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_), __UNIQUE_ID(h_))
         |         ^~~~~~~~~~~~
   include/linux/minmax.h:206:28: note: in expansion of macro '__careful_clamp'
     206 | #define clamp(val, lo, hi) __careful_clamp(auto, val, lo, hi)
         |                            ^~~~~~~~~~~~~~~
   ad4691.c:419:16: note: in expansion of macro 'clamp'
     419 |         freq = clamp(freq, 1, st->chip->max_rate);
         |                ^~~~~


vim +/__compiletime_assert_418 +706 include/linux/compiler_types.h

eb5c2d4b45e3d2d Will Deacon 2020-07-21  692  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  693  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21  694  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  695  
eb5c2d4b45e3d2d Will Deacon 2020-07-21  696  /**
eb5c2d4b45e3d2d Will Deacon 2020-07-21  697   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  698   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2d Will Deacon 2020-07-21  699   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2d Will Deacon 2020-07-21  700   *
eb5c2d4b45e3d2d Will Deacon 2020-07-21  701   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  702   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2d Will Deacon 2020-07-21  703   * compiler has support to do so.
eb5c2d4b45e3d2d Will Deacon 2020-07-21  704   */
eb5c2d4b45e3d2d Will Deacon 2020-07-21  705  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2d Will Deacon 2020-07-21 @706  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2d Will Deacon 2020-07-21  707  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

