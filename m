Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF93D528C
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 06:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhGZDv3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 25 Jul 2021 23:51:29 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:46674 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhGZDv2 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 25 Jul 2021 23:51:28 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 7EC644400D8;
        Mon, 26 Jul 2021 07:31:43 +0300 (IDT)
References: <889aae1b88f120cb6281919d27164a959fbe69d0.1626948070.git.baruch@tkos.co.il>
 <2c4df635c57085fc33150d1b9a97845694e63e03.1626948070.git.baruch@tkos.co.il>
 <YP2u9Hz2/+av6JLG@yoga>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 2/4] pwm: driver for qualcomm ipq6018 pwm block
In-reply-to: <YP2u9Hz2/+av6JLG@yoga>
Date:   Mon, 26 Jul 2021 07:31:55 +0300
Message-ID: <87czr5wv9g.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bjorn,

On Sun, Jul 25 2021, Bjorn Andersson wrote:
> On Thu 22 Jul 05:01 CDT 2021, Baruch Siach wrote:
>> +	if (IS_ERR(pwm->clk))
>> +		return dev_err_probe(dev, PTR_ERR(pwm->clk),
>> +				"failed to get core clock");
>> +
>> +	ret = clk_prepare_enable(pwm->clk);
>
> Not sure if Uwe asked you this already, but do you need to clock the
> supply even when the PWM isn't enabled?

I guess not. However, tracking clock enable/disable per PWM signal
complicates the code. We'd need to balance enables with matching
disables in the .remove callback. I'd prefer to leave that as room for
future optimization.

>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "clock enable failed");
>> +
>> +	pwm->chip.dev = dev;
>> +	pwm->chip.ops = &ipq_pwm_ops;
>> +	pwm->chip.npwm = 4;
>> +
>> +	ret = pwmchip_add(&pwm->chip);
>
> Depending on above answer you may or may not have the need to ensure the
> ordering of clk_disable_unprepare() in the remove function.

According to Uwe pwmchip_remove() must precede clock disable:

  https://lore.kernel.org/linux-arm-msm/20210714201839.kfyqcyvowekc4ejs@pengutronix.de/

How is that related to per PWM signal clock handling?

> Otherwise devm_pwmchip_add() would be nice here.

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
