Return-Path: <linux-pwm+bounces-8598-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHquAkie4GlKkQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8598-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 10:31:04 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FFD40B916
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ED213006397
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 08:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A87391513;
	Thu, 16 Apr 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbNL1BW3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01283890E1;
	Thu, 16 Apr 2026 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327872; cv=none; b=SD8UTzIRmH3itul7eo3n49f2XphMA/edz9tlG01sJ4KOaMlEXsXzk6NHzy9tPSHLGSlvBkPUbEzVXdnCjR2w0a+REuQXacp+eBhL3gnYNy+LIH6Y/IuuEbrWZerWZCTd7Dlob89Ju6Bv3aEB0GWjBI1JWCL5CMblePc2JXBBi5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327872; c=relaxed/simple;
	bh=B9NrsopThAdQy1pEQQhGyJ5Ca9nA0GaI99bu8QZCq8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1UjcSU1OxYLiyXQMKaF1qqDL2dNi+NRajJBwvvq56TJ5A2ke4bu0012orp6h+FHwC3FktUa+EN6Lf5wT2JM2Uve9PQ6FQmJlQMvYdKOIVKOgLhNS2VpH9yXKYdJdAkTTX3J3GVcahrLPdj+PpTJ1gWoJWK3o6i9yPPszh19H8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbNL1BW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EF9C2BCAF;
	Thu, 16 Apr 2026 08:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776327872;
	bh=B9NrsopThAdQy1pEQQhGyJ5Ca9nA0GaI99bu8QZCq8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YbNL1BW3G8VlKFztm99hsxG+cOBPjXewViZlBi3YoKDSwQLw2yLg2c8yyK3RsU+Yh
	 m8fFDq1MlwINhFR1WLz4evtFK6L2TB1nho7dIKILjppndigNqNMPHFV0EQJdD/uilj
	 /K67bOuESDM49cdejT+yk3LwSOuLFZngL4Er7C/4r05q3SWsiDJyyK8msJNNyoH8Rs
	 HBVzb0ajlqlKWeNjxRiSJyxQt2TeQMucQEc7VlcHP+wmspY/JkxQpQVVu5GtVWX97g
	 kz4NJOUHdgDMhBy26A+paEhHICR6EaD5lMlEkCwqinhUmia0L0iSyOVKnumRFJa7Rp
	 wygwQsu/31pJA==
Date: Thu, 16 Apr 2026 10:24:29 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: dongxuyang@eswincomputing.com, ukleinek@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, ben-linux@fluff.org, 
	ben.dooks@codethink.co.uk, p.zabel@pengutronix.de, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, xuxiang@eswincomputing.com, wangguosheng@eswincomputing.com, 
	pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v4 1/2] dt-bindings: pwm: dwc: add reset optional
Message-ID: <20260416-wandering-solemn-uakari-083ae7@quoll>
References: <20260415094908.1539-1-dongxuyang@eswincomputing.com>
 <20260415095020.1597-1-dongxuyang@eswincomputing.com>
 <20260415-reacquire-handstand-d1923af82c9d@spud>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415-reacquire-handstand-d1923af82c9d@spud>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8598-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,eswincomputing.com:email]
X-Rspamd-Queue-Id: 94FFD40B916
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 04:09:49PM +0100, Conor Dooley wrote:
> On Wed, Apr 15, 2026 at 05:50:20PM +0800, dongxuyang@eswincomputing.com wrote:
> > From: Xuyang Dong <dongxuyang@eswincomputing.com>
> > 
> > The DesignWare PWM includes separate reset signals dedicated to each clock
> > domain:
> > The presetn signal resets logic in pclk domain.
> > The timer_N_resetn signal resets logic in the timer_N_clk domain.
> > The resets are active-low.
> > 
> > Signed-off-by: Xuyang Dong <dongxuyang@eswincomputing.com>
> 
> This commit implies that your hardware differs from existing devices,
> I think you should add a device-specific compatible.
> 
> > ---
> >  .../devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml       | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> > index 7523a89a1773..a8bbad0360f8 100644
> > --- a/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/snps,dw-apb-timers-pwm2.yaml
> > @@ -43,6 +43,9 @@ properties:
> >        - const: bus
> >        - const: timer
> >  
> > +  resets:
> > +    maxItems: 2

And this should really be listed with description, because order is
fixed.

Best regards,
Krzysztof


