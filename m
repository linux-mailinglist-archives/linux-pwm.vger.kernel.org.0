Return-Path: <linux-pwm+bounces-8700-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDhaKyW77mkPxQAAu9opvQ
	(envelope-from <linux-pwm+bounces-8700-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 03:25:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6B246BE6B
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 03:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB5153004584
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2026 01:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEC1255F28;
	Mon, 27 Apr 2026 01:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bN5zx+rt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m49241.qiye.163.com (mail-m49241.qiye.163.com [45.254.49.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB916213E89;
	Mon, 27 Apr 2026 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777253150; cv=none; b=qZIMQl7X19qvT+Byg4QwByCpoWkvx/adVRicDKsCD1Nu/9W0MmnDI99ul+GnawdMHxnoRLi0zkjZvUrrU3KTGjkUto5HGA5HRkOZQsWOLNze4HjQt5oSk8iJG0v48lKYbAwJcCyNB7deSGlHpwvL3Eql9xlxO+wP1EJuVQfAGvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777253150; c=relaxed/simple;
	bh=JCYm/azDhaw/7P893qeHwreR94t1+eJ9p6AjS61Ju2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMkVTHSH/DHSZwDauc0BtHxHkyL3e/mE273BGj8CfR9h834J+JZnjsutl5v90Vd27RRTdIwls2ySMH0HZGXCK6+PzKCyCqXGqUdArNIyCHklKo9UG9fdPCPQqt4vQemn/abP3ngjQvUvOZrYC3Dc7D1uxQ+bI7T2jjpuJYB7hqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bN5zx+rt; arc=none smtp.client-ip=45.254.49.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.43] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3c3462145;
	Mon, 27 Apr 2026 09:20:24 +0800 (GMT+08:00)
Message-ID: <2af2f6a1-9b3b-4be5-b842-dcf29621e7ec@rock-chips.com>
Date: Mon, 27 Apr 2026 09:20:24 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] pwm: Add rockchip PWMv4 driver
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lee Jones <lee@kernel.org>, William Breathitt Gray <wbg@kernel.org>,
 kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
 Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20260420-rk3576-pwm-v5-0-ae7cfbbe5427@collabora.com>
 <20260420-rk3576-pwm-v5-3-ae7cfbbe5427@collabora.com>
 <4592b323-bebd-4242-ae31-892a51b5b3be@rock-chips.com>
 <ae4MCRE_hGJ-VcBQ@monoceros>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <ae4MCRE_hGJ-VcBQ@monoceros>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9dcc85f48b03a3kunm09663e0d16a152
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0kdVhodSk4fTBoYGB4aHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=bN5zx+rtmrL/sfaeiN+vg4O5kxMPAdyyupG2fp4MJaav5iTPpC3+Md9GiDIwaAEa20itdarD/TrppKYVToPHo/R9mZIVkQzwHk0zzW7y0APT8DmguCFa2GcaMdME/F662c9RLqfWIX+kk0dx0he8C4S8WCAeOMp5f3/CgfSwlPs=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=LIIi6TlLlORarJbE8L0nD/XYuT5XrhpXxkOCrf081b0=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Queue-Id: 4C6B246BE6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rock-chips.com,none];
	R_DKIM_ALLOW(-0.20)[rock-chips.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8700-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[collabora.com,kernel.org,sntech.de,kwiboo.se,gmail.com,lists.infradead.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[damon.ding@rock-chips.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[rock-chips.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rock-chips.com:email,rock-chips.com:dkim,rock-chips.com:mid]

Hi Uwe,

On 4/26/2026 9:06 PM, Uwe Kleine-König wrote:
> Hello,
> 
> first of all thanks for your extensive testing, very appreciated.
> 
> On Sun, Apr 26, 2026 at 05:44:46PM +0800, Damon Ding wrote:
>> On 4/20/2026 9:52 PM, Nicolas Frattaroli wrote:
>>> The Rockchip RK3576 brings with it a new PWM IP, in downstream code
>>> referred to as "v4". This new IP is different enough from the previous
>>> Rockchip IP that I felt it necessary to add a new driver for it, instead
>>> of shoehorning it in the old one.
>>>
>>> Add this new driver, based on the PWM core's waveform APIs. Its platform
>>> device is registered by the parent mfpwm driver, from which it also
>>> receives a little platform data struct, so that mfpwm can guarantee that
>>> all the platform device drivers spread across different subsystems for
>>> this specific hardware IP do not interfere with each other.
>>>
>>> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
>> Tested-by: Damon Ding <damon.ding@rock-chips.com>
>>
>> The continuous mode of all PWM channels has been preliminarily tested
>> and verified working on the RK3576 IoT board.
>>
>> I have tested with several typical period and duty cycle configurations.
>>
>> Following Uwe's suggestion [0], I also tested with libpwm using commands
>> similar to the following:
>>
>> ./pwmset -c 0 -p 0 -P 1000000 -D 500000 -s 5000
> 
> This one is good if you have an oscilloscope (or something similar) to
> verify the output. Without that (or additionally) pwmtestperf creates a
> series of requests that in combination with PWM_DEBUG should uncover
> rounding errors in the .tohw and .fromhw callbacks.

Aha, this is my oversight. I did not elaborate on my verification 
methods. ;-)

I have adopted three ways to complete the test:

1. Measure the output waveform of each channel with a simple logic 
analyzer, Kinst LA2016.
2. Read relevant registers to verify that the configured period and duty 
values match expectations.
3. Connect the PWM continuous output pins to capture input pins 
directly, to confirm the capture measurement results.

> 
> A good set of calls then is:
> 
> 	pwmtestperf -p ... -c ... -P 50000 -S1
> 	pwmtestperf -p ... -c ... -P 50000 -S1 -I
> 
> 	pwmtestperf -p ... -c ... -P 50000 -S-1
> 	pwmtestperf -p ... -c ... -P 50000 -S-1 -I
> 
> (Assuming that 50000 is a sensible period for the device under test.)
> 

Okay, I will look into this tool and run these commands to conduct more 
in-depth verification.

> And yes, I know, I need to document that using something more permanent
> than a mailing list post.
> 

Best regards,
Damon


