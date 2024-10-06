Return-Path: <linux-pwm+bounces-3503-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E5F991CAB
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Oct 2024 07:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE16B2834FC
	for <lists+linux-pwm@lfdr.de>; Sun,  6 Oct 2024 05:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F71165F19;
	Sun,  6 Oct 2024 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UMMeRGF5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C434120B;
	Sun,  6 Oct 2024 05:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728192714; cv=none; b=roGiY0QorPZVR9xKbZqpvTvFwj34dE0j/g4vdbh5OjG3G/f/x4dYHwP4oNdoSyiQ6TRLY0K3/UVYPv4zq2OkztkseHNGW1fSyK3APvlp0M9FcSihWtr7xQg6GbF1UCEE+Cn8dXLkpcQpJaAZdqdwWFB0J7sHYWJM/Li6vdXvPkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728192714; c=relaxed/simple;
	bh=NaeIIqZcYdXezy4Xv5IAocLm2iT8QvpFiFoXkNZMNDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJYmm+A9bVOYsak8qbrDyFRhUolBIt5FLZfdCSeyLPEb5RSo8obrQ4YJY/aQKqHplSJbWmAHyvh+FJEzmbkcfXw42yrb5LNsH2jA1SEWAunhR+jk0sXwRK97747fUzS561q7bDddq7lR0mYdQagijvRU4snjS9r4TjDk2yXJAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UMMeRGF5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728192712; x=1759728712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NaeIIqZcYdXezy4Xv5IAocLm2iT8QvpFiFoXkNZMNDQ=;
  b=UMMeRGF5oLMWMOMB6dhPxq5RD05esWgS8d+eB/fsZf4WwN9RVFMFD1XT
   HYsEcXVHQ6JQO2hrkEh0uYmZ8tLQffNdhvJ/sX5tk3tSvXkde50WhSvru
   vzTWNihj6z3YYYXEcaXHyQDoquLf3uS5LQ/SJ7RT87xUekRx7OQeM6Un1
   rCoPNEoaAjXf8x6jdEWR5NETBETnvMMl+Pw4cl/Dbrc9Mym9KvQga6bFV
   7kv4EUcC0X5jH+vKW37HegedjQ7XfC2Afy2Pds2nxdY2UxZ3queGaDDDw
   CtFq4J+vfOZaYgNSxwhMKfIzAeiX+LQEJtp30R7bM+I/Jzk9cufy1QX5N
   Q==;
X-CSE-ConnectionGUID: 5GDZbhbrQkeDENfCaCY0yA==
X-CSE-MsgGUID: icSPb2gXQrW09bOlFRgeBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="38756202"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="38756202"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 22:31:52 -0700
X-CSE-ConnectionGUID: iR1C34s6RkqZ1GwlHbd0Sw==
X-CSE-MsgGUID: sUvdpoPwSd6hvwAfgSUNFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="75365820"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Oct 2024 22:31:47 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxJrs-0003dU-34;
	Sun, 06 Oct 2024 05:31:44 +0000
Date: Sun, 6 Oct 2024 13:31:36 +0800
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
Subject: Re: [PATCH v3 09/10] iio: adc: ad7606: Add iio-backend support
Message-ID: <202410061307.IHo3Eizh-lkp@intel.com>
References: <20241004-ad7606_add_iio_backend_support-v3-9-38757012ce82@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-ad7606_add_iio_backend_support-v3-9-38757012ce82@baylibre.com>

Hi Guillaume,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 35307f34d6fef8f9d41a1e8f4f532e4b0a7ee422]

url:    https://github.com/intel-lab-lkp/linux/commits/Guillaume-Stols/iio-adc-ad7606-Fix-typo-in-the-driver-name/20241005-055256
base:   35307f34d6fef8f9d41a1e8f4f532e4b0a7ee422
patch link:    https://lore.kernel.org/r/20241004-ad7606_add_iio_backend_support-v3-9-38757012ce82%40baylibre.com
patch subject: [PATCH v3 09/10] iio: adc: ad7606: Add iio-backend support
config: x86_64-randconfig-123-20241006 (https://download.01.org/0day-ci/archive/20241006/202410061307.IHo3Eizh-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410061307.IHo3Eizh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410061307.IHo3Eizh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad7606_par.c:89:29: sparse: sparse: symbol 'ad7606_bi_bops' was not declared. Should it be static?

vim +/ad7606_bi_bops +89 drivers/iio/adc/ad7606_par.c

    88	
  > 89	const struct ad7606_bus_ops ad7606_bi_bops = {
    90		.iio_backend_config = ad7606_bi_setup_iio_backend,
    91		.update_scan_mode = ad7606_bi_update_scan_mode,
    92	};
    93	EXPORT_SYMBOL_NS_GPL(ad7606_bi_bops, IIO_AD7606);
    94	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

