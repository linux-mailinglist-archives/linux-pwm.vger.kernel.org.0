Return-Path: <linux-pwm+bounces-2786-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB6592FD41
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917881F21517
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649DC172BB2;
	Fri, 12 Jul 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="KjJOdeOG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F7A1094E;
	Fri, 12 Jul 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797161; cv=none; b=nFZrwVFQWPpIAHuF0ibW4rhWjvVJbFK3Vf0kH7/XNqMTnGefXP9VhM3poBc+4EnVDQ8D7Ckm/Tfi9l6qvKRUylpN4NoHfx90SotNEmSd1YHGf0CvdyTkST14+VJeSJ9rGjD9+rjEbsIq2qBkFpy4OSbum4h7wuuDTz/wcKthPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797161; c=relaxed/simple;
	bh=kk3VCsodT36p1OeCq7qcg3gMsTSpYlykPwJM1lIha/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bjYfyVwfAh2ewgS70WWmk4HMqpg75cdTOV3cRPJA7jbGV4Ao+Y4xGYk3L6b4gDFqrvvx/uM0wpm1J7JLXUdJt1P3tj0KOHy7dF9c4nwshRQahQK/4dQ8nEP2RW8y1jPsxkOiQs7TEfqlTNegfE80mRr3/yr42uBWsGikDsy73w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=KjJOdeOG; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 34EE5100005;
	Fri, 12 Jul 2024 18:12:27 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 34EE5100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720797147;
	bh=+oxJwwvIdh6XFlSXZQ495IyXoY1J3oreqmYkj7vcugo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=KjJOdeOG76Q/rAZsj2JmvtveqrzZacRH75soOoKP2TSZ+DHiWb9SHcY4EluR+zotX
	 b992bisjVeImpjzb2Bya0dNgU3Y9vLS0TAcTMxFGhH5GccKeaxZ7LMU/d5phZBa/Cd
	 hYirI3PI4Xu7JXf16ceezKUWz+TczVobknnKK9qqWKxkcgUzGOdTPJFanlSpi2lLK4
	 x935kV7C8zJvnvWsx67rC5/nZ2QXV8XL36fBDhhHjpZH2iZzJmCDdPkRFSlkK30+at
	 Cv+sSaMTp4wzqiW0TmqtWmhsEVbAVTOODkqHrmPYEEOwoP2t54KmIBwPqXqBZo8j/e
	 m1MLz3d9wGMKg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 12 Jul 2024 18:12:27 +0300 (MSK)
Received: from [172.28.64.36] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 12 Jul 2024 18:12:26 +0300
Message-ID: <55f73e79-2d21-48ba-8486-26ee168c7bc3@salutedevices.com>
Date: Fri, 12 Jul 2024 18:12:26 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: pwm: amlogic: Add new bindings for
 meson A1 PWM
To: Rob Herring <robh@kernel.org>, <conor+dt@kernel.org>
CC: <ukleinek@kernel.org>, <krzk+dt@kernel.org>, <neil.armstrong@linaro.org>,
	<khilman@baylibre.com>, <jbrunet@baylibre.com>,
	<martin.blumenstingl@googlemail.com>, <hkallweit1@gmail.com>,
	<linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
 <20240710234116.2370655-3-gnstark@salutedevices.com>
 <20240712125219.GA472311-robh@kernel.org>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240712125219.GA472311-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186493 [Jul 12 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/12 14:32:00 #25964803
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Rob, Conor

On 7/12/24 15:52, Rob Herring wrote:
> On Thu, Jul 11, 2024 at 02:41:15AM +0300, George Stark wrote:
>> The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF.
>>
>> Signed-off-by: George Stark <gnstark@salutedevices.com>
>> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> 
> Missing ack from Conor. When you submit new versions, it is your
> responsibility to add tags.

I had Conor's ack in my mind but his response was related to the
squashed patch (a1 compatible + power domains) and the current patch was
a bit different that's why I didn't dare to add the ack.

Conor, do you mind if I resend this patch (and may be [PATCH v4 1/3])
with your ack?

> 
>> ---
>>   .../devicetree/bindings/pwm/pwm-amlogic.yaml       | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)

-- 
Best regards
George

