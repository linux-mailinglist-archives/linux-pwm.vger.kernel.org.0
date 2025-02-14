Return-Path: <linux-pwm+bounces-4913-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B18A362A2
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 17:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133DF7A4EDE
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB6E2673AB;
	Fri, 14 Feb 2025 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="di0s5rsT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D70E22F165;
	Fri, 14 Feb 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549104; cv=none; b=TBJaRGGI0eOARRTarocx/1R6PavHAWYVRG06Xu0y1O/6IEAXhIQRWsASrJJQ3kBDKkgl/mYmEU5XNt6EfCwtccKztZTza9KONbJ9eOWI4UjB9Pm+W077wDLXH2uN0pdu02bgBB/QUBi1WdFR7da6woNMLGinD1NoBVBV82Oke9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549104; c=relaxed/simple;
	bh=gr+oFhNZmIjaeOQHXEddIaHj9o3Ld8UUt/GpyThOrsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjNZQd3vShARmIEGMYZMFrxAbKIlJ5dUftpOKbFf3SYM30OjF0GmcjIlGsIgBpIHSEaG1cUIQsJ4mdNfv+eIoOxVmk5k3isA33BnUuOH6DoPkv85m1IdGL+eseeqY3C7N2dcXuE4c1t4YALeDEHqhQh8rB6ZsuLNdL/0Rs7jdP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=di0s5rsT; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739549103; x=1771085103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gr+oFhNZmIjaeOQHXEddIaHj9o3Ld8UUt/GpyThOrsg=;
  b=di0s5rsT1RqrqburwP7mMYAvJLDBmU6cCagg5tuPZUr/SduKoucJ6QKl
   umhsarHre91GExldW3mwJ8xQES1EsbYQP5x3bbxA3sMNB1u/q/nqSptJn
   mbNjf0YOIuTcm1kO/Xfnf6smoEhlwm/sntDS0lUnh4YmPMjbqOCVFuqkf
   JMtIb7UeEt4Lfx9QBLkox0d5gXlDmIyEeJnlBhqjBj6QaFbBGg7Qh4958
   AD0k8K0XCVgOiF27Xp/DjU30z3d2uTNlsdhZeTP0s2E+QDigyqwrdvLBF
   TBsD1EtF9FhZ6MmehKOoqnejq5+toNRfqOmfurQ66OBhokldQpCOxACYO
   w==;
X-CSE-ConnectionGUID: aMh4YZITRk27nm/ufItmmg==
X-CSE-MsgGUID: DA2uUI1lT0eNqsdJxSrDvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43140741"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="43140741"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:05:03 -0800
X-CSE-ConnectionGUID: vl3+/74xSCCbS1PUPCn3VQ==
X-CSE-MsgGUID: pzc6VEhtSK6qJZqBNHH8AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150655444"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:04:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tiyBS-0000000BXUB-0oan;
	Fri, 14 Feb 2025 18:04:54 +0200
Date: Fri, 14 Feb 2025 18:04:53 +0200
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
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 05/10] gpio: regmap: Allow to retrieve ngpio
Message-ID: <Z69ppU4LGvej0w-V@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-5-8a35c6dbb966@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-mdb-max7360-support-v4-5-8a35c6dbb966@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 12:49:55PM +0100, Mathieu Dubois-Briand wrote:
> Drivers can leave the ngpio field of the gpio_regmap_config structure
> uninitialized, letting gpio_regmap_register() retrieve its value from
> the "ngpios" device property. Yet, the driver might still need to know
> the ngpio value later: allow to extract this value from the gpio_regmap
> structure.

I don't think it will be needed after looking at the user. Since we have
somewhat around ten of them already and no-one wanted it makes me feel
that this is a hack which can be avoided.

-- 
With Best Regards,
Andy Shevchenko



