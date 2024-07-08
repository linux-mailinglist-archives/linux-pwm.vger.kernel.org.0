Return-Path: <linux-pwm+bounces-2729-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A6592A5DB
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 17:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A8C282145
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 15:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9EA13F426;
	Mon,  8 Jul 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="v1VQQhwl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77F61E898;
	Mon,  8 Jul 2024 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453050; cv=none; b=op33gn6icAj/o5vHfmROC01R1AeIZkU9veE23snhzAM2J/QE2otwZmfZR9xdcIAKo1AWg7ZjiK45Kl1S+UXsjPT3q25W9O4FfSqDTEDjhv0P9DTdA4IUYFJb/6N0leAcFUdfrejXCzhmPb5VR8ML+I5IVsqshthU3Jg6hQmPkfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453050; c=relaxed/simple;
	bh=91QbJhmZE7ivkt7ImAusrGfiOF3UCW7ZXNMXwT01oH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tkhcdb4osRZoRnpxVE38SI4/NIi1eZ4JhZlFL+NgNnk3vEMGEcvWeggArvaTawHq4Qc5A+2RE4dSyTRIHOkwEt4NFt/SnmhGxeS4JCo020pV17/DRgtHc6HajmJlTVMBWNhHYmn5PuRHlHG1vQutNHyMzshlnjIdSecC0KwBIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=v1VQQhwl; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 10192120005;
	Mon,  8 Jul 2024 18:37:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 10192120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720453042;
	bh=Bo/6XCu3DzX8pb2DXto2aIjlWq7K1MB2e/LDCsAwPr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=v1VQQhwlvdIQcefu+5VOdf7ahVdnlEg1GJcsptyzWz02GK5Bj4V/Zer5Fv6yXQOK7
	 02NUnd2qSIJ+LT1tBtFr8Bh6ksotDPwLM9ttqdDOcG/OKEkx4rAkqR/cishfu7iDFy
	 /XczqEpgrlTs+mTlk4aecTuT/Z5STeoIn7pN2Gh5tKCXcCvMBe02X9ZZ5Y/ODo2TYV
	 QK2568OIt1RZrrQ0GisIHSAc1vU7/uWbdTjT8fRaPU5oe0RSJZ5b4FDLxFOB3g2UJU
	 /XZb/XMcGqSyn/c9MZBvd42O0gTRaNGvD3UC1aP1M9f2qot/IWtd1t4+j0hixdeEVK
	 aI3aFVmir5bdg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  8 Jul 2024 18:37:21 +0300 (MSK)
Received: from [172.28.64.179] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 8 Jul 2024 18:37:21 +0300
Message-ID: <4ec6b50e-b915-4e18-a8a5-97ca7ab9e4ce@salutedevices.com>
Date: Mon, 8 Jul 2024 18:37:21 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 PWM
To: Jerome Brunet <jbrunet@baylibre.com>
CC: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <hkallweit1@gmail.com>,
	<linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
References: <20240702123425.584610-1-gnstark@salutedevices.com>
 <20240702123425.584610-2-gnstark@salutedevices.com>
 <1j8qychvv6.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <1j8qychvv6.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186376 [Jul 08 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 23 0.3.23 8881c50ebb08f9085352475be251cf18bb0fcfdd, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/08 12:56:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/08 14:31:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/08 12:25:00 #25908179
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Jerome

Thanks for the review

On 7/8/24 16:11, Jerome Brunet wrote:
> On Tue 02 Jul 2024 at 15:34, George Stark <gnstark@salutedevices.com> wrote:
> 
>> The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF.
>>
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-amlogic.yaml    | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> index 1d71d4f8f328..e021cf59421a 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml

...

> 
> The change is not only introducing a1 compatibility but also allowing a
> power-domain for the other SoC, even if optional.
> 
> If that is intended, it should be stated in the description and probably
> a separate change.

AFAIK the only SoC with a separate PD for PWM is A1 (currently). I added 
PD to bindings by an independent change in series #2 [1] but Rob
proposed it should be squashed into compatible patch. The only thing 
missed in series #2 was the conditional schema making PD required for A1.

I personally would prefer to add PD as a separate change.
I'll give it a try.

[1] 
https://lore.kernel.org/lkml/20240701172016.523402-1-gnstark@salutedevices.com/T/#m0e004fc0d22e205aa3bf6bdd0284d251f26eb0f3


> 
>>     "#pwm-cells":
>>       const: 3
>>   
>> @@ -136,6 +143,16 @@ allOf:
>>         required:
>>           - clocks
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - amlogic,meson-a1-pwm
>> +    then:
>> +      required:
>> +        - power-domains
>> +
>>   additionalProperties: false
>>   
>>   examples:
> 

-- 
Best regards
George

