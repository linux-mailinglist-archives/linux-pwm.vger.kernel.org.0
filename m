Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E86517B7C0
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Mar 2020 08:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgCFHwI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 6 Mar 2020 02:52:08 -0500
Received: from uho.ysoft.cz ([81.19.3.130]:35880 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgCFHwI (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 6 Mar 2020 02:52:08 -0500
X-Greylist: delayed 499 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Mar 2020 02:52:07 EST
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id E1D0DA09A2;
        Fri,  6 Mar 2020 08:43:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1583480626;
        bh=VQ2yfrk082krOOc+X5xfsM6cnf+28cUcXlzWreCfHzg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CmpXh/XC8gLmgngZR43hA84rY5noqvaYDPq46k5cw1ETsCmylpKOQD5RDLBkCPJT4
         YoWJqGnKWxca6t2AV7ADR0WmhOh6lxe0EAbsPU/ANudHdAvo0G7gd2rMO4bwJP8is/
         GUwZ/RTuRLXHp4Y9ST+r6z6HPpCw65jl8tZN5QNY=
Subject: Re: Inverted PWM output on iMX6
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Paul Barker <pbarker@konsulko.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200305132232.1aced378@ub1910>
 <20200305133649.bx7r7d4ntwi75qqb@pengutronix.de>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <619c279c-5dd7-8d81-3527-dc37f8827104@ysoft.com>
Date:   Fri, 6 Mar 2020 08:43:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200305133649.bx7r7d4ntwi75qqb@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 05. 03. 20 14:36, Uwe Kleine-König wrote:
> Hello,
> 
> On Thu, Mar 05, 2020 at 01:22:32PM +0000, Paul Barker wrote:
>> I recently ran into an issue using the pwm-fan driver with an inverted
>> PWM output on iMX6.
>>
>> The fan is defined in the device tree as follows:
>>
>> 	fan0: pwm-fan {
>> 		compatible = "pwm-fan";
>> 		pwms = <&pwm2 0 25000 PWM_POLARITY_INVERTED>;
>> 		...
>> 	}
>>
>> In pwm_imx27_probe() the support for a third `flags` argument in a pwm
>> reference is enabled:
>>
>> 	imx->chip.of_xlate = of_pwm_xlate_with_flags;
>> 	imx->chip.of_pwm_n_cells = 3;
>>
>> However, the flag is ignored and the output is not inverted.
>>
>> By adding some prints I saw that when of_pwm_xlate_with_flags() is
>> called, args->args_count is 2 instead of 3.
>>
>> Looking at the definition of the pwm device itself in imx6qdl.dtsi I
>> can see that the number of cells in a pwm reference is set to 2 not 3:
>>
>> 	pwm2: pwm@2084000 {
>> 		#pwm-cells = <2>;
>> 		...
>> 	};
>>
>> That seems to be preventing a third argument from being passed.
>>
>> I can change `#pwm-cells` to <3> and then everything works for my
>> device but I'm not sure that is the correct solution for everyone. That
>> would require all pwm references on iMX6 devices to use 3 cells. The
>> code in of_pwm_xlate_with_flags() seems to be built to handle either 2
>> or 3 argument cells but I can't see any way to allow this choice in the
>> device tree.
>>
>> If the solution is to set `#pwm-cells` to <3> I'm happy to send a patch
>> which does this and updates all pwm references in device trees which
>> include `imx6dql.dtsi`. Before I do that I'd like to know that it's the
>> correct approach though.
>>
>> For context I've confirmed this is the case in Linux 5.4 and that the
>> relevant files haven't changed between that release and 5.6.0-rc4.
> 
> I think changing that is fine. However you'd have to care that all
> in-tree users that rely on #pwm-cells = <2> are fixed accordingly.
> 
> I'd do: add #pwm-cells = <3> in the cpu.dtsi and then adapt all
> machine.dts to add #pwm-cells = <2> until there are no more changes to
> the generated files compared to the current state.

I solved that in the past on our board the same way as other imx6 boards
did. Just override the #pwm-cells property in your board specific devicetree
and you are fine:

   linux-src$ git grep pwm-cells -- arch/arm/boot/dts/imx6*-*
   arch/arm/boot/dts/imx6dl-yapp4-common.dtsi:     #pwm-cells = <3>;
   arch/arm/boot/dts/imx6q-display5.dtsi:  #pwm-cells = <3>;
   arch/arm/boot/dts/imx6q-mccmon6.dts:    #pwm-cells = <3>;
   arch/arm/boot/dts/imx6qdl-tx6.dtsi:     #pwm-cells = <3>;
   arch/arm/boot/dts/imx6qdl-tx6.dtsi:     #pwm-cells = <3>;
   arch/arm/boot/dts/imx6ul-tx6ul.dtsi:    #pwm-cells = <3>;
   arch/arm/boot/dts/imx6ull-colibri.dtsi: #pwm-cells = <3>;
   arch/arm/boot/dts/imx6ull-colibri.dtsi: #pwm-cells = <3>;
   arch/arm/boot/dts/imx6ull-colibri.dtsi: #pwm-cells = <3>;
   arch/arm/boot/dts/imx6ull-colibri.dtsi: #pwm-cells = <3>;

Michal
