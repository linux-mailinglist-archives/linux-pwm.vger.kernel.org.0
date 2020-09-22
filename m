Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB827410A
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Sep 2020 13:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIVLhE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Sep 2020 07:37:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45934 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgIVLhD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Sep 2020 07:37:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08MBamS7113201;
        Tue, 22 Sep 2020 06:36:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600774608;
        bh=ld3vYC0kWkXR/z2w5WEX+jmQfpiHTi9KtNWEfTWxkxA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aoqNyr+rCe46BR+SfRZoyMr8YYfuA5vR9gPlhXw/ccUNa7mDrVehyH+FWgL1MEFMv
         Lf7RRP/Aoi0Bj2ziIFR6RdbDu1xVMg8+ZV/Enok+EepcoubHUSLp+TtnjvKkM44MYL
         B9HRop2MT/71r2hqWDGsZX1+mkDYrwCI1VKzlg0U=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08MBamkK064472;
        Tue, 22 Sep 2020 06:36:48 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Sep 2020 06:36:48 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Sep 2020 06:36:48 -0500
Received: from [10.250.35.164] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08MBal3X004763;
        Tue, 22 Sep 2020 06:36:47 -0500
Subject: Re: [PATCH] MAINTAINERS: move Milo Kim to credits
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>, Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20200921210233.21449-1-krzk@kernel.org>
 <20200921210610.GA5338@amd>
 <CAJKOXPdwQc86H-S=C4v_1VCbd7RhC2Soepj_2LqG1e_E_bgAug@mail.gmail.com>
 <20200922093637.GK4792@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <346f2ecd-a015-7f26-b68d-10cf6b5343b6@ti.com>
Date:   Tue, 22 Sep 2020 06:36:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922093637.GK4792@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

All

On 9/22/20 4:36 AM, Mark Brown wrote:
> On Tue, Sep 22, 2020 at 09:08:37AM +0200, Krzysztof Kozlowski wrote:
>> On Mon, 21 Sep 2020 at 23:06, Pavel Machek <pavel@ucw.cz> wrote:
>>> I believe normal way would be to mark the entries "orphaned", not to
>>> drop them altogether. Plus, I believe someone from TI is likely to
>>> step up.
>> These are entries for specific drivers so they are covered by the
>> subsystem maintainers. You believe someone will step up, I believe if
>> these were important for TI, they would find the person some time ago,
>> so the emails won't bounce... This was similar with BQ chargers where
> It's fairly common for mobile parts to get dropped relatively quickly as
> the technology moves fairly quickly in that market, I think a lot of teh
> parts that Milo was working on were mobile ones.

These specific drivers don't see many patches applied to them. These 
drivers did have a few patches this year to fix random bugs.

Since I have worked in these other subsystems if replacing the 
Maintainer is desired over removal then my name and email can be added 
like I did with Andrews.

Dan Murphy <dmurphy@ti.com>

Dan

