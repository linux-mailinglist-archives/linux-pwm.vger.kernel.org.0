Return-Path: <linux-pwm+bounces-5188-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98642A60DA9
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 10:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45BF167372
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 09:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7AE1EF0B6;
	Fri, 14 Mar 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1DH2ZJv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511321EEA4E;
	Fri, 14 Mar 2025 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945469; cv=none; b=gqpMddq7DE4JapWWjT2Li62RuBeJ+v6YoBzxpCNpHua4wiAtg5BGx2majYDG+uTFAqNXtlnSFNu4BLQAPX6r5TDSuENPlp5X/5QB+XjIaVWEWYVQLKkS5P3uG8/5kIf1TSjDleczXvIbqSCvZ7wTT0qeK0M6Ep3fUSN1DMv6JQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945469; c=relaxed/simple;
	bh=yJdtMfU2C1WeWnG7I3RoEg8QOSlVcnTdq5SN+gMoPkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2H+G944m0jBIljWya4pKA1PixFhtZ94MlP2HzUlgevg78n+ZLGzQpWhHHJgGp54iEcUme9JGqapo0F2UjBnP4kFXi7AA09Ud6hc41BKa20zT+j2z8VeP03lxHjGokJFQf5OW50VetrSMEJ6wtbNqn63O29nKBWkqY9M24/6WkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1DH2ZJv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741945467; x=1773481467;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yJdtMfU2C1WeWnG7I3RoEg8QOSlVcnTdq5SN+gMoPkc=;
  b=F1DH2ZJvkWtH37OuA2K7G12ne5Id+/HjeF1hR/40YscXAYnJRoSoV4F1
   pM8R2EqpdY2S2o3yfpKOmJw0NvrSm4QqGOSL3kUP7uls+QrX1GuEedCfa
   kq46L7JWSWQsgiQAX6mOtT5CWnAVxB0SihbG7nU0+pGcDLDYRS5dhevbp
   DqThGt0GWh4k9+TN9/f9pOYO/kV5Rz8H1NLxsrqs+oUkiNFF8Ud6THiQV
   oDAM7/3WHu5VaPnRLQufbjY8tJXUpB0Uazb6Hvcgsz7do2Or/U+jkBYfh
   6nHZAZu7BbYB+jNlMW/6IxsgjEufBie1Fhy9B2ivtwq8uOO0kT/NuM+/G
   w==;
X-CSE-ConnectionGUID: 8AYf40F2R+eEweyvy68SrQ==
X-CSE-MsgGUID: dKCRQHiIRlKUY7YMmXbIuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="53744121"
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="53744121"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 02:44:26 -0700
X-CSE-ConnectionGUID: Gdd3iWAVR9C25s2zdOTsDA==
X-CSE-MsgGUID: 1reStWcITZ2bamIO/UAmyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,246,1736841600"; 
   d="scan'208";a="121259547"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 14 Mar 2025 02:43:56 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tt1a6-000AIq-0V;
	Fri, 14 Mar 2025 09:43:54 +0000
Date: Fri, 14 Mar 2025 17:43:34 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 10/18] mfd: adp5585: add support for key events
Message-ID: <202503141730.dPtGWqXX-lkp@intel.com>
References: <20250313-dev-adp5589-fw-v1-10-20e80d4bd4ea@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313-dev-adp5589-fw-v1-10-20e80d4bd4ea@analog.com>

Hi Nuno,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4d395cb071a343196ca524d3694790f06978fe91]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-S-via-B4-Relay/dt-bindings-mfd-adp5585-ease-on-the-required-properties/20250313-222511
base:   4d395cb071a343196ca524d3694790f06978fe91
patch link:    https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-10-20e80d4bd4ea%40analog.com
patch subject: [PATCH 10/18] mfd: adp5585: add support for key events
config: sparc-randconfig-001-20250314 (https://download.01.org/0day-ci/archive/20250314/202503141730.dPtGWqXX-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250314/202503141730.dPtGWqXX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503141730.dPtGWqXX-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mfd/adp5585.c: In function 'adp5585_keys_reset_parse':
>> drivers/mfd/adp5585.c:485:47: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     485 |                         adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET1_POL, 1);
         |                                               ^~~~~~~~~~
   drivers/mfd/adp5585.c: In function 'adp5585_report_events':
>> drivers/mfd/adp5585.c:654:27: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     654 |                 key_val = FIELD_GET(ADP5585_KEY_EVENT_MASK, key);
         |                           ^~~~~~~~~
   drivers/mfd/adp5585.c: At top level:
   drivers/mfd/adp5585.c:271:34: warning: 'adp5585_02_info' defined but not used [-Wunused-const-variable=]
     271 | static const struct adp5585_info adp5585_02_info = {
         |                                  ^~~~~~~~~~~~~~~
   drivers/mfd/adp5585.c:258:34: warning: 'adp5585_01_info' defined but not used [-Wunused-const-variable=]
     258 | static const struct adp5585_info adp5585_01_info = {
         |                                  ^~~~~~~~~~~~~~~
   drivers/mfd/adp5585.c:246:34: warning: 'adp5585_info' defined but not used [-Wunused-const-variable=]
     246 | static const struct adp5585_info adp5585_info = {
         |                                  ^~~~~~~~~~~~
   drivers/mfd/adp5585.c:49:41: warning: 'adp5589_volatile_regs' defined but not used [-Wunused-const-variable=]
      49 | static const struct regmap_access_table adp5589_volatile_regs = {
         |                                         ^~~~~~~~~~~~~~~~~~~~~


vim +/FIELD_PREP +485 drivers/mfd/adp5585.c

   464	
   465	static int adp5585_keys_reset_parse(struct adp5585_dev *adp5585)
   466	{
   467		const struct adp5585_info *info = adp5585->info;
   468		struct device *dev = adp5585->dev;
   469		u32 prop_val;
   470		int ret;
   471	
   472		ret = adp5585_keys_parse_array(adp5585, "adi,reset1-keys",
   473					       adp5585->reset1_keys,
   474					       &adp5585->nkeys_reset1,
   475					       ARRAY_SIZE(adp5585->reset1_keys), true);
   476		if (ret)
   477			return ret;
   478	
   479		if (adp5585->nkeys_reset1 > 0) {
   480			if (test_bit(ADP5585_ROW4, adp5585->keypad))
   481				return dev_err_probe(dev, -EINVAL,
   482						     "Invalid reset1 output(R4) being used in the keypad\n");
   483	
   484			if (device_property_read_bool(dev, "adi,reset1-active-high"))
 > 485				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET1_POL, 1);
   486		}
   487	
   488		ret = adp5585_keys_parse_array(adp5585, "adi,reset2-keys",
   489					       adp5585->reset2_keys,
   490					       &adp5585->nkeys_reset2,
   491					       ARRAY_SIZE(adp5585->reset2_keys), true);
   492		if (ret)
   493			return ret;
   494	
   495		if (adp5585->nkeys_reset2 > 0) {
   496			if (test_bit(info->max_rows + ADP5585_COL4, adp5585->keypad))
   497				return dev_err_probe(dev, -EINVAL,
   498						     "Invalid reset2 output(C4) being used in the keypad\n");
   499	
   500			if (device_property_read_bool(dev, "adi,reset2-active-high"))
   501				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET2_POL, 1);
   502		}
   503	
   504		if (!adp5585->nkeys_reset1 && !adp5585->nkeys_reset2)
   505			return 0;
   506	
   507		if (device_property_read_bool(dev, "adi,rst-passtrough-enable"))
   508			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RST_PASSTHRU_EN, 1);
   509	
   510		ret = device_property_read_u32(dev, "adi,reset-trigger-ms", &prop_val);
   511		if (!ret) {
   512			switch (prop_val) {
   513			case 0:
   514				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 0);
   515				break;
   516			case 1000:
   517				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 1);
   518				break;
   519			case 1500:
   520				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 2);
   521				break;
   522			case 2000:
   523				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 3);
   524				break;
   525			case 2500:
   526				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 4);
   527				break;
   528			case 3000:
   529				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 5);
   530				break;
   531			case 3500:
   532				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 6);
   533				break;
   534			case 4000:
   535				adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 7);
   536				break;
   537			default:
   538				return dev_err_probe(dev, -EINVAL,
   539						     "Invalid value(%u) for adi,reset-trigger-ms\n",
   540						     prop_val);
   541			}
   542		}
   543	
   544		ret = device_property_read_u32(dev, "adi,reset-pulse-width-us",
   545					       &prop_val);
   546		if (!ret) {
   547			switch (prop_val) {
   548			case 500:
   549				adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 0);
   550				break;
   551			case 1000:
   552				adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 1);
   553				break;
   554			case 2000:
   555				adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 2);
   556				break;
   557			case 10000:
   558				adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 3);
   559				break;
   560			default:
   561				return dev_err_probe(dev, -EINVAL,
   562						     "Invalid value(%u) for adi,reset-pulse-width-us\n",
   563						     prop_val);
   564			}
   565		}
   566	
   567		return 0;
   568	}
   569	
   570	static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585)
   571	{
   572		const struct adp5585_info *info = adp5585->info;
   573		unsigned int n_pins = info->max_cols + info->max_rows;
   574		unsigned int *keypad_pins;
   575		unsigned int prop_val;
   576		int n_keys, key, ret;
   577	
   578		adp5585->keypad = devm_bitmap_zalloc(dev, n_pins, GFP_KERNEL);
   579		if (!adp5585->keypad)
   580			return -ENOMEM;
   581	
   582		if (device_property_present(dev, "#pwm-cells"))
   583			adp5585->has_pwm = true;
   584	
   585		n_keys = device_property_count_u32(dev, "adi,keypad-pins");
   586		if (n_keys <= 0)
   587			goto no_keypad;
   588		if (n_keys > n_pins)
   589			return -EINVAL;
   590	
   591		keypad_pins = devm_kcalloc(dev, n_keys, sizeof(*keypad_pins),
   592					   GFP_KERNEL);
   593		if (!keypad_pins)
   594			return -ENOMEM;
   595	
   596		ret = device_property_read_u32_array(dev, "adi,keypad-pins",
   597						     keypad_pins, n_keys);
   598		if (ret)
   599			return ret;
   600	
   601		for (key = 0; key < n_keys; key++) {
   602			if (keypad_pins[key] >= n_pins)
   603				return -EINVAL;
   604			if (adp5585->has_pwm && keypad_pins[key] == ADP5585_ROW3)
   605				return dev_err_probe(dev, -EINVAL,
   606						     "Invalid PWM pin being used in the keypad\n");
   607			if (!info->has_row5 && keypad_pins[key] == ADP5585_ROW5)
   608				return dev_err_probe(dev, -EINVAL,
   609						     "Invalid row5 being used in the keypad\n");
   610			__set_bit(keypad_pins[key], adp5585->keypad);
   611		}
   612	
   613	no_keypad:
   614		ret = device_property_read_u32(dev, "adi,key-poll-ms", &prop_val);
   615		if (!ret) {
   616			switch (prop_val) {
   617			case 10:
   618				fallthrough;
   619			case 20:
   620				fallthrough;
   621			case 30:
   622				fallthrough;
   623			case 40:
   624				adp5585->key_poll_time = prop_val / 10 - 1;
   625				break;
   626			default:
   627				return dev_err_probe(dev, -EINVAL,
   628						     "Invalid value(%u) for adi,key-poll-ms\n",
   629						     prop_val);
   630			}
   631		}
   632	
   633		ret = adp5585_keys_unlock_parse(adp5585);
   634		if (ret)
   635			return ret;
   636	
   637		return adp5585_keys_reset_parse(adp5585);
   638	}
   639	
   640	static void adp5585_report_events(struct adp5585_dev *adp5585, int ev_cnt)
   641	{
   642		unsigned int i;
   643	
   644		guard(mutex)(&adp5585->ev_lock);
   645	
   646		for (i = 0; i < ev_cnt; i++) {
   647			unsigned int key, key_val, key_press;
   648			int ret;
   649	
   650			ret = regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i, &key);
   651			if (ret)
   652				return;
   653	
 > 654			key_val = FIELD_GET(ADP5585_KEY_EVENT_MASK, key);
   655			key_press = FIELD_GET(ADP5585_KEV_EV_PRESS_MASK, key);
   656	
   657			if (key_val >= adp5585->info->gpi_ev_base &&
   658			    key_val <= adp5585->info->gpi_ev_end) {
   659				unsigned int gpi = key_val - adp5585->info->gpi_ev_base;
   660	
   661				if (adp5585->gpio_irq_handle)
   662					adp5585->gpio_irq_handle(adp5585->gpio_dev, gpi,
   663								 key_press);
   664			} else if (adp5585->keys_irq_handle) {
   665				adp5585->keys_irq_handle(adp5585->input_dev, key_val,
   666							 key_press);
   667			}
   668		}
   669	}
   670	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

