Return-Path: <linux-pwm+bounces-8196-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMvoOsoWqmnFKgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8196-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 00:50:34 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE8D2197F5
	for <lists+linux-pwm@lfdr.de>; Fri, 06 Mar 2026 00:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CDD3300AB19
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 23:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC8F34EEE2;
	Thu,  5 Mar 2026 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbUsSV5l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF8313E05;
	Thu,  5 Mar 2026 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754632; cv=none; b=mvcL16Ey34hWY8Wzla+kS5csEnmHAJBXPG9FcTME/iYE7E0T+GMNQr6f+ZTlhf51JNAKMLlytLECVullODkC9bfL1wDQSzePYkOpk9JzCbBiksmW5fXSLsv9YLDZc8sw3oiGGteIjKCQIlaSk1YC9eyCfFrcPC/QHzUtgc56qaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754632; c=relaxed/simple;
	bh=L74ljxlOMOHO7j1qIlwoOavzI+BtasTxWVEi3URKLLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fhv0mmgDfDcxJmoz67/msqlz6J3kTDDZf2TFdb28DUUwZ2TeDZDXSZgg4gJJDH8u0jfMUX7JZGynQIkA6EkOvTE/AXtb2g1QLrcPULjPbakYFHij+w7wUJRpFchcCDu9u0alTi0WFnEIpQc0XHlxbBGlNZ0cWlLYP0f/D4LE67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbUsSV5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CEDC116C6;
	Thu,  5 Mar 2026 23:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772754631;
	bh=L74ljxlOMOHO7j1qIlwoOavzI+BtasTxWVEi3URKLLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbUsSV5l/lchMJE4IC1QCrlxz+dPFqDFrRa4IGL6G6W6voGN9sRcy2CxJmNzAXtRD
	 TnM/h2ggoMXNcVq0Yzt6tPJCp94as9M3OxZJLZ6pc80r+mL4J3zyxpJ3B1isMUqozR
	 +dXkqpsPIg5UM3vxhkTeio0osF4sFmrPx4YsdcHV76WLGlYU96w3cD0CQ8x4r8mboI
	 eUAS5gy8lWskOkHtj1o1+BWUSQskB5en9s395aHML4CjbMxmrJ6zWBSiQgOZ3JUUt5
	 QZy/yRsfod5lMhaO5Fr5rarxNPkLJd2NKHmCO7kXvWUVNa0SC0e1fOYvDODbbi+SEW
	 e9cAiMiwmqtRA==
Date: Thu, 5 Mar 2026 17:50:30 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Aleksandr Shubin <privatesub2@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org,
	Cheo Fusi <fusibrandon13@gmail.com>, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Lukas Schmid <lukas.schmid@netcube.li>
Subject: Re: [PATCH v13 1/3] dt-bindings: pwm: Add binding for Allwinner
 D1/T113-S3/R329 PWM controller
Message-ID: <177275463009.803008.10030326759377016804.robh@kernel.org>
References: <20260221183609.95403-1-privatesub2@gmail.com>
 <20260221183609.95403-2-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221183609.95403-2-privatesub2@gmail.com>
X-Rspamd-Queue-Id: 3DE8D2197F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8196-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sholland.org,pengutronix.de,gmail.com,kernel.org,dabbelt.com,ghiti.fr,eecs.berkeley.edu,lists.infradead.org,lists.linux.dev,vger.kernel.org,netcube.li];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Sat, 21 Feb 2026 21:35:51 +0300, Aleksandr Shubin wrote:
> Allwinner's D1, T113-S3 and R329 SoCs have a new pwm
> controller which is different from the previous pwm-sun4i.
> 
> The D1 and T113 are identical in terms of peripherals,
> they differ only in the architecture of the CPU core, and
> even share the majority of their DT. Because of that,
> using the same compatible makes sense.
> The R329 is a different SoC though, and should have
> a different compatible string added, especially as there
> is a difference in the number of channels.
> 
> D1 and T113s SoCs have one PWM controller with 8 channels.
> R329 SoC has two PWM controllers in both power domains, one of
> them has 9 channels (CPUX one) and the other has 6 (CPUS one).
> 
> Add a device tree binding for them.
> 
> Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
> ---
>  .../bindings/pwm/allwinner,sun20i-d1-pwm.yaml | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-d1-pwm.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


