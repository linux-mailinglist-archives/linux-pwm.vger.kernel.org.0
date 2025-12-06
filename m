Return-Path: <linux-pwm+bounces-7766-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB2CAA0C6
	for <lists+linux-pwm@lfdr.de>; Sat, 06 Dec 2025 05:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B3C1301E6D7
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Dec 2025 04:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C412B23EA95;
	Sat,  6 Dec 2025 04:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZATwAjZk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1494C1A256E;
	Sat,  6 Dec 2025 04:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764995624; cv=none; b=UdlW/tDMmVRoFLT/LzEI9vdcY12O4WxrrypxE9jMviVBvZ6Rf98bd4RUarXe3OghtoGbEgKU4AbIhGkLWa7CNtaYbs1zTgPRaV2kZC29TO20IAQdP1pYb+jsdW+/nQjL9GMke0Zer4acZS2syJ1VfdYCcU7U3LB43JgHWcdjMgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764995624; c=relaxed/simple;
	bh=1RXda8DebYFioOiumkkWKKD95G9Tw8ToK4dBLUquDSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFMAPAF+jlsz2zJdGIQAcR/eg4iACDcRlsiJBsRThDV/hroh3nDfQWGbY/jIU3LmHl7Uy9Wyy4VqSfLNqAAeE6Y7vOJ6BKgZuQIbyU4iLH92CvsPdFilOS3k33CHZLPcMpvjVnepLeR+jFQHhoHUieGLkiGXj6/NzsAEoWCZf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZATwAjZk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764995623; x=1796531623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1RXda8DebYFioOiumkkWKKD95G9Tw8ToK4dBLUquDSg=;
  b=ZATwAjZkVBu1sDZff9xwZxmPTB07KET6SVhaUbn7fJTyeKRzU+fltgsH
   PVVAc66OGWGHquZ0txaPEDr//h55XPrC0uu8xaaDgoMqnLFSQbdhIrAaU
   62a8U7fwaD+wrOzb0vxvfXe7PYfZFJoiCu3HjD6JQHr8hYe6TzG1zoTHS
   CaUR9/7nXsPCIwUGJ/DU3k+KsyfHnoB7z/xoBmHd1Wy0QEO/DbOI9gfHw
   WxgY+HLSmX9FMKoIbcvM1+1OzOfELx/TILPNm00FV7JDz8v1Ndy6FBMWJ
   IOB6UwFeERDuOqWhWrlxifDpEbduAvx5YK5gkz5hZQC2kPUCd6a8Pl6L+
   A==;
X-CSE-ConnectionGUID: 7FXn9Tp/QSaHWv9GjbMNfw==
X-CSE-MsgGUID: 6FfmdcGSTcGQQGjQVTsYKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="77714545"
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="77714545"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 20:33:43 -0800
X-CSE-ConnectionGUID: WgE21FiOSiGitnIlBwcihA==
X-CSE-MsgGUID: Ak20VQHVTPSmYGdp4jTokA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,254,1758610800"; 
   d="scan'208";a="199938011"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Dec 2025 20:33:39 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vRjzD-00000000Fqj-37PO;
	Sat, 06 Dec 2025 04:33:35 +0000
Date: Sat, 6 Dec 2025 12:32:50 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Genoud <richard.genoud@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [PATCH 2/4] pwm: sun50i: Add H616 PWM support
Message-ID: <202512061246.jJ5UrB71-lkp@intel.com>
References: <20251205100239.1563353-3-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205100239.1563353-3-richard.genoud@bootlin.com>

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6987d58a9cbc5bd57c983baa514474a86c945d56]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Genoud/dt-bindings-pwm-sunxi-add-PWM-controller-for-Allwinner-H616/20251205-214804
base:   6987d58a9cbc5bd57c983baa514474a86c945d56
patch link:    https://lore.kernel.org/r/20251205100239.1563353-3-richard.genoud%40bootlin.com
patch subject: [PATCH 2/4] pwm: sun50i: Add H616 PWM support
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20251206/202512061246.jJ5UrB71-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251206/202512061246.jJ5UrB71-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512061246.jJ5UrB71-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pwm/pwm-sun50i-h616.c: In function 'h616_pwm_get_state':
   drivers/pwm/pwm-sun50i-h616.c:76:41: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
      76 | #define PWM_REG_DUTY(reg)               FIELD_GET(PWM_DUTY_MASK, reg)
         |                                         ^~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c:452:30: note: in expansion of macro 'PWM_REG_DUTY'
     452 |         tmp = NSEC_PER_SEC * PWM_REG_DUTY(val);
         |                              ^~~~~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c: In function 'h616_pwm_calc':
   drivers/pwm/pwm-sun50i-h616.c:79:41: error: implicit declaration of function 'FIELD_MAX' [-Wimplicit-function-declaration]
      79 | #define PWM_PERIOD_MAX                  FIELD_MAX(PWM_PERIOD_MASK)
         |                                         ^~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c:493:54: note: in expansion of macro 'PWM_PERIOD_MAX'
     493 |                 freq = div64_u64(NSEC_PER_SEC * (u64)PWM_PERIOD_MAX, period);
         |                                                      ^~~~~~~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c: In function 'h616_pwm_apply':
   drivers/pwm/pwm-sun50i-h616.c:78:41: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
      78 | #define PWM_DUTY(dty)                   FIELD_PREP(PWM_DUTY_MASK, dty)
         |                                         ^~~~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c:577:23: note: in expansion of macro 'PWM_DUTY'
     577 |                 val = PWM_DUTY(chan->active_cycles);
         |                       ^~~~~~~~
   drivers/pwm/pwm-sun50i-h616.c: In function 'h616_add_composite_clk':
>> drivers/pwm/pwm-sun50i-h616.c:666:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     666 |                 mux->reg = (u64)mux->reg + reg;
         |                            ^
   drivers/pwm/pwm-sun50i-h616.c:676:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     676 |                 gate->reg = (u64)gate->reg + reg;
         |                             ^
   drivers/pwm/pwm-sun50i-h616.c:686:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     686 |                 rate->reg = (u64)rate->reg + reg;
         |                             ^


vim +666 drivers/pwm/pwm-sun50i-h616.c

   650	
   651	static int h616_add_composite_clk(const struct clk_pwm_data *data,
   652					  void __iomem *reg, spinlock_t *lock,
   653					  struct device *dev, struct clk_hw **hw)
   654	{
   655		const struct clk_ops *mux_ops = NULL, *gate_ops = NULL, *rate_ops = NULL;
   656		struct clk_hw *mux_hw = NULL, *gate_hw = NULL, *rate_hw = NULL;
   657	
   658	
   659		if (data->mux_hw) {
   660			struct clk_mux *mux;
   661	
   662			mux_hw = data->mux_hw;
   663			mux = to_clk_mux(mux_hw);
   664			mux->lock = lock;
   665			mux_ops = mux_hw->init->ops;
 > 666			mux->reg = (u64)mux->reg + reg;
   667		}
   668	
   669		if (data->gate_hw) {
   670			struct clk_gate *gate;
   671	
   672			gate_hw = data->gate_hw;
   673			gate = to_clk_gate(gate_hw);
   674			gate->lock = lock;
   675			gate_ops = gate_hw->init->ops;
   676			gate->reg = (u64)gate->reg + reg;
   677		}
   678	
   679		if (data->rate_hw) {
   680			struct clk_divider *rate;
   681	
   682			rate_hw = data->rate_hw;
   683			rate = to_clk_divider(rate_hw);
   684			rate_ops = rate_hw->init->ops;
   685			rate->lock = lock;
   686			rate->reg = (u64)rate->reg + reg;
   687	
   688			if (rate->table) {
   689				const struct clk_div_table *clkt;
   690				int table_size = 0;
   691	
   692				for (clkt = rate->table; clkt->div; clkt++)
   693					table_size++;
   694				rate->width = order_base_2(table_size);
   695			}
   696		}
   697	
   698		*hw = clk_hw_register_composite(dev, data->name, data->parent_names,
   699						data->num_parents, mux_hw,
   700						mux_ops, rate_hw, rate_ops,
   701						gate_hw, gate_ops, data->flags);
   702	
   703		return PTR_ERR_OR_ZERO(*hw);
   704	}
   705	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

