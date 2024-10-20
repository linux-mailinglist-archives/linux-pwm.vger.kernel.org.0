Return-Path: <linux-pwm+bounces-3733-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97EA9A5384
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Oct 2024 12:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B83B2115C
	for <lists+linux-pwm@lfdr.de>; Sun, 20 Oct 2024 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A315183CD5;
	Sun, 20 Oct 2024 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMsrlVWo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E08121F;
	Sun, 20 Oct 2024 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729421084; cv=none; b=ACuZxdKuHERV4vNFz6p3pZMzTO0R/huE4j2kM7ZsvErneRkPt5Dftvi+XRzbFT9yJ6iCYvd3HbdtN2XKcD2pSFBYo2+Sun8R6BZoxCm9r212K6iIhCaDgQCuDthjNw4jilzZFQUdAzC4lwW+luzDpAdJqXx2DOJ7iU7DW3CFh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729421084; c=relaxed/simple;
	bh=BlU6SNAVuB+ePlLNf75kQesr0X45PWZmw4zKs7QsWaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsCf6JZBZLjCb+bWF21y0hydfvUBRBqklyMUCnFwUzgsAXtwuzHDVd5L8j4HQ+fCBLVhm+ulTBQYn2ccotshCqheg9hFt5O0GTv9dWX0c/6HwgtwmhUBaTlmbqUEV/GcmvkOa/xtw6wAHBwVHP4v5nSlV9RQOL0ID6b4UvngqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMsrlVWo; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729421082; x=1760957082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BlU6SNAVuB+ePlLNf75kQesr0X45PWZmw4zKs7QsWaA=;
  b=WMsrlVWoE22X3J+thmAmRaIhEQa2B7PkgNZ1Ol8FN5SGrgdPu8bkjuHB
   zMdKLfSuUkmLJApT1tM5J2XHUKf85mQGjoCTwOkBOKwP041b9RNzVWIWN
   jytWRC0G6pv1lZVIn8jQMLUduiYmWkdw/8gflDOTXzTr4HXYEkaiYWA2s
   uHplPB2m3JfH9/h+9nudGyvabeqKvT99xz6Pwjp1LOAtO/5tE7JN/6vzz
   A0z2dquX0COoHmpw+4IXZAdMylP1x7zR2+GAt7pZ4TbJvfsOrnUAprhBQ
   vGno805Y82SupY9hZBlVZ9Cj3uDXbBOEoln2bGkb+X1avbhpPgKk8T2fq
   Q==;
X-CSE-ConnectionGUID: 7zIYyh3ZTNWjVDWbM3Rqyw==
X-CSE-MsgGUID: A0JYpiVaQbK4KFmoEWGGAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11230"; a="54321247"
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="54321247"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2024 03:44:41 -0700
X-CSE-ConnectionGUID: bSBlRiX2SOu/CEqHAPGTHw==
X-CSE-MsgGUID: bIgfV6zqTKOGZlhOMRHZxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,218,1725346800"; 
   d="scan'208";a="110018743"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 20 Oct 2024 03:44:39 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t2TQK-000QDD-1C;
	Sun, 20 Oct 2024 10:44:36 +0000
Date: Sun, 20 Oct 2024 18:44:01 +0800
From: kernel test robot <lkp@intel.com>
To: George Stark <gnstark@salutedevices.com>,
	u.kleine-koenig@pengutronix.de, neil.armstrong@linaro.org,
	khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-pwm@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com, George Stark <gnstark@salutedevices.com>
Subject: Re: [PATCH v2 1/4] pwm: meson: Simplify get_state() callback
Message-ID: <202410201612.QJbPOweL-lkp@intel.com>
References: <20241016152553.2321992-2-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016152553.2321992-2-gnstark@salutedevices.com>

Hi George,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc3 next-20241018]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/George-Stark/pwm-meson-Simplify-get_state-callback/20241016-232751
base:   linus/master
patch link:    https://lore.kernel.org/r/20241016152553.2321992-2-gnstark%40salutedevices.com
patch subject: [PATCH v2 1/4] pwm: meson: Simplify get_state() callback
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241020/202410201612.QJbPOweL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410201612.QJbPOweL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410201612.QJbPOweL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pwm/pwm-meson.c: In function 'meson_pwm_get_state':
>> drivers/pwm/pwm-meson.c:312:35: warning: variable 'channel' set but not used [-Wunused-but-set-variable]
     312 |         struct meson_pwm_channel *channel;
         |                                   ^~~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/channel +312 drivers/pwm/pwm-meson.c

c375bcbaabdb92 Martin Blumenstingl 2019-06-12  306  
6c452cff79f8bf Uwe Kleine-König    2022-12-02  307  static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
211ed630753d2f Neil Armstrong      2016-08-22  308  			       struct pwm_state *state)
211ed630753d2f Neil Armstrong      2016-08-22  309  {
211ed630753d2f Neil Armstrong      2016-08-22  310  	struct meson_pwm *meson = to_meson_pwm(chip);
c375bcbaabdb92 Martin Blumenstingl 2019-06-12  311  	struct meson_pwm_channel_data *channel_data;
c375bcbaabdb92 Martin Blumenstingl 2019-06-12 @312  	struct meson_pwm_channel *channel;
2acdf419b01bae George Stark        2024-10-16  313  	unsigned int hi, lo;
329db102a26da0 Heiner Kallweit     2023-05-24  314  	u32 value;
211ed630753d2f Neil Armstrong      2016-08-22  315  
c375bcbaabdb92 Martin Blumenstingl 2019-06-12  316  	channel = &meson->channels[pwm->hwpwm];
c375bcbaabdb92 Martin Blumenstingl 2019-06-12  317  	channel_data = &meson_pwm_per_channel_data[pwm->hwpwm];
211ed630753d2f Neil Armstrong      2016-08-22  318  
211ed630753d2f Neil Armstrong      2016-08-22  319  	value = readl(meson->base + REG_MISC_AB);
329db102a26da0 Heiner Kallweit     2023-05-24  320  	state->enabled = value & channel_data->pwm_en_mask;
c375bcbaabdb92 Martin Blumenstingl 2019-06-12  321  
c375bcbaabdb92 Martin Blumenstingl 2019-06-12  322  	value = readl(meson->base + channel_data->reg_offset);
2acdf419b01bae George Stark        2024-10-16  323  	lo = FIELD_GET(PWM_LOW_MASK, value);
2acdf419b01bae George Stark        2024-10-16  324  	hi = FIELD_GET(PWM_HIGH_MASK, value);
c375bcbaabdb92 Martin Blumenstingl 2019-06-12  325  
2acdf419b01bae George Stark        2024-10-16  326  	state->period = meson_pwm_cnt_to_ns(chip, pwm, lo + hi);
2acdf419b01bae George Stark        2024-10-16  327  	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, hi);
6c452cff79f8bf Uwe Kleine-König    2022-12-02  328  
8caa81eb950cb2 Uwe Kleine-König    2023-03-22  329  	state->polarity = PWM_POLARITY_NORMAL;
8caa81eb950cb2 Uwe Kleine-König    2023-03-22  330  
6c452cff79f8bf Uwe Kleine-König    2022-12-02  331  	return 0;
211ed630753d2f Neil Armstrong      2016-08-22  332  }
211ed630753d2f Neil Armstrong      2016-08-22  333  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

