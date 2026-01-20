Return-Path: <linux-pwm+bounces-7963-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE8yLlxXcGlvXQAAu9opvQ
	(envelope-from <linux-pwm+bounces-7963-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 05:34:36 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE9851119
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 05:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56FA38A9423
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC3843C053;
	Tue, 20 Jan 2026 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hK7YGx3r"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31326345CC2;
	Tue, 20 Jan 2026 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916716; cv=none; b=b+lib1/biWivsTILJPIXYF4h2FFd/mI1sgnzWpV2D/LLYLnel4Ecu7w1kPLcG3nwA6gjjrMZZ0Dt54Q4S+pu6tjiLoVPxmjHx6oJVxg4ZFyaiIvgkt7Ebz9px8k1n0ApFCWWdA+ODc0GWRkAuMb6nxKqbaLMrBrSZW5qOo7ifJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916716; c=relaxed/simple;
	bh=+vXHyUJgSDEcnPi6EZ+EUoqKYfKwW0OABkD2K8PFze4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMG/c+oIbengUzeuin7csUv1PsP17XQDuHA15hOqv1GDy6Jk7Wy7Y9babERcjrUnYV/RW+Pov0wDcdwxwpsR4ykhuCv3WdW0ex351AqtRofHWy+1IfWtWqgvLQc1wiNjyFJWltErFexIp32dxnQv1XA6TzS1mDGJ5qWR5YHunbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=hK7YGx3r; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dwT934Cgqz9t8w;
	Tue, 20 Jan 2026 14:45:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1768916711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BI8mu4T4VqyqrbAlgLAivShp9lKVjxOQSYnza3RctDg=;
	b=hK7YGx3rXKB7Knfyo3AV7em21Lb5Jlo6BCeyN4OGKZjXEl/pYRlZspxRLMeCeNSjPkbb+X
	w+autHexXjrNCaEtDIlYSOgCCc9gz+7K4fwDpV4FoX6Ib2aJA39yY5n1CdyWlONc6CrIdl
	YHZ4GV+AMaGE6Y4moPSQwgOoWGZMGNCzUPmhZnHQ3nWIb8DotBEgqxpNxqUSwP113zZYaC
	HuF8z4OA08T3tV3MT+I9AYtX05bJXpmU11PAT1tkNw/CqlqefHs8kxmIYw1tcK1uES/u1b
	wMQ1yywUR0SRG1+6sM8qgkWf+m7HMwF+bgL8kMv/G5kHWwPXLdF1yb1jTbbtfA==
Message-ID: <832e0533-39db-4b27-870a-9530ecd046cb@mailbox.org>
Date: Tue, 20 Jan 2026 14:45:09 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
References: <20250904210604.186893-1-marek.vasut+renesas@mailbox.org>
 <qdqla4f5nfccqg2vdwkshzo6znwfizqizsyhfs7ksp6znja7uv@u4uwzvx7pgn6>
 <05bf0e18-68dd-4eab-b4d2-05af5f8d1ef7@mailbox.org>
 <ygyirj7jqkivztwgpwzskmleyvscywl2yjfjhfcawmlsgkkohe@dzsahribiqid>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ygyirj7jqkivztwgpwzskmleyvscywl2yjfjhfcawmlsgkkohe@dzsahribiqid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ie7hcygo9ni3tnsbaec6ke7fakheau1s
X-MBO-RS-ID: 7d1ef0484ffb3ec0bfe
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,raspberrypi.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-7963-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 2BE9851119
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/15/26 7:09 PM, Uwe Kleine-König wrote:

Hello Uwe,

>> I'll send a V3 now, but even revisiting it at this point, the waveform API
>> does not seem to be the right fit for this device.
> 
> If you consider the waveform API worse than the .apply() callback,
> please expand on the reasons.
What I meant to convey was, maybe this should have been a backlight 
driver instead of a pwm driver. But then, we would lose the ability to 
bind pwm backlight to it, and the code reuse would decrease.

