Return-Path: <linux-pwm+bounces-8345-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CWhJTk7wWn2RgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8345-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 14:08:09 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CB72F286B
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 14:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CE5F3019C91
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055083A875F;
	Mon, 23 Mar 2026 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikl1fSsQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D411917CD;
	Mon, 23 Mar 2026 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271191; cv=none; b=B+auL71lzF10+Z0DT6ces6MzzWn75QayLBh4Awx4BIob4x8PEMOOAZS07yVYVLnIqXC1qoRAFSnkLgegOEGDXMcOlvvLpaNrYbt9WaxPaC6mS7a6NKwxiAMNFj9dVE+90Be0uXNQigAx//g8rEkDnTTuyQqLeEo1bV/VXmoZcWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271191; c=relaxed/simple;
	bh=gOgv5bKsksgGx3nrv4fb0woIoZIh4/V/CUpY0JM0vXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1aaX+24czW4+41B+edcpm7BRncRWzVDno+HGDHfJrkYqDEJxGAoG7mo7Q4636iJyaH4KyusHjYLmIzHDIQH9B5FQk4h6Wpn31Q708NqEZ1s/KRTiMn3tF87L+MEHPjZM+7V7h4wpitERMXZ5HzWs1TqrFVMBbwgXD4oxuySKqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikl1fSsQ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774271189; x=1805807189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gOgv5bKsksgGx3nrv4fb0woIoZIh4/V/CUpY0JM0vXI=;
  b=ikl1fSsQN01POC/6fLBTSOAH+OphbMORWXCkkgvlxB7EDKyVDyqiiDjw
   OFAaCh30UnaP8gMChjGQxp9/qPI7B0Ktoor4UO5k2Y3UxptjGSaT+QRvG
   0VjPnaemMjlOKzxCwEGsSPQWQwGlr3Zw4n85ASt0CHC6FYPIqN5LbCsyE
   qOsk3sKkE8ZwJkaUXx4iPWUS2SxFzXrN1KgmSSv2CuCCsyaEDuoSO1fbm
   vXy7BPsSr4EaszajvsmvWAB2acqXpl0uI/VQD6L2DnOp7TV7uc4rVk0OO
   6AkFumiIqx7r4OEPJy6Y2+Gr70yWmbDSTJDU4PXK5putxXwTIxoVKUAqq
   A==;
X-CSE-ConnectionGUID: OZYIWwnTR8isps2Cy+UnOg==
X-CSE-MsgGUID: BEDOk68ZS62Q6MI0lsrEhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75332744"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75332744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 06:06:28 -0700
X-CSE-ConnectionGUID: W/sWqUpCSw2K+giilmXCDw==
X-CSE-MsgGUID: K15JoVVdTbGmKczSDs/sOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224235586"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Mar 2026 06:06:21 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4ez2-000000000Zt-0X7C;
	Mon, 23 Mar 2026 13:06:16 +0000
Date: Mon, 23 Mar 2026 21:06:13 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH v4 4/4] iio: adc: ad4691: add SPI offload support
Message-ID: <202603232017.8IO2whBG-lkp@intel.com>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a@analog.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8345-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,metafoo.de,analog.com,baylibre.com,gmail.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 18CB72F286B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Radu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Sabau-via-B4-Relay/dt-bindings-iio-adc-add-AD4691-family/20260321-120718
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a%40analog.com
patch subject: [PATCH v4 4/4] iio: adc: ad4691: add SPI offload support
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260323/202603232017.8IO2whBG-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260323/202603232017.8IO2whBG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603232017.8IO2whBG-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: module ad4691 uses symbol devm_iio_dmaengine_buffer_setup_with_handle from namespace IIO_DMAENGINE_BUFFER, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

