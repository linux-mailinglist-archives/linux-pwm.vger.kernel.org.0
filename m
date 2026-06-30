Return-Path: <linux-pwm+bounces-9482-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BeUmFB1jQ2rlXgoAu9opvQ
	(envelope-from <linux-pwm+bounces-9482-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 08:33:01 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA326E0C3E
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 08:33:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=biKk+QvE;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9482-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9482-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 610373003EF5
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 06:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D109F3659E8;
	Tue, 30 Jun 2026 06:32:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FDF2F1FDF;
	Tue, 30 Jun 2026 06:32:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782801178; cv=none; b=hSo308IslRfezB9CEfAD1lXGFtzYt6lcAPMxSeCsg4kfqa+1eQERgSiGYOWhDShig+JjCjutJDW8QPQsFift25P6bVQGE5cgeKot1GgCejh7pYKW/MDE7VdCB10zPFuL21wPYhSj1nXBWde0d8OzMlmWTJyaSYNJLqgReqLWAM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782801178; c=relaxed/simple;
	bh=I9t8nQfOjj9/aUr9XFtsyxbPFcqWKMnzkHixQOT91Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glRIrRlbOjOGSMpftcDddsTSMbrb3cRBscyXTfzE8UXk2ZL7YTnFqxz6bTmwJq0xVzFtUpSd6JmBHRo08hkw54kTbxNDfRIF0Kgc75wiiXFFlDg0YGb4o1ON4a+5+/TjC8Rdl72wPwmJhra+B7xCPQBTon71WKe8SachyllEn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biKk+QvE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788FB1F000E9;
	Tue, 30 Jun 2026 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782801177;
	bh=Kl+w1FAsj/uySaEZ3UOYaV3smbCW0UBPqhVmiNwbMjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=biKk+QvEthSVytwRLlPpvQ5bnk6zb5nYVb/Spo6lktHn44Tftb5SYvxdiAc6tPfYk
	 a9XJJ7ilTLLGxpluwYWie+kZc01Gn9Jz50hp9GiS4wO9yyQ6HoeZQ4Zu8onddMhf0K
	 /aW2HFzzKe/d2u5ZIXf+/7hn2kP15E0EsAnYxC8Q4TTlJNi3sDwO/8ZrMouGozbjw4
	 URhucxpOIFCTYo5pqF9OG6CwpbCPv5Usz5gEnSL8zUwnbsl9P1lY+qsfi8lboaF9s2
	 N/tj01GMcYVzzkZ+OC65DQEWYv1AWWlWcSMuV7Grn3dOEy7sb11JFADLPA+noFym14
	 IahmX3BRmOHQw==
Date: Tue, 30 Jun 2026 08:32:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charan Pedumuru <charan.pedumuru@gmail.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: pwm: st,sti-pwm: convert to DT schema
Message-ID: <20260630-antique-iron-chachalaca-a7560e@quoll>
References: <20260629-st-pwm-v5-1-a93f2bfec38c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260629-st-pwm-v5-1-a93f2bfec38c@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:charan.pedumuru@gmail.com,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:lee@kernel.org,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:charanpedumuru@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9482-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,quoll:mid,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FA326E0C3E

On Mon, Jun 29, 2026 at 12:58:37PM +0000, Charan Pedumuru wrote:
> Convert STMicroelectronics STiH41x PWM/Capture controller binding
> to DT schema.
> Changes during conversion:
> - Fix compatible string from "st,pwm" to "st,sti-pwm" to match the
>   actual hardware variant naming convention used across STi bindings.
> - Drop pinctrl-names from the required list as pinctrl properties are
>   inherited and validated by the pinctrl schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


