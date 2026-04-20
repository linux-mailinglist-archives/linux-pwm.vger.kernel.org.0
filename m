Return-Path: <linux-pwm+bounces-8633-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGl/ILf35WnjpgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8633-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 11:53:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4FC429196
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 11:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4611301B91E
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Apr 2026 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095DA346A1D;
	Mon, 20 Apr 2026 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UAcnueRr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A913D24B28;
	Mon, 20 Apr 2026 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678822; cv=none; b=BqvvqlDQ32NuvRrqHNFbDC0lwFbM/bhi5RVRtL8+C5LBVQrr78GAxE3Clhj4PhgzVVxbVpDLxuXlpBZXOmhJB6wgVqi8dLkichzFzHaprbKNkT8vTGL3gu11hoI6ZMHITXlJOWgDhbjAJmtRapROSxuo9++4xF1iRJHNyFe9LKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678822; c=relaxed/simple;
	bh=yUqQqQg1+O6iuqTf/jsk5/wv7OLarZ8saA9Jt+EigLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaK3xcoMHGBiSEmw/p93dMTJ+i77zxoCe4f6P09GWhDMPectocDPJDYTMegaWBygVir+OtPslqeavrzMLbuGKAeqRiUn4b5KUo7lyPl/74xIDUB4Ns9mcqTfNankgXN5juoFR6NNPDeZGB6QQfFgTCKseqmVlLLpAGJMC8W1iUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UAcnueRr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776678822; x=1808214822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yUqQqQg1+O6iuqTf/jsk5/wv7OLarZ8saA9Jt+EigLU=;
  b=UAcnueRrnvUapl7aOXBykZp+if/3sFm6mJ3lMGTnDTRjZver+FplqArk
   NufdWcBP6yMDDF4G+nLUuDpcjDWoP4pL7v6aPs87A/iBFVLGYcTl9CAte
   8OV6woZsxQ0NSqCJb34WvawM8igK3vPsc3QmwVwJRF0GKJpWTi4EPUaBX
   k4f+/lY8n5kpzULOlEpEojBOzhNlamM28EcGWKrVhHTQFC3Sfw55sbFTM
   8dnaC39b2TtGKqkbatQ7hdBHX7b+4ZGsNB3NoUSNHBug8sxiQ/XCG2eG9
   dCDbXXtFuLSIVjDm9U4PNHIILeJzkDlMf5GQFGHEFxXRRk0WOe3T/ITkP
   A==;
X-CSE-ConnectionGUID: qwTtQktoQW29EfQjxokr7w==
X-CSE-MsgGUID: r32hbQs0SfCDGz5ME4UuSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77772724"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="77772724"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:53:41 -0700
X-CSE-ConnectionGUID: VZ4SjzCEQWKGwA1bZtfgGQ==
X-CSE-MsgGUID: 1TOMVDy3QseP1psk2RAVKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="254935418"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:53:39 -0700
Date: Mon, 20 Apr 2026 12:53:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Cercueil <paul@crapouillou.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH v1 1/1] pwm: jz4740: Drop unused include
Message-ID: <aeX3oUzDqWSOTTsN@ashevche-desk.local>
References: <20260320220755.3237369-1-andriy.shevchenko@linux.intel.com>
 <ab3GbpMDeH9RbVOm@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3GbpMDeH9RbVOm@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8633-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: EC4FC429196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 12:13:06AM +0200, Andy Shevchenko wrote:
> On Fri, Mar 20, 2026 at 11:07:55PM +0100, Andy Shevchenko wrote:
> > This driver includes the legacy header <linux/gpio.h> but does
> > not use any symbols from it. Drop the inclusion.
> 
> Sorry, this is just a 1:1 copy of the previous message sent by a mistake.
> Use whatever you want, though, they are absolutely identical (body wise).

Uwe, can this be applied?

-- 
With Best Regards,
Andy Shevchenko



