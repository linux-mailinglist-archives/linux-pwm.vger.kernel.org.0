Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2ED71AB1
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jul 2019 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbfGWOpd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Jul 2019 10:45:33 -0400
Received: from vern.gendns.com ([98.142.107.122]:35634 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732850AbfGWOpd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 23 Jul 2019 10:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OuZctdUUveCDjOVizawYZ+/RE1oqBYnynbzzPf+MOl8=; b=0IgNld4+UjgjRm3pgN/LIyj7UB
        jJ7eayhB6Z81Zqx5kKpW0HvC5qok+wvM4G+cAi5+W7Z5FxQwMhJvK+0dX9Fyh62mFCwzFsUPsDgf+
        rCpSDDMriqtQBQwnn6m15+Rsl8TYsNkGWMFcQciOBJxc0XTGPQwMXP0zOo6PQ4WV2AIU5Lc0ItcBY
        Nyaa+SaDjbJcbXES+lQRT66SAuO1dpNWLCvFCCmds+7PI0TQE8VDvAK4cqKVdNFApXfEPM9X4rTWh
        RNH03l7b2r/qRMx9wfq9sBBhqK06wgYqzc3JaIp4NO4yKuc+pjZMtRL3g5x0HtZq80oxHFiQ5LUfs
        vKjBxGAg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:49700 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hpw2l-009zPy-D8; Tue, 23 Jul 2019 10:45:31 -0400
Subject: Re: [PATCH 3/4] ARM: dts: am33xx: Add nodes for eQEP
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-4-david@lechnology.com>
 <20190723084213.GR5447@atomide.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <af21fd76-7123-b317-896b-bfe18d293325@lechnology.com>
Date:   Tue, 23 Jul 2019 09:45:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190723084213.GR5447@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/23/19 3:42 AM, Tony Lindgren wrote:
> * David Lechner <david@lechnology.com> [190722 15:46]:
>> This adds new nodes for the Texas Instruments Enhanced Quadrature
>> Encoder Pulse (eQEP) module in the PWM subsystem on AM33XX.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   arch/arm/boot/dts/am33xx-l4.dtsi | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
>> index 3b1fb2ba4dff..7fdc2f61c553 100644
>> --- a/arch/arm/boot/dts/am33xx-l4.dtsi
>> +++ b/arch/arm/boot/dts/am33xx-l4.dtsi
>> @@ -1908,6 +1908,15 @@
>>   					status = "disabled";
>>   				};
>>   
>> +				eqep0: eqep@180 {
>> +					compatible = "ti,am3352-eqep";
>> +					reg = <0x180 0x80>;
>> +					clocks = <&l4ls_gclk>;
>> +					clock-names = "fck";
>> +					interrupts = <79>;
>> +					status = "disabled";
>> +				};
>> +
> 
> You probably no longer need to map any clocks here as this> is now a child of the interconnect target module managed
> by ti-sysc driver. I have not checked but probably l4ls_gclk
> is same as clocks = <&l4ls_clkctrl AM3_L4LS_EPWMSS0_CLKCTRL 0>
> already managed by ti-sysc. If so, then just using runtime PM
> calls in any of the child device drivers will keep it enabled.
> 
> If l4ls_gclk is a separate functional clock, then it still
> needs to be managed by the child device driver directly.

The clock is included so that we can get the clock rate for
the timing aspects of the eQEP, not for power management.

I chose to use the "fck" name to be consistent with the
sibling EHRPWM and ECAP nodes that already have the same
bindings for the same clock.
