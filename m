Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A14E6183727
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 18:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgCLRPJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 13:15:09 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49094 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgCLRPI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 13:15:08 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02CHEvi2118683;
        Thu, 12 Mar 2020 12:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584033297;
        bh=F1Bl5KRdM8p1lw3n/IaD14JUKZw+gIocUSbFL8V0++U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yuwAX0WVPIo2mKAaXZuNoh0A2oc3iOPOXloIX3p1ONeV9BMBZyFVdh50Oda7HAz9r
         43iycFz2a381YE90mGwTuVq6Ffr6hwa/rFFh1yzxC3KHOo+nd/6pzjeiRJLipdGs70
         iO6nlfes39FPFm16fF/XXOSp8CAxZAUaxWy/RAlk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02CHEvwm123158
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Mar 2020 12:14:57 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Mar 2020 12:14:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Mar 2020 12:14:57 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02CHErSN096128;
        Thu, 12 Mar 2020 12:14:54 -0500
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
To:     Richard Cochran <richardcochran@gmail.com>
CC:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        <kernel@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <f250549f-1e7c-06d6-b2a4-7ae01c06725b@ti.com>
 <20200312084739.isixgdo3txr6rjzg@pengutronix.de>
 <2a5a06cd-7aca-c450-b048-33329d058eca@ti.com>
 <20200312142126.GB2466@localhost>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <b8750b79-8703-5d8f-eacf-b3a67cedd252@ti.com>
Date:   Thu, 12 Mar 2020 22:44:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200312142126.GB2466@localhost>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Richard,

On 12/03/20 7:51 PM, Richard Cochran wrote:
> On Thu, Mar 12, 2020 at 04:14:34PM +0530, Lokesh Vutla wrote:
>> But the problem here is that inactive breaks between two periods is not desired.
>> Because the pwm is used to generate a 1PPS signal and is continuously
>> synchronized with PTP clock.
> 
> The 1-PPS case is the "easy" one.  If the PWM is adjustable on the
> fly, then people will use it with higher frequency signals.

Yes, PWM can be adjusted on the fly. TRM does specify that corresponding
registers(TLDR, TMAR, TCRR) registers can be updated when timer is active.

>  
>> I am up if this can be solved generically. But updating period is very specific
>> to hardware implementation. Not sure what generic solution can be brought out of
>> this. Please correct me if I am wrong.
> 
> What happens today when the PWM frequency or duty cycle are changed
> while the signal is enabled?

Today, PWM is stopped and then period/duty_cycle are updated.

> 
> Do different PWM devices/drivers behave the same way?
> 
> Does this series change the behavior of the am335x and friends?

Yes, this series  is applicable on all TI OMAP2+ devices with DMTIMER.

[0] http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf Section 20.1.1.1 DMTIMER
overview Page 4436.

Thanks and regards,
Lokesh
