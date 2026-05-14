Return-Path: <linux-pwm+bounces-8877-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLBtJyVcBmqdjAIAu9opvQ
	(envelope-from <linux-pwm+bounces-8877-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 01:35:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D5547C85
	for <lists+linux-pwm@lfdr.de>; Fri, 15 May 2026 01:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 942EB30005AD
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2026 23:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4A39734D;
	Thu, 14 May 2026 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzDuGBx6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0213909B5;
	Thu, 14 May 2026 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778801690; cv=none; b=ad/vZ5wDKfPGSK9q2IPlD3ErHIqnnSfU5P7z4mC4nSdmFZN5LmJ0Ccxbq9Xd8B5meMZgxel2jOkImy9D/HJrjJs76gcC77XJAr1g1uHeK8maUFUfD/YAfFEZMXM8Pb205bCAKyxDwvel74bSR3HoBi8kXhnB5X9EZiJpaWY4sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778801690; c=relaxed/simple;
	bh=VTVKVwBI0yfXk8vWOqDjB0TtPEq/BIS9tDluZGPTVE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stCqC0BmpvSfHbBjG+NSJwQ9xtV3EYPhmf9bNtor5mcfAh8pbfiz1mnl6dYNEyMuPmr6KITJnlqm557NexbD2I8B1ZgQaLWlqmonNV8GQYxrzFVnCzj7PZWdh3vSaOHJGw/Y/WVjQvlbd0YZXz6rJ3GOsa2S/lh7BHuNss4i6QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzDuGBx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353E7C2BCB3;
	Thu, 14 May 2026 23:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778801690;
	bh=VTVKVwBI0yfXk8vWOqDjB0TtPEq/BIS9tDluZGPTVE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzDuGBx6iH26mngpO4t7dd7Ic4nvod0HRexS7rQXFo1QPRZA/pT27Zb0RM54kS4ax
	 vLoFpifHWxhr4nDK0Ox2RFpMAsz4sbMuOCCGVtVxPCusPjFk84roYr0isUi6ARFzA/
	 EFhq8gP7QnWpbLJHq5TqDKr8rr77g36rrTG9zsbNkc+lcAQ0838NHkPrO1D+NMeziu
	 cK7KTcGBzI7uq2IXSLfS2muqYoF7nFUbY5i2Qi2CHTTI8nG+qQA6vzSyZhK+NA4Hr8
	 jOTek0vzKCyFsJa7+mL6lcTVwo+a1rvh4zmuy36abVQ0tS5Wg0gVtUJVIpvabeOOxL
	 UTZZ7K9cVm6yg==
Date: Thu, 14 May 2026 23:34:48 +0000
From: Yixun Lan <dlan@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev
Subject: Re: [PATCH v2 0/2] pwm: spacemit: Add Support for K3 SoC
Message-ID: <20260514233448-GKA3663945@kernel.org>
References: <20260428-03-k3-pwm-drv-v2-0-a532bbe45556@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260428-03-k3-pwm-drv-v2-0-a532bbe45556@kernel.org>
X-Rspamd-Queue-Id: A92D5547C85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8877-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlan@kernel.org,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Uwe Kleine-König,
  Can you queue this one for v7.2? I'm sending the DTS part patch
and got a complaint for "clock definitions violation"

https://lore.kernel.org/all/20260511235952.F32FBC2BCB0@smtp.kernel.org/

On 10:46 Tue 28 Apr     , Yixun Lan wrote:
> The PWM controller in SpacemiT K3 SoC reuse the same IP as previous K1
> generation, while the difference is that one additional bus clock is
> added. Introduce a new compatible string and also adjust driver code to
> support it.
> 
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> Changes in v2:
> - Merge dt-binding of clock-names property
> - Use local variable for bus clock
> - Rebase to v7.1-rc1
> - Link to v1: https://lore.kernel.org/r/20260409-03-k3-pwm-drv-v1-0-1307a06fba38@kernel.org
> 
> ---
> Yixun Lan (2):
>       dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K3 PWM support
>       pwm: pxa: Add optional bus clock
> 
>  .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   | 41 ++++++++++++++++++++--
>  drivers/pwm/pwm-pxa.c                              |  8 ++++-
>  2 files changed, 45 insertions(+), 4 deletions(-)
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260401-03-k3-pwm-drv-4ea99ae355d6
> 
> Best regards,
> -- 
> Yixun Lan <dlan@kernel.org>
> 

-- 
Yixun Lan (dlan)

