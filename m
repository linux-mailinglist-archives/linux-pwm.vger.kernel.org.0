Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A833D5234
	for <lists+linux-pwm@lfdr.de>; Mon, 26 Jul 2021 06:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhGZD2L (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 25 Jul 2021 23:28:11 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:46620 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230321AbhGZD2K (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 25 Jul 2021 23:28:10 -0400
Received: from tarshish (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 38D2A440E57;
        Mon, 26 Jul 2021 07:08:24 +0300 (IDT)
References: <889aae1b88f120cb6281919d27164a959fbe69d0.1626948070.git.baruch@tkos.co.il>
 <70f0522a9394e9da2f31871442d47f6ad0ff41aa.1626948070.git.baruch@tkos.co.il>
 <YP2tAR+zZgJZQOgG@yoga>
User-agent: mu4e 1.4.15; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Balaji Prakash J <bjagadee@codeaurora.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Kathiravan T <kathirav@codeaurora.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/4] dt-bindings: pwm: add IPQ6018 binding
In-reply-to: <YP2tAR+zZgJZQOgG@yoga>
Date:   Mon, 26 Jul 2021 07:08:36 +0300
Message-ID: <87h7ghwwcb.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Bjorn,

On Sun, Jul 25 2021, Bjorn Andersson wrote:
> On Thu 22 Jul 05:01 CDT 2021, Baruch Siach wrote:
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: core
>
> With a single clock, it's nice to skip the -names.

I find it nicer and better for forward compatibility with hardware
variants the might introduce more clocks.

Are there any downsides to -names?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
