Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6286D6F2964
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjD3Pkv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3Pku (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 11:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD991739
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 08:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682869202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQ16pmB1gtE1KSPBErTmJ1zb6H8Xmxi2VyW+gGOxZdw=;
        b=IPdn9t0AXUQR0pMgOjUlQlRzylavdoY/5d2YUDnl/b15yyukJf3tS/cMLpKfzxqCc2BTdG
        ysJMDJz/s7zswzdi8DICCrdwsSC+8lxGP23JGqOer7nEQEsVa+IN4gfN8j691glSighWd+
        gY29NrmuBcqBhfff3BXuxUNIYIZN9dM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-2ZI0TbtHOd68LVgpv_DweA-1; Sun, 30 Apr 2023 11:39:53 -0400
X-MC-Unique: 2ZI0TbtHOd68LVgpv_DweA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355c9028so205860366b.3
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 08:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682869191; x=1685461191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ16pmB1gtE1KSPBErTmJ1zb6H8Xmxi2VyW+gGOxZdw=;
        b=hnfzs4cMHU3TFI/kW2SX9uhBSd8eEepem9i7Y+Ka4WDea5nCkO60v9hI3eOxd8Znnw
         5uV69KlZfQK1hxccw7D5MZT/BD6b++nhBFVL1HjejP50dYFOAXx42aXaA4SUz4HHjrsJ
         8sqkRsqgWDu9tcxDNuM9KtgfAMrOCZTOUzlvGN9MlTuzdn/zIKp0y/yh4MuTq+tTs0Mu
         cOFJ1hsCeeckUq5i7vfB3wp1dv1qN57rZCcjEYg23aSlJkBG9FGuzkPIMcEkG/8w0HCm
         yFubDjMYIuZtP2lOi+hpg1uYZZgnqB7VRdpk31txWqhM/6Pj+CeFmZ2NSdvo0/I/fEtq
         14WQ==
X-Gm-Message-State: AC+VfDxdRZOTxjq5RigR4clbRCpeQYnv+TID4bLwrdNw+ct/SPqHPBJJ
        57ZXPRNQ3UjmuvMcn6UKC2LmvO/kXT760hpw4YAukT4Dj/cGYjhz2rhVH54aCmrkc2CWfR90k2p
        VPVu1ZXvG4FNExK3RL62F
X-Received: by 2002:a17:907:9807:b0:94b:4a4:2836 with SMTP id ji7-20020a170907980700b0094b04a42836mr11939102ejc.69.1682869191769;
        Sun, 30 Apr 2023 08:39:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dJeI8z1d3dV3690wn9/BaNN+x/IpTVnmozRHk5O8lqujWDaTlhkgxjAo7mSAw5ua7zixzBQ==
X-Received: by 2002:a17:907:9807:b0:94b:4a4:2836 with SMTP id ji7-20020a170907980700b0094b04a42836mr11939080ejc.69.1682869191458;
        Sun, 30 Apr 2023 08:39:51 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id jz9-20020a17090775e900b0096152a82ef3sm1629877ejc.213.2023.04.30.08.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Apr 2023 08:39:50 -0700 (PDT)
Message-ID: <44e88d4d-388c-17c6-e1ec-fad7df2cb246@redhat.com>
Date:   Sun, 30 Apr 2023 17:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 17/19] platform/x86: lenovo-yogabook: Add platform driver
 support
Content-Language: en-US, nl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20230429181551.98201-1-hdegoede@redhat.com>
 <20230429181551.98201-18-hdegoede@redhat.com>
 <CAHp75VfCzm+ZS=Q4jmeww_12UeU0YKHFqURBfJiSFX-MxxbFbg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VfCzm+ZS=Q4jmeww_12UeU0YKHFqURBfJiSFX-MxxbFbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Andy,

Thank you for all the reviews.

I agree with all your comments and I will fix them
all for version 2 of this series.


On 4/30/23 12:49, Andy Shevchenko wrote:

<snip>

>> +       r = gpiod_to_irq(data->pen_touch_event);
>> +       if (r < 0) {
>> +               dev_err_probe(dev, r, "Getting pen_touch_event IRQ\n");
>> +               return r;
> 
> return dev_err_probe();
> 
>> +       }
>> +       data->pen_touch_irq = r;
>> +
>> +       r = request_irq(data->pen_touch_irq, yogabook_pen_touch_irq, IRQF_TRIGGER_FALLING,
>> +                       "pen_touch_event", data);
>> +       if (r) {
>> +               dev_err_probe(dev, r, "Requesting backside_hall_sw IRQ\n");
>> +               return r;
> 
> Ditto.

Actually this block has 2 copy and paste errors:

1. The second error message
2. Both "return r;" statements need to be replaced with goto error_put_devs.

I'll fix this both for version 2.

> 
>> +       }
> 
> ...
> 
>> +MODULE_ALIAS("platform:" YB_PDEV_NAME);
> 
> Hmm... Do we need this?

Yes simple platform_drivers like this one typically don't have
a device-id table (they simply match by name) and thus they also
don't have a MODULE_DEVICE_TABLE(platform, ...); statement so
they need an explicit MODULE_ALIAS to correctly auto-load.

Regards,

Hans


> 

