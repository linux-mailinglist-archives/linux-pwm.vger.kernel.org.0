Return-Path: <linux-pwm+bounces-9680-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IQHiE9/iT2r4pgIAu9opvQ
	(envelope-from <linux-pwm+bounces-9680-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 20:05:19 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BF67341AE
	for <lists+linux-pwm@lfdr.de>; Thu, 09 Jul 2026 20:05:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=jannau.net header.s=fm3 header.b=qzwJu7DB;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b=IGOtA0Dc;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9680-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9680-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B51863027B6E
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2026 18:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70098385D61;
	Thu,  9 Jul 2026 18:05:14 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA04195D0;
	Thu,  9 Jul 2026 18:05:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620314; cv=none; b=sJSvgixCQdnikv12YTGgqrvTfGDj3oIZYly0Re0LtILACvLhac7lyWpxuGi8fgZcQLgPZypPuZpPCUjlGSDxyx0ygoK0KQ/uVOfnumnQRM9x92zXSr9UXFeJpEz6PneDE6XymdViMtAHLiF4d9stEFL0RvgTgNxhkamFoAzdcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620314; c=relaxed/simple;
	bh=88Il6o3GDumq1/JRffaM/gPhh8A1X4ZmXlkGnyV22T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU11nm0sLuYqxJBsHR40X4ZeT8C1/Lm1FtbbFKEcVMouRX2gZqEph7jx6nw2PUpsyR+udxXWnb8spz7mme1pG3gwBUc4fnkzEUdMchy7ZpkPjJHhOZY2eoUamTe6rcCmVwTsPEkq9tihExRgPU/wkYQqy5XezUjQnz6sWUi7Akw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=qzwJu7DB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IGOtA0Dc; arc=none smtp.client-ip=103.168.172.139
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id A722813801E6;
	Thu,  9 Jul 2026 14:05:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Jul 2026 14:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1783620311; x=1783627511; bh=zLBIDdgp21
	CA6tyOS8pa4Vcch/zpzqNCPhjDMKvoA64=; b=qzwJu7DB9JJZElTNFp5TPvC/++
	rynA1aIFA9q5ayidl9MyZDH9ofdhA5rnSIPKPkvIGWMz8v/Ht3Xxa6W2EuymfNMK
	aOU1AVEmjXgMmtg2WVOwcqeoE4QquvzA4kZoczjCbfyFrzXUwJoXHrsyav4dZ8hm
	/XaILJb1V9sTG/yvzQoHw5acDu1hK8ZdGpFeVei2tZI3cwt925TmDl1fvSafqVBn
	70wXV6jJhid55buIOKpPTe0X4PUjjiHmLuaOBmNtXmt1PMFua5BwJ+SEeeDzIh6d
	N+rTI4vhtiYSGNH4Hv/Op31sg3H+qYkJM/Iren1KNrrICgia1Mn1Vg00hpKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783620311; x=1783627511; bh=zLBIDdgp21CA6tyOS8pa4Vcch/zpzqNCPhj
	DMKvoA64=; b=IGOtA0Dci4mdhoeln1IJGLMitqFEihNxkdU90vLVjcM9LHY3EXU
	AksllROpBSlsrEjZdYdOZ0gS0PFq+GfmlReirytYxCNLUWxOSph3tk+t4cRRD31t
	utS3Dw5K9JF3hZ+flYnmARHKvzcxINYIVCgxIRIOF47oEJVPfIpNaZCpcuZLsIfx
	yRpWURHvWJFCCOtmtf4pmhwTgbyXyHwXg5e5ztb00lJHYs6Q/2Izt9np1tgfBWDp
	rNcKAxhIifyImEYESAIjeK2FDR2xJvgL471UHqYtk79MDq5tqdvV0mevIVgYB+oH
	bzEnqXMX+hheJMgqjIymN+kwH1RvZvFxkHA==
X-ME-Sender: <xms:1uJPaqXTJpyaqyYOfeVvjMXoG_Z8JvqcbQy599_ZakFYB-ERLfgXYQ>
    <xme:1uJPardOG5Me_aRUArgznZqdIfzEyAJ8MQUgGhbppc36iMphnbRGFw9EEiqVoNu4i
    5vibMftK3daLCBoOnsk0HNnfdyV81N7smM9e7dtVn3ejyOZrViG9FE>
X-ME-Received: <xmr:1uJPar_-OMZXN_efuC0Aa0L6bfR4TTtJcLKPVQ_5f6eL4PXTFlQFO5zeVXAnXVD2X_xcXuAKVtS6VNh4mKASNk1ImcEkTwUHbsY>
X-ME-Proxy-Cause: dmFkZTGG4NIPPZO3zNACYWoFBeZMjipowLkaVFS6w00rSUNcpMTlTv0UEDx1iKBB59vNxU
    eDUqCv6fMm5ST+f8AVDNSwXnSkiRkTOxJlvRqXoyx6tSxGtpA7xQ/nDmCFYUvlL7/fWph3
    a7SpIUDvibHYvCngc7umdumQDXo/auJw847PqxegzFZ6YZrWF9iOlb95ZbIt05beo7Ef2g
    RpDqSvSd1n1+ksU1BZKQ0zb/0wyhMxzOHiwAnCjXYvvK/efT3HetwAWLCiQt0y5vz/KGCH
    7qAn1jJlPCkEC4qFTNtsbRN6AekNUJkH3SJBZxlwwfCPgNozkACOcdx3foTDRQHRz0SEpb
    ii6NTL8uJY6TLoNWRCtBIeUNK8BGICIfMJfYalOeUCoyUetDRLJPxfSpY+faiLfsk2pbnO
    3PzP0tAU/kHzmZ3q/epgnhfjP1ciWOLb7rU/4hcNzszZwYW56VD2scbpDF22YHyWPh0+Ox
    VuPqX6/JVsGJO8DVV3aSBRMtvtnbtGf3idhWxJ1QFKvYyQ8M4FPk6LSs1B0XTOsNlZNwJY
    EuqG+64gVRiS+bhaNxCxyAUM+M4xo2fh90DoUbYWgH3ZDrVk7JDl1H5lLKtVwJllM1Q/7n
    ucJ4BkRf1CW7VLVBg5tIt7gxSAJF/gSqT5jNuWfOFtBmFI3cE5C0NfyaMmqQ
X-ME-Proxy: <xmx:1uJPajbh2iHlWLbX_fCr40ZWWPGq6dHrXKtVff2wPkglyRn2csgvdw>
    <xmx:1uJPajvBmB5d73u7twbjfGXENXIfljtlc1Bf7JvAPQRdV_dGjfNs0w>
    <xmx:1uJPaoaPM19OqrOrkBvcNfpTe0YMUW9fLMusi0yYDljMmmO-LXwWXg>
    <xmx:1uJPavS_K6hsTdI1bxu3YBKk9-OT_LUKMGjulVfxHfM5Dnvn8oCWpg>
    <xmx:1-JPahNJC3_2Q28LHOSPearUEuFIKUe0x2HIXKkc3D7REDCg7tF_AkVe>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 14:05:07 -0400 (EDT)
Date: Thu, 9 Jul 2026 20:05:04 +0200
From: Janne Grunau <j@jannau.net>
To: Conor Dooley <conor@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linusw@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Finkelstein <k@chaosmail.tech>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: arm: apple: Add M3 Pro/Max/Ultra
 devices (T603x)
Message-ID: <20260709180504.GB1985988@robin.jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-1-55b305833123@jannau.net>
 <20260709-impeding-tingling-c5858eb0191d@spud>
 <20260709-unflawed-humorist-918325879ab6@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260709-unflawed-humorist-918325879ab6@spud>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9680-lists,linux-pwm=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:conor@kernel.org,m:sven@kernel.org,m:neal@gompa.dev,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:tglx@kernel.org,m:wim@linux-watchdog.org,m:linux@roeck-us.net,m:linusw@kernel.org,m:kettenis@openbsd.org,m:andi.shyti@kernel.org,m:ukleinek@kernel.org,m:k@chaosmail.tech,m:asahi@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-watchdog@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	DMARC_NA(0.00)[jannau.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,robin.jannau.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,jannau.net:from_mime,jannau.net:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93BF67341AE

On Thu, Jul 09, 2026 at 06:50:11PM +0100, Conor Dooley wrote:
> On Thu, Jul 09, 2026 at 06:47:40PM +0100, Conor Dooley wrote:
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > pw-bot: not-applicable
> 
> 
> Actually, sashiko complaint looks valid here?

yamllint errors are already fixed locally as reported in my reply to
the cover letter. I'll send a v2.

dt_binding_check did not fail though. Not sure if if there's an issue in
my local setup.

Janne

