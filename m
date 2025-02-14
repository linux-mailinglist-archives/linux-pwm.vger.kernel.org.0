Return-Path: <linux-pwm+bounces-4915-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4D3A362BA
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 17:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D041653D3
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 16:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B1267388;
	Fri, 14 Feb 2025 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rt0vUjco"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEBD22F165;
	Fri, 14 Feb 2025 16:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549265; cv=none; b=Di/gMFKcifFfAHcz9UGWK/xFMtbT8Drel1jGBMTVt1rhwHuk9pOMoV2ZBcnQzJs1weqv7uidRhnmjshEdt9dFEEgYxik17NjzAarBavZPM/230frWv+Cmc9SfGtufAWuH2xOpTDOOVoS9wMFMEqc8ZoTX1rbYLJKmiLDrTCmY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549265; c=relaxed/simple;
	bh=kIPwPH7X7wZ8cRjLtiCbyATDZF5ahgyEmcy1BihksyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8O0HZS/BOVpOkfTjXvl+mouun5kfpqTjBATSND5Pp1ApOyoLmh6qxtSGOw7J+/z6tOWwz0SBTitVVIyvbm9SeJJdKJHKqaOplRsSYDoAW91oEG6bu+9+zCGImI2xahlJwvT/ZQRnZaHVFKRZ897NeY/0IPGdvqPNqvO2WtWLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rt0vUjco; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739549264; x=1771085264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kIPwPH7X7wZ8cRjLtiCbyATDZF5ahgyEmcy1BihksyY=;
  b=Rt0vUjcotGo1pevTU5rd1U9H2JBqBgTiUvvuHbFDLCepma4GYNagazdA
   Eo+LBtqzgWAIkxgba82J0skX68VafEhwiutmSXrJlv0CRKsTDfCOUvVQG
   f2XRTC/hA2zbdkO7oWAgeexeoUzTO9/a2u3mUl9VGnNOVC2fbOPn1snjn
   9LWFYue2bfXKzUxgy2czQlD0h4/xCPBISGINDSOFP8GfObk5appXDziOU
   rl1EL//0S16D1EOXQaaIPusrbwXDghkNeZGgW2/+iONcukcHc9kQqayT9
   x06qcW46QZpypjKTNC/ix8xdy3DvrIKMLbKJDor2VBbprn01BROIhZkXU
   Q==;
X-CSE-ConnectionGUID: +XiEyjH/ReirNUMi8hqceA==
X-CSE-MsgGUID: +Cd292ZORs6z1b+XZ/D6Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="43141038"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="43141038"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:07:43 -0800
X-CSE-ConnectionGUID: fL05wUw3TFu5bVqAt2WnrQ==
X-CSE-MsgGUID: OFDMSXopTM2RK4LrmNzj8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="144347581"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:07:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1tiyE3-0000000BXWw-0Sh6;
	Fri, 14 Feb 2025 18:07:35 +0200
Date: Fri, 14 Feb 2025 18:07:34 +0200
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
Subject: Re: [PATCH v4 04/10] gpio: regmap: Allow to provide request and free
 callbacks
Message-ID: <Z69qRrQ3XxgKtPUD@smile.fi.intel.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-4-8a35c6dbb966@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214-mdb-max7360-support-v4-4-8a35c6dbb966@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 14, 2025 at 12:49:54PM +0100, Mathieu Dubois-Briand wrote:
> Allows to populate the gpio_regmap_config structure with request() and
> free() callbacks to set on the final gpio_chip structure.

Yeah, I understand the intention, but I have mixed feelings about this.
OOH it helps with the cases like yours, OTO it sounds like a hack instead
of proper implementation of the pin muxing. Yes, I know there are some
drivers in the kernel do similar things, but it most likely historically
and not always having the same HW capabilities as this chip.

-- 
With Best Regards,
Andy Shevchenko



