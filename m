Return-Path: <linux-pwm+bounces-4694-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C734A18103
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 16:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B624163BF8
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Jan 2025 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956921F4285;
	Tue, 21 Jan 2025 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q6kfCJNo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED927702;
	Tue, 21 Jan 2025 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472818; cv=none; b=HpSfXTLWKzvlPFx8XCQSdTi54iP60bW9HNLz4RsTYTeoZbyYSh8Oqro4NxUzjgy59Aum5TmeFO9EfVgp15a0l9BPXx2t5nN62IoL4L6Lu5cypPt9RuyBnlx5m7njJNofXx+Q5/faLvNabIFe80I4vJCPRxlviGXBbVJF5sek7Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472818; c=relaxed/simple;
	bh=e2vLAIWhjmH4ZetsKNk7tcaF6ZxnqxH6io/qtat2wxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsfcoRdKOsgWTfQHEEhgTKA7gxqhZAX079pyyyPUPII+yhwxbshk7D3PbtGx6XDK9L6tcecp4UcP2H6XmHAFhNN2fePoY5cVDlmdOPfNUO/EouS1dfSVEZrjFhx+cYLOJDfpf37kqSKulJvZQnAbLAbRd7TCGV8pCyMa4fdQzCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q6kfCJNo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737472817; x=1769008817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e2vLAIWhjmH4ZetsKNk7tcaF6ZxnqxH6io/qtat2wxY=;
  b=Q6kfCJNouesHp2JFkTNalWmeloL038PMJOAka+HMPJjjMFpWx5PbGAbg
   YybFaXjA+LLPM4bwSVQ8hjkOMC6ABGko0+1r7K9Bt9axmBFWsDtJoF7L6
   9dh1rD6a+7BITDdoUUOWqMgaVJcKvuHmARDRpKMofJzgA8veMUeHIlC4q
   UBjwrOZLF8ni/yPz5PHX3AC0hgogPGhg37nqzBNkHKNg8B2gQsCkM5q7c
   yMxEnJZgJvpk4Hx9DLKOFsLPK7CaEPqim10oXljfHfIWFTIyQ+5KRSEv3
   EdB0g8zMOsfQPUkmZSbElTZ4GZ280x2tFC4gU+FbYmcEX+1KGVOOjJMrR
   g==;
X-CSE-ConnectionGUID: RTLZvbOCTjiX/0lf5LDNkQ==
X-CSE-MsgGUID: E0yMstiyRq6dsIc4D2tPLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="55440417"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="55440417"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:20:14 -0800
X-CSE-ConnectionGUID: kUB0vU8BRk+u+Kp97pnCPg==
X-CSE-MsgGUID: 0ocxmk3jSaWC4RxzsRW7bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="111828141"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 21 Jan 2025 07:20:09 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id ACF122D0; Tue, 21 Jan 2025 17:20:08 +0200 (EET)
Date: Tue, 21 Jan 2025 17:20:08 +0200
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
Message-ID: <Z4-7KAUhfXUSmD9I@black.fi.intel.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-4-37a8d22c36ed@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223-mdb-max7360-support-v2-4-37a8d22c36ed@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 23, 2024 at 05:42:36PM +0100, Mathieu Dubois-Briand wrote:
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> 
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>   These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.

May I ask if you researched for the existing drivers that may host this without
much to modify?

Second, please, avoid OF-centric APIs in a new code. Use fwnode and/or device
property APIs. (This stands for the whole series and any new contributions)

-- 
With Best Regards,
Andy Shevchenko



