Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF0916B8AC
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2020 06:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgBYFDB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Feb 2020 00:03:01 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46792 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYFDA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 00:03:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P52unl104021;
        Mon, 24 Feb 2020 23:02:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582606976;
        bh=uw9P8mRUCHvHKE75vpNXsxCie2ihNA0bQ8oCR087XQ4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fbYtx216xi41UFtgovgPqBmhrzG4S80gck8+pz9HCizsCvYyvgf3HRuWRIIWAgt2P
         fVyV3jwmduxNjxXWAWGLG86fGPwv5TjK6az2s6OteyebRx0x9iBTxYh7rDnYwQX3Od
         8XFexeBljnlstBXMvhmtjfBktYnBgpmLysIF7s0c=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P52uVt075683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 23:02:56 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 23:02:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 23:02:55 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P52rCP016151;
        Mon, 24 Feb 2020 23:02:53 -0600
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: Drop unused header file
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-2-lokeshvutla@ti.com>
 <20200224075302.jd3vcrdl6fuqrkpb@pengutronix.de>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <ca33326e-22c8-e57b-c5fe-900f4749e640@ti.com>
Date:   Tue, 25 Feb 2020 10:32:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200224075302.jd3vcrdl6fuqrkpb@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 24/02/20 1:23 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Feb 24, 2020 at 10:51:32AM +0530, Lokesh Vutla wrote:
>> @@ -190,9 +190,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>>  		load_value, load_value,	match_value, match_value);
>>  
>>  	omap->pdata->set_pwm(omap->dm_timer,
>> -			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
>> -			      true,
>> -			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
>> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
>> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> 
> This is unrelated.

PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE is deleted along with header file
and used OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE. I should have mentioned this
in my commit description. Will fix it in v2.

Thanks and regards,
Lokesh
