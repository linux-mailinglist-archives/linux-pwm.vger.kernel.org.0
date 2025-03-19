Return-Path: <linux-pwm+bounces-5248-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF50FA69328
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 16:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE9116E0EC
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Mar 2025 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280311C831A;
	Wed, 19 Mar 2025 15:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lc8QL+wu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52C1C5D53;
	Wed, 19 Mar 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397395; cv=none; b=pZoitFQXNvjHaSg3XuCLXkrrw3jf6AU7LtBYw30R0RaxCEvNE9r1lwU7iFMjKe4EDoomlTMLkqgAQdufBSfvLVHvupsC3UMnbqCaxZJXm45HHVznPZkMFII6ZfM/5TKSFL5aYgKsebqL5pcrcKZhFDE44pB3q5i2OLPAT0Z6qxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397395; c=relaxed/simple;
	bh=WVcWVQJpGeDUiTGY9vo3z1CvL7csVDDzGiAEHoJjlHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhVY1fAXAofSrOsDHmilzy5uDXW0YVXODuIsI58oOcFg+zIdIOQnectyLufkUsQOOIz7HtxXLXO4XYvQuAT/0mmjzMHKfCRB8oZqm9i3aOYrGTsimndwOfcAid0lxutLdu+DoQJhdO4E2UxgTpkri2oCTCp23SWK4n4Oede5Qj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lc8QL+wu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742397393; x=1773933393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WVcWVQJpGeDUiTGY9vo3z1CvL7csVDDzGiAEHoJjlHU=;
  b=Lc8QL+wu9BeVpDsCzf7tx0pSMAkyWYdl+bqmjHG8UlXBelr2AP7AstPV
   R2N4+W1du9z9Es942lJb64+kqynlnZdAv8WRz40Ok8Gstu26Jhp3Q4KoU
   PxCuj11N54IXjNn9EXi3JOqHmlLBbj2VVqpAelj8RpP2A5gRcwaHOpefG
   Ur4CuOFmYzSgViqoYyPnUNWyFdWnyNv3EZwmhUUL33sCinzKxPQjx9w84
   itpLygWrIYLP2QlAmoVwcN13iH2vhuiNlEhzVSi3m9Uhmyu+lxJz7DnUW
   YX4D273qjZlWlrUAQPL8GWUfrBpSZgl684NNRnBnObIEKKn7/ePObgelM
   g==;
X-CSE-ConnectionGUID: klbsgNRwQpqWVU5sIPJ+GQ==
X-CSE-MsgGUID: m9SU5dEVSemSBGeDOeLgEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43778903"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43778903"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 08:16:27 -0700
X-CSE-ConnectionGUID: 6lWnkvOESRuKL6SPREtqIA==
X-CSE-MsgGUID: 8vqABt5QTl287LzZrRVQTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="123150826"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Mar 2025 08:16:22 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tuv9Y-000FP0-0W;
	Wed, 19 Mar 2025 15:16:20 +0000
Date: Wed, 19 Mar 2025 23:15:22 +0800
From: kernel test robot <lkp@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH v5 09/11] input: keyboard: Add support for MAX7360 keypad
Message-ID: <202503192258.ULXxG0T4-lkp@intel.com>
References: <20250318-mdb-max7360-support-v5-9-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-9-fb20baf97da0@bootlin.com>

Hi Mathieu,

kernel test robot noticed the following build errors:

[auto build test ERROR on a64dcfb451e254085a7daee5fe51bf22959d52d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-mfd-gpio-Add-MAX7360/20250319-003750
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250318-mdb-max7360-support-v5-9-fb20baf97da0%40bootlin.com
patch subject: [PATCH v5 09/11] input: keyboard: Add support for MAX7360 keypad
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20250319/202503192258.ULXxG0T4-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192258.ULXxG0T4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192258.ULXxG0T4-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/input/keyboard/max7360-keypad.c: In function 'max7360_keypad_irq':
>> drivers/input/keyboard/max7360-keypad.c:57:8: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
     row = FIELD_GET(MAX7360_FIFO_ROW, val);
           ^~~~~~~~~
   drivers/input/keyboard/max7360-keypad.c: In function 'max7360_keypad_hw_init':
>> drivers/input/keyboard/max7360-keypad.c:114:5: error: implicit declaration of function 'FIELD_PREP'; did you mean 'EV_REP'? [-Werror=implicit-function-declaration]
        FIELD_PREP(MAX7360_DEBOUNCE, val));
        ^~~~~~~~~~
        EV_REP
   cc1: some warnings being treated as errors


vim +/FIELD_GET +57 drivers/input/keyboard/max7360-keypad.c

    29	
    30	static irqreturn_t max7360_keypad_irq(int irq, void *data)
    31	{
    32		struct max7360_keypad *max7360_keypad = data;
    33		unsigned int val;
    34		unsigned int row, col;
    35		unsigned int release;
    36		unsigned int code;
    37		int ret;
    38	
    39		do {
    40			ret = regmap_read(max7360_keypad->regmap, MAX7360_REG_KEYFIFO, &val);
    41			if (ret) {
    42				dev_err(&max7360_keypad->input->dev, "Failed to read max7360 FIFO");
    43				return IRQ_NONE;
    44			}
    45	
    46			/* FIFO overflow: ignore it and get next event. */
    47			if (val == MAX7360_FIFO_OVERFLOW)
    48				dev_warn(&max7360_keypad->input->dev, "max7360 FIFO overflow");
    49		} while (val == MAX7360_FIFO_OVERFLOW);
    50	
    51		if (val == MAX7360_FIFO_EMPTY) {
    52			dev_dbg(&max7360_keypad->input->dev, "Got a spurious interrupt");
    53	
    54			return IRQ_NONE;
    55		}
    56	
  > 57		row = FIELD_GET(MAX7360_FIFO_ROW, val);
    58		col = FIELD_GET(MAX7360_FIFO_COL, val);
    59		release = val & MAX7360_FIFO_RELEASE;
    60	
    61		code = MATRIX_SCAN_CODE(row, col, MAX7360_ROW_SHIFT);
    62	
    63		dev_dbg(&max7360_keypad->input->dev, "key[%d:%d] %s\n", row, col,
    64			release ? "release" : "press");
    65	
    66		input_event(max7360_keypad->input, EV_MSC, MSC_SCAN, code);
    67		input_report_key(max7360_keypad->input, max7360_keypad->keycodes[code], !release);
    68		input_sync(max7360_keypad->input);
    69	
    70		return IRQ_HANDLED;
    71	}
    72	
    73	static int max7360_keypad_open(struct input_dev *pdev)
    74	{
    75		struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
    76		int ret;
    77	
    78		/*
    79		 * Somebody is using the device: get out of sleep.
    80		 */
    81		ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG,
    82					MAX7360_CFG_SLEEP, MAX7360_CFG_SLEEP);
    83		if (ret) {
    84			dev_err(&max7360_keypad->input->dev,
    85				"Failed to write max7360 configuration\n");
    86			return ret;
    87		}
    88	
    89		return 0;
    90	}
    91	
    92	static void max7360_keypad_close(struct input_dev *pdev)
    93	{
    94		struct max7360_keypad *max7360_keypad = input_get_drvdata(pdev);
    95		int ret;
    96	
    97		/*
    98		 * Nobody is using the device anymore: go to sleep.
    99		 */
   100		ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_CONFIG, MAX7360_CFG_SLEEP, 0);
   101		if (ret)
   102			dev_err(&max7360_keypad->input->dev,
   103				"Failed to write max7360 configuration\n");
   104	}
   105	
   106	static int max7360_keypad_hw_init(struct max7360_keypad *max7360_keypad)
   107	{
   108		unsigned int val;
   109		int ret;
   110	
   111		val = max7360_keypad->debounce_ms - MAX7360_DEBOUNCE_MIN;
   112		ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_DEBOUNCE,
   113					MAX7360_DEBOUNCE,
 > 114					FIELD_PREP(MAX7360_DEBOUNCE, val));
   115		if (ret) {
   116			return dev_err_probe(&max7360_keypad->input->dev, ret,
   117				"Failed to write max7360 debounce configuration\n");
   118		}
   119	
   120		ret = regmap_write_bits(max7360_keypad->regmap, MAX7360_REG_INTERRUPT,
   121					MAX7360_INTERRUPT_TIME_MASK,
   122					FIELD_PREP(MAX7360_INTERRUPT_TIME_MASK, 1));
   123		if (ret) {
   124			return dev_err_probe(&max7360_keypad->input->dev, ret,
   125				"Failed to write max7360 keypad interrupt configuration\n");
   126		}
   127	
   128		return 0;
   129	}
   130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

