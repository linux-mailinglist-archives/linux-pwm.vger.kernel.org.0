Return-Path: <linux-pwm+bounces-8769-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJglL+p0+GlavgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8769-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 12:28:58 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 187B84BBB93
	for <lists+linux-pwm@lfdr.de>; Mon, 04 May 2026 12:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 741D7300682F
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2026 10:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCCF3932D5;
	Mon,  4 May 2026 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ditjBDes"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1E37DE85;
	Mon,  4 May 2026 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890529; cv=none; b=CjZh7U2nRelgEQriV/SNS36dEcbZ/DD2/PqmKQkulMDtsL1LMB7TtwJhq0SZgEWI7A2doirRlSQmW8ipv096EUjQQUbNjdNgWC/kBcVe+2+PUPjg23Cyt4JrYIrsf/uPo/XPaA7f5SHNP/UgEZwXfbtpz1ulroTNTkUZXJDXI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890529; c=relaxed/simple;
	bh=C8xErYLvhPi3/y5PT2xKoQR2XSjSO6oonC2p86NBA50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhSsDE58Wj8QtXaFIEvBhq8DaCBI1o19UzjFrEQuirV3ArRQ+iRfU6vHV4T15kLGGXmBxTTLiufo7yZTRYZMOCv6S6RcsWVTbfjcpjBCgqyHBRicwDgv9wNHDB+Z2UGzMhGqV47iHZ3JXiI4Ey3jJcRIWw8hQvgR8NuB+OqI/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ditjBDes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9D7C2BCB8;
	Mon,  4 May 2026 10:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777890528;
	bh=C8xErYLvhPi3/y5PT2xKoQR2XSjSO6oonC2p86NBA50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ditjBDesUUK94v7TkQQRnjRwaJ732nv/8eUZqEi8iRb2kdbutLnnnqFgN47QwqQ/p
	 0phoOneGTIIDY0Vk+TXrJTXbKPf+5Yyn6Hiz55PDQRqNLZ3t6KvKkaPlwK9aDvt81T
	 dAApoGze9zzDj8XfUkbqYpuKRgYAa5/QWL/nh1cDLNmFj+ahpR13f22w0R9pyLzF0O
	 lSHV/Y4jFKRhelvRTOgzuBdmBUvCVwALjoME4rr8Y+nOU4CL5iqSlfEKGWhgnfA6/l
	 Ac/nXcoI6ECHc8+xDEl8mmt83TWDWBpFhYyqnWgc0JqM8jBHQve2WG/3tUP4on87ZD
	 wCJGAOVM1XtfQ==
Date: Mon, 4 May 2026 12:28:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manish Baing <manishbaing2789@gmail.com>
Cc: ukleinek@kernel.org, thierry.reding@gmail.com, linusw@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: stmpe: convert to DT schema
Message-ID: <20260504-urban-judicious-buzzard-14bd50@quoll>
References: <20260501073305.5866-1-manishbaing2789@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501073305.5866-1-manishbaing2789@gmail.com>
X-Rspamd-Queue-Id: 187B84BBB93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8769-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, May 01, 2026 at 07:33:05AM +0000, Manish Baing wrote:
> Convert the STMicroelectronics STMPE PWM controller bindings
> from text format to YAML schema.
> 
> Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> ---
>  .../devicetree/bindings/pwm/st,stmpe-pwm.txt  | 18 --------

It is already covered by st,stmpe.yaml, which you were supposed to find
with git grep.

Instead, drop the TXT file.

Best regards,
Krzysztof


