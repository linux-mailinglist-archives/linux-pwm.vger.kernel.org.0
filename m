Return-Path: <linux-pwm+bounces-9390-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u++KKes5PmobBwkAu9opvQ
	(envelope-from <linux-pwm+bounces-9390-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 10:35:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7556CB658
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 10:35:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KsZ9e3Bo;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9390-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9390-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C410E3001835
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Jun 2026 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCAB3DBD76;
	Fri, 26 Jun 2026 08:31:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03813BD241;
	Fri, 26 Jun 2026 08:31:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462718; cv=none; b=Ug7kdIj8hDvWK0ajfx21fFK55zXVD+y7eYFZAlTqIvIyzx2QsMJdKibU7YqBM0eoEfnRfrdmissDE1zUOXulHVjMYdGuwIjL9GC2YyIZKTNrC/mj6w1G0nSSZQx80XsXg0lAcOIGrSL2pUhdV+PFwyjkwmj1tNWvadnyrZyVicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462718; c=relaxed/simple;
	bh=FokIJv8AfgUPd2/aIFIvPg8FRcuvZThvaCVNpsev7y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJ8a/ubPMv5vrA1w4htE4jNjZQzmuwS2W3PLsjiMMg2KujSKG6yi+6IKukRvINZpoZwoj4nQWMVsp+N8Ygdu9uQhXEX3aJEcB3LDsMnDg13q019Kl7/Mwz2Ea0mjc8JbQ7rFgbzLGwFI1HmM81/i9wPy9ZyIgkWsRCfJvh0BZEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsZ9e3Bo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5D01F000E9;
	Fri, 26 Jun 2026 08:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462717;
	bh=ETIOhQUjPQWtqaHHtPokG8x+YN/KAxvHFrTSu7Z6x+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KsZ9e3BoBiBb6B/WyDZnv2wjYMXQBwMYu6PFx79wuEiXP5V9+V3vU/VnEdoId+kbU
	 rl+AFNuGYSmgZwuqVxsLGX+9h3yXkLM0dwwUAUVmV2sBlW8pn3nsSzaDTVjqeVQPnD
	 1qJc0oj817Gu6wyDXZ+ZT8itig2YK0Sj784DjN5T2hOlc1T7NlmLknRAiHordm5ZQs
	 eEz0U+A5Cx1GLeaOHotg0d086If8gCdHIxD6n6XtKaGRZSnibmpJLzj9pZm1Rfz6Ju
	 rkcGT1yUp9eoMuLC0axDGYNR3qwhMm7f1g4VmtR+d8JOydt6oRc6UcZELgBEcZRw5T
	 ywJhUWvYuwuOg==
Date: Fri, 26 Jun 2026 10:31:52 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: pwm: st,sti-pwm: convert to DT schema
Message-ID: <20260626-daring-daft-shark-d33234@quoll>
References: <20260625-st-pwm-v4-1-958d7d6bdf39@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625-st-pwm-v4-1-958d7d6bdf39@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9390-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:charan.pedumuru@gmail.com,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lee@kernel.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:charanpedumuru@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F7556CB658

On Thu, Jun 25, 2026 at 11:24:15AM +0000, Charan Pedumuru wrote:
> +maintainers:
> +  - Lee Jones <lee.jones@linaro.org>
> +
> +description:
> +  The STiH41x PWM controller supports both PWM output and input capture
> +  functionality. It provides multiple PWM output channels for generating
> +  variable duty-cycle waveforms, and multiple input capture channels for
> +  measuring external signal periods and pulse widths. PWM output channels
> +  and input capture channels are configured independently via
> +  st,pwm-num-chan and st,capture-num-chan respectively.
> +
> +allOf:
> +  - $ref: pwm.yaml#
> +
> +properties:
> +  compatible:
> +    const: st,sti-pwm
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  pinctrl-names:
> +    const: default
> +
> +  clock-names:

items:
  minItems: 1
  - const: pwm
  - const: capture

> +    items:
> +      enum: [pwm, capture]
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2

Best regards,
Krzysztof


