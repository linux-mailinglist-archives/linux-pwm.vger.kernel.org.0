Return-Path: <linux-pwm+bounces-8365-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LeRGKnLw2lKuAQAu9opvQ
	(envelope-from <linux-pwm+bounces-8365-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 12:48:57 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BBD324334
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 12:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E72131AA7F6
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F423CCFD1;
	Wed, 25 Mar 2026 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HaNMdamF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187573C9EC1;
	Wed, 25 Mar 2026 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774438415; cv=none; b=rfU5yVWCno4s+652qHu6dqx3mj6bk6+ik2yh6ED8t9n5ulzHcyhjB53+Yd9B02+GsuON7nGSidrFweY3nrxO3xcBOi9Q5pKZowT+n/G64L9VapI7niJoxb4i6we733E2MrYUNhg9qKG6jFh2mRamg6QgmNo5IyFaeSPk71eabVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774438415; c=relaxed/simple;
	bh=SVgS/c3csFd9u/m9vlt0wexGSwtyJ6O5udDeLz/HdPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyeqi3F/pqJt7QB+o4txaBBNphvjhNYmpCx8XynyoUa8KRHFOgZ/yodJlwUjB175dSd9LX3wXmXRrgPYV0Y7krCv7/et9XHIng89GnY/2u7etH94R01+ju/ELF3418acQdjDmijIIwXCnweftjIInxoHWgXjueDLwQ+ZDNZ1sI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HaNMdamF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774438414; x=1805974414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SVgS/c3csFd9u/m9vlt0wexGSwtyJ6O5udDeLz/HdPc=;
  b=HaNMdamFxGOG+S/OI+n77nmpQ6p0Qmcli0+tlWZUoHlXfwWTmr3y2jAO
   iy4jd2FyzL0yNWNsqrYX9PoZHEoYa4+p95GIK/b8ss9EkViN0uLN3vWn5
   LSjzli2Ug5qoPq+dLFtCsKqjv1G7vQ2euclvZj4VHRb1x5fNWMS03cZuX
   xaDxzYy2+prIK+68QLlNEMChn4fLGw4zI440svBe78isMUrH6tU+FzOxZ
   lLc2ZDI26PnH+BvZ6pU3JdG7xH5cc4q0vuitZ6hXdCfIJneFtRVEZRf15
   8NDw4TGpMqcJAFqySSPh5yopIK+i/4ydm2yuyti46mZJMC0gkQAGz693C
   A==;
X-CSE-ConnectionGUID: Lpaq3+ZTSPe+XmnLkcVFnQ==
X-CSE-MsgGUID: RU6RxR4sQviJwHKxw/mEQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75539630"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75539630"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:33:33 -0700
X-CSE-ConnectionGUID: SsrqaiHRQjKJ9G0vieL5ig==
X-CSE-MsgGUID: yKxUJewKQAyCBv06w/Hncg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="219804166"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 25 Mar 2026 04:33:28 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5MUG-000000006k5-3sfo;
	Wed, 25 Mar 2026 11:33:24 +0000
Date: Wed, 25 Mar 2026 19:32:43 +0800
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
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
	Radu Sabau <radu.sabau@analog.com>
Subject: Re: [PATCH v4 4/4] iio: adc: ad4691: add SPI offload support
Message-ID: <202603251904.qcAGC4cf-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8365-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,metafoo.de,analog.com,baylibre.com,gmail.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: B5BBD324334
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Radu,

kernel test robot noticed the following build errors:

[auto build test ERROR on 11439c4635edd669ae435eec308f4ab8a0804808]

url:    https://github.com/intel-lab-lkp/linux/commits/Radu-Sabau-via-B4-Relay/dt-bindings-iio-adc-add-AD4691-family/20260321-120718
base:   11439c4635edd669ae435eec308f4ab8a0804808
patch link:    https://lore.kernel.org/r/20260320-ad4692-multichannel-sar-adc-driver-v4-4-052c1050507a%40analog.com
patch subject: [PATCH v4 4/4] iio: adc: ad4691: add SPI offload support
config: openrisc-randconfig-r063-20260325 (https://download.01.org/0day-ci/archive/20260325/202603251904.qcAGC4cf-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603251904.qcAGC4cf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603251904.qcAGC4cf-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: module ad4691 uses symbol devm_iio_dmaengine_buffer_setup_with_handle from namespace IIO_DMAENGINE_BUFFER, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

