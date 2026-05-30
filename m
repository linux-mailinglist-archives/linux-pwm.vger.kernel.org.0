Return-Path: <linux-pwm+bounces-9211-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sSfaEhqoGmr26ggAu9opvQ
	(envelope-from <linux-pwm+bounces-9211-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 11:04:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B860BC6E
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 11:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5934301FFBA
	for <lists+linux-pwm@lfdr.de>; Sat, 30 May 2026 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F3637BE7F;
	Sat, 30 May 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="fgQ0jPCX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b5DxiRjJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFE25B0BF;
	Sat, 30 May 2026 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780131755; cv=none; b=uyTf3u93Cnq2DFlf2WBuCFOSq9SRf3kVN6TBHdTABw15iPS4OEP0/N1mJtdabR5GLwhVaqUHxefz7RqMybAsrLavoOFLHKKf3JnqOh/86+29Ju5+6/fdmlwrckZMvjDMBGSSsyiVad8l8KqkByAq/Lt8J6AW+McfCtp5F/E5Ark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780131755; c=relaxed/simple;
	bh=bREBuEqpqyQwcnS4eQ6YqGQ3bXoZoXgfLkUpJIqywVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o8RwkwCZG5ICavEyJdbsiyzV9sM0toDa21AIFGRctneEyDgRZ1t8opzkNR96sD2ewSZJanoejLSkCVnoDasyrwFIChbH2vVsm42grNE+RA6NP/paiYowtO0hujV0uQKmm3HwEkNSoFM85o9IUFbz06x44Y/FV0X4AR+0kBTBMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=fgQ0jPCX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b5DxiRjJ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AF79140005C;
	Sat, 30 May 2026 05:02:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 30 May 2026 05:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780131752; x=1780218152; bh=8Y08Yc/9Ob
	CFrBoa3oD8RRhgwJsluA9PsZz28hZyP2k=; b=fgQ0jPCXayXSAJqBQbatCaW9Ss
	jpkUHz5FPNuDUMmSsGTE5Npo1vcymtYwGEjPdkX0gW+QhTXpABu6epu+UoEvXdbT
	Zr/SmFESXrka23JfHJld7cgEu5EaJBUw6JvcSdx+0j90IQyMVmcO1eaLgRTpAAyj
	cEdUxv+RkfkqQW5R3JSaRGIHOsu2fn9MNgOUEnflxKIW7FFnjS+G4j4ycCo4exam
	Ds5IedqeGNREoY6gHUD6pfpaa7ltWwP1YuXwpwqJYGOfcjUaULbIsJJH6iz1yiJa
	FIKiLG8X66nZxUiGx51F2kebGQom0eOAR4ShhohF3r5c6j52AuT4WjIxDmiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780131752; x=1780218152; bh=8Y08Yc/9ObCFrBoa3oD8RRhgwJsluA9PsZz
	28hZyP2k=; b=b5DxiRjJZJLtP4bXVx1V+Tu/Pk9CLrx9k8Pk4nuVmbNC2T/PA7E
	19p9U8yaK/IsevjwI8vrtma1CFoP6qhI3zzFCIURb1IfWd/cze37M43KmKl8Zfux
	nfRBXyOozp6WHabGIO/C3TEaWvmrAwz2zz2BHSqTqBD6NnsVunAmevXVfnyWPAqZ
	NuWraZtdJHKWaNw2VAAGpv7bqxB8pTFvRKVMdNxWIjIjIoPJSu2gTBdEHZThnUce
	DnP3eqiz/4eWSxjOHxJceg9EAPq33JD0GzMMhyjM2ZJwkLP7DgTWArM9b5Hynnm1
	3ba7r/wL8fIeijTXQBqMhAqDLnhv3Lu6D8Q==
X-ME-Sender: <xms:p6caatfeaLTeU7fNxL6_FesenpZNCDdPfC04lB2QMOSgoWqCdti-CA>
    <xme:p6caagHj4WU9YZ07M_AQKn8itQ-zWmhIQtw6UTMjR0KMX1ScTzvO9kER063pP1x9G
    okHIA05XtGOb2hvT1GrsyP-Bl5V_-v7lQtggj8hNvoiKcRlnH1DDhiU>
X-ME-Received: <xmr:p6caavHVWKml6D3yxSxIqtZ0L2yduXPzJk_RgiGUCAgI6APSpWjT_RDvB93Yuv7jjjGNxKVpE6OjWnnl2vaVRYr-Wmg9JxEacWo>
X-ME-Proxy-Cause: dmFkZTEgVH0+MijfGOyS8LccP2FlT4PjQGKiqHieM85QnwsZb/DBivIGG35sOrFkzroCgS
    QVTAP1PgLElAjKh9dN6yLCKwn/4uQu2yMoiNWvaZitp16XcLa3tFAZ1FZdzYOvRgj6ZANh
    FvtzLlempzhlx7Ej3sI0Sqs0Ok9EwgzWYII28ZvQbNcigUMolKZ6X2gOSNbvnUfy5RKOD/
    IE0kn6LWxudtaLRqJ+t5yFn9bx4JSuvJRiVW7zArCFqfc51DA9YaVtZstuF1Xk12GAirow
    CqtmzRJ2INp31rbWw3riCGZ+xQDrxavxNVXxdl/s1yrIUDPGZQ7Kh3LOIE9V2CpN0Z5IQc
    JXT2EWV8j5/BT+0RDuMF+3pMUoA6ceg9cpx2a5xZZod8MJL4kYeyOSbiY2INV/24nMbRxS
    PKGEQ4kvI8T7q64axGwA0wbdDhrP7nL3erfHDHy+yIjtYmUYzADtKKGD8Rk0sXnpM/uVqm
    8bCezPypUrTPf0O/POhI7Ab/4XCiMEWF75FFiRKnKhekT+goHc272r7zM1xP9rWjG+JKgm
    Tp1qFyA/C2hQ+gtmdtTtHWLgKNQLHEQvVeEr70JcMgeUAPIsFCJTnKnsL5xdOmpC68+9jW
    mnESXLWLyPTOWJhQyOSmAryENA/UTvzapfhrwkFNPzTB1xFzzVj4JTqK4nqw
X-ME-Proxy: <xmx:p6caaoPsOP86pd9veLKivz2dzdn1JedNn9MqU2XlktKKUqLgtFKpQQ>
    <xmx:p6caaspMkntuLkPUPYod3UbXRGRvnL6zTt87sKrGHHsWSTfJKV2HPQ>
    <xmx:p6caahAY81d8ns5umtS1DLbca_vPgOXuU3S3cRhsZo7yEmBXCdImMQ>
    <xmx:p6caatNXS2So5FPQ3sHrPMF58Rsd1beci-eCEUSNon3Is6aLfIV84w>
    <xmx:qKcaatr0ejJZQiftEFTHfqMN87jLApxgMtOG-_ak6qvUR_O6jD7TUdvE>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 May 2026 05:02:30 -0400 (EDT)
Date: Sat, 30 May 2026 11:02:29 +0200
From: Janne Grunau <j@jannau.net>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Mark Kettenis <kettenis@openbsd.org>,
	Sasha Finkelstein <k@chaosmail.tech>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org,
	Joshua Peisach <jpeisach@ubuntu.com>,
	Michael Reeves <michael.reeves077@gmail.com>
Subject: Re: [PATCH v3 0/5] Initial Apple silicon M3 device trees and
 dt-bindings
Message-ID: <20260530090229.GA1424101@robin.jannau.net>
References: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-apple-m3-initial-devicetrees-v3-0-ca07c81b5dc7@jannau.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jannau.net:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9211-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[jannau.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.infradead.org,ubuntu.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[jannau.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j@jannau.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[robin.jannau.net:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,jannau.net:email,jannau.net:dkim]
X-Rspamd-Queue-Id: 862B860BC6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hej,

On Thu, May 07, 2026 at 09:33:06AM +0200, Janne Grunau wrote:
> 
> This series adds initial device trees for M3 Apple silicon devices. The
> device trees contain only a minimal set of hardware not going much
> beyond the minimum required for booting kernel and initramfs and
> verify via serial console that the hardware and drivers work.
> The hardware with the exception of the interrupt controller is
> compatible with the M1 and M2 SoCs and the existing drivers.
> `make dtbs_check` depends on the already applied and dropped apple,i2c
> and apple,pmgr dt-binding changes.
> The watchdog load depends on stalled and forgotten addition of the
> "apple,t8103-wdt" compatible posted in [1]. I've replied to the thread
> to get the change merged.
> 
> Merge strategy:
> Apply whole series via apple-soc / arm-soc to keep `make dtbs_check`
> errors minimal. Otherwise no dependencies between the patches.
> I might want to send another series which depends on this later in this
> cycle.
> 
> Link: https://lore.kernel.org/linux-watchdog/20251231-watchdog-apple-t8103-base-compat-v1-1-1702a02e0c45@jannau.net/ [1]
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v3:
> - adjust reg size of pmgr node to fit all its childrens' regs. Improper
>   size was caused by a bug in the script used to convert Apple's
>   power-states into DT nodes
> - drop picked up changes from v2:
>   - [PATCH v2 1/6] dt-bindings: arm: apple: apple,pmgr: Add t8122 compatible" (for v7.2-rc1)

This is wrong, I must have mixed this up with "[PATCH v2 3/6]
dt-bindings: watchdog: apple,wdt: Add t8122 compatible". The change is
missing in next and causes dtbs_check warnings.

I can either resend the change or Sven can pick it up from the v2 series
in https://lore.kernel.org/all/20260505-apple-m3-initial-devicetrees-v2-1-b0c2f3519e0e@jannau.net/

Thanks

Janne

