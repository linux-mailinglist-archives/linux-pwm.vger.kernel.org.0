Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE50E5EC5A4
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Sep 2022 16:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiI0ONt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 27 Sep 2022 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbiI0ONm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 27 Sep 2022 10:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3854B1BA3A5
        for <linux-pwm@vger.kernel.org>; Tue, 27 Sep 2022 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664288020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HKGdAdKWhJTx/Xv7Sz8bsLwa+ZuDoj3wym0zFd3EU8g=;
        b=PUjKZTCIzPgodewD2xdE7EWidzp+P8Oa4FpZjIMdthPCTKeRSnz1/R9DT/B2kOvHdZY8pp
        6SJtxeL0BHwfULWNIetqWZfoL5ddS2sb6gPjL/lULw8Okfed80bGaOZvwpnpUQYxImpaUn
        dinNFUsneR+0I4Gu8x/9pfBHlKGpV/0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-467-RDqp1UDHM9usMbENWT2LNg-1; Tue, 27 Sep 2022 10:13:37 -0400
X-MC-Unique: RDqp1UDHM9usMbENWT2LNg-1
Received: by mail-ed1-f71.google.com with SMTP id r11-20020a05640251cb00b004516feb8c09so7876752edd.10
        for <linux-pwm@vger.kernel.org>; Tue, 27 Sep 2022 07:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HKGdAdKWhJTx/Xv7Sz8bsLwa+ZuDoj3wym0zFd3EU8g=;
        b=iovIdCifzuo9qS3vEw8njkkPx6/074HwGW12g+uSGyG6FGExMRkpThVSzBPgWUjWsG
         /wtkoVVlIvPUCCteL0WH5FGvuDINOwfgqX40ww3DfHpvZWD1P57oMWJS1OeTlLXPlfD6
         smC3ZDXW2Vz3xVV8aUnBNYqth7h4pFTZzc7+Uah7poEBO0bdrHpyWSPaIgv72kaQBNXE
         jFlBlBYX8LHdJzcmHnFaU/vKAa+4GRpPDDe7eoQ1wHjVctLXJKdXiW/RFCmT7LnNAqLE
         9f7RjHJD6z4cOb88NO57Idsl1gkYT2WLAlhj4wxVb3NrC2a80tf86gPmz2qNEWnltHA2
         ewXQ==
X-Gm-Message-State: ACrzQf1MaRGFogDmNqw5g4LP8kzHd6wNoo4Yq2dOScPrEozzqXiRXcJJ
        K/32ExiQnTdU3iUOcYdzzo3P14ucR7At2RzmeC2uVgo5xnsRYUOs11rJDL/zZZLZ9QB6Z492Vai
        DvjN0J1A//Ia4+1xa+ZmN
X-Received: by 2002:a05:6402:849:b0:453:10c3:2ee3 with SMTP id b9-20020a056402084900b0045310c32ee3mr28141357edz.339.1664288015986;
        Tue, 27 Sep 2022 07:13:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM48+iUYPej+zslJBIkvtvG5lG69A/kb6fiPhXTmUhm+OZkn3tzqFE7c8bbmgOMXiyaun4ITGg==
X-Received: by 2002:a05:6402:849:b0:453:10c3:2ee3 with SMTP id b9-20020a056402084900b0045310c32ee3mr28141345edz.339.1664288015785;
        Tue, 27 Sep 2022 07:13:35 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id a26-20020a170906369a00b0077fc47605b4sm857235ejc.217.2022.09.27.07.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:13:35 -0700 (PDT)
Message-ID: <04a42b71-27ad-7bcd-a270-5c342f764b77@redhat.com>
Date:   Tue, 27 Sep 2022 16:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 0/9] pwm: lpss: Clean up and convert to a pure library
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>
References: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220908135658.64463-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 9/8/22 15:56, Andy Shevchenko wrote:
> First of all, a set of cleanups and code deduplications (for better
> maintenance) to the PWM LPSS driver.
> 
> Second, we may (re-)use the core part as a library in the future in
> the devices that combine the same PWM IP in their address space. So
> convert the core file to be a pure library which doesn't require any
> special resource handling or alike.
> 
> Changelog v2:
> - replace patch 1 by Uwe's version (Uwe)
> - update NS patch to have a default namespace defined (Uwe)
> - describe all changes done in patch 4 (Uwe)
> 
> Andy Shevchenko (8):
>   pwm: lpss: Move exported symbols to PWM_LPSS namespace
>   pwm: lpss: Move resource mapping to the glue drivers
>   pwm: lpss: Include headers we are direct user of
>   pwm: lpss: Use device_get_match_data to get device data
>   pwm: lpss: Use DEFINE_RUNTIME_DEV_PM_OPS() and pm_ptr() macros
>   pwm: lpss: Make use of bits.h macros for all masks
>   pwm: lpss: Add a comment to the bypass field
>   pwm: lpss: Allow other drivers to enable PWM LPSS
> 
> Uwe Kleine-König (1):
>   pwm: lpss: Deduplicate board info data structures
> 
>  drivers/pwm/pwm-lpss-pci.c                 | 48 +++++-----------------
>  drivers/pwm/pwm-lpss-platform.c            | 40 +++++-------------
>  drivers/pwm/pwm-lpss.c                     | 46 ++++++++++++++++++---
>  drivers/pwm/pwm-lpss.h                     | 22 ++++------
>  include/linux/platform_data/x86/pwm-lpss.h | 33 +++++++++++++++
>  5 files changed, 101 insertions(+), 88 deletions(-)
>  create mode 100644 include/linux/platform_data/x86/pwm-lpss.h

Uwe, thank you for Cc-ing me.

Andy, thank you for the patches.

The entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

