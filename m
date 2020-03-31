Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C731999AC
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2020 17:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgCaPaB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 31 Mar 2020 11:30:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52150 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCaPaB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 31 Mar 2020 11:30:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02VFTppm040271;
        Tue, 31 Mar 2020 10:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585668591;
        bh=kM4Ax6d+vhrMhW72KR5b85pDK4TnudTARv3wYwyWrtg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tetMq0tknzzZpVvEwpJLvt4eXavNQsnpk/tPWI8gD2HeuFdcRq8B90HPDd0c9AnUo
         r5y3L2uK91IUR5AUITDe58qprFonipy2yxgkfjwTD9IsxULnl2jGE+CzTng/PEaW6y
         jLwhD37QPmY68GG+AmWAF/RRa89c8JV1QzJMptOo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02VFTpW0060517;
        Tue, 31 Mar 2020 10:29:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 31
 Mar 2020 10:29:50 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 31 Mar 2020 10:29:50 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02VFTm1v121414;
        Tue, 31 Mar 2020 10:29:48 -0500
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <638d7136-6a74-8069-5331-b2248c948ed4@ti.com>
Date:   Tue, 31 Mar 2020 20:59:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200330141436.GG2431644@ulmo>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On 30/03/20 7:44 PM, Thierry Reding wrote:
> On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-König wrote:
>> On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
>>> Only the Timer control register(TCLR) cannot be updated when the timer
>>> is running. Registers like Counter register(TCRR), loader register(TLDR),
>>> match register(TMAR) can be updated when the counter is running. Since
>>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
>>> timer for period/duty_cycle update.
>>
>> I'm not sure what is sensible here. Stopping the PWM for a short period
>> is bad, but maybe emitting a wrong period isn't better. You can however
>> optimise it if only one of period or duty_cycle changes.
>>
>> @Thierry, what is your position here? I tend to say a short stop is
>> preferable.
> 
> It's not clear to me from the above description how exactly the device
> behaves, but I suspect that it may latch the values in those registers
> and only update the actual signal output once a period has finished. I
> know of a couple of other devices that do that, so it wouldn't be
> surprising.
> 
> Even if that was not the case, I think this is just the kind of thing
> that we have to live with. Sometimes it just isn't possible to have all
> supported devices adhere strictly to an API. So I think the best we can
> do is have an API that loosely defines what's supposed to happen and
> make a best effort to implement those semantics. If a device deviates
> slightly from those expectations, we can always cross fingers and hope
> that things still work. And it looks like they are.
> 
> So I think if Lokesh and Tony agree that this is the right thing to do
> and have verified that things still work after this, that's about as
> good as it's going to get.

Yes this is needed especially in the use-case[0] that I am trying to enable
using PWM. In this case PWM cannot be stopped in between and needs to be updated
dynamically. Also hardware doesn't provide any restrictions on updating the
period. So IMHO, this might be the right thing to do.

Tony did provide tested-by and I measured PWM signals on scope with these
changes. Let me know if any thing else is required?

[0] https://sourceforge.net/p/linuxptp/mailman/message/36943248/

Thanks and regards,
Lokesh

> 
> I know this is perhaps cheating a little, or turning a blind eye, but I
> don't know what the alternative would be. Do we want to tell people that
> a given PWM controller can't be used if it doesn't work according to our
> expectations? That's hard to argue if that controller works just fine
> for all known use-cases.
> 
> Thierry
> 
