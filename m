Return-Path: <linux-pwm+bounces-7272-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD9CB4AB90
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 13:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17077BA135
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6287B2C235F;
	Tue,  9 Sep 2025 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnydVDDx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8853C289824;
	Tue,  9 Sep 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757416851; cv=none; b=uHc1Lo+w9heckKDlsn7n/o/85eAT85HoTEybao3s2bNht+IywF5jYfjBVmnXHNqPxKkcDPAl0i/SEi1LU9GkDaELiLHPu+oDosCmGbOOJk8B+NcqAat5LlwpK9dH6ID6JW9gkc9ckq8tyzVObDwsEvKrXjpUNhJhUQI2JJc19hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757416851; c=relaxed/simple;
	bh=4Sk8uKg8KewSVHo3QMgix4TJW9BrUE6rQ60lTzpd6QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4ongIhu3mC4X+ae4rq5po9r+9pyrc2c2W1GxnckUsIsMBG4bCcEAO1El39QzKpcKhqG6ZTVQ8tsbXxCbviNe4ykxK3e9KLUtY0H5NafSBsySDWJ4JFdad7AzQg1Qjv3z0sSAt9R8Jp2TS1mIwHfGXgLxeTdg1RzUkpDfoTkTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnydVDDx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757416849; x=1788952849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4Sk8uKg8KewSVHo3QMgix4TJW9BrUE6rQ60lTzpd6QY=;
  b=XnydVDDxhGY1komMeUVdj6plnPsKwIGPw2EcQQvn3otzbUDgnIlBD0Pf
   GskWClKn808wVdRhTr32VGkd1qzneZwi6yRiJ/a7oQx095r4N96NkCUXJ
   fbjRnACALgn85w345Zkzje5jrVKQnE7vw60ThHFnRCcqRNxhVeNjCzgZ/
   mP6q/Ggw46BLrEU7HFWbotKZTuVWqX9tWCx0H7TlBsl9q836xWCiLOQvs
   rn0ChyXixfdgZwMOesJNUQVf9bQpLSWLeoe00RfqSFIFW/VPVa5JjXqnk
   hIiDJsfMwso3iNgcATfO/cG65dGl7ulWKJf2XvQy4nQNQG1k6odet4gVU
   w==;
X-CSE-ConnectionGUID: 1Hf5IA59QzOxG44GXiumuQ==
X-CSE-MsgGUID: QZ0xDnieQ7SU4Wytljq6HQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="71071070"
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="71071070"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 04:20:49 -0700
X-CSE-ConnectionGUID: 8dvQPB+URSmJAdvFEx1atA==
X-CSE-MsgGUID: 78Yi63hyRv6qZnqAxxuF9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,251,1751266800"; 
   d="scan'208";a="172229014"
Received: from smile.fi.intel.com ([10.237.72.51])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2025 04:20:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uvwOx-00000001QC7-2agt;
	Tue, 09 Sep 2025 14:20:43 +0300
Date: Tue, 9 Sep 2025 14:20:43 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH v23] pwm: airoha: Add support for EN7581 SoC
Message-ID: <aMANiyqxneM1QxQ-@smile.fi.intel.com>
References: <20250708145053.798-1-ansuelsmth@gmail.com>
 <xsblhw36y3corxx3pxe6223auirrsqr3efovfnrm5lbo4xy3lf@wf3ytlivzv6g>
 <68bf2509.050a0220.702b3.c003@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68bf2509.050a0220.702b3.c003@mx.google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 08, 2025 at 08:48:38PM +0200, Christian Marangi wrote:
> On Fri, Aug 01, 2025 at 11:15:41AM +0200, Uwe Kleine-König wrote:
> > On Tue, Jul 08, 2025 at 04:50:52PM +0200, Christian Marangi wrote:

> > > +	 * Period goes at 4ns step, normalize it to check if we can
> > 
> > 4 ms or 4 ns?
> 
> 4ms you are right

One small but important side note (to Uwe as well, however he seems
follows what I am about to say). Recently I discovered a nice wrap-up [1]
on the writing values with units. And I think we should try to follow it
(at bare minimum to be consistent with chosen — Journalism vs. Scientific —
 style).

[1]: https://poynton.ca/notes/units/

-- 
With Best Regards,
Andy Shevchenko



