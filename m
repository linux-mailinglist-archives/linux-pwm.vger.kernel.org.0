Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AAA16B8AD
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2020 06:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBYFDR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Feb 2020 00:03:17 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58394 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYFDQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 00:03:16 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P53C1f053677;
        Mon, 24 Feb 2020 23:03:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582606992;
        bh=pqg8FMYGRN98RoiwIVfqMq71IWxG8ilSU9xMVrDRDU4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WP0isu4kmKs2Xtfsehs+mrAG6MNoAX7JPso+ly2t3q7pNtKR5qxtxpF2a9XKqXd23
         SWDQMjswsCu7KNYGlUmD+McRBqC1NOVXkDqR95mNznN5rUDYYZaCkI6FGnX53p4CWZ
         Kb0Ck8LCIfa1D7sE+S97DA1ElCoMOLj+i429Yspg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P53C6t062869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 23:03:12 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 23:03:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 23:03:12 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P539bC016936;
        Mon, 24 Feb 2020 23:03:10 -0600
Subject: Re: [PATCH 2/4] pwm: omap-dmtimer: Fix pwm enabling sequence
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-3-lokeshvutla@ti.com>
 <20200224084956.wwsnf2y24ragg3vf@pengutronix.de>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <bac78775-4bee-7437-f5ef-3cf85997e7d1@ti.com>
Date:   Tue, 25 Feb 2020 10:32:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200224084956.wwsnf2y24ragg3vf@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 24/02/20 2:19 PM, Uwe Kleine-König wrote:
> On Mon, Feb 24, 2020 at 10:51:33AM +0530, Lokesh Vutla wrote:
>> To configure DM timer is pwm mode the following needs to be set in
>> OMAP_TIMER_CTRL_REG using set_pwm callback:
>> - Set toggle mode on PORTIMERPWM output pin
>> - Set trigger on overflow and match on PORTIMERPWM output pin.
>> - Set auto reload
>>
>> This is a one time configuration and needs to be set before the start of
>> the dm timer. But the current driver tries to set the same configuration
>> for every period/duty cycle update, which is not needed. So move the pwm
>> setup before enabling timer and do not update it in pwm_omap_dmtimer_config.
> 
> Is this change kind of moot with the conversion to .apply in the next
> patch?

Yes, but I didn't want to club it with the conversion to .apply as this is
functional change wrt to the existing driver.

Thanks and regards,
Lokesh
