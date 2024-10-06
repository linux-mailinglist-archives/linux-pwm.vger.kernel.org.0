Return-Path: <linux-pwm+bounces-3504-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B79991CBF
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Oct 2024 08:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D56B7281A38
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Oct 2024 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB1167296;
	Sun,  6 Oct 2024 06:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8qBoDWu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63D4C9D;
	Sun,  6 Oct 2024 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728195834; cv=none; b=nZ4eRCRjNriMRB3GKDST2g798Qo9uQilKZB5aMCmVBAS8A+sc/24wXF7x4CAhGAe5GS26ifu2F99G3F09QOn12NjRFA6q0k6uSBhGZmkhExv3NB4kD/0qhqb8mYqWChfvat0K5ABGAo5MCIG3OkcuyAxrGatep6yz4P/KnfvTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728195834; c=relaxed/simple;
	bh=H/emNg2aVZv4n2YTV6WagRn5Age0z2hVFcUSuk6iDKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvi4FSTSLK2+4wcpQu+9BWLdBGhX/IR/AMg9XzWdYQsETPkGZ0xktOCKtHA0Yyz6CqgntHVGIgES9fb8FY0F35eUYD0blG9jIBpOK1G5wMJNQapyyWKDFiqCfnN5LU34aitqGdMXUSEjXlED2q5Uge23EYcSbSCGUrAk14XRQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8qBoDWu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728195833; x=1759731833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H/emNg2aVZv4n2YTV6WagRn5Age0z2hVFcUSuk6iDKk=;
  b=n8qBoDWubJK+tzTZjyr9TnvUzF3b14EKjJCnhMURusXYgDnby8ETYN1t
   UjmxnNPqhjhQ41WMG8teopxFo6kCuCZSZ0msfO3X7H1ADBkMK+Yqcqm5s
   Bdog/7FRcPUwSYbzspkGZi6XzhtJVGWHyyh91nRyS+s8og9N6f0QiYZXV
   1mkOoH8gquy0ZkhzWuzhYiLy7SdNJdps4iU/eX5mnWdMtdKW2rBnjqFIC
   oYTAlPw3lVfj8eqJMOe8aWC9T3S1wpuKbHUIVG91/xo645ALF0xD4KzK8
   KkRAcVumsDUQs9Non+UJQgWPneZJRu7DtJnoJjzXo/ePKQB6NaIxhhx8k
   Q==;
X-CSE-ConnectionGUID: bl4LoanqQealht3LruVIqA==
X-CSE-MsgGUID: aqd3TEuzTgSyiNzfMKBxBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="27254801"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="27254801"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 23:23:52 -0700
X-CSE-ConnectionGUID: gkqTNOEbSYqLP/6WzoJMHA==
X-CSE-MsgGUID: 2L3DpjURSSmUkBiqjKKkbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="79703327"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 05 Oct 2024 23:23:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxKgD-0003em-1y;
	Sun, 06 Oct 2024 06:23:45 +0000
Date: Sun, 6 Oct 2024 14:23:08 +0800
From: kernel test robot <lkp@intel.com>
To: Guillaume Stols <gstols@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, aardelean@baylibre.com,
	dlechner@baylibre.com, Guillaume Stols <gstols@baylibre.com>
Subject: Re: [PATCH v3 07/10] iio: adc: ad7606: Add compatibility to fw_nodes
Message-ID: <202410061420.L3sUSK8b-lkp@intel.com>
References: <20241004-ad7606_add_iio_backend_support-v3-7-38757012ce82@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-ad7606_add_iio_backend_support-v3-7-38757012ce82@baylibre.com>

Hi Guillaume,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 35307f34d6fef8f9d41a1e8f4f532e4b0a7ee422]

url:    https://github.com/intel-lab-lkp/linux/commits/Guillaume-Stols/iio-adc-ad7606-Fix-typo-in-the-driver-name/20241005-055256
base:   35307f34d6fef8f9d41a1e8f4f532e4b0a7ee422
patch link:    https://lore.kernel.org/r/20241004-ad7606_add_iio_backend_support-v3-7-38757012ce82%40baylibre.com
patch subject: [PATCH v3 07/10] iio: adc: ad7606: Add compatibility to fw_nodes
config: i386-randconfig-062-20241006 (https://download.01.org/0day-ci/archive/20241006/202410061420.L3sUSK8b-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410061420.L3sUSK8b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410061420.L3sUSK8b-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad7606_spi.c:324:29: sparse: sparse: symbol 'ad7606_spi_bops' was not declared. Should it be static?
>> drivers/iio/adc/ad7606_spi.c:328:29: sparse: sparse: symbol 'ad7616_spi_bops' was not declared. Should it be static?
>> drivers/iio/adc/ad7606_spi.c:337:29: sparse: sparse: symbol 'ad7606b_spi_bops' was not declared. Should it be static?
>> drivers/iio/adc/ad7606_spi.c:346:29: sparse: sparse: symbol 'ad7606c_18_spi_bops' was not declared. Should it be static?
>> drivers/iio/adc/ad7606_spi.c:370:30: sparse: sparse: symbol 'ad7606_4_bus_info' was not declared. Should it be static?
>> drivers/iio/adc/ad7606_spi.c:375:30: sparse: sparse: symbol 'ad7606b_bus_info' was not declared. Should it be static?
>> drivers/iio/adc/ad7606_spi.c:380:30: sparse: sparse: symbol 'ad7606c_16_bus_info' was not declared. Should it be static?
>> drivers/iio/adc/ad7606_spi.c:385:30: sparse: sparse: symbol 'ad7606c_18_bus_info' was not declared. Should it be static?
>> drivers/iio/adc/ad7606_spi.c:390:30: sparse: sparse: symbol 'ad7616_bus_info' was not declared. Should it be static?

vim +/ad7606_spi_bops +324 drivers/iio/adc/ad7606_spi.c

   323	
 > 324	const struct ad7606_bus_ops ad7606_spi_bops = {
   325		.read_block = ad7606_spi_read_block,
   326	};
   327	
 > 328	const struct ad7606_bus_ops ad7616_spi_bops = {
   329		.read_block = ad7606_spi_read_block,
   330		.reg_read = ad7606_spi_reg_read,
   331		.reg_write = ad7606_spi_reg_write,
   332		.write_mask = ad7606_spi_write_mask,
   333		.rd_wr_cmd = ad7616_spi_rd_wr_cmd,
   334		.sw_mode_config = ad7616_sw_mode_config,
   335	};
   336	
 > 337	const struct ad7606_bus_ops ad7606b_spi_bops = {
   338		.read_block = ad7606_spi_read_block,
   339		.reg_read = ad7606_spi_reg_read,
   340		.reg_write = ad7606_spi_reg_write,
   341		.write_mask = ad7606_spi_write_mask,
   342		.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
   343		.sw_mode_config = ad7606B_sw_mode_config,
   344	};
   345	
 > 346	const struct ad7606_bus_ops ad7606c_18_spi_bops = {
   347		.read_block = ad7606_spi_read_block18to32,
   348		.reg_read = ad7606_spi_reg_read,
   349		.reg_write = ad7606_spi_reg_write,
   350		.write_mask = ad7606_spi_write_mask,
   351		.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
   352		.sw_mode_config = ad7606c_18_sw_mode_config,
   353	};
   354	
   355	static const struct ad7606_bus_info ad7605_4_bus_info = {
   356		.chip_info = &ad7605_4_info,
   357		.bops = &ad7606_spi_bops,
   358	};
   359	
   360	static const struct ad7606_bus_info ad7606_8_bus_info = {
   361		.chip_info = &ad7606_8_info,
   362		.bops = &ad7606_spi_bops,
   363	};
   364	
   365	static const struct ad7606_bus_info ad7606_6_bus_info = {
   366		.chip_info = &ad7606_6_info,
   367		.bops = &ad7606_spi_bops,
   368	};
   369	
 > 370	const struct ad7606_bus_info ad7606_4_bus_info = {
   371		.chip_info = &ad7606_4_info,
   372		.bops = &ad7606_spi_bops,
   373	};
   374	
 > 375	const struct ad7606_bus_info ad7606b_bus_info = {
   376		.chip_info = &ad7606b_info,
   377		.bops = &ad7606b_spi_bops,
   378	};
   379	
 > 380	const struct ad7606_bus_info ad7606c_16_bus_info = {
   381		.chip_info = &ad7606c_16_info,
   382		.bops = &ad7606b_spi_bops,
   383	};
   384	
 > 385	const struct ad7606_bus_info ad7606c_18_bus_info = {
   386		.chip_info = &ad7606c_18_info,
   387		.bops = &ad7606c_18_spi_bops,
   388	};
   389	
 > 390	const struct ad7606_bus_info ad7616_bus_info = {
   391		.chip_info = &ad7616_info,
   392		.bops = &ad7616_spi_bops,
   393	};
   394	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

