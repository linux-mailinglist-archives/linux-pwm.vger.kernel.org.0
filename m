Return-Path: <linux-pwm+bounces-3171-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A31329719DE
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 14:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF73B1C23043
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBA81B81AE;
	Mon,  9 Sep 2024 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="HwgsT1B8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4C1B7904;
	Mon,  9 Sep 2024 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886198; cv=none; b=DecMi6AKIoIjtGyIgZd//xvPA4JtJyN0qbguwLQDtEmBrEM8CVfK1EMxbR84OM0vNIqB0xlmsbfrlboVeF3A5qm2jZhp+HU8cJhnxmdGScLnMqX3rZ0cW9867272Q1ZYlvJXemJKWJ9KEa6GAMp/8OFF7uP5HHbKjHOV3IBBnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886198; c=relaxed/simple;
	bh=POoZAlpXWIcBBhqnM0thSxdA88hrh+LbpyPm9LHJaF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ad9LS7bnTd8H8w7QJOTZrmD2AvAW3leGvGHj3Q+qhfM3McGssoxfOyVahjQLWcflOCFDw4TMk1gKmYSDOGgOWNVCQ4Hfk6hMp5vXxDooC2Eb5cXsd9WVuCh3jaT5ZWdcLkE7k/PfpUY3FpsKYIdXS87VDhIN99X4J3M2KWSFIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=HwgsT1B8; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 28265120004;
	Mon,  9 Sep 2024 15:49:31 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 28265120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1725886171;
	bh=awRRfm8rHC7gTrRPbeDo7AQhEId5BvBbvaNmDJyoOtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=HwgsT1B8gsB1Fa2ATlyDFo/sgssLM/3EC0foIMhOu5iQMtaPSTG+E+dF/2ACPv0tu
	 kNUao55Lk9YYwj6YKJQZ1lfyLHFsF1a3DEpZ0d23HeCG19xucwhWEQsSMMm7Dc+OKU
	 cE7V7c3D88/23R5UJzTxrOZHQYxAIFNalw9s4pomdLevu2+GhoB25XtRqvgo5BVhtr
	 QatqxC+6g9d0h7HhcToCn46uk8f5Nl10sh7LoQDldbyw9fWb9VxD79fUXzbPO5k1TC
	 q8sKx12Ba4izUou5VZWONyTW/dM+ykaGo+jePewtJN0NBrL/lbeJmcqJaAg2g2YlDl
	 remHYvJ5Js7oQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  9 Sep 2024 15:49:30 +0300 (MSK)
Message-ID: <fcd005d2-dba4-4980-8d0d-f55632c7a6d9@salutedevices.com>
Date: Mon, 9 Sep 2024 15:49:29 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH 1/2] dt-bindings: pwm: amlogic:
 Document C3 PWM
To: <kelvin.zhang@amlogic.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Kevin Hilman
	<khilman@baylibre.com>, <linux-pwm@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Heiner Kallweit
	<hkallweit1@gmail.com>
References: <20240906-c3-pwm-v1-0-acaf17fad247@amlogic.com>
 <20240906-c3-pwm-v1-1-acaf17fad247@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240906-c3-pwm-v1-1-acaf17fad247@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187629 [Sep 09 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 32 0.3.32 766319f57b3d5e49f2c79a76e7d7087b621090df, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/09 07:41:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/09 07:41:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/09 09:27:00 #26546224
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Kelvin, Krzysztof

There's acked yet not merged patch [1] adding amlogic,meson-a1-pwm with 
s4 as back-compatible. Should amlogic,c3-pwm be added in the enum along 
with a1?

[1] 
https://lore.kernel.org/linux-arm-kernel/dbb4be50-4793-40ab-b362-6c9a6dd87324@salutedevices.com/T/

On 9/6/24 15:46, Kelvin Zhang via B4 Relay wrote:
> From: Kelvin Zhang <kelvin.zhang@amlogic.com>
> 
> Document amlogic,c3-pwm compatible, which falls back to the meson-s4-pwm
> group.
> 
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> index 1d71d4f8f328..356371164acd 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> @@ -44,6 +44,10 @@ properties:
>                 - amlogic,meson-axg-pwm-v2
>                 - amlogic,meson-g12-pwm-v2
>             - const: amlogic,meson8-pwm-v2
> +      - items:
> +          - enum:
> +              - amlogic,c3-pwm
> +          - const: amlogic,meson-s4-pwm
>   
>     reg:
>       maxItems: 1
> 

-- 
Best regards
George

