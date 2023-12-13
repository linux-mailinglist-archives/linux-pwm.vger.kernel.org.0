Return-Path: <linux-pwm+bounces-550-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A117810CEA
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 10:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 232DBB209CA
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Dec 2023 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEE41EB47;
	Wed, 13 Dec 2023 09:03:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3797AF7;
	Wed, 13 Dec 2023 01:03:38 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 1C90224E2A6;
	Wed, 13 Dec 2023 17:03:31 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Dec
 2023 17:03:30 +0800
Received: from [192.168.120.47] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Dec
 2023 17:03:28 +0800
Message-ID: <30eed909-a0c9-409e-a78e-5961c43a9114@starfivetech.com>
Date: Wed, 13 Dec 2023 17:03:26 +0800
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/4] pwm: opencores: Add PWM driver support
To: Philipp Zabel <p.zabel@pengutronix.de>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-pwm@vger.kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Hal Feng
	<hal.feng@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	"Palmer Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20231208094209.1910934-1-william.qiu@starfivetech.com>
 <20231208094209.1910934-3-william.qiu@starfivetech.com>
 <92ac0bc4c43fa70ff4bcba44ba4382c0c8ebfb75.camel@pengutronix.de>
Content-Language: en-US
From: William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <92ac0bc4c43fa70ff4bcba44ba4382c0c8ebfb75.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag



On 2023/12/8 19:47, Philipp Zabel wrote:
> Hi William,
> 
> On Fr, 2023-12-08 at 17:42 +0800, William Qiu wrote:
>> Add driver for OpenCores PWM Controller. And add compatibility code
>> which based on StarFive SoC.
>> 
>> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
> [...]
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 4b956d661755..d87e1bb350ba 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -444,6 +444,18 @@ config PWM_NTXEC
>>  	  controller found in certain e-book readers designed by the original
>>  	  design manufacturer Netronix.
>>  
>> +config PWM_OCORES
>> +	tristate "OpenCores PWM support"
>> +	depends on HAS_IOMEM && OF
>> +	depends on COMMON_CLK && RESET_CONTROLLER
> 
> There is no need for reset consumers to depend on RESET_CONTROLLER.
> 
Will drop
> [...]
>> diff --git a/drivers/pwm/pwm-ocores.c b/drivers/pwm/pwm-ocores.c
>> new file mode 100644
>> index 000000000000..996ca3805901
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-ocores.c
>> @@ -0,0 +1,229 @@
> [...]
>> +static int ocores_pwm_probe(struct platform_device *pdev)
>> +{
> [...]
>> +	ddata->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> 
> Missing error handling.
> 
Will add.
>> +	reset_control_deassert(ddata->rst);
> 
> Missing error handling.
> 
Will add.
> 

Thank you for spending time on this patch series.

Best Regards,
William
> regards
> Philipp

