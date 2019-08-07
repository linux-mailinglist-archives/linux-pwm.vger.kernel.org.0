Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB51385418
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Aug 2019 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbfHGTtL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Aug 2019 15:49:11 -0400
Received: from vern.gendns.com ([98.142.107.122]:45794 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbfHGTtL (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Aug 2019 15:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Nst5tJBgYXLQSuO9ejqLVN2tX7w6xuinsTrxMZni18Y=; b=F12ywx4OqcdCCr+52KzFFqojPP
        TvrXyYp7ya2oHkQUMdz9hzWp8XjT56wMs6V/qGogeJ3Nr+UUPX84DvMUPXWjObF7bBppZ56C+tmo1
        5cacL+W4/mloc5Dmyy6Rqbc8HIOZKMHl0Q+xC2UthTqopxx9uZhXbu0liGIpMehSAHdrdDdwIa3e1
        6c7pL3m2XXrXJA2Fprc/DS1r6jSWVV92kw8Gs7swIT3SvA1bw3ilgatTs3Y1Ym3w5HFP+oOqv6M53
        Ajo4clGgDEg54z2a+AUgjSEY/S1HvFbw7L8DV1ykUelg6iVfX078vjKXnJsiXGmayl6KxCyNytUFt
        iskpBEIg==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:60448 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1hvRvp-0001Kq-1z; Wed, 07 Aug 2019 15:49:09 -0400
Subject: Re: [PATCH v2 3/5] counter: new TI eQEP driver
To:     linux-iio@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <20190807194023.15318-1-david@lechnology.com>
 <20190807194023.15318-4-david@lechnology.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <73c4b228-e3d0-ecb0-21b7-6101587481b3@lechnology.com>
Date:   Wed, 7 Aug 2019 14:49:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807194023.15318-4-david@lechnology.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 8/7/19 2:40 PM, David Lechner wrote:
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 2967d0a9ff91..7eeb310f0cda 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -49,6 +49,18 @@ config STM32_LPTIMER_CNT
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called stm32-lptimer-cnt.
>   
> +config TI_EQEP
> +	tristate "TI eQEP counter driver"
> +	depends on (SOC_AM33XX || COMPILE_TEST)
> +	select PWM

oops, missed removing `select PWM`. This line is no longer needed with
patch 1/5.

> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable the Texas Instruments Enhanced Quadrature
> +	  Encoder Pulse (eQEP) counter driver.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ti-eqep.
> +
>   config FTM_QUADDEC
>   	tristate "Flex Timer Module Quadrature decoder driver"
>   	depends on HAS_IOMEM && OF
