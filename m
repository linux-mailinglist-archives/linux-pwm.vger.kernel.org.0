Return-Path: <linux-pwm+bounces-7244-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 648F9B40FDF
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Sep 2025 00:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3332E7ABD2E
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Sep 2025 22:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32527586E;
	Tue,  2 Sep 2025 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="zNm5l8OO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C826D4F1;
	Tue,  2 Sep 2025 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850904; cv=none; b=H7jvOoLbkDt2BbQ0tg4mM62UB17/9/mR+pn7gTMNW7ZJGR2bMv2FJmnWqliz/ELw74HGvULchMHta3c2Aj6rnSerzVFLfro1kBvkw+zhEtxdUrg5PT7zO9gHenmFKM7MU448J7iyxw1fadqNtO2NdM+rxmu5EiJCBjSsFwp06AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850904; c=relaxed/simple;
	bh=G0RYCOT90CrGhircnrMk/BDMxP2JZkDnNQpM0oQeRyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2Sbxs1wOXhcofSLj1qIL0k0nK5mRf3IfzPPRm2W//12Jd/C5rq7SUb80Sd/aibT/+iaW4TVOO1rf0tIwotB3nYsfFWTh1F44or5SlGBzsKgYPZ53auZ5LobyaeK8JX7IgK0n2CnDxR7CFEZ+k5dl5g5VwL9/af5KcLaewmaRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=zNm5l8OO; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=35h7ZP3HWeexPQor3+1LL8BTy8dPZMEO4Wmo0XCjCCI=; b=zNm5l8OOUlLBklNVb5qeH0kXoC
	tS09VjcKuk333B5QHKIxfMAbgRxwzZvcVdT6VJRKEfPrMs2+HTgk1ebMMZ54YpfAeJDDQaApqWBVn
	pODuj0OIdnUTgrKPkTKVgVyMW8sKm+e8N7suQfzmBaOoovl/j6g1iJ9BRODaSZBzJqXFEBSWgaVEO
	MVIf8WSNaOGxfiw9022eYwtmEHmlXOsF2TEH7nfubk45EEzTKzXUge7mPoFlZmAPwXKb9X8fXunoJ
	XK3Jtq/RskRnwZpYjAr7oi4VitP3AbJS8aplGC2F26ioGbxVVRylJWpm0yGwCqkNgFgAbz6ul+ma5
	KtlHFxmg==;
Date: Wed, 3 Sep 2025 00:08:04 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, ukleinek@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v5] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250903000804.689a0a06@akair>
In-Reply-To: <20250902212921.89759-1-jihed.chaibi.dev@gmail.com>
References: <20250902212921.89759-1-jihed.chaibi.dev@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Tue,  2 Sep 2025 23:29:21 +0200
schrieb Jihed Chaibi <jihed.chaibi.dev@gmail.com>:

[...]
> +      be paired with a generic fallback (generally for power
saving mode).
> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        oneOf:
> +          - enum:
> +              - ti,twl4030-power
> +              - ti,twl4030-power-reset
> +              - ti,twl4030-power-idle
> +              - ti,twl4030-power-idle-osc-off
> +              # Add all board-specific compatibles for completeness
> +              - ti,twl4030-power-omap3-sdp
> +              - ti,twl4030-power-omap3-ldp
> +              - ti,twl4030-power-omap3-evm
> +              - ti,twl4030-power-beagleboard-xm
> +              - ti,twl4030-power-n900
> +          - items:
> +              - enum:
> +                  - ti,twl4030-power
> +                  - ti,twl4030-power-reset
> +                  - ti,twl4030-power-idle
> +                  - ti,twl4030-power-idle-osc-off
> +                  # Add all board-specific compatibles for completeness
> +                  - ti,twl4030-power-omap3-sdp
> +                  - ti,twl4030-power-omap3-ldp
> +                  - ti,twl4030-power-omap3-evm
> +                  - ti,twl4030-power-beagleboard-xm
> +                  - ti,twl4030-power-n900
> +              - enum:
> +                  # Fallback (for power saving mode)
> +                  - ti,twl4030-power-idle
> +                  - ti,twl4030-power-idle-osc-off

this allows quite weird combinations like
 "ti,twl4030-power-idle", "ti,twl4030-power-idle".
I would propose to rather clean this up to things used in
twl4030-power.c and at the same time available in dts, also
taking the brush in the dts. I do not expect that these specific
compatibles are in use anywhere. I looked around earlier.

Regards,
Andreas

