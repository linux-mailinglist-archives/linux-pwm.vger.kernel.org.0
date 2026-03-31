Return-Path: <linux-pwm+bounces-8445-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFAkClR7y2lPIQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8445-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:44:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83B365685
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABB3E3011C5D
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312C83C9EE2;
	Tue, 31 Mar 2026 07:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Vqbye4/g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF633C196A;
	Tue, 31 Mar 2026 07:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774942989; cv=none; b=r/QEK8wsCwMnpkhbuZp1YfqcR2li0Jwnr2BBwWzjr1P3+MRUOVgXoQrPdJMaJlJRVXdDlkprw6H7j/x5eyIPu102JpqKJzouy83a/E+SWsGy1evBGZPlmODC+X6hWwNwPZv0HXnpLrnM0i8UTyFrlu1lJ19S4p414nfZDNREpgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774942989; c=relaxed/simple;
	bh=vFRhdAeUjt7gLU7Xzz2MxFnVkJR6y70K37uER2LcHcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jYEOovqJkW6eBeCjzjybJrEjeLIF9NRRtk710GzRALxsvpxEpLzcJTSPRz74NLIcNQJ2bxLDuI5QOV3NgAUlZ3EhMwLrwkPAJwrzrhMT835rad0Ckz1b3e4co0BXoTW5old90k2waxmUgYusHusKowOhaBhhEEQqonjLADJpLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Vqbye4/g; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 2EBE9240009;
	Tue, 31 Mar 2026 10:33:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 2EBE9240009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1774942439;
	bh=pqy2ZQ2K4gQV5vy8fXRZ04Ksn+hbGqCwiDElTb+KLWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=Vqbye4/gxEkN5y6SkrGeFFYraxQHst5BP5gymx/wE6420SwJHr3YNYA2U1nz+y/kG
	 LNbOv6RIwAvd0hJg/1DnZbvjH1qVZlhvtykhSQMmbXgDtSUwr6SzTgJbK8VuIBluia
	 ly3rPuZJW/xaBVtrLBWmsR6qCcI/pZ63sWIO5jXhNrBcfbiIa1tC+7cPv/RnqqnZXc
	 3F6qwy7WlwbvEAXsDQuKdL4bwwFG/1gXYyofGINJ6uknXgzTSEromqeImnrk7QXmrE
	 8zfZzParopCAq48OKIv7NCK5AikhalzdwH1IkT4OJa1FRsU9WfigWgQxqSd3Z83B/w
	 mH3hVWsaC4+Gw==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "R12" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Tue, 31 Mar 2026 10:33:58 +0300 (MSK)
Message-ID: <4a9c726a-d580-4b0b-9530-228b58389c80@salutedevices.com>
Date: Tue, 31 Mar 2026 10:33:57 +0300
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
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <70a637b1-a76a-470c-9a97-0b4599a40a1c@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-exch-cas-a-m1.sberdevices.ru (172.24.201.216) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/03/31 06:48:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 95 0.3.95 0e4b6d4f1992c354ebd6a5cc3c5624a3b0aa8cbc, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lists.infradead.org:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 201803 [Mar 31 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.22
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/03/30 22:26:00 #28356219
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/03/31 06:48:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[salutedevices.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[salutedevices.com:s=post];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8445-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[amlogic.com,googlemail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,vger.kernel.org,lists.infradead.org,amlogic.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnstark@salutedevices.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[salutedevices.com:+];
	NEURAL_HAM(-0.00)[-0.880];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,infradead.org:url,salutedevices.com:dkim,salutedevices.com:mid]
X-Rspamd-Queue-Id: 5E83B365685
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Martin, Xianwei


On 3/31/26 10:10, Xianwei Zhao wrote:
> Hi Martin,
>      I confirmed with Junyi Zhao that the current implementation counts 
> from zero, so this submission is correct.
> We agree this should be fixed and will address it in a follow-up patch.
> Thanks for pointing it out.
> 
> On 2026/3/31 05:54, Martin Blumenstingl wrote:
>> Hi Xianwei Zhao,
>>
>> thanks for your contribution!
>>
>> On Thu, Mar 26, 2026 at 7:35 AM Xianwei Zhao via B4 Relay
>> <devnull+xianwei.zhao.amlogic.com@kernel.org>  wrote:
>>> Add bindings and driver support Amlogic S7/S7D/S6 SoCs.
>> There is an old report that got lost, stating that the current

Xianwei Zhao thanks for the confirmation.
I am the author of the old report and the corresponding patch and it's 
not lost. So if the patch is correct I'll be glad to add relevant 
tested-by tags.

>> pwm-meson driver has an off-by-one error with the hi and lo fields:
>> [0]
>> Since you are working on bringing up a new platform: is this something
>> you can verify in your lab?
>> To be clear: I'm not expecting you to work on this ad-hoc or bring a
>> patch into this series. However, it would be great if you could verify
>> if the findings from [0] are correct and send an updated patch in
>> future.
>>
>> Thank you and best regards
>> Martin
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Best regards
George

