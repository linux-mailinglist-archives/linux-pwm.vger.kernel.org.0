Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A938DBC8
	for <lists+linux-pwm@lfdr.de>; Sun, 23 May 2021 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEWQEu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Sun, 23 May 2021 12:04:50 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:52807 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231817AbhEWQEt (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 23 May 2021 12:04:49 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 May 2021 12:04:49 EDT
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id D1FC0440583;
        Sun, 23 May 2021 18:54:26 +0300 (IDT)
References: <70ced827689b7ab35d8f3b07db8d9ccd1489e3e2.1621410526.git.baruch@tkos.co.il>
 <20210522213524.lnb5bds5hvv2f2zi@pengutronix.de>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/3] pwm: driver for qualcomm ipq6018 pwm block
In-reply-to: <20210522213524.lnb5bds5hvv2f2zi@pengutronix.de>
Date:   Sun, 23 May 2021 18:54:08 +0300
Message-ID: <87zgwltpi7.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Thanks for your review comments.

On Sun, May 23 2021, Uwe Kleine-König wrote:
> On Wed, May 19, 2021 at 10:48:44AM +0300, Baruch Siach wrote:
>> Driver for the PWM block in Qualcomm IPQ6018 line of SoCs. Based on
>> driver from downstream Codeaurora kernel tree. Removed support for older
>> (V1) variants because I have no access to that hardware.
>> 
>> Tested on IPQ6010 based hardware.
>> 
>> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

[...]

>> +static void ipq_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>> +{
>> +	struct ipq_pwm_chip *ipq_chip = to_ipq_pwm_chip(pwm->chip);
>> +	unsigned offset = ipq_pwm_reg_offset(pwm, PWM_CFG_REG1);
>> +	unsigned long val;
>> +
>> +	val = readl(ipq_chip->mem + offset);
>> +	val |= PWM_UPDATE;
>
> What is the effect of this register bit?
>
> Does the output become inactive or does it freeze at state that happens
> to be emitted when the ENABLE bit is removed?

I don't know. PWM does not work when this bit is not set here. The
original downstream driver[1] does not set this bit on disable. But it
also enables PWM unconditionally on .config. I added the 'enabled' check
in .config, and then PWM stopped working even when enabled later. It was
only by accident (excess copy/paste) that I found this workaround.

A comment on the original code says that PWM_UPDATE is "auto cleared".
This is evidently not true on my hardware (IPQ6010). This might be true
for older variants of this PWM block. Unfortunately, I have no access to
hardware documentation.

[1] https://source.codeaurora.org/quic/qsdk/oss/kernel/linux-ipq-5.4/tree/drivers/pwm/pwm-ipq.c?h=NHSS.QSDK.11.4.1.r1&id=9e4627b7088b0c06ddd910c8770274d26613de9e

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
