Return-Path: <linux-pwm+bounces-7281-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD35B50445
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 19:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A228E188B2D3
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3F63376BF;
	Tue,  9 Sep 2025 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="KhR2BACu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EFA47F4A;
	Tue,  9 Sep 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437996; cv=none; b=GL+WMp+MnNYCgjzugDR32Lr4TNToB+Hcrh5aDOQu6Sd0R6CoMIHHeK6lGMjglUQTQ4QHWCwpIsmLKj0bjuF/leS9PmUB9D7XEqJ7Jv+8P+Jx0V10CvaOpbJV3SBE4W78kNphDDcBkxcA+Jm+IynyUUGoc1xWaRuO8gW9hnqajNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437996; c=relaxed/simple;
	bh=UIgroxwjNsocefzYeNXpv+P4J1BDISPEayenqAM7f/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jXmhSA+Gt4zSwviEEKkxDOgx3Z3KKEJv/+XKMU2ltDEbI9NZT0LIBHck7oOncUf7Ln9Qs98m1XSsz7LBD3tDwvMJl5MHB9NY+mriJPrsUrxdVTnpAK2Rj/XrqJ0yl8HDaPeGfKvTIFybinLS+u9OwuPXc/vTEM9QHpcdZbKhKmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=KhR2BACu; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=335qG6TxRl+OaXa5gJMcONmejIM97kcMNo8NqCzOKpo=; b=KhR2BACuTnjsU1aJ7leroQpr14
	uOgcLojVTTh3/vWBHuxm15W8iGiqIKUQbvKsQlCq7IDv3TWu/bl7wNhJvSaNAjV2SI8/z8rQrVDMT
	2A0zBBfeH7gEPaM0aM9arGNF1m6FyqdVegpW784TOU5FLq8cG0ip5hGWq0ip4Dlt9KleTbaAhIXtT
	Ymnddl/IwFhex8NwI2r2JRlL20ZrRxZkFjSyKNWb7OqU2zNRFA6xBCFAfCB28a74w3XqwXK8qoy6q
	EHppKSVraLWwg1ckI9DYl288Z8dxaPDMlyQqTTHlbFQ7BxtdCeeLka5Z0DBz96VN/ZPQtMITuqQPn
	dgOMPE5A==;
Date: Tue, 9 Sep 2025 19:13:00 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: robh@kernel.org, lee@kernel.org, krzk+dt@kernel.org, tony@atomide.com,
 conor+dt@kernel.org, ukleinek@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250909191300.03ba06e0@akair>
In-Reply-To: <20250906145905.93845-2-jihed.chaibi.dev@gmail.com>
References: <20250906145905.93845-1-jihed.chaibi.dev@gmail.com>
	<20250906145905.93845-2-jihed.chaibi.dev@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Sat,  6 Sep 2025 16:59:03 +0200
schrieb Jihed Chaibi <jihed.chaibi.dev@gmail.com>:

[...]
> @@ -181,28 +194,189 @@ properties:
>    "#clock-cells":
>      const: 1
>  
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: fck
> +
>    charger:
>      type: object
>      additionalProperties: true
> +
>      properties:
>        compatible: true
> +
>      required:
>        - compatible
>  
>    rtc:
>      type: object
>      additionalProperties: false
> +
>      properties:
>        compatible:
>          const: ti,twl4030-rtc
>        interrupts:
>          maxItems: 1
>  
> +  audio:
> +    type: object
> +    additionalProperties: true
> +
> +    properties:
> +      compatible:
> +        const: ti,twl4030-audio
> +
> +    required:
> +      - compatible
> +
hmm, twl6030/32 have no audio, but it is in the common part with no
false in the if: part

> +  keypad:
> +    type: object
> +    additionalProperties: true
> +
> +    properties:
> +      compatible:
> +        const: ti,twl4030-keypad
> +
> +    required:
> +      - compatible
> +

same here and in more places. So if we do not want this old stuff to be
that precise and just have dtbs_check clean and this nightmare of a
conversion finished, then it might be fine.

Regards,
Andreas

