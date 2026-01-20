Return-Path: <linux-pwm+bounces-7980-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JlECvs4cGmgXAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7980-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 03:24:59 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9053D4FB81
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 03:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 573E34F561A
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 02:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619530F7E3;
	Wed, 21 Jan 2026 02:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PJr/3nGC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D36925D53B;
	Wed, 21 Jan 2026 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962249; cv=none; b=p7sx2GfjRL6SEyqSkfvMWV4RqGlHh4odBk6EaPO4+4I9/uxDY6u1BUaTNflNZWe7aCmdquwl4kWgFPsOSUe5XYYGKvhb1uKuibQX37Hr1ZiZnMp2D5PjRzZPcrhrDuGItkwi5vRRsIRGtjhwUmwvJHBKJqnpqQrTCjs2vXXmcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962249; c=relaxed/simple;
	bh=o2TpBi/eIfX8XAILWJhc6JbCt8VFDYV+up456fyHPr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUvZApfjVR29WdeX2NF4cFwuJ3P/8JqgVL624N6htbBjiVdqeoKj5QA/8PyAfxcvN6AKtoMgnNrd4Pn21sNhATSUFP/H4WQvlo32WIfBI2HwHy1QhMZ/mqkJh03+sFBi6aTT0aFNrt5w89t7rkJJ4L05H+l2M+nRsrqlz3DO4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=PJr/3nGC; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dwp0Z1b5yz9tSr;
	Wed, 21 Jan 2026 03:23:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1768962238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdnkUYqHrxuqZ1aAU1ihlPoTAOjU+7NyiM6wRLRQD1Y=;
	b=PJr/3nGCl31mIfx2fR+ahWv1aKmfZ2OJwBy2fG9kcmXg/uCO+xiQ2XhTY78TBbD8UHcg7w
	8k0B0+npLjmg6YiyVy15Wi2AxhW+/gBp7nwry3qf3OaKmkTf2zkSBjqSQj1fmikwCkYP8t
	J+v3t1vXOBSMErwCoFIPFOTbL9CaPhXmaDG3KZ/sntEGBzheieDX3o/+Emg3qJARSP+0M4
	joQYiV53WO0jplpj/mhjIB2G02r1pYbXXNMybY+NC3OJInW/7msFux8ql9dNZkK8WZsXqg
	jl4Bqlbk/AUgOsU1ZGj0vi5AfO3BxIILnEFdb+iEXZAywDrDg7d8iTBlDcXyQw==
Message-ID: <31b27059-f980-4b44-a9fd-1d909c9729ea@mailbox.org>
Date: Tue, 20 Jan 2026 23:25:59 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 linux-pwm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
 <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
 <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org>
 <xsjwvmlqclctnf6dgwyuoi7zits27is2s7r7taprb2w2lhsf7i@uiljd7o3ivbk>
 <855e5015-98c8-48f6-9320-ca8163591940@mailbox.org>
 <izui2w7jddvnji3nbw57yivdoohrs6tabkb42gtklhy53v7byg@zkcjf4js5fbl>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <izui2w7jddvnji3nbw57yivdoohrs6tabkb42gtklhy53v7byg@zkcjf4js5fbl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8nja9ah1d1nz73rdx4aat5wmyfxxmx86
X-MBO-RS-ID: 6825753780513d65adf
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[raspberrypi.com,vger.kernel.org,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-7980-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[mailbox.org,reject];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mailbox.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mailbox.org:mid,mailbox.org:dkim,msgid.link:url,get_maintainer.pl:url,get-maintainers.pl:url]
X-Rspamd-Queue-Id: 9053D4FB81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 3:19 PM, Uwe Kleine-König wrote:

Hello Uwe,

> On Tue, Jan 20, 2026 at 02:50:03PM +0100, Marek Vasut wrote:
>> On 1/15/26 5:37 PM, Uwe Kleine-König wrote:
>>> . Given that the dt specifies something made up and the driver was
>>> written in a way that is wrong but does the right thing in combination
>>> with the made up .dts, you cannot fix the driver to be a correct PWM
>>> driver without having to adapt the invented values in the .dts, too.
>>
>> I think this is what this V3 does. Would that be an option here ?
> 
> No, the driver doesn't become a correct one with your patch.

Hmmmm. Then I really do not know what to do or how to move this forward, 
because if I go with the V2 approach, I wouldn't be able to use this on 
the board I use.

Can we update the timing information in DT ? I think we can not.

> Another option I see is to make the driver directly a backlight driver,
> instead of a (broken) pwm driver + pwm-backlight.

That's what I mentioned in reply to V2, but then we lose the benefits of 
reusing pwm-backlight code .

>>> Maybe the lesson to take away here is: if a driver implements a PWM, Cc:
>>> the linux-pwm list and the pwm maintainer on the submission. And let me
>>> point out that even get-maintainers.pl knows about that:
>>>
>>> 	$ git format-patch -1 --stdout d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4 | scripts/get_maintainer.pl
>>> 	...
>>> 	"Uwe Kleine-König" <ukleinek@kernel.org> (maintainer:PWM SUBSYSTEM:Keyword:pwm_(config|apply_might_sleep|apply_atomic|ops))
>>> 	...
>>> 	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM:Keyword:pwm_(config|apply_might_sleep|apply_atomic|ops))
>>> 	...
>>
>> I do use get_maintainer to CC people when sending patches, hmmmm.
> 
> What I looked at before writing this was:
> 
> 	$ git log linus/master -- drivers/regulator/rpi-panel-v2-regulator.c | grep Link:
> 	    Link: https://patch.msgid.link/20250616154018.430004-1-marek.vasut+renesas@mailbox.org
> 	    Link: https://patch.msgid.link/20250609223012.87764-1-marek.vasut+renesas@mailbox.org
> 	    Link: https://patch.msgid.link/20250609000748.1665219-2-marek.vasut+renesas@mailbox.org
> 
> and neither I nor linux-pwm was on Cc: for these. Maybe you used
> get_maintainer.pl from before 8f960106c150a9733f5d7408b975c0a687617961?
> :-D
No, I use the one in tree only, which has to be the one from linux-next 
around the time it was posted.

