Return-Path: <linux-pwm+bounces-6603-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99702AEE09C
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4417A56EF
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C3228AAEA;
	Mon, 30 Jun 2025 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yv1N+2YK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9819628B7D6;
	Mon, 30 Jun 2025 14:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293599; cv=none; b=Lt3aZgu7FSwdvv7BodDheR/sBrRIZAZnkAo7O8Vy8s7TZzH9qJ/TvDRiqW8iyd5SC/xGH4gixwwiXTTt83wmkHK2Vrw7/fNfulfk96Uk9pdes40X/a4yxulVEh5mktKSAxRxavOzhDFEAvDQckBu4fXP+G/kSVmArVOEOvL6U4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293599; c=relaxed/simple;
	bh=LH0zpZNtemYaui0yK8YL8xxeqgeBRfGvZY2w1RSLDPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3Rl04aLJcZK761tPo326NFbbKj46RHrG29ucATrXm01DJ9gdrD9MXqzs/PI/XPYpBMka1wTOtlf/up5Qtseu2ij4bS4D3626qJpJqid6Z9BuMQj9JB3JodB0/8p5ejFuEFG7TRmoupIYb+T5BXuwyOozZvFGCoV0yJqLR3gYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yv1N+2YK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751293598; x=1782829598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LH0zpZNtemYaui0yK8YL8xxeqgeBRfGvZY2w1RSLDPg=;
  b=Yv1N+2YKgsh2rsKFUiyFkCYij7cDF2b12g7G6G5YU/H0kXpi0siiO1r/
   aBXsgzUOd08GxzlyPQpCjIYcYDTBSeksBFO5OwBw3I/CnhsjJrNy745eg
   evdqLG3sCKaDrX69bnE0CkaNy6olyA9QHSucgZTCifWjzw5UBd13nXmD1
   YVfvOm8RACcPg1ZGh+0TaMxJlx2v0GUpTR23KVVv174MAVRPVPNdfBkgs
   WzcH2oZ5aVqhN1Fccy1J7LYnI+snyyH0ACpqnPFBYwQgSjruYMxwUUGpS
   1BnnzwzBcjiYZW57s2KFN+i2O2BWZKBoUk4RMYEjFaxE45YWOE5T8dgvq
   g==;
X-CSE-ConnectionGUID: /n5IoTUJSEqlJUagPkpoDQ==
X-CSE-MsgGUID: mtwG6Mn8S3q8kg5kL4uk3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53383141"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53383141"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:26:31 -0700
X-CSE-ConnectionGUID: OqDc/OX+THKtV4fz/6CtAg==
X-CSE-MsgGUID: TQePXOhoQ2OLNm7XPC+H7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="154010984"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:26:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWFSk-0000000BKaD-0sOx;
	Mon, 30 Jun 2025 17:26:26 +0300
Date: Mon, 30 Jun 2025 17:26:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v19] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aGKekeRcr-W7V0Ba@smile.fi.intel.com>
References: <20250630114504.8308-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630114504.8308-1-ansuelsmth@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 30, 2025 at 01:44:39PM +0200, Christian Marangi wrote:

> Introduce driver for PWM module available on EN7581 SoC.

This version LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



