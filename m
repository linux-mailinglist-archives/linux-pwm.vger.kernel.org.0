Return-Path: <linux-pwm+bounces-9286-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n8iXEUZbLGpTPwQAu9opvQ
	(envelope-from <linux-pwm+bounces-9286-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2026 21:17:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D560E67BF2D
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2026 21:17:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nK5ym7pM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=A7rPy1qM;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RD9DdjJ8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iNpp5ScH;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9286-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9286-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F1063019034
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jun 2026 19:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FFE3988FB;
	Fri, 12 Jun 2026 19:17:22 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7623379990
	for <linux-pwm@vger.kernel.org>; Fri, 12 Jun 2026 19:17:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291842; cv=none; b=D09jIPD7yoxGT2NATpxHpNbSlpT5PAJSQWf/c3d2ptLpB0UD+HC5Ps+LV9n6pwbfRgIdpxoKC9lT/BAqmVMUxbB1qnR+kS7qrAWVoqaNF5oG77TnOGxTbfXiYiDY6UyPyP/g7ufkpGsMW+JJXs0kTBbx12tJwsw5gXaRW3ujSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291842; c=relaxed/simple;
	bh=oheb5sC3pZhkuk7d8shVc0BtHQ1YAy5CEMlPCE96g4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyeiTddZNR/PrvQfVyhSnk7XMx0/GsZK2vYLmG8MfFxsCZyk9XcNxUB1MErQUaYkWmqdEUViaJR3JoVLPKNSsMa2zF1zURyNi26aprPQuS9KXcUmN8u/thHYGMjc2ZkNFYPOii5J+uRWm/bg+kUUtw/JzcGDo+8IRfM9cNVXcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nK5ym7pM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A7rPy1qM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RD9DdjJ8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iNpp5ScH; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CABF5457E;
	Fri, 12 Jun 2026 15:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781277886; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1uZmAFhIf/BpsGYDdVGvZjfqxClnkRrnP4gO1FVGUw=;
	b=nK5ym7pMW9Z4M8QUnM4ayPb3a8K+dFo0xH73ixcZYMu2hXJrSCa0K14B8lgwERaTs0UX19
	wOGeeHqy3Km0ENk/mYXssDLpibc/i5H8pdv2IVHk1zr+Mgs2fe6wrup60zjvo5rovztjgC
	FUpVRghUYKTtrI+TPLKHHrSf3HdXg74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781277886;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1uZmAFhIf/BpsGYDdVGvZjfqxClnkRrnP4gO1FVGUw=;
	b=A7rPy1qMPgVT9GJwnXaH/XQ7r5noj13QWQvuEYJNdWthII/ZdyCj4IuQI/yRAXado37oYU
	Yw2oMxCSenVz0WAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781277884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1uZmAFhIf/BpsGYDdVGvZjfqxClnkRrnP4gO1FVGUw=;
	b=RD9DdjJ8H6xiTX7/QP1zmmp7O8cXO+NtSCaQp0ABphlvvBbvAlExMolznNYCj+P3SsCYRb
	+Jth+bCfGMJn6n2kr/2LM5NxalI581vtVIhXwus+vU11vabJ0km11I/MHhubkYlCVsA04Z
	z7bpHHvmhpaaN6LkhxKAXZNCHPeSD/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781277884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1uZmAFhIf/BpsGYDdVGvZjfqxClnkRrnP4gO1FVGUw=;
	b=iNpp5ScHONDgQfBeneamoXJDuc+gZUzvF5gijJKjNmYXb76gjf++r73TRbg7ti5yFuMdq7
	XQWrVzTbZ5B0U4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 203C8779A7;
	Fri, 12 Jun 2026 15:24:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MvyDBbwkLGrTVwAAD6G6ig
	(envelope-from <svarbanov@suse.de>); Fri, 12 Jun 2026 15:24:44 +0000
Message-ID: <5b167316-ed50-448c-aa05-6a041a6544d5@suse.de>
Date: Fri, 12 Jun 2026 18:24:39 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dt-bindings: pwm: Add Raspberry Pi RP1 PWM
 controller
To: Andrea della Porta <andrea.porta@suse.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Naushir Patuck <naush@raspberrypi.com>,
 Stanimir Varbanov <svarbanov@suse.de>, mbrugger@suse.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <cover.1780670224.git.andrea.porta@suse.com>
 <350c2fb454951fd2c9d959f1d94802fea8fa8152.1780670224.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stanimir Varbanov <svarbanov@suse.de>
In-Reply-To: <350c2fb454951fd2c9d959f1d94802fea8fa8152.1780670224.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9286-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[svarbanov@suse.de,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:andrea.porta@suse.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:devicetree@vger.kernel.org,m:linux-rpi-kernel@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:naush@raspberrypi.com,m:svarbanov@suse.de,m:mbrugger@suse.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[svarbanov@suse.de,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email,suse.de:dkim,suse.de:email,suse.de:mid,suse.de:from_mime,qualcomm.com:email,raspberrypi.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D560E67BF2D



On 6/12/26 5:01 PM, Andrea della Porta wrote:
> From: Naushir Patuck <naush@raspberrypi.com>
> 
> Add the devicetree binding documentation for the PWM
> controller found in the Raspberry Pi RP1 chipset.
> 
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Co-developed-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/pwm/raspberrypi,rp1-pwm.yaml     | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
> new file mode 100644
> index 0000000000000..6f8461d0454f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/raspberrypi,rp1-pwm.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/raspberrypi,rp1-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Raspberry Pi RP1 PWM controller
> +
> +maintainers:
> +  - Naushir Patuck <naush@raspberrypi.com>

Could you add you or me as a maintainer as well. I'm not sure Naushir
had agreed to maintain the bindings in mainline.

~Stan

