Return-Path: <linux-pwm+bounces-2347-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC088FC700
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CEF1F21AF9
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 08:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F1718F2F3;
	Wed,  5 Jun 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="vKFf8t/q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90308F9D9;
	Wed,  5 Jun 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717577643; cv=none; b=olP5W7Kx8OvUPi7K0uV0+VIoWrKncxy6m8SsmrmKT88Y9h6M6X30GhEYMk0zb5am4aez3fU9YOh/bOZGFacgAybpLl6Iy0iSVO9wZDJ7P3NLFu4+L3zlh4vacdxKGrUKmvEcizeWXMuM3/PyKIAdeXvnUZWYTr6q8lUWaDOTh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717577643; c=relaxed/simple;
	bh=j+WVWuginHWn+1ASt34SLPVNFE3ZE6mu+8v1fyYbjVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WHhFxM4/lqDh0PfagrWBak4n2jck7roInehI3Sh7bJ/gaJ24Z4/QaADbiO9nbdxEmNX5RyTG2GUitpIYoy3cqhTztfcG5QaInaHmHiCec1SUTGtzYz5i9zw/nXDWA5DzFm2aKY1wULQDbLNo5oS//7vKuhaTL3XtHP0oUZ8P3J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=vKFf8t/q; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 90E1C12000E;
	Wed,  5 Jun 2024 11:48:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 90E1C12000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1717577283;
	bh=qhnCf7tWXo/37Lgb8g/EWxYO4igTg0awCL+nXcJWkbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=vKFf8t/qhkeNbGpgQme6pfmQPHTH5qqHhpQYKCtVaiNJuHq+OYvTGS6unXaPEK2PJ
	 fy7oC7iqQn4uRHeRyWktMrso80diQ0OGkOb9UKDkhGblyk1forBlgzwS2uGvPXWB0r
	 VQ0kNrpc0nr6Vzhtouf3G6+WpHOohVM7czHiGi7Z+s9dBYudL0kfYZ4Rg/3qs0aMcy
	 PF5zMhjMX+sCkdmruG+54y3kXKZRlKKrgqsM4FPEO59OOcdvYGt8kU8foyu4gimKDI
	 xqdZnP7COn9Cw0vVEBt0m1Yh5W+/J4hklU0FEAL+oMbHftEtM2uktGxqz0wt2hJJDi
	 4Akr0fs3zlwVg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  5 Jun 2024 11:48:03 +0300 (MSK)
Received: from [172.28.225.88] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 5 Jun 2024 11:48:02 +0300
Message-ID: <faebf74c-cfeb-48c5-8db3-0f51ed6bd9eb@salutedevices.com>
Date: Wed, 5 Jun 2024 11:48:02 +0300
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH v7 2/2] arm64: dts: amlogic: Add
 Amlogic S4 PWM
To: <kelvin.zhang@amlogic.com>
CC: Jerome Brunet <jbrunet@baylibre.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Kevin Hilman
	<khilman@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Conor
 Dooley <conor+dt@kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Junyi Zhao
	<junyi.zhao@amlogic.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
References: <20240605-s4-pwm-v7-0-e822b271d7b0@amlogic.com>
 <20240605-s4-pwm-v7-2-e822b271d7b0@amlogic.com>
Content-Language: en-US
From: George Stark <gnstark@salutedevices.com>
In-Reply-To: <20240605-s4-pwm-v7-2-e822b271d7b0@amlogic.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185732 [Jun 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/06/05 04:05:00 #25448641
X-KSMG-AntiVirus-Status: Clean, skipped

Hello Kelvin, Junyi

Reviewed-by: George Stark <gnstark@salutedevices.com>

On 6/5/24 05:44, Kelvin Zhang via B4 Relay wrote:
> From: Junyi Zhao <junyi.zhao@amlogic.com>
> 
> Add device nodes for PWM_AB, PWM_CD, PWM_EF, PWM_GH and PWM_IJ
> along with GPIO PIN configs of each channel.
> 
> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi | 199 ++++++++++++++++++++++++++++++
>   1 file changed, 199 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index 10896f9df682..b686eacb9662 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -312,6 +312,160 @@ mux {
>   					};
>   				};
>   
> +				pwm_a_pins1: pwm-a-pins1 {
> +					mux {
> +						groups = "pwm_a_d";
> +						function = "pwm_a";
> +					};
> +				};
> +
> +				pwm_a_pins2: pwm-a-pins2 {
...


-- 
Best regards
George

