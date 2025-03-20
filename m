Return-Path: <linux-pwm+bounces-5254-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35704A69E3D
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 03:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CB2189EA56
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Mar 2025 02:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6541C173C;
	Thu, 20 Mar 2025 02:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7u3UbIY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BA91E98FC;
	Thu, 20 Mar 2025 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742437582; cv=none; b=PGPVCrlP65uL7OxL4bnY+YL0oo+k057OfHSJxssUYuScKhOacOHGXgaA7hU7mToYpYMJ4G49tIqKk3Ov/rqvzHdbpLeZikZKzVpSZqKMOwpRSzBWuocW0Yz/paxEcBAROkAZQP1V2JKgCToMJKE0cJz3C1lhKOyvQZ9Ky0ak+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742437582; c=relaxed/simple;
	bh=291HTSj4fCLUSrxd6oGcWY8dOfOz8/d+lx/A+WebZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhmDk02ZeUs/1EfpR5KQa0W+3HZntcGCC2KQ9BzVfRMKWWOK1r794RLGWl3t4bETTNiaeU+KNC0Ht2eKOrY2qnHsHSnuBcKVGFhobF6YRVkZU6YQn3dZbo5yj+xP4yg1ERdlwHI1Vug2T9JCl9Sxca3vA7DIzPAHi8k6bhD/E1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7u3UbIY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742437581; x=1773973581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=291HTSj4fCLUSrxd6oGcWY8dOfOz8/d+lx/A+WebZc0=;
  b=H7u3UbIYyRVKflPJct5l7/4T19frxGMi15/ZMpeefuoOeVO4lpumzy4A
   d/phdLpk40kyILZA4JF6VgjEbagaXW196Zx1X8xOQiedlh71qIwsI4wFb
   QLYNLHppcExdCKsKUVNWEhacvOiwkR+pmNmVovz8sa/Kj+1afZHHgLwom
   z0760gaZy7XjE7KiiMZKC839hjkKNazLdjQnKF2LV32toaf+IvLdLS3a0
   TjuucwDYwVQNILQDMBVcY2Cu0+XRlXVWO4quypdgntIYMMi7WNSBEjjSb
   suJSsipn0hzJxCNXUtRH5IL0r7MJhPI0h8ErLdmSZxrqIySr0kaaow9tc
   w==;
X-CSE-ConnectionGUID: TM/wO+W7Q8uMnUk8thqmpQ==
X-CSE-MsgGUID: sWYVrA2mQne8qotXCmJUWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="31234046"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="31234046"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 19:26:20 -0700
X-CSE-ConnectionGUID: WQ1ooowkQ3Otx7abhDKtlw==
X-CSE-MsgGUID: lazrnhHSRHew6gtn2nXdWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="128129700"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 19 Mar 2025 19:26:14 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tv5bn-00007r-1J;
	Thu, 20 Mar 2025 02:26:11 +0000
Date: Thu, 20 Mar 2025 10:25:59 +0800
From: kernel test robot <lkp@intel.com>
To: mathieu.dubois-briand@bootlin.com, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
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
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	andriy.shevchenko@intel.com,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: Re: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Message-ID: <202503201022.7smCPVZj-lkp@intel.com>
References: <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on a64dcfb451e254085a7daee5fe51bf22959d52d3]

url:    https://github.com/intel-lab-lkp/linux/commits/Mathieu-Dubois-Briand/dt-bindings-mfd-gpio-Add-MAX7360/20250319-003750
base:   a64dcfb451e254085a7daee5fe51bf22959d52d3
patch link:    https://lore.kernel.org/r/20250318-mdb-max7360-support-v5-4-fb20baf97da0%40bootlin.com
patch subject: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
config: nios2-kismet-CONFIG_PINCTRL_MAX7360-CONFIG_PWM_MAX7360-0-0 (https://download.01.org/0day-ci/archive/20250320/202503201022.7smCPVZj-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20250320/202503201022.7smCPVZj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503201022.7smCPVZj-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for PINCTRL_MAX7360 when selected by PWM_MAX7360
   WARNING: unmet direct dependencies detected for PINCTRL_MAX7360
     Depends on [n]: PINCTRL [=n] && MFD_MAX7360 [=y]
     Selected by [y]:
     - PWM_MAX7360 [=y] && PWM [=y] && MFD_MAX7360 [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

