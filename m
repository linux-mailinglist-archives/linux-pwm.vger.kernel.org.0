Return-Path: <linux-pwm+bounces-2854-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0F3937719
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 13:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4601C21037
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Jul 2024 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8B584D3E;
	Fri, 19 Jul 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="QTTQpw/g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68284E14;
	Fri, 19 Jul 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388149; cv=none; b=fy8hyO2pj/CtIKEvQB22Y/ev0NSS1qBHrlbtS9zbC71JT4FIuQIg/kd/CN+a0eTkjSBhv3fakIsA2xZxlCem0cbBMzB2iuR5HjQr4x+r6ovhXcAQGRx6hMhVf6uATpDuPb2geSZ0LgFiXIq91fLVS9toP8Ek3+TDHj10TO/HScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388149; c=relaxed/simple;
	bh=gCBf+KZT1rBru5MYqeke41rALdRkuIZfrNphkR+xKtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B9HZ6clHdmR+oWwlNljU4QcdkUDAhhpIQ/cNBodcDz+tWibri7MK5hAzJlgX/GCG/wtkvOn//Zt6y+y4Xw7brbNLRURCrdyHzP6GYgJTm2Sg1bduuHc2QXMXTS/lLouHDUk28jDfDNDn/a6ikp7TBRODpCiz0+3L9GWLBY2GCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=QTTQpw/g; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 259E7100004;
	Fri, 19 Jul 2024 14:22:21 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 259E7100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1721388141;
	bh=llE/44dMTNKnUSBmsfPJUwp9Lmbr3Wo7lWfPjeUVyzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=QTTQpw/go/CMBjRenn7SNcC23QGqsmSYiuUPI8srwMrN8+2P0zG2EUB5hJxOGbrmV
	 7KhTiw486GV1jubtq7EO5aQ7HFhWLRoVppGn6NiQqQA2t7eCcOnJcNyvReNjQBmq90
	 3TUqsbL9mRLWXECK0eQFw6tIwLi64vLdEQ/hhCs2wjG3g9L7xgeSWSyiVN6djx6nhP
	 2j/exCVIRf5SK+TjMxg+Z0qKjFNYUid0Vlvx+gsCZC/2Pxqfez75R7RzWX+4NNbVMB
	 nC903xNilBhW6Rn08tnib6G93bKjl4FLhS5T5yThA0SMJR8VghD3lucHdpkExQ1QAn
	 ZWcYzscBCgnEA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 19 Jul 2024 14:22:20 +0300 (MSK)
Received: from [192.168.1.143] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 19 Jul 2024 14:22:20 +0300
Message-ID: <dbb4be50-4793-40ab-b362-6c9a6dd87324@salutedevices.com>
Date: Fri, 19 Jul 2024 14:22:20 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] pwm: meson: add pwm support for A1
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<neil.armstrong@linaro.org>, <linux-pwm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <martin.blumenstingl@googlemail.com>,
	<jbrunet@baylibre.com>, <khilman@baylibre.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>,
	<hkallweit1@gmail.com>
References: <20240710234116.2370655-1-gnstark@salutedevices.com>
 <52e2e211-a0b7-47b1-a451-34c304028097@salutedevices.com>
 <bp3hbxl6zs6lwomfdj6edhq35pde3gr5i2qizgdf2varke2eai@weeodo6gacd7>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <bp3hbxl6zs6lwomfdj6edhq35pde3gr5i2qizgdf2varke2eai@weeodo6gacd7>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186588 [Jul 18 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_arrow_text}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/18 08:50:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/18 08:50:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/18 08:29:00 #26061289
X-KSMG-AntiVirus-Status: Clean, skipped



On 7/19/24 10:20, Uwe Kleine-König wrote:
> Hello George,
> 
> On Thu, Jul 18, 2024 at 04:09:04PM +0300, George Stark wrote:
>> Excuse me, should I fix/improve anything on this series?
> 
> The known issue with this series is just that it's one of several patch
> series that I didn't come around to review yet. I tackle them one at a
> time, usually in a FIFO order as listed on
> https://patchwork.ozlabs.org/project/linux-pwm/list/ .
> 
> Best regards
> Uwe

Hello Uwe

Ok, no problem. Thanks for letting me know.

-- 
Best regards
George

