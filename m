Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3EC2A23DA
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Nov 2020 06:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgKBFBw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Nov 2020 00:01:52 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51646 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgKBFBw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Nov 2020 00:01:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A251kgO013816;
        Sun, 1 Nov 2020 23:01:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604293306;
        bh=K02E9Q2eJoit2mw59sTVq8JgZJ/xKtklxtwqLjjQ268=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BpEUXHq/1iHq5a4d+273TJ8VpsxThxJM8NYf4bFkKJJPATEY8MvkB0DWl3BiQrMzk
         OtJ4l5/jqolGe7YB/nCYv7HEljWtp+858ZhSa3lQoQ6qO0npXrNCd6vthGLifnqRal
         jBaPLSAWPK1lgGmwTNhpwsH+kyGTAWGxnvZfIFIc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A251kX2111430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 1 Nov 2020 23:01:46 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sun, 1 Nov
 2020 23:01:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sun, 1 Nov 2020 23:01:46 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A251hgt076290;
        Sun, 1 Nov 2020 23:01:44 -0600
Subject: Re: [PATCH] pwm: lp3943: Dynamically allocate pwm chip base
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
References: <20201030134135.28730-1-lokeshvutla@ti.com>
 <20201030201117.x5asfjxh7htwv35s@pengutronix.de>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <d1c0467a-f64e-fac5-54fa-e62ac8c5f448@ti.com>
Date:   Mon, 2 Nov 2020 10:31:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201030201117.x5asfjxh7htwv35s@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 31/10/20 1:41 am, Uwe Kleine-König wrote:
> On Fri, Oct 30, 2020 at 07:11:35PM +0530, Lokesh Vutla wrote:
>> When there are other pwm controllers enabled along with pwm-lp3943,
>> pwm-lp3942 is failing to probe with -EEXIST error. This is because
>> other pwm controller is probed first and assigned pwmchip 0 and
>> pwm-lp3943 is requesting for 0 again. In order to avoid this, assign the
>> chip base with -1, so that id is dynamically allocated.
>>
>> Fixes: af66b3c0934e ("pwm: Add LP3943 PWM driver")
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> Reviewed-by: Uwe Kleine-König <u.kleine-könig@pengutronix.de>

Thanks.

> 
> With this patch applied only the pwm-ab8500 driver is left not using -1
> for base.

pwm-ab8500 is assigning ab8500->chip.base as pdev->id. At least in the DT case
pdev->id is always -1(as of today). So, base is being allocated dynamically in
case of DT.

Thanks and regards,
Lokesh

> 
> Best regards
> Uwe
> 
