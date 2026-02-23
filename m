Return-Path: <linux-pwm+bounces-8148-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK2XA0gUnGkq/gMAu9opvQ
	(envelope-from <linux-pwm+bounces-8148-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 09:48:08 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185DC173477
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 09:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2CD2300CE64
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D134C990;
	Mon, 23 Feb 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka1gUbDa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1DDDF76;
	Mon, 23 Feb 2026 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836485; cv=none; b=ImcPPdnMnckav6FWcuHagJ3+pX02gdrmetyLjYIJPNJ+CxcL3cfIbN2tba+kf/r1lZ8LcWKqPZs/BqcFVGIh/7lnfdW+yrVi7Ph8YgFcbCBGf7CdAXTM1/Eb+yYGGrKhWIdZM3CTQXhTeDlIbpEC6P0e+x2zcMKW7WVmWrjNpNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836485; c=relaxed/simple;
	bh=z+kXThslhG2AyYgr/jT4aZbPeF6AcBYD56qROwdY0Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fW8bntSFy0MAzeEx37rlzFSnykIQcfSFDjMQh0yrkvEELnGBiWOqFEL+7D6oVu9Q+0ht+2GmQ1YUcQOrmKQwDS8b8PIHiBPRuloB3G/BSNcUF/2RS3Rpl1KZ2eP5G9O1Lbo4rLSvcS7oiRdAYTkdxHIojW/uO+p3YgS5Leks064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka1gUbDa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771836483; x=1803372483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z+kXThslhG2AyYgr/jT4aZbPeF6AcBYD56qROwdY0Rk=;
  b=ka1gUbDaYlsEJNBONWPGAB0nWxW6y7fXH6Vo8S8JNc9emlHi+wl6QNoU
   Pbslte5+rNZjMS4p4dQbGMz5ah02RdQp0xGQpjuqo8acGOrNvcUIdy04r
   s0VDZKIUx4Jqlp8z3yvQnbdtRqNuub46Foc9iP9ASnhPTK1LVcM9yeAmX
   6mPUzWTGDO8X9wtsgIJ0RZtoKgx31O8GrS6gjHOwpt6l+//A+90wntx/r
   IA4J7K34f4668Rm+KwGbcHwESgbKmqJWohopSM8rOD0AF9Za36Ca6WfGq
   HD/HkPb+Nx8uzkW++UZDOdrWDb2NdSXgebUSDYFNOw4gdOaAyOcYJ8GoU
   Q==;
X-CSE-ConnectionGUID: sdDDOnvASMiFDbtkWxz6hA==
X-CSE-MsgGUID: ZOKH8nPzRoi0x7m+6NtfXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="83538695"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="83538695"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:48:02 -0800
X-CSE-ConnectionGUID: riLOn9xtRsWaCqi0dYDx1g==
X-CSE-MsgGUID: 85d6+7KnTWqEum4PO7INxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215512214"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:47:58 -0800
Date: Mon, 23 Feb 2026 10:47:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <aZwUPKL4wGWyKBE6@smile.fi.intel.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
 <20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
 <20260222185704.375a2a0b@jic23-huawei>
 <PH0PR03MB63517AE635266411B18E1BD7F177A@PH0PR03MB6351.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR03MB63517AE635266411B18E1BD7F177A@PH0PR03MB6351.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8148-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,smile.fi.intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 185DC173477
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:49:38AM +0000, Torreno, Alexis Czezar wrote:
> > > Add support for the Analog Devices AD5706R, a 4-channel 16-bit current
> > > output digital-to-analog converter with SPI interface.
> > >
> > > Features:
> > >   - 4 independent DAC channels
> > >   - Hardware and software LDAC trigger
> > >   - Configurable output range
> > >   - PWM-based LDAC control
> > >   - Dither and toggle modes
> > >   - Dynamically configurable SPI speed
> > >
> > > Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> > 
> > Hi Alexis
> > 
> > Welcome to IIO.  A few quick comments inline, but as others have observed
> > the patch is too large and needs breaking up.  Also there is a lot of custom ABI.
> > Given we are reluctant to merge that at all, it definitely needs documentation
> > and careful consideration of whether it can be done with existing ABI or is
> > more appropriate in DT.
> > 
> > Thanks,
> > 
> > Jonathan
> 
> Using this reply to acknowledge all the emails/feedback.

> Thanks for the time you spent on this large patch.
> 
> It seems I will have to split this up first. I think it would be the basic driver,
> the ABI + docu, then the debugfs. Merge 1 before I submit the others.
> Will apply each feedback as I go.
> 
> Some naming schemes need to be updated, to properly reflect the datasheet
> terms rather than the one internally agreed upon.
> 
> The most unusual that a lot pointed out is related to the clock/.speed_hz/
> spi_engine. I was asked to make it work a bit beyond 50MHz, using a cora
> fpga. The cora processor spi is limited to 50MHz due to HW, hence the need
> to use an spi-engine. However, this is limited to the resolution on how small
> the frequencies can be changed, the spi engine only does integer division, thus
> leading me to change the clock driver of the spi_engine itself.
> I'll try to see if the implementation can be changed to something simpler and
> will make it easier for us.

Please, do remove the context you are not commenting on!
I have listed ~500 lines to understand if there is anything below.
Waste of time for each reviewer / follower...

-- 
With Best Regards,
Andy Shevchenko



