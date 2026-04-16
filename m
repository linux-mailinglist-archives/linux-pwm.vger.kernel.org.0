Return-Path: <linux-pwm+bounces-8596-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDabCXyW4GlMkAAAu9opvQ
	(envelope-from <linux-pwm+bounces-8596-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 09:57:48 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156E640B3F0
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 09:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3EB3303EFCC
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2026 07:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D049138B7BB;
	Thu, 16 Apr 2026 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M0udllnP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4030EF9B;
	Thu, 16 Apr 2026 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326264; cv=none; b=S2AtarRu8NIhPzpDw+c2tLybfzTcsmZcJQbE8f3gdaDchHoANbVi33foiUfVF5jm6nT4RZ9W+I2i/6BsB8uN3WmzfE7ec+l7HK3Hi8y5QS/Nae2CQDlfLeF0pM/+nwcoDxiN5kBuuJb5z0Ea1fD7FyguoW8UWMYxijN2OXnuDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326264; c=relaxed/simple;
	bh=PkXMUSfNt05PGTT38T88UWe63KprqzcvxVx4oYeo77Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ie0lhZ3qWjVOwxTj+J9WvQJGN696zc9MSji2cJdVBhvt+Fe7FtiHOv09QHtyxWY0Fn0Soq5MstggRjnddGJUiwxGgpGHIFfKAA6ohQYxoWtAPafGMAUQ0IzOZMx4JMuT7+cr1xLyeL0PiHP0LKLPtBa+/axbRxeCjf3Ar+iyURY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M0udllnP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 367C31A32F3;
	Thu, 16 Apr 2026 07:57:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0AEF75FDEB;
	Thu, 16 Apr 2026 07:57:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC9FB10459AF6;
	Thu, 16 Apr 2026 09:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776326260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wDw1aA0aJGL5LVw4zkko2JKL4HHId3Bi3Out6Lm4kEs=;
	b=M0udllnPe/Q05WsEcZoNNjkjkms1oP8gEzoT+kTRbsnB3G+xO7wJC8G82V8NOMQ7XTjqDR
	hl9ME7re9eBX6y0YUJp6YzSi3z2MuLHtzG51zeADDzJu98xrahg7l/uFMHMNPy0Wi1VLYD
	3SGPAU3zNltVXqPG6gDcVn8saRrwdG9/YJg8DzrJWmA8PrcAjD/7n3vgYfKGhHMtexwCgt
	2BooONaf+eB9JdAS4kQ5BQ5FhIJtAsOzYgcevff94hwkcUZSbXbegLHcoIkFYyznIbQjlQ
	BjUy0AqcvXmtWzEtXLW5j7vZk8BYCR8QYRRm0dVcNsH88fSogZs8Advp6ozidA==
Message-ID: <2721356a-e905-4074-a5c5-025f18b8fb27@bootlin.com>
Date: Thu, 16 Apr 2026 09:57:37 +0200
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] pwm: sun50i: Add H616 PWM support
To: bigunclemax@gmail.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 jernej.skrabec@gmail.com, joao@schimsalabim.eu, jstultz@google.com,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-sunxi@lists.linux.dev, p.zabel@pengutronix.de, paulk@sys-base.io,
 robh@kernel.org, samuel@sholland.org, thomas.petazzoni@bootlin.com,
 u.kleine-koenig@baylibre.com, wens@csie.org
References: <20260305091959.2530374-3-richard.genoud@bootlin.com>
 <20260413123920.2459916-1-bigunclemax@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260413123920.2459916-1-bigunclemax@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8596-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,schimsalabim.eu,google.com,lists.infradead.org,lists.linux.dev,pengutronix.de,sys-base.io,sholland.org,bootlin.com,baylibre.com,csie.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.genoud@bootlin.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 156E640B3F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Le 13/04/2026 à 14:39, bigunclemax@gmail.com a écrit :
> Hi Richard,
> 
>> +
>> +/* PWM Capture Fall Lock Register */
>> +#define H616_PWM_CFLR(x)		(0x74 + (x) * 0x20)
>> +
>> +#define H616_PWM_PAIR_IDX(chan)		((chan) >> 2)
>> +
> 
> It looks like there's a typo or a mistake in the PAIR_IDX calculation.
> It should be like ((chan) >> 1).
> For example, for the 5th channel the result will be 1, but it should be 2.
Good catch!

I mainly tested with PWM1 as it's the only one easily accessible with a 
scope.

I'll change that in the next iteration.

Thanks!

> 
> Best regards
> Maksim
> 


