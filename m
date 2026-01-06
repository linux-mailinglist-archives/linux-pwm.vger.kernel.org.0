Return-Path: <linux-pwm+bounces-7853-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1BCF785C
	for <lists+linux-pwm@lfdr.de>; Tue, 06 Jan 2026 10:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBEC3133069
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jan 2026 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4877C30F958;
	Tue,  6 Jan 2026 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyk05fZ/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B030BF62;
	Tue,  6 Jan 2026 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691254; cv=none; b=DjbaJszbLV7tvTQeK2eVQOB4dHpDEM20MIYDUrvFoVaKR/jh1OBzH0JNwBbvZVDtjBa5T1mfzGshO2LvsJ8h5WaWjP+Nf3hEptVF8vPW5+/+UlDy9hlzmjBFGLWNiKxwo5VfTCHXBF628jf/gaX1jw2nFf7sH6Ro1tpZ6aD6SMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691254; c=relaxed/simple;
	bh=oOeYTrnQxGPulauC7TDQ/8FzcIcuR5115oWjDelvo6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtKDiGPVcXIKk0/RdbGxHew85s6+zQJUqC15vVIPRl0Nc2Ms+eGOK3bP0wjFDmSNnI73xI/C5T2cJBQEOWjOAHU6XsdZNrinYY431fLPa3PUxtmkL/KNeEGvdTQR2Vj7bNiiF8EGdFeIj+k490r8IUXvLaF1FRF+I9GDjJOpMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyk05fZ/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767691252; x=1799227252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oOeYTrnQxGPulauC7TDQ/8FzcIcuR5115oWjDelvo6U=;
  b=jyk05fZ/5WG3lUylV0/fWgwl361vWCDhQTbK5l2zWPI3yaVQuMFDbX9O
   h+P+9t8AXf80UFIw9xKOU91+jLmBhNpBqTZUouqWUfKBXZJ6VPncUV7Sb
   KS/Kf2SNuzXGsLyuYMk4o9pOO2rZRjGLOjetFPR6DvZMPNSqTNNs9aQb1
   2cDSEyFvOmPEzPCLIzaMSGQ8CBV6N7nymaEpRL63NaP6ynbXfTlB2KJ6/
   JG/01heXVUo5nnBU8KOSAJymrdcg2+aKxQ6CtkUt79g1dxsBSIeB9KgJT
   8sRdwdzHDyRIi3261olSV8zr91jnj4Xg4RGwlWGVyetDgyNyegyBzXf45
   g==;
X-CSE-ConnectionGUID: HmVSAsXJRz6Xncvy15PgrQ==
X-CSE-MsgGUID: FOqni6JFR8uWMELz9HbeGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="79360758"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="79360758"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 01:20:52 -0800
X-CSE-ConnectionGUID: xn1SB4kURNeTd4yE4V4HnA==
X-CSE-MsgGUID: 9vbT8GC2Tfmylghk1fElgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="233753110"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 01:20:50 -0800
Date: Tue, 6 Jan 2026 10:20:47 +0100
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: ukleinek@kernel.org, heikki.krogerus@linux.intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pwm: dwc: Use size macro
Message-ID: <aVzT728UnMQyFV8q@black.igk.intel.com>
References: <20260105091737.17280-1-raag.jadav@intel.com>
 <aVvpzK1fXqwms6Ct@smile.fi.intel.com>
 <aVvsFsLvNHuBWvUv@black.igk.intel.com>
 <aVv9y8RuA_LLm7GZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVv9y8RuA_LLm7GZ@smile.fi.intel.com>

On Mon, Jan 05, 2026 at 08:07:07PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 05, 2026 at 05:51:34PM +0100, Raag Jadav wrote:
> > On Mon, Jan 05, 2026 at 06:41:48PM +0200, Andy Shevchenko wrote:
> > > On Mon, Jan 05, 2026 at 02:47:37PM +0530, Raag Jadav wrote:
> > > > Use SZ_4K from size.h instead of hardcoding constant.
> > > 
> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Thank you.
> > 
> > > OTOH, not sure if it's just an unneeded churn. What was the motivation to
> > > create this patch?
> 
> > Your hard work[1] continues to motivate me :)
> 
> Ha-ha, but that one has a principal difference, i.e. there was _a custom macro_
> *already*, which was replaced with a generic one. From the code perspective
> it's not a churn as it kills the unneeded custom macro. Here the situation is
> different, i.e. the explicit number 0x1000 is changed to SZ_4K. Just a line to
> change, the added header inclusion and no other changes, so as a standalone one
> it sounds to me like a churn.

Fair, but converting to standard macro is noteworthy IMHO.
I'll leave the final call to you all.

Raag

> > [1] https://lore.kernel.org/r/20250825163545.39303-3-andriy.shevchenko@linux.intel.com

