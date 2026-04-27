Return-Path: <linux-pwm+bounces-8702-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CLeOAif72kbDQEAu9opvQ
	(envelope-from <linux-pwm+bounces-8702-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 19:38:16 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 601C4477C29
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 19:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D00EB308FC43
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30AC3E51E3;
	Mon, 27 Apr 2026 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Zk7ogawB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE52369970;
	Mon, 27 Apr 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311366; cv=pass; b=DD0pler385LyEYW8abMyu6n/p9b1H0Z3uznIC/dKQA5/uBRED4xACmdcd0YM2/uptwFDM9gIkRTLZCbZMHGMbybuKtrJrkLu7JKH6jdLTxxTi+nvEPBx9kU5GpLntCevgtZbDz4Twj6AzU+OL66dfjM+HUnZ12ynyA2Op46jJRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311366; c=relaxed/simple;
	bh=nr5ilqN014BdeoWLjGf8aQJGuYGOGF0K4mmsCEMvF4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=REqVpqi8FlD4KvWz97Vzqv/Sfwju7ORsGrgP+gKkumpLns+cJbk1O0CM5Aa2f4/rwCvzh6kedc3iKQ/sUFV+a6U9+n3HhnnHFDGWFJ7Y9UoL2VtxFE85xvsb/+84WPurcP1lhCOBOBG9DJ+VX8n3jNRfm9gR38XdPBuM4Sv+QoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Zk7ogawB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1777311340; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AD31+MNPTHWPoTYCQMpX7n3R0Er4g3R9tw0h41WKv3hmOvvgViSemwhfzgvt0V/Xr18hI/13AuZ0oc0jPRO1vaW8c/KDAqRL2r30pWhwGATOtKWmuq12DKZQQTOg1LqmiiHzVlG6YN2u+grPU4bwOqHmSMG/tOYf69jDCalMJLw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777311340; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UmdZibbd/+Riw2ttNnhE20ZsNtrexm4/ybN5Xvwgvow=; 
	b=LXggAq9qe3W+IUdyL2SssQt6RWKdrnslU1yGMFBo6D1XXM6lNMqddmD0wdndgrl7EWNOY6exIK0HAQ6yvlpkbRDJCviTPe9oD481ycqCzL3J9zoN6jg2Deoji6iwl5sUZScIEeeKqVMnoeHYRZ/tLdLuJClButw5EBNT31hnOHE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777311340;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=UmdZibbd/+Riw2ttNnhE20ZsNtrexm4/ybN5Xvwgvow=;
	b=Zk7ogawB1ZqlMX1b33i7nQ48RAsz7BPFAlhFSMtpmi8D4JtbDjXDFb4ZwdMH1rlr
	lehBH8gAk6rM/QAG7ZaQYWhFns4VQdtZ3tGA53rooZDa9H+oXX7voL4Z8XxCgCBA45i
	s9i7M6LHzBfPYjGKSjicMwGrYclXUYxOUUbKXPDc=
Received: by mx.zohomail.com with SMTPS id 1777311337704981.5046370792685;
	Mon, 27 Apr 2026 10:35:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 Damon Ding <damon.ding@rock-chips.com>
Cc: kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 4/6] counter: Add rockchip-pwm-capture driver
Date: Mon, 27 Apr 2026 19:35:32 +0200
Message-ID: <q0kG3ZZyT92lQlYsvZD_qg@collabora.com>
In-Reply-To: <91eed9a4-4dc3-4846-baf3-e9cef53be79b@rock-chips.com>
References:
 <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-4-ae7cfbbe5427@collabora.com>
 <91eed9a4-4dc3-4846-baf3-e9cef53be79b@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 601C4477C29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-8702-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[collabora.com,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.frattaroli@collabora.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[collabora.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,collabora.com:dkim,collabora.com:mid,rock-chips.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Damon,

On Sunday, 26 April 2026 12:55:20 Central European Summer Time Damon Ding wrote:
> Hi Nicolas,
> 
> On 4/20/2026 9:52 PM, Nicolas Frattaroli wrote:
> > Among many other things, Rockchip's new PWMv4 IP in the RK3576 supports
> > PWM capture functionality.
> > 
> > Add a basic driver for this that works to expose HPC/LPC counts and
> > state change events to userspace through the counter framework. It's
> > quite basic, but works well enough to demonstrate the device function
> > exclusion stuff that mfpwm does, in order to eventually support all the
> > functions of this device in drivers within their appropriate subsystems,
> > without them interfering with each other.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> >   MAINTAINERS                            |   1 +
> >   drivers/counter/Kconfig                |  11 ++
> >   drivers/counter/Makefile               |   1 +
> >   drivers/counter/rockchip-pwm-capture.c | 307 +++++++++++++++++++++++++++++++++
> >   4 files changed, 320 insertions(+)
> > 
> 
> For functional validation, I connected PWM0/PWM1 (continuous output)
> to PWM2 (capture input) pairwise.
> 
> I enabled the counter via:
> /sys/bus/counter/devices/counter0/count0/enable
> 
> Then I verified the functionality by reading the count values from:
> /sys/bus/counter/devices/counter0/count0/count
> /sys/bus/counter/devices/counter0/count1/count
> 
> Tested-by: Damon Ding <damon.ding@rock-chips.com>

Thanks for testing! To make sure a bug on the pwm output driver won't
be cancelled out by an equivalent bug in the counter driver, I did
my counter driver testing by using an RK3588 as the source of the
PWM signal, with the two boards sharing a common ground. Maybe I
should get a proper function generator. :)

> BTW: Is there any user-space test tool similar to libpwm for the
> counter subsystem?

I've tried looking for this as well, and couldn't find anything. If
it exists then adding a mention of it to generic-counter.rst would
be in order I think.

> 
> ......
> > diff --git a/drivers/counter/rockchip-pwm-capture.c b/drivers/counter/rockchip-pwm-capture.c
> > new file mode 100644
> > index 000000000000..09a92f2bc409
> > --- /dev/null
> > +++ b/drivers/counter/rockchip-pwm-capture.c
> > @@ -0,0 +1,307 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2025 Collabora Ltd.
> > + *
> > + * A counter driver for the Pulse-Width-Modulation (PWM) hardware found on
> > + * Rockchip SoCs such as the RK3576, internally referred to as "PWM v4". It
> > + * allows for measuring the high cycles and low cycles of a PWM signal through
> > + * the generic counter framework, while guaranteeing exclusive use over the
> > + * MFPWM device while the counter is enabled.
> > + *
> > + * Authors:
> > + *     Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/counter.h>
> > +#include <linux/devm-helpers.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/mfd/rockchip-mfpwm.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +
> > +#define RKPWMC_INT_MASK			(PWMV4_INT_LPC | PWMV4_INT_HPC)
> > +
> > +struct rockchip_pwm_capture {
> > +	struct rockchip_mfpwm_func *pwmf;
> > +	struct counter_device *counter;
> > +};
> > +
> > +static struct counter_signal rkpwmc_signals[] = {
> > +	{
> > +		.id = 0,
> > +		.name = "PWM Clock"
> > +	},
> > +};
> > +
> > +static const enum counter_synapse_action rkpwmc_hpc_lpc_actions[] = {
> > +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> > +};
> 
> For the capture function, it uses the PWM's reference clock (dclk) as 
> the time base to measure how many reference cycles the high and low 
> levels of the input waveform last respectively.
> 
> I find it a bit strange to set COUNTER_SYNAPSE_ACTION_BOTH_EDGES for 
> counting. If we treat the input waveform as a sequence of square waves 
> sampled by dclk cycles, it feels like we should count on a single edge 
> (rising edge only) rather than both edges.
> 

Yeah, that's a good point. I think I've been struggling to wrap my head
around what the signal is and what the synapse should trigger on because
the signal isn't something exposed in this case.

Your explanation makes sense, and perhaps I should rename
rkpwmc_hpc_lpc_actions as well. Currently it makes it seem like HPC
and LPC are the signal, when actually the waveform is the signal, HPC
and LPC are the counts, and the synapse is a sample every dclk spotting
a transition if I understand this correctly.

> > +
> > +static struct counter_synapse rkpwmc_pwm_synapses[] = {
> > +	{
> > +		.actions_list = rkpwmc_hpc_lpc_actions,
> > +		.num_actions = ARRAY_SIZE(rkpwmc_hpc_lpc_actions),
> > +		.signal = &rkpwmc_signals[0]
> > +	},
> > +};
> > +
> 
> Best regards,
> Damon
> 

Kind regards,
Nicolas Frattaroli



