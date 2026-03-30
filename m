Return-Path: <linux-pwm+bounces-8428-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLioH3EMy2msDQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8428-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 01:51:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8D3626FB
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 01:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75DEF3014A37
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 23:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101D03BED15;
	Mon, 30 Mar 2026 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PR/2km4+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C903B9608;
	Mon, 30 Mar 2026 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774914666; cv=none; b=b3eAHHuRi1zAFbgapgCJOj6FoeYwCV7ZRUGuQsOYlrORCVnfBdgDeMK+Yk2SXh1BpnrTibGRZIdZUMntOnS8peDsgMoKDF+gjeZTG7Gi1bdBl1Qm0LDEBltpsdjqxR1v/xk2Z7O1T7jbgdyDIrirn08l+PSuX3lQ6k16B0yVmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774914666; c=relaxed/simple;
	bh=3Ve9LY2wIgFdBUPZpWBHQ981zkpK8qkZE5S/h1XyfBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBERajMx1BCeRlxWa+JYeeN3KNZzJEMEgcD9/wpGWrr1chAWQeVfsNjU16iKRP9wBYJF9Ipw4BKoWR8NWD/FJzUUpeLqMIFMHUaV0bJBl7IEkeo4mjK15+KeQUE5ZCj2dsGHOX1RknJ1XX1gh+e+HGbMAmiI+OCpDuDE/5TRmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PR/2km4+; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774914666; x=1806450666;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3Ve9LY2wIgFdBUPZpWBHQ981zkpK8qkZE5S/h1XyfBE=;
  b=PR/2km4+ARthZX9vQWnlzbDCTYgOsyNcGajl4zHCIFQfgntunKmLjF1V
   g/4Io+XE+7+8OhdjE1eIkerY2MQ0yosNFMWGbDcpgyA6L0O+qHVwRHJVX
   aI5uVm2f96t9aaaTUoZp2sGUcvNEMvP1t9U2sgatPJDqV0tlpNEDIbHHd
   xfVXgtiHhbt2JMMQbO7o7bhY8H5t0eY/46BtLlmRa+clEP3vwMKdebBJ9
   gNRUEc24J+SzJxfQU8net/YFAUbIJnR6YFDNWSeiEaLyMDm57m+EsWdDm
   sDzeppC6loH+MPOu9UNlbpT7y/8PxL/SlWpSMXn2kLMLq3qn37SGnNdbX
   g==;
X-CSE-ConnectionGUID: x0Dyo3z3REGDyQp6VzKVZw==
X-CSE-MsgGUID: GpPnaW5iR8689AHhGb4XNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="98528031"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="98528031"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 16:51:05 -0700
X-CSE-ConnectionGUID: OVPUjDCUSPO9Em7wSZcCCA==
X-CSE-MsgGUID: EYhVNtHzTaiYOy311aqwaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="249419287"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 30 Mar 2026 16:51:00 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7MNk-000000001sn-41Af;
	Mon, 30 Mar 2026 23:50:56 +0000
Date: Tue, 31 Mar 2026 07:50:39 +0800
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH v5 3/4] iio: adc: ad4691: add triggered buffer support
Message-ID: <202603310753.zLWq0JDB-lkp@intel.com>
References: <20260327-ad4692-multichannel-sar-adc-driver-v5-3-11f789de47b8@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327-ad4692-multichannel-sar-adc-driver-v5-3-11f789de47b8@analog.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8428-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,metafoo.de,analog.com,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 64C8D3626FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Radu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Sabau-via-B4-Relay/dt-bindings-iio-adc-add-AD4691-family/20260330-200546
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260327-ad4692-multichannel-sar-adc-driver-v5-3-11f789de47b8%40analog.com
patch subject: [PATCH v5 3/4] iio: adc: ad4691: add triggered buffer support
config: i386-randconfig-r131-20260331 (https://download.01.org/0day-ci/archive/20260331/202603310753.zLWq0JDB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603310753.zLWq0JDB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603310753.zLWq0JDB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/ad4691.c:675:47: sparse: sparse: dereference of noderef expression
>> drivers/iio/adc/ad4691.c:675:47: sparse: sparse: dereference of noderef expression
   drivers/iio/adc/ad4691.c:757:47: sparse: sparse: dereference of noderef expression
   drivers/iio/adc/ad4691.c:757:47: sparse: sparse: dereference of noderef expression
   drivers/iio/adc/ad4691.c:809:46: sparse: sparse: dereference of noderef expression
   drivers/iio/adc/ad4691.c:809:46: sparse: sparse: dereference of noderef expression
   drivers/iio/adc/ad4691.c:815:40: sparse: sparse: dereference of noderef expression
   drivers/iio/adc/ad4691.c:815:40: sparse: sparse: dereference of noderef expression
   drivers/iio/adc/ad4691.c: note: in included file:
   include/linux/bitmap.h:797:55: sparse: sparse: shift too big (32) for type unsigned long
   include/linux/bitmap.h:797:55: sparse: sparse: shift too big (32) for type unsigned long

vim +675 drivers/iio/adc/ad4691.c

   668	
   669	static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
   670	{
   671		struct ad4691_state *st = iio_priv(indio_dev);
   672		struct device *dev = regmap_get_device(st->regmap);
   673		struct spi_device *spi = to_spi_device(dev);
   674		unsigned int n_active = bitmap_weight(indio_dev->active_scan_mask,
 > 675						      indio_dev->masklength);
   676		unsigned int n_xfers = n_active + 1;
   677		unsigned int k, i;
   678		int ret;
   679	
   680		st->scan_xfers = kcalloc(n_xfers, sizeof(*st->scan_xfers), GFP_KERNEL);
   681		if (!st->scan_xfers)
   682			return -ENOMEM;
   683	
   684		st->scan_tx = kcalloc(n_xfers, sizeof(*st->scan_tx), GFP_KERNEL);
   685		if (!st->scan_tx) {
   686			kfree(st->scan_xfers);
   687			return -ENOMEM;
   688		}
   689	
   690		st->scan_rx = kcalloc(n_xfers, sizeof(*st->scan_rx), GFP_KERNEL);
   691		if (!st->scan_rx) {
   692			kfree(st->scan_tx);
   693			kfree(st->scan_xfers);
   694			return -ENOMEM;
   695		}
   696	
   697		spi_message_init(&st->scan_msg);
   698	
   699		k = 0;
   700		iio_for_each_active_channel(indio_dev, i) {
   701			st->scan_tx[k] = cpu_to_be16(AD4691_ADC_CHAN(i));
   702			st->scan_xfers[k].tx_buf = &st->scan_tx[k];
   703			st->scan_xfers[k].rx_buf = &st->scan_rx[k];
   704			st->scan_xfers[k].len = sizeof(__be16);
   705			st->scan_xfers[k].cs_change = 1;
   706			spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
   707			k++;
   708		}
   709	
   710		/* Final NOOP transfer to retrieve last channel's result. */
   711		st->scan_tx[k] = cpu_to_be16(AD4691_NOOP);
   712		st->scan_xfers[k].tx_buf = &st->scan_tx[k];
   713		st->scan_xfers[k].rx_buf = &st->scan_rx[k];
   714		st->scan_xfers[k].len = sizeof(__be16);
   715		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
   716	
   717		st->scan_msg.spi = spi;
   718	
   719		ret = spi_optimize_message(spi, &st->scan_msg);
   720		if (ret) {
   721			ad4691_free_scan_bufs(st);
   722			return ret;
   723		}
   724	
   725		ret = ad4691_enter_conversion_mode(st);
   726		if (ret) {
   727			spi_unoptimize_message(&st->scan_msg);
   728			ad4691_free_scan_bufs(st);
   729			return ret;
   730		}
   731	
   732		return 0;
   733	}
   734	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

