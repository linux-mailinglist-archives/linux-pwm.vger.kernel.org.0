Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34190396CDE
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jun 2021 07:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhFAFeP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Jun 2021 01:34:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39904 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFAFeP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Jun 2021 01:34:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1515WL8R064115;
        Tue, 1 Jun 2021 00:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622525541;
        bh=WvpvW7OgztFAVo/BvWJFiOHwaLBd1oH444fGsFPLFiM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NfkIMv3bqsyBF0coTqHQSXSGwub4K8MNWx5xWhuK9Y/ckozs+5rshKoohN3hMDOd0
         d5t3y2UbkaBrmmxFwQFJe1xz5pejk3OQGw+2qSiYnaReXWB4hBioVehniX4FEMnmLq
         armTI6pCEo73AkpJsP/5A4GNjhXnA5MsMXpyeqIg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1515WLA1029907
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Jun 2021 00:32:21 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 00:32:21 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 1 Jun 2021 00:32:21 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1515WEtv070319;
        Tue, 1 Jun 2021 00:32:16 -0500
Subject: Re: [PATCH 1/4] arm: dts: ti: drop usage of redundant compatible
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>
CC:     <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        <linux-pwm@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>
References: <20210526084306.6534-1-lokeshvutla@ti.com>
 <20210526084306.6534-2-lokeshvutla@ti.com>
 <de96c176-1163-a6c4-54f2-a9924db6f9df@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <627acc59-b702-d3da-2a61-3f321c8432e8@ti.com>
Date:   Tue, 1 Jun 2021 11:02:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <de96c176-1163-a6c4-54f2-a9924db6f9df@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 31/05/21 4:47 pm, Grygorii Strashko wrote:
> 
> 
> On 26/05/2021 11:43, Lokesh Vutla wrote:
>> Commit 229110c1aa691 ("ARM: dts: am437x/am33xx/da850: Add new ECAP and
>> EPWM bindings") added ti,am3352-ehrpwm compatible which is similar to
>> ti,am33xx-ehrpwm but without out t,hwmod properties. But with commit
>> 58bfbea5b1c68 ("ARM: dts: am437x/am33xx: Remove hwmod entries for ECAP
>> and EPWM nodes") dropped support for all ti,hwmod for ehrpwm, but
>> missed deprecating ti,am33xx-ehrpwm compatible. So drop ti,am33xx-ehrpwm
>> from DT as it is no longer needed.
>>
>> ti-ehrpwn driver still support ti,am33xx-ehrpwm in order to maintain
>> backward compatibility.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>   .../devicetree/bindings/pwm/pwm-tiehrpwm.txt   | 13 ++++++-------
>>   arch/arm/boot/dts/am33xx-l4.dtsi               |  9 +++------
>>   arch/arm/boot/dts/am437x-l4.dtsi               | 18 ++++++------------
>>   arch/arm/boot/dts/da850.dtsi                   |  6 ++----
>>   4 files changed, 17 insertions(+), 29 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>> b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>> index c7e28f6d28be..e124e41418d8 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
>> @@ -2,10 +2,10 @@ TI SOC EHRPWM based PWM controller
>>     Required properties:
>>   - compatible: Must be "ti,<soc>-ehrpwm".
>> -  for am33xx  - compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
>> -  for am4372  - compatible = "ti,am4372-ehrpwm", "ti-am3352-ehrpwm",
>> "ti,am33xx-ehrpwm";
>> +  for am33xx  - compatible = "ti,am3352-ehrpwm";
>> +  for am4372  - compatible = "ti,am4372-ehrpwm", "ti-am3352-ehrpwm";
>>     for am654   - compatible = "ti,am654-ehrpwm", "ti-am3352-ehrpwm";
>> -  for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm",
>> "ti,am33xx-ehrpwm";
>> +  for da850   - compatible = "ti,da850-ehrpwm", "ti-am3352-ehrpwm";
>>     for dra746 - compatible = "ti,dra746-ehrpwm", "ti-am3352-ehrpwm";
>>   - #pwm-cells: should be 3. See pwm.yaml in this directory for a description of
>>     the cells format. The only third cell flag supported by this binding is
>> @@ -19,7 +19,7 @@ Optional properties:
>>   Example:
>>     ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
>> -    compatible = "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
>> +    compatible = "ti,am3352-ehrpwm";
>>       #pwm-cells = <3>;
>>       reg = <0x48300200 0x100>;
>>       clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
>> @@ -27,16 +27,15 @@ ehrpwm0: pwm@48300200 { /* EHRPWM on am33xx */
>>   };
>>     ehrpwm0: pwm@48300200 { /* EHRPWM on am4372 */
>> -    compatible = "ti,am4372-ehrpwm", "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
>> +    compatible = "ti,am4372-ehrpwm", "ti,am3352-ehrpwm";
>>       #pwm-cells = <3>;
>>       reg = <0x48300200 0x80>;
>>       clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
>>       clock-names = "tbclk", "fck";
>> -    ti,hwmods = "ehrpwm0";
>>   };
>>     ehrpwm0: pwm@1f00000 { /* EHRPWM on da850 */
>> -    compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm", "ti,am33xx-ehrpwm";
>> +    compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm";
>>       #pwm-cells = <3>;
>>       reg = <0x1f00000 0x2000>;
>>   };
>> diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
>> index 039a9ab4c7ea..fbf3458ab246 100644
>> --- a/arch/arm/boot/dts/am33xx-l4.dtsi
>> +++ b/arch/arm/boot/dts/am33xx-l4.dtsi
>> @@ -2017,8 +2017,7 @@ eqep0: counter@180 {
>>                   };
>>                     ehrpwm0: pwm@200 {
>> -                    compatible = "ti,am3352-ehrpwm",
>> -                             "ti,am33xx-ehrpwm";
>> +                    compatible = "ti,am3352-ehrpwm";
>>                       #pwm-cells = <3>;
>>                       reg = <0x200 0x80>;
>>                       clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
>> @@ -2078,8 +2077,7 @@ eqep1: counter@180 {
>>                   };
>>                     ehrpwm1: pwm@200 {
>> -                    compatible = "ti,am3352-ehrpwm",
>> -                             "ti,am33xx-ehrpwm";
>> +                    compatible = "ti,am3352-ehrpwm";
>>                       #pwm-cells = <3>;
>>                       reg = <0x200 0x80>;
>>                       clocks = <&ehrpwm1_tbclk>, <&l4ls_gclk>;
>> @@ -2139,8 +2137,7 @@ eqep2: counter@180 {
>>                   };
>>                     ehrpwm2: pwm@200 {
>> -                    compatible = "ti,am3352-ehrpwm",
>> -                             "ti,am33xx-ehrpwm";
>> +                    compatible = "ti,am3352-ehrpwm";
>>                       #pwm-cells = <3>;
>>                       reg = <0x200 0x80>;
>>                       clocks = <&ehrpwm2_tbclk>, <&l4ls_gclk>;
>> diff --git a/arch/arm/boot/dts/am437x-l4.dtsi b/arch/arm/boot/dts/am437x-l4.dtsi
> 
> [...]
> 
>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index 7cf31b6e48b7..afdf3d3747ce 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
>> @@ -574,8 +574,7 @@ mmc1: mmc@21b000 {
>>               status = "disabled";
>>           };
>>           ehrpwm0: pwm@300000 {
>> -            compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
>> -                     "ti,am33xx-ehrpwm";
>> +            compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm";
>>               #pwm-cells = <3>;
>>               reg = <0x300000 0x2000>;
>>               clocks = <&psc1 17>, <&ehrpwm_tbclk>;
>> @@ -584,8 +583,7 @@ ehrpwm0: pwm@300000 {
>>               status = "disabled";
>>           };
>>           ehrpwm1: pwm@302000 {
>> -            compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm",
>> -                     "ti,am33xx-ehrpwm";
>> +            compatible = "ti,da850-ehrpwm", "ti,am3352-ehrpwm";
>>               #pwm-cells = <3>;
>>               reg = <0x302000 0x2000>;
>>               clocks = <&psc1 17>, <&ehrpwm_tbclk>;
>>
> 
> I think, the DT changes can be split and posted standalone while bindings fixed
> as part of yaml conversation.
> Personally I do not see reasons for separate .txt bindings fix here as ymal
> conversation just
> reveals inconsistency between DT bindings, DTBs and code which leads to DTBs fix.

I agree. Will split the series into DT changes and yaml conversion.

Thanks and regards,
Lokesh
