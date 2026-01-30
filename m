Return-Path: <linux-pwm+bounces-8014-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMVoNrw9fGkxLgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8014-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 06:12:28 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3938B7399
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 06:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A5BE3011C4A
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 05:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082E433AD9E;
	Fri, 30 Jan 2026 05:12:21 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (exmail.andestech.com [60.248.187.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1422329392;
	Fri, 30 Jan 2026 05:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.187.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749940; cv=none; b=n+2OpuvMFNm1IcdGu16L06pbbcm87J4vewb+haKVbw+0d08WfY9+6EYX0LVjnB8759PW9U3x0T0AHN0rorazZ6epGZ6wSPWPG5jAdqe6R/2rg496Oltnwp0zb6+eJ8+v4uSH11ZjCRjew56MLEZ1+18rBezw1i6sNcz4SZ3wNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749940; c=relaxed/simple;
	bh=XRTXKmVjr3TZFfKZ/DbL+RHaFXvxsYezIPJIp/AqseA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFTgwmswhrW1U+5J6qYL8bq7xdcDPWlq5JS1k1FZw4HN733wVDev+/FlEBPK+Eri6LdbZOPxhJq9xCkGjfOCmG98OcsBFrFanDmJ51fDCXee7hWACkyuI3iulu6l88vj6oxMQPZIhXELZp9dtsEpOXXsh8N0CjnLsB9uCCzD/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.187.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTP id 60U5Bgw0021883;
	Fri, 30 Jan 2026 13:11:42 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 30 Jan 2026 13:11:42
 +0800
Date: Fri, 30 Jan 2026 13:11:41 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: pwm: remove redundant check in pwm_ops_check()
Message-ID: <aXw9jY5kpPNAiyxR@swlinux02>
References: <20260129-fix-pwm-ops-check-v1-1-6f0b7952c875@andestech.com>
 <jxzeyujbaj6s2j3woj7lyuilwi7tzlhenamlih2q23khxw4d3f@dpbnhlxzsjmr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jxzeyujbaj6s2j3woj7lyuilwi7tzlhenamlih2q23khxw4d3f@dpbnhlxzsjmr>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 60U5Bgw0021883
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_DNSFAIL(0.00)[andestech.com : query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben717@andestech.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8014-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,andestech.com:email]
X-Rspamd-Queue-Id: A3938B7399
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:19:00AM +0100, Uwe Kleine-König wrote:
> I would rewrite the commit log to:
> 
> 	pwm: Remove redundant check in pwm_ops_check()
> 
> 	ops->write_waveform is already known to be non-NULL so there is
> 	no need to check it a second time.
> 
> 	The superflous check was introduced in commit 17e40c25158f
> 	("pwm: New abstraction for PWM waveforms").
> 
> 	Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> 
> to make the change more clear and also to not bother the stable team
> with backporting the commit to stable.
> 
> Please confirm if you're ok with this change, then I cope for the update
> while applying your change.
> 
> Best regards
> Uwe

Hi Uwe,

I'm ok with the change, and thank you for the review.

Best regards,
Ben


