Return-Path: <linux-pwm+bounces-8001-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BCQLK3Sc2kCywAAu9opvQ
	(envelope-from <linux-pwm+bounces-8001-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 20:57:33 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9C67A63F
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 20:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9ACA3004CAC
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 19:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643F12C3768;
	Fri, 23 Jan 2026 19:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOwfXG22"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D632A1E5B68;
	Fri, 23 Jan 2026 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198247; cv=none; b=A9fTryHJtz2907Pc7kWSk/hRfSizhzvui88hZNWS5ZsoxNOTXBJ93QlrGI/cxfiRru3bXOApYPt/HsO3QIa8AxUjmk7TE+ZQ1wDR+TG88fqdWECFBbSyLOFaI58PUgF/uPmg4rnUzzjG2rL4UUwBRAGVOjzZxCrFGbAX1gAgPGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198247; c=relaxed/simple;
	bh=ltOq6SCjupE7BLOIATjhL+BWeHyh5Ngusu9gTtz8HpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxEh9plXG0c1dfwzWCsPF0eCdMCygRM8fgsq6Q/+t+cpLu1s7A2omIpvgLt32thccdhRvx3AXFxXkG24Fx0M76+ZefNLrZIdJKS87M9UEvU9CO9AYAYe+IZOJOpHyvpNeBGdtvNnNuCuvw0xgCikButgcDUFBy6+DHwW9IsAPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOwfXG22; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769198246; x=1800734246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ltOq6SCjupE7BLOIATjhL+BWeHyh5Ngusu9gTtz8HpE=;
  b=mOwfXG22i4sSU20WzBNlf+xEIixSNgYx5ukDXqlBwVxGuEzLMvIzH09U
   GpQ8Q/sF9a3uyog/hvQbd0I0Z0g+sHMgwF4ZbkPQEPC/Rgumx9tJCAxcL
   7ofQZbY16yDHbRRCDQ8yfwdXFd24oDnU5YJ/Rs3GWiRPkcEOF6g+hkvFa
   rxBU6SOJn8g66yxwfH0H/B457fZAPNZKunxlfbodQbogJ5aY+UoKG0fkJ
   M3oSRfcmRucsxBSHVVfkKVPp6YUfn4p0U3afLs8y2aHMCRmR6/UjSYNhr
   MC1NIkRFEGNcPUT4zYqy2BGXrWmnlY68pDcp1HI3wraJl1aXRUNmhLFVo
   g==;
X-CSE-ConnectionGUID: AbsoPM5CRAqdH+v0yoUFLw==
X-CSE-MsgGUID: yG/cPy1IQL6phL1kRpSj4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="70621899"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="70621899"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 11:57:25 -0800
X-CSE-ConnectionGUID: eDHf0z5qT4K4NYlUNgWJEA==
X-CSE-MsgGUID: hEhj3cZ7RfOGQf1SGFtXBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="244728318"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 23 Jan 2026 11:57:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vjNHS-00000000UP4-1mM9;
	Fri, 23 Jan 2026 19:57:18 +0000
Date: Sat, 24 Jan 2026 03:56:21 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Genoud <richard.genoud@bootlin.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, Paul Kocialkowski <paulk@sys-base.io>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: Re: [PATCH v3 2/4] pwm: sun50i: Add H616 PWM support
Message-ID: <202601240328.Lv73l3dC-lkp@intel.com>
References: <20260123093322.1327389-3-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123093322.1327389-3-richard.genoud@bootlin.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8001-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,baylibre.com,kernel.org,csie.org,gmail.com,sholland.org,pengutronix.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9B9C67A63F
X-Rspamd-Action: no action

Hi Richard,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Genoud/dt-bindings-pwm-allwinner-add-h616-pwm-compatible/20260123-174342
base:   9ace4753a5202b02191d54e9fdf7f9e3d02b85eb
patch link:    https://lore.kernel.org/r/20260123093322.1327389-3-richard.genoud%40bootlin.com
patch subject: [PATCH v3 2/4] pwm: sun50i: Add H616 PWM support
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20260124/202601240328.Lv73l3dC-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260124/202601240328.Lv73l3dC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601240328.Lv73l3dC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pwm/pwm-sun50i-h616.c: In function 'h616_add_composite_clk':
>> drivers/pwm/pwm-sun50i-h616.c:720:28: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     720 |                 mux->reg = (u64)mux->reg + reg;
         |                            ^
   drivers/pwm/pwm-sun50i-h616.c:730:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     730 |                 gate->reg = (u64)gate->reg + reg;
         |                             ^
   drivers/pwm/pwm-sun50i-h616.c:740:29: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     740 |                 rate->reg = (u64)rate->reg + reg;
         |                             ^


vim +720 drivers/pwm/pwm-sun50i-h616.c

   704	
   705	static int h616_add_composite_clk(struct clk_pwm_data *data,
   706					  void __iomem *reg, spinlock_t *lock,
   707					  struct device *dev, struct clk_hw **hw)
   708	{
   709		const struct clk_ops *mux_ops = NULL, *gate_ops = NULL, *rate_ops = NULL;
   710		struct clk_hw *mux_hw = NULL, *gate_hw = NULL, *rate_hw = NULL;
   711		struct device_node *node = dev->of_node;
   712	
   713		if (data->mux_hw) {
   714			struct clk_mux *mux;
   715	
   716			mux_hw = data->mux_hw;
   717			mux = to_clk_mux(mux_hw);
   718			mux->lock = lock;
   719			mux_ops = mux_hw->init->ops;
 > 720			mux->reg = (u64)mux->reg + reg;
   721		}
   722	
   723		if (data->gate_hw) {
   724			struct clk_gate *gate;
   725	
   726			gate_hw = data->gate_hw;
   727			gate = to_clk_gate(gate_hw);
   728			gate->lock = lock;
   729			gate_ops = gate_hw->init->ops;
   730			gate->reg = (u64)gate->reg + reg;
   731		}
   732	
   733		if (data->rate_hw) {
   734			struct clk_divider *rate;
   735	
   736			rate_hw = data->rate_hw;
   737			rate = to_clk_divider(rate_hw);
   738			rate_ops = rate_hw->init->ops;
   739			rate->lock = lock;
   740			rate->reg = (u64)rate->reg + reg;
   741	
   742			if (rate->table) {
   743				const struct clk_div_table *clkt;
   744				int table_size = 0;
   745	
   746				for (clkt = rate->table; clkt->div; clkt++)
   747					table_size++;
   748				rate->width = order_base_2(table_size);
   749			}
   750		}
   751	
   752		/*
   753		 * Retrieve the parent clock names from DTS for pwm-clk-srcxy
   754		 */
   755		if (!data->parent_names) {
   756			data->num_parents = of_clk_get_parent_count(node);
   757			if (data->num_parents == 0)
   758				return -ENOENT;
   759	
   760			data->parent_names = devm_kzalloc(dev,
   761							  sizeof(*data->parent_names),
   762							  GFP_KERNEL);
   763			for (unsigned int i = 0; i < data->num_parents; i++)
   764				data->parent_names[i] = of_clk_get_parent_name(node, i);
   765		}
   766	
   767		*hw = clk_hw_register_composite(dev, data->name, data->parent_names,
   768						data->num_parents, mux_hw,
   769						mux_ops, rate_hw, rate_ops,
   770						gate_hw, gate_ops, data->flags);
   771	
   772		return PTR_ERR_OR_ZERO(*hw);
   773	}
   774	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

