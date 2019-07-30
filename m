Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8127AC62
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2019 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbfG3P2O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jul 2019 11:28:14 -0400
Received: from vern.gendns.com ([98.142.107.122]:41606 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbfG3P2O (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 30 Jul 2019 11:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D1cCKbBJLkaeJdKkx3868DjQ1Exc5f5bo+iv777eCxM=; b=oMplsA8uNa2qIKzbHTIzvrjLHu
        iKNy3P0r1uBI1xJ1VmdzMQgorZddjJQ9g6ARWgJilPRIG5wZiD25Pk/n55nQbwj3YP7HOFIAvXWOu
        uMdNvVQH0FvUUbQ/QM438RIbLsbr6ZfE7CLyNKwVkJI87xEXzUOZ58wX6paoIc8zDy7LmxUDWjn8i
        wwYdFlpoadsErKsRjDieagqDq+SXaEXNNZJu93CjkmhW4I84hSvkcI+nqyrgE9s3HBn82lSNIFQhm
        Lhz2j/mqJKMVdzrDdWYtzQMJKPcEObd+aSly9uo8oqRRjm7HUIu+pLOo3sp5MyGosQJQ9keL2Ydkm
        UYMbmWoQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:57832 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hsU2t-00G8iR-1G; Tue, 30 Jul 2019 11:28:11 -0400
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com>
 <20190730123523.cjtmr3tpttn6r3pt@pengutronix.de>
From:   David Lechner <david@lechnology.com>
Message-ID: <58ef00df-4d99-f4f2-0eda-01db2afe5502@lechnology.com>
Date:   Tue, 30 Jul 2019 10:28:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730123523.cjtmr3tpttn6r3pt@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 7/30/19 7:35 AM, Uwe Kleine-König wrote:
> On Mon, Jul 22, 2019 at 10:45:36AM -0500, David Lechner wrote:
>> This adds a new counter driver for the Texas Instruments Enhanced
>> Quadrature Encoder Pulse (eQEP) module.
>>
>> Only very basic functionality is currently implemented - only enough to
>> be able to read the position. The actual device has many more features
>> which can be added to the driver on an as-needed basis.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---
>>   MAINTAINERS               |   6 +
>>   drivers/counter/Kconfig   |  12 ++
>>   drivers/counter/Makefile  |   1 +
>>   drivers/counter/ti-eqep.c | 381 ++++++++++++++++++++++++++++++++++++++
>>   drivers/pwm/Kconfig       |   2 +-
> 
> It's not obvious why the change to drivers/pwm/Kconfig is needed. Can
> you please motivate that in the change log?

Will do. The short version is that it is needed for power management.

> 
> Best regards
> Uwe
> 

