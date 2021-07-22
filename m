Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD03D21BD
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jul 2021 12:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhGVJ2V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 22 Jul 2021 05:28:21 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:39339 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhGVJ2U (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Jul 2021 05:28:20 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 5C872440E85;
        Thu, 22 Jul 2021 13:08:38 +0300 (IDT)
References: <f79128fa287e37ee59cb03ae04b319ecb3d68c29.1626176145.git.baruch@tkos.co.il>
 <1173e7b0b58730fd187871d9e14a02cab85158cc.1626176145.git.baruch@tkos.co.il>
 <20210714201839.kfyqcyvowekc4ejs@pengutronix.de> <87eebyst5z.fsf@tarshish>
 <20210716070427.kv7w6imp2zoxhyz5@pengutronix.de>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, Robert Marko <robert.marko@sartura.hr>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Balaji Prakash J <bjagadee@codeaurora.org>
Subject: Re: [PATCH v5 2/4] pwm: driver for qualcomm ipq6018 pwm block
In-reply-to: <20210716070427.kv7w6imp2zoxhyz5@pengutronix.de>
Date:   Thu, 22 Jul 2021 13:08:47 +0300
Message-ID: <87k0lizmmo.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Fri, Jul 16 2021, Uwe Kleine-König wrote:
> On Fri, Jul 16, 2021 at 08:51:20AM +0300, Baruch Siach wrote:
>> On Wed, Jul 14 2021, Uwe Kleine-König wrote:
>> > On Tue, Jul 13, 2021 at 02:35:43PM +0300, Baruch Siach wrote:
>> >> +	val = FIELD_PREP(IPQ_PWM_REG0_HI_DURATION, hi_dur) |
>> >> +		FIELD_PREP(IPQ_PWM_REG0_PWM_DIV, pwm_div);
>> >> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG0, val);
>> >> +
>> >> +	val = FIELD_PREP(IPQ_PWM_REG1_PRE_DIV, pre_div);
>> >> +	ipq_pwm_reg_write(pwm, IPQ_PWM_CFG_REG1, val);
>> >> +
>> >> +	/* Enable needs a separate write to REG1 */
>> >> +	val |= IPQ_PWM_REG1_UPDATE;
>> >
>> > Setting this bit results in the two writes above being configured
>> > atomically so that no mixed settings happen to the output, right?
>> 
>> I guess so. I have no access to hardware documentation, mind you. I
>> first tried to do only one write to REG1, but it had no effect. The
>> existence of the UPDATE bit also indicates that hardware works as you
>> suggest.
>
> I wouldn't trust HW documentation here. If you have some means to
> inspect the waveform this is easy to test. Depending on how long you can
> make the periods an LED is enough. If you start with a slower parent
> clk, a big pre_div and hi_dur = 0 the LED is supposed to be off. Then
> set hi_dur = pwm_div/2 which either make the LED blink slowly or keeps
> off. Then setting pre_div = 2 either increased the blink frequency or it
> doesn't. ...

I currently have only access to DVM to measure the PWM effect. I'll try
to do more measures when I have access to better equipment.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
