Return-Path: <linux-pwm+bounces-7849-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB4CF4D4E
	for <lists+linux-pwm@lfdr.de>; Mon, 05 Jan 2026 17:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10EE630133D5
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jan 2026 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16E30DEC4;
	Mon,  5 Jan 2026 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5SDAXMj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FB27602C;
	Mon,  5 Jan 2026 16:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631902; cv=none; b=fXAoYZQrVLlPqz3cqZSLjvD5p2BRNQx+iCAuKmtKXJNsOUOYNkKIp1bEwpEqiPrDPXt53DNzFhxaWZ75kAJfg2Mm+VPSu6WCMYoQE7RX6N76M+DKG4g464HD8Lju8fUz4rINvj9w8PQ+IrC93aEs4D/mSgO9BxFqB+yRvLDJJNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631902; c=relaxed/simple;
	bh=v1T4XQCusX2KIgFydp6bVTLUAefqUAbECZSNwp93e00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzJ/9/AGpYWbuNq/zaZi0eTcLV20r4/tf/B9pdfO+xd/v/4pp+xsr0NaiK4nTyRwtwir6kb32CfVmHnvJBrH81amGfC2PcEQx6JmfWo81uLu3is/Rs73crdmKloSV0waF2qsrnkv58uTVdSQQi4ysD8v3W3eTW1dUr3jdr0N/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5SDAXMj; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767631901; x=1799167901;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v1T4XQCusX2KIgFydp6bVTLUAefqUAbECZSNwp93e00=;
  b=A5SDAXMjOYHvUNa4JDVKkROJPYI6e1C8kJNTDFfJ0b2h0OnNgPufh6Bb
   qqC0Lv2QLAKWcOuKpw1+BDQ6cXUwPgESe21SvbffNfimF60rYv5rI7HnX
   vNYrZwgIQb7pyD+2ZQhohmm9iTQa1knSgG7C/coMlu3rMQr0CjzVr0ssX
   dnO3gsbYlexzCdvHF7tM2exm5mpbZupAZc8xMUcqpynRrPyjHWC7tv6ok
   pazDevVz74Ug1PqJs+4Kbx6dOqMG8u1ODyPJSE1CjY4ax+ATRbMkBhuNB
   lnnsNIpjSTyfA8nCPg2r8kPcEk23QPfgkp0w9pbHTThMWUgMx1vddBEZV
   w==;
X-CSE-ConnectionGUID: wScLv2Y0S7iIVEtn04htyQ==
X-CSE-MsgGUID: WxwbiCnZSAu9/8gfGEJa4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="86417752"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="86417752"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:51:39 -0800
X-CSE-ConnectionGUID: VOZpqdAdTgCDUs90DnneyA==
X-CSE-MsgGUID: q1dP0BuoTSiLLWcaGM37UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="203398222"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:51:37 -0800
Date: Mon, 5 Jan 2026 17:51:34 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ukleinek@kernel.org, heikki.krogerus@linux.intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: Use size macro
Message-ID: <aVvsFsLvNHuBWvUv@black.igk.intel.com>
References: <20260105091737.17280-1-raag.jadav@intel.com>
 <aVvpzK1fXqwms6Ct@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVvpzK1fXqwms6Ct@smile.fi.intel.com>

On Mon, Jan 05, 2026 at 06:41:48PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 05, 2026 at 02:47:37PM +0530, Raag Jadav wrote:
> > Use SZ_4K from size.h instead of hardcoding constant.
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thank you.

> OTOH, not sure if it's just an unneeded churn. What was the motivation to
> create this patch?

Your hard work[1] continues to motivate me :)

[1] https://lore.kernel.org/r/20250825163545.39303-3-andriy.shevchenko@linux.intel.com

Raag

