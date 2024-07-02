Return-Path: <linux-pwm+bounces-2656-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E414923DDE
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 14:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7911C24630
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 12:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8D51741C0;
	Tue,  2 Jul 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="V7uvODUv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BC9171E66;
	Tue,  2 Jul 2024 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923385; cv=none; b=gv93UpmUYqA2jjrfuO4Yg7F8N8TFfOncIFkf5x0G1GYhbxKoX9y23s5XU2hYZ1OAKPY5CjAyp9U2L3tdRb8FA55hDGGT8HkbdpnxgQGqnOj0qqNmW3/Cx8mUA+ndrsn1zT7jiy6cyHrOSLgeCHYzh/AQxFzUjfVHXT1ygIG1Vzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923385; c=relaxed/simple;
	bh=ub8nrZjAshM9poetjgAQUtT06ScuMMiWEri2/MbcD54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TFAzjZlGaH/TDe4pz6GG8JYjhBBodtcYpLCCPwQdEhJyqqQGB8ve0/2erlIYG8pkAAxit4H5qmd2PYo84bwPUH+y/7yIlCAK29t4KbcGjGdU/usnfF34yHYcJSGQyHAciiMISxZ65Gmk2ePLoiMGMDireStF6wDAOBiUO1ao768=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=V7uvODUv; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id C4E2E12000A;
	Tue,  2 Jul 2024 15:29:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C4E2E12000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719923376;
	bh=dRg6152bEnilxNCIoE5zA/wmMBOuMDTu0AIr+x54D4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=V7uvODUvcYFk1y+du59hc3HqKuLLj3yNsdafT7CCsNDKzRrbsv5Tl2d0LD0zNxjm8
	 KnM7JwvrnrSvgCAiaLKf3893wX9dwIVfPp5+onT2rRWv0sNZy53dmjdHurpXJ3W5QQ
	 Oa/cneThEv0vMriZYaJrWtlWSZWTZRfEjlL/smfLMphKsfvYxqNa5xGuBdMC+Cym52
	 zkthJ+HqkJkhDXW7vM9qAbIL3Ssjy9IHfoAnUnaPLNjELGVqBZfboX+/6RgANbIbJ0
	 /Vt/C1uQkRYJkvDl6ISRIoiC+j5w9VH3Jlri+LJo5SXZP2NyZjVQxbhxJctfdXfTMQ
	 lTBexzl94ZRGg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  2 Jul 2024 15:29:36 +0300 (MSK)
Received: from [172.28.129.1] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jul 2024 15:29:36 +0300
Message-ID: <66278f9c-3dde-420a-b446-69693690dc10@salutedevices.com>
Date: Tue, 2 Jul 2024 15:29:27 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: pwm: amlogic: Add optional
 power-domains
To: Rob Herring <robh@kernel.org>
CC: <ukleinek@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<neil.armstrong@linaro.org>, <khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <hkallweit1@gmail.com>,
	<linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>
References: <20240701172016.523402-1-gnstark@salutedevices.com>
 <20240701172016.523402-3-gnstark@salutedevices.com>
 <20240701183631.GA349021-robh@kernel.org>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240701183631.GA349021-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186277 [Jul 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/02 07:59:00 #25796134
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Rob

Thanks for the review.

On 7/1/24 21:36, Rob Herring wrote:
> On Mon, Jul 01, 2024 at 08:20:15PM +0300, George Stark wrote:
>> On newer SoCs, the PWM can require a power-domain to operate so add it
>> as optional.
> 
> If required, then how is it optional?

Newly adding SoC's PWM definitely requires power-domains, older SoCs
don't have dedicated power-domain for that that kind of periphery.
But I can't say other new SoCs won't require it too that's why I made it
by a separate patch. And squash the power-domians patch into main one
is ok too.

> 
> If the 'newer SoCs' means the one you just added, then this should be
> squashed into the prior patch with a conditional schema making it
> required for the new compatible.

> 
>>
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index da22cb3ed878..c814d88748dd 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> @@ -60,6 +60,9 @@ properties:
>>       minItems: 1
>>       maxItems: 2
>>   
>> +  power-domains:
>> +    maxItems: 1
>> +
>>     "#pwm-cells":
>>       const: 3
>>   
>> -- 
>> 2.25.1
>>

-- 
Best regards
George

