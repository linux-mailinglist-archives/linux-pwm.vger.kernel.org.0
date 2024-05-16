Return-Path: <linux-pwm+bounces-2176-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442658C79E0
	for <lists+linux-pwm@lfdr.de>; Thu, 16 May 2024 17:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E2B22B21
	for <lists+linux-pwm@lfdr.de>; Thu, 16 May 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7829D14E2D2;
	Thu, 16 May 2024 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HccA8G+Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F014D713;
	Thu, 16 May 2024 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874912; cv=none; b=c3kyr3V2G0flH/gbIfuQmeKQmMjm6gswBbUbo5F2UwmZB6aMAmQ6mEkS8BIEdgr6Aw8t2j/2IhIclInXeK+VJ3EJo7QrsHr5yxvRBjObibdOXn11zUNtNj50m9dz9lAmr1JXXBx/NmQKGtchv8flXU4+tqPrsqFwxcmZFzSjsxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874912; c=relaxed/simple;
	bh=12vt83DDQ9W1vK1XXPC3vvTvH4RQzN7F1BBnruNYXew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNfuJ+SezedCqw8kLavE2y3/LXXTfcLTbl+wW+vSh2wpTT+Ry8CZ8HrxGoR37rI5L+qw2RZgWFotGVRRc1vDuGq0ukq7jiRdxluvIEsd6wkUpowc/tNmeR61X1mJJuWflIMQyloAvX2UJCYZOkF6VZG5ZTxgZnPrlDbspZpcWqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HccA8G+Q; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715874910; x=1747410910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12vt83DDQ9W1vK1XXPC3vvTvH4RQzN7F1BBnruNYXew=;
  b=HccA8G+QU4MZw88m94pnX/HLKpF9dZqpt8WFR17eE536nN1sFM33wAM3
   ti6+wpPbRoB4D3qE2csWhIxI5QZd51ahMNNYy6llhboOxYFprLQkyhqZu
   vXr6CxAMVK93mk4d2Lmcf9NmuFeM4cq3TTncRrvJ3IUWRwXhwiMN56xvR
   AXC/2k8ci7cmTf2jYTq3CUbjRS7JEmumQem4gThxXt4CVtyHNwU8bte+l
   kqvE4yxaZ3Q+2b8MJqQ20mk0gg/lOl/w2Mh/mrm33Jv9V0knDW4ioygS1
   IS9ZNWgHsivgckn0MC4xp4uD+CQ9gtRRfyTH6YUgqHJVZyuphci4W5xA6
   Q==;
X-CSE-ConnectionGUID: E1EE79brSnaQWuGacEwo2A==
X-CSE-MsgGUID: 5rgZJShETgKu9XhdqTIMAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="22600387"
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="22600387"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 08:55:10 -0700
X-CSE-ConnectionGUID: QW/JcknhS0yz25vN+Jm6Ng==
X-CSE-MsgGUID: gTmiFC6JTV+qrfeYB3sspA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,165,1712646000"; 
   d="scan'208";a="62683601"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2024 08:55:07 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s7dRh-000EQ7-1j;
	Thu, 16 May 2024 15:55:05 +0000
Date: Thu, 16 May 2024 23:54:27 +0800
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
Message-ID: <202405162306.aFLe0sSZ-lkp@intel.com>
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
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20240516/202405162306.aFLe0sSZ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240516/202405162306.aFLe0sSZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405162306.aFLe0sSZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pwm/pwm-mc33xs2410.c: In function 'mc33xs2410_xfer_regs':
>> drivers/pwm/pwm-mc33xs2410.c:123:34: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     123 |                         val[i] = FIELD_GET(MC33XS2410_RD_DATA_MASK,
         |                                  ^~~~~~~~~
   drivers/pwm/pwm-mc33xs2410.c: In function 'mc33xs2410_pwm_get_freq':
>> drivers/pwm/pwm-mc33xs2410.c:206:16: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
     206 |         return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step) |
         |                ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/FIELD_GET +123 drivers/pwm/pwm-mc33xs2410.c

    74	
    75	static int mc33xs2410_xfer_regs(struct spi_device *spi, bool read, u8 *reg,
    76					u16 *val, bool *ctrl, int len)
    77	{
    78		struct spi_transfer t[MC33XS2410_MAX_TRANSFERS] = { { 0 } };
    79		u8 tx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
    80		u8 rx[MC33XS2410_MAX_TRANSFERS * MC33XS2410_WORD_LEN];
    81		int i, ret, reg_i, val_i;
    82	
    83		if (!len)
    84			return 0;
    85	
    86		if (read)
    87			len++;
    88	
    89		if (len > MC33XS2410_MAX_TRANSFERS)
    90			return -EINVAL;
    91	
    92		for (i = 0; i < len; i++) {
    93			reg_i = i * MC33XS2410_WORD_LEN;
    94			val_i = reg_i + 1;
    95			if (read) {
    96				if (i < len - 1) {
    97					tx[reg_i] = reg[i];
    98					tx[val_i] = ctrl[i] ? MC33XS2410_RD_CTRL : 0;
    99					t[i].tx_buf = &tx[reg_i];
   100				}
   101	
   102				if (i > 0)
   103					t[i].rx_buf = &rx[reg_i - MC33XS2410_WORD_LEN];
   104			} else {
   105				tx[reg_i] = reg[i] | MC33XS2410_WR;
   106				tx[val_i] = val[i];
   107				t[i].tx_buf = &tx[reg_i];
   108			}
   109	
   110			t[i].len = MC33XS2410_WORD_LEN;
   111			t[i].cs_change = 1;
   112		}
   113	
   114		t[len - 1].cs_change = 0;
   115	
   116		ret = spi_sync_transfer(spi, &t[0], len);
   117		if (ret < 0)
   118			return ret;
   119	
   120		if (read) {
   121			for (i = 0; i < len - 1; i++) {
   122				reg_i = i * MC33XS2410_WORD_LEN;
 > 123				val[i] = FIELD_GET(MC33XS2410_RD_DATA_MASK,
   124						   get_unaligned_be16(&rx[reg_i]));
   125			}
   126		}
   127	
   128		return 0;
   129	}
   130	
   131	static
   132	int mc33xs2410_write_regs(struct spi_device *spi, u8 *reg, u16 *val, int len)
   133	{
   134	
   135		return mc33xs2410_xfer_regs(spi, false, reg, val, NULL, len);
   136	}
   137	
   138	static int mc33xs2410_read_regs(struct spi_device *spi, u8 *reg, bool *ctrl,
   139					u16 *val, u8 len)
   140	{
   141		return mc33xs2410_xfer_regs(spi, true, reg, val, ctrl, len);
   142	}
   143	
   144	
   145	static int mc33xs2410_write_reg(struct spi_device *spi, u8 reg, u16 val)
   146	{
   147		return mc33xs2410_write_regs(spi, &reg, &val, 1);
   148	}
   149	
   150	static
   151	int mc33xs2410_read_reg(struct spi_device *spi, u8 reg, u16 *val, bool ctrl)
   152	{
   153		return mc33xs2410_read_regs(spi, &reg, &ctrl, val, 1);
   154	}
   155	
   156	static int mc33xs2410_read_reg_ctrl(struct spi_device *spi, u8 reg, u16 *val)
   157	{
   158		return mc33xs2410_read_reg(spi, reg, val, true);
   159	}
   160	
   161	static
   162	int mc33xs2410_modify_reg(struct spi_device *spi, u8 reg, u16 mask, u16 val)
   163	{
   164		u16 tmp;
   165		int ret;
   166	
   167		ret = mc33xs2410_read_reg_ctrl(spi, reg, &tmp);
   168		if (ret < 0)
   169			return ret;
   170	
   171		tmp &= ~mask;
   172		tmp |= val & mask;
   173	
   174		return mc33xs2410_write_reg(spi, reg, tmp);
   175	}
   176	
   177	static u8 mc33xs2410_pwm_get_freq(u64 period)
   178	{
   179		u8 step, count;
   180	
   181		/*
   182		 * Check if period is within the limits of each of the four frequency
   183		 * ranges, starting with the highest frequency(lowest period). Higher
   184		 * frequencies are represented with better resolution by the device.
   185		 * Therefore favor frequency range with the better resolution to
   186		 * minimize error introduced by the frequency steps.
   187		 */
   188	
   189		switch (period) {
   190		case MC33XS2410_MIN_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(3):
   191			step = 3;
   192			break;
   193		case MC33XS2410_MAX_PERIOD_STEP(3) + 1 ... MC33XS2410_MAX_PERIOD_STEP(2):
   194			step = 2;
   195			break;
   196		case MC33XS2410_MAX_PERIOD_STEP(2) + 1 ... MC33XS2410_MAX_PERIOD_STEP(1):
   197			step = 1;
   198			break;
   199		case MC33XS2410_MAX_PERIOD_STEP(1) + 1 ... MC33XS2410_MAX_PERIOD_STEP(0):
   200			step = 0;
   201			break;
   202		}
   203	
   204		count = DIV_ROUND_UP(MC33XS2410_MAX_PERIOD_STEP(step), period) - 1;
   205	
 > 206		return FIELD_PREP(MC33XS2410_PWM_FREQ_STEP_MASK, step) |
   207		       FIELD_PREP(MC33XS2410_PWM_FREQ_COUNT_MASK, count);
   208	}
   209	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

