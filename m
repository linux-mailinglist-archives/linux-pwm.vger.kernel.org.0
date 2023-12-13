Return-Path: <linux-pwm+bounces-554-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A99B811BAA
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 18:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188D2282596
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C685C59B79;
	Wed, 13 Dec 2023 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="me/H8nb5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45663107;
	Wed, 13 Dec 2023 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702490178; x=1734026178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nx8jkz8cM5ma2VLAzIec1DKhKGn4kadIgzdI3KbpeWg=;
  b=me/H8nb5rDjbf0a2jz9dlXblgJfo+aWhgDiLF5Jvcm8yy7C3ufjuXvmu
   NUndxfmad0smFPP08dX4jnVC1aViTxwZmWVKtM/EYCf6oYZsaEh/n4lk3
   xL8pvn/a5wVTDPNce1S4BQ3nlU8TXZYPaMY+de0ujIZeIdkOX3A4Du27u
   pDPo9cyBPNsmrBb1ZeiImMMQDtsfHA8A9Aj9LT1GpKSv2taK9fuOkh6Jx
   e+02vUeLOdCTuWCE1WZLkyjEwO1rCkLB9XpeCvZlMJNSmhcVRpm/Q4sAb
   +5sa5QBMbfmnL9dlRznSU0uAX8KAO83MRyk1st/wset5aYA3CWhowNXGS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="392176140"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="392176140"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:56:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="777587292"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="777587292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 09:56:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rDTSv-00000005bHC-0nMU;
	Wed, 13 Dec 2023 19:56:13 +0200
Date: Wed, 13 Dec 2023 19:56:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 14/40] pwm: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <ZXnwPOD4hVOHvNju@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-14-c307b8ac9aa8@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-14-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 12, 2023 at 11:20:31AM +0300, Nikita Shubin wrote:
> Add OF ID match table.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



