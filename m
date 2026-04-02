Return-Path: <linux-pwm+bounces-8457-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GxZJ1JYzmkxnAYAu9opvQ
	(envelope-from <linux-pwm+bounces-8457-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Apr 2026 13:51:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331CC388965
	for <lists+linux-pwm@lfdr.de>; Thu, 02 Apr 2026 13:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CB023020A69
	for <lists+linux-pwm@lfdr.de>; Thu,  2 Apr 2026 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090493E123E;
	Thu,  2 Apr 2026 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="N+YMWDi2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA503C344C;
	Thu,  2 Apr 2026 11:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775130422; cv=none; b=FtmafZJpa0/YYMndlEMUvTs7pBT30fXVN9uOdcTPyNecppOfMCCxHPz7IwZKYwOtZ0KoN7BpJgRn84HYTRIV9tuWbvGpDDB/8VsHKjvVvA8dIthdLSrh+k+Iiy9fqQ9q9u8H/s7UnGwZwD7fF2nfI+D+Jjeu/8KHkhTKoxZqrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775130422; c=relaxed/simple;
	bh=C6BnlSlAquTCbKbHPYjW9baNoRu/YDPrrH2izkgFDFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c1CUzaw0Nb7zXEVJEl67e7ar3xgoLPBquB9DBmXK9rEvQyaSU2XaeT+EczG9RbHXGuERudnE1CahoJ+ut6p9BXWK43OM9fcpF+8dezuCTe9wOnZ7HbQTY2+kZs5HO5wHce4MKp5whfoj3Yf1llH3mAnmZIND2KR6GSNndkJbdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=N+YMWDi2; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 05B9A240005;
	Thu,  2 Apr 2026 14:46:42 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 05B9A240005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1775130402;
	bh=LS4xrv2sD/iCCx4NjkrxG3qRMXJ6P8C3NNJ6hNqyLu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=N+YMWDi2qhINcmzCHNSXhp6ERUeAKq0p2KdXHod7x7aVtTbW/R2sG6vjo9+SsWIbZ
	 +SnIEKHalDH9insT3IKFn0q3um+WvBs1BIOBKgrf/74KweMlOZJiwd3jMQKCTdCAVu
	 Yt6B8OfNaXdDzH/6PxXFTFdHOIZyQjv7m6GshOjzuprKb4+MEHiOI0an8KSrDh3KsU
	 dmSqbyp6pjRjkcXYclMWN1Gig69RoIZt5jZwjNd2Hh5OHqeNtCMOPtfA/7et9dAzYf
	 +ZkVcpDBQDt7oZJG8SuFp7UUVJU9YcnnHGFtm0sklPjSiLJyDYiWIe01oIpU/qXOkh
	 /AGFJPh0taGDw==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  2 Apr 2026 14:46:41 +0300 (MSK)
Message-ID: <6fd5f5a8-dd60-48ad-be29-d263578e6b0a@salutedevices.com>
Date: Thu, 2 Apr 2026 14:46:40 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error]Re: [PATCH 0/2] Add PWM support Amlogic S7 S7D S6
To: Xianwei Zhao <xianwei.zhao@amlogic.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, <linux-pwm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	Junyi Zhao <junyi.zhao@amlogic.com>
References: <20260326-s6-s7-pwm-v1-0-67e2f72b98bc@amlogic.com>
 <CAFBinCD1GPP82MEBDHg3BwCJg6JY5k2HksEt+kCB=YjnYTO7Tw@mail.gmail.com>
 <70a637b1-a76a-470c-9a97-0b4599a40a1c@amlogic.com>
 <4a9c726a-d580-4b0b-9530-228b58389c80@salutedevices.com>
 <78e05060-6f25-4d78-8b0d-35b8fca0cecb@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <78e05060-6f25-4d78-8b0d-35b8fca0cecb@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 96 0.3.96 f0df504111d78c4fb91ce829559989c2d1ddd192, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 201900 [Apr 02 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/04/02 09:00:00 #28364014
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8457-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[amlogic.com,googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,vger.kernel.org,lists.infradead.org,amlogic.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnstark@salutedevices.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 331CC388965
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Xianwei Zhao

On 3/31/26 10:59, Xianwei Zhao wrote:
> Hi George,
> 
> On 2026/3/31 15:33, George Stark wrote:
>> Hello Martin, Xianwei
>>
>>
>> On 3/31/26 10:10, Xianwei Zhao wrote:
>>> Hi Martin,
>>>      I confirmed with Junyi Zhao that the current implementation counts
>>> from zero, so this submission is correct.
>>> We agree this should be fixed and will address it in a follow-up patch.
>>> Thanks for pointing it out.
>>>
>>> On 2026/3/31 05:54, Martin Blumenstingl wrote:
>>>> Hi Xianwei Zhao,
>>>>
>>>> thanks for your contribution!
>>>>
>>>> On Thu, Mar 26, 2026 at 7:35 AM Xianwei Zhao via B4 Relay
>>>> <devnull+xianwei.zhao.amlogic.com@kernel.org>  wrote:
>>>>> Add bindings and driver support Amlogic S7/S7D/S6 SoCs.
>>>> There is an old report that got lost, stating that the current
>>
>> Xianwei Zhao thanks for the confirmation.
>> I am the author of the old report and the corresponding patch and it's
>> not lost. So if the patch is correct I'll be glad to add relevant
>> tested-by tags.
>>
> 
> I will use your patch and won't send a separate one.
> Do you mean I should add a Tested-by tag to your patch?

Yes since you've confirmed the problem exists then your tested-by tag 
would be appropriate. And I'm ok if you resend the patch. Thanks.

>>>> pwm-meson driver has an off-by-one error with the hi and lo fields:
>>>> [0]
>>>> Since you are working on bringing up a new platform: is this something
>>>> you can verify in your lab?
>>>> To be clear: I'm not expecting you to work on this ad-hoc or bring a
>>>> patch into this series. However, it would be great if you could verify
>>>> if the findings from [0] are correct and send an updated patch in
>>>> future.
>>>>
>>>> Thank you and best regards
>>>> Martin 

-- 
Best regards
George

