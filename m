Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5CA455C7B
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 14:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhKRNWn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Nov 2021 08:22:43 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:21601 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhKRNWn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Nov 2021 08:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637241583; x=1668777583;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yIrZAo54rZ3DAXexqyAzLPHQ4ztCKoEXIwr7Mfa6QpU=;
  b=JIHjIMhpDHHkH0XC7ALmSHLybWK3e8N6J9w9+HZcyjVWf5q7rV98gWwE
   o7a9BNOPbHy3MDMWtmwOjjEqkZ5wIeKAFDlJQ4wd8cF71nrpd2zzXof48
   yBiyeVVemsbauRNis4zuFfGDSyp8jfhfjfDFjhQxlkUs+w4pKXAXNIA9X
   T8M3bIJQXZvHgVLfgT/jjON5EnTpRz+ifrbMYlFRbihUc8hoEDYZ3LY/j
   3qaRH1vw7M/X2z7FemwAXWh0B4qfXMwPZmVea5Vn0mlA2SjbczB+CScix
   X74Fwcl9ISGXF3v0/RZC2nkkmvQSGGntRGfHrjccGBstAjo5XFZrXAfow
   w==;
IronPort-SDR: IgVHdGdfN1vVE4ffD2slPPBESiLzb50BsRLXZ1vbwPtJzki5NKZtj7t/btsxz9Vzr4YtG7xR0V
 idpv5knBfdIE61wwX7BPZKOjYs8kWbchVcCcicc51Hnf/GFQaegxYMRCEBAja99a/qP43oPtja
 qurioZdQE2pezYF2HMO5vI6NLb/G/1kfdvll3u2Own4JjJaWta/M6ufhx73uACjj/XeXdxZiRD
 9vhBY2aK4voqp2XgdnHiYg6KhpHwUsCx6cQVTPyjemNrC11mF2deZXNGn7r2IW3r6+DRJAe5tA
 MpCc+0gH9UBXnesaQWjxNElr
X-IronPort-AV: E=Sophos;i="5.87,244,1631602800"; 
   d="scan'208";a="139575941"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2021 06:19:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 06:19:42 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 18 Nov 2021 06:19:39 -0700
Subject: Re: [PATCH] pwm: Use div64_ul instead of do_div
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     <cgel.zte@gmail.com>, <linux-pwm@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, Zeal Robot <zealci@zte.com.cn>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
        <thierry.reding@gmail.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        <lee.jones@linaro.org>, <linux-arm-kernel@lists.infradead.org>
References: <20211117020426.159242-1-deng.changcheng@zte.com.cn>
 <20211117112400.bkscb2pyavonpfsn@pengutronix.de>
 <YZYmZecp8WPkFY2F@shell.armlinux.org.uk>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <a9a62f9d-7227-0421-e36f-44222b79bbe7@microchip.com>
Date:   Thu, 18 Nov 2021 14:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YZYmZecp8WPkFY2F@shell.armlinux.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 18/11/2021 at 11:09, Russell King (Oracle) wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Wed, Nov 17, 2021 at 12:24:00PM +0100, Uwe Kleine-König wrote:
>> Hello,
>>
>> On Wed, Nov 17, 2021 at 02:04:26AM +0000, cgel.zte@gmail.com wrote:
>>> From: Changcheng Deng <deng.changcheng@zte.com.cn>
>>>
>>> do_div() does a 64-by-32 division. If the divisor is unsigned long, using
>>> div64_ul can avoid truncation to 32-bit.
>>
>> After some research I understood your commit log. I'd write:
>>
>>        do_div() does a 64-by-32 division. Here the divsor is an
>>        unsigned long which on some platforms is 64 bit wide. So use
>>        div64_ul instead of do_div to avoid a possible truncation.
>>
>> The priority of this patch seems to be low, as the device seems to exist
>> only on (32bit) arm.
> 
> ... where unsigned long is 32-bit.
> 
> In any case, for this to overflow, we would need to have a clock in
> excess of 2^32-1 Hz, or around 4GHz - and if we had such a situation
> on 32-bit devices, we need to change the type for holding the frequency
> in the clk API, and probably a lot of code in the CCF as well.
> 
> Unless there is a real reason for this change, I would suggest leaving
> the code as is - there is absolutely no point in making these divisions
> more expensive unless there is a real reason.

Thanks for the technical demonstration Russell. With this in mind:
NACK to the patch, sorry Changcheng Deng.

Best regards,
   Nicolas


-- 
Nicolas Ferre
