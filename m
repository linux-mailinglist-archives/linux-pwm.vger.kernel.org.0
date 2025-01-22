Return-Path: <linux-pwm+bounces-4707-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7787A1967F
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 17:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38388168665
	for <lists+linux-pwm@lfdr.de>; Wed, 22 Jan 2025 16:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE022214234;
	Wed, 22 Jan 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ+WMqJe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B61149E17;
	Wed, 22 Jan 2025 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563506; cv=none; b=liGuAz8/RPNWhV/DWFnCBN+nfgpc0fZQ+agRAgXSIyQjtjiDUrTX+320lQrvSMhcWcH3zGlvaOqE0CvyGM14peEfYiuRM4ktBqGq99T3+fbapuSONjXA4fHebfgBnMF8UVFXoCDK0siEhIDzm92si+NPiii3z3HQ+vhf4qu4AS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563506; c=relaxed/simple;
	bh=hD1EwUAbMc4qNDNhYPerVt+3dhyGBpkdBqMncX9l12s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aen+jr5Rsb69V60RnYQwssc3aASol5+XX9tD5KlKDTGg1FZcF0pE1f1VGKJHwcWVqEFW7bMOJk0wHNAO9pkscvUpsxZMimePARPIjGZZ4mPoWnwuOm+sv60t376KP7Fju7wl4WWn2QwEXvKuJ+Cr+265fX6H4oTX5mMSkhVnZak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ+WMqJe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737563505; x=1769099505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hD1EwUAbMc4qNDNhYPerVt+3dhyGBpkdBqMncX9l12s=;
  b=fZ+WMqJewz0zplMA6lPMQ/TQQ3UTcW4PpMoA9u29UV3qP6HFILIpJ9sF
   0b9pMwFdbEJf7+Hj6755CJUYXWygSkSc1Fq5TkKfiERCd0Dy53AqrPL7B
   r5PL28VviXF6Vp7veQSHWt5GxPFojlOKybPCmbIUcawC/4KR5jcuVZ+pU
   hy0+xXGoy77/R9FqKOI9ezWly8MTNWn4Tg7R4REzr3PbzPVz2fKXbD6j1
   FPlvogxR8F72RnXn0KP31/flpV4N2XTJWX+B/PhGkI1S0MQlZOK2Ddycg
   BPNZnYUHaF9OiTO/5UMhz4dXzAscfw7XyBjCToCV+tkEmpLpSM2b6zy4K
   A==;
X-CSE-ConnectionGUID: y5NSluC8RJqo3RDhaMx7rQ==
X-CSE-MsgGUID: sAKCQ38FT4qLZP/+drkxvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="48624768"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; 
   d="scan'208";a="48624768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 08:31:17 -0800
X-CSE-ConnectionGUID: ehtJF203QXiqFhPDXhX3JA==
X-CSE-MsgGUID: CX/RKrdIS+WwjkNaYuIgkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107631389"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 08:31:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1taddG-000000048bL-3deJ;
	Wed, 22 Jan 2025 18:31:10 +0200
Date: Wed, 22 Jan 2025 18:31:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 4/7] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z5EdThjjifY7LkCC@smile.fi.intel.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-4-37a8d22c36ed@bootlin.com>
 <Z4-7KAUhfXUSmD9I@black.fi.intel.com>
 <D78MG8EQMSBU.2U6T5DXG2YJXI@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D78MG8EQMSBU.2U6T5DXG2YJXI@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 22, 2025 at 02:04:35PM +0100, Mathieu Dubois-Briand wrote:
> On Tue Jan 21, 2025 at 4:20 PM CET, Andy Shevchenko wrote:

...

> Thanks for your review. I'm not sure you have seen it, but there is a v3
> of this series. V3 of this patch can be seen here:
> https://lore.kernel.org/all/20250113-mdb-max7360-support-v3-4-9519b4acb0b1@bootlin.com/

Thanks for sharing, I will look at it later this on next week.

-- 
With Best Regards,
Andy Shevchenko



