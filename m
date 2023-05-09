Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8056FC403
	for <lists+linux-pwm@lfdr.de>; Tue,  9 May 2023 12:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbjEIKeU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 May 2023 06:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjEIKeI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 May 2023 06:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FF510A11
        for <linux-pwm@vger.kernel.org>; Tue,  9 May 2023 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683628383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rY0wAhFO0QvQXSIMKQo3/4SZywWKrbnd3LDq+RJ6btQ=;
        b=OiYv/rkhhOV+MA9a57cyIijO1vCpytl9dI1mFQgucXuBmylCdyqPKnZFuZvqge9bmItugD
        wjSZWZw24ZIaW3ApRlc8ff+23bgvQ0SUCPeddSTzEtzgo9dUAQOQDSS4at87kx5ddilwKp
        h+wGT1AjOiUPTQJH7p3FxVVeltGkcEA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-FUWlKzOAP4CCjAg5jxmuvw-1; Tue, 09 May 2023 06:33:01 -0400
X-MC-Unique: FUWlKzOAP4CCjAg5jxmuvw-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-506beab6a73so6537576a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 09 May 2023 03:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683628380; x=1686220380;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rY0wAhFO0QvQXSIMKQo3/4SZywWKrbnd3LDq+RJ6btQ=;
        b=YIxsxML5sEVkXnSIQC9bQPpiQO4DZl5WJAO2iGGbaS+UZJclwgmB3dn/XFw7CSL9q1
         6TJSCc7XgN5TY0G3Q+U6RTzGkwxCp0DU3aE5U7Pn0d/iw5s6KXwPwoUs6LdG2DUyi/Qe
         lugY64yvRZB3tiWoUe6sr3NIBdUTMpXTzjrw0W0GumV+EbULtCH5jVRfQCt6lbRQkZYY
         goeRu1OszdxcFqe4D/S3mG2RoMFeekZ2cSgsDnCq72a/JhGQXkMaXvm3UAFoBwEgRCDT
         Reu/iaetm626fGqGUmUrtjcs32VdA6tFomj4RTO0e+q9TUjtdGNHXnrrtwHDwjSBY3tC
         j1cg==
X-Gm-Message-State: AC+VfDyiPDFeQwZ9hAVMwErdxpLZWbdtWwlef+I0Gwi1e66s8HZ/PCo2
        jzvsgUPSx7S+7O5VJPgYJJoCQwGOtP968+MR71vOuJIOOYtOE0UShEyz06YdwCAYd/HSts+v7As
        YcIEwLg8aCrEVG/vH99mk
X-Received: by 2002:a17:907:a4d:b0:95e:de94:5bea with SMTP id be13-20020a1709070a4d00b0095ede945beamr11586528ejc.56.1683628380814;
        Tue, 09 May 2023 03:33:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ZAQ9eCkaXMHHXerfZzIta4y0/T8ovCZ82gEgyXT6wc8rMWJpmUYK9BAFnT0SZXGRYHhkx1g==
X-Received: by 2002:a17:907:a4d:b0:95e:de94:5bea with SMTP id be13-20020a1709070a4d00b0095ede945beamr11586508ejc.56.1683628380502;
        Tue, 09 May 2023 03:33:00 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v20-20020a170906b01400b0096165b2703asm1153586ejy.110.2023.05.09.03.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 03:33:00 -0700 (PDT)
Message-ID: <a36a760f-6f64-190f-f94b-d30b82b3382e@redhat.com>
Date:   Tue, 9 May 2023 12:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 10/19] platform/x86: lenovo-yogabook: Split probe()
 into generic and WMI specific parts
Content-Language: en-US, nl
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20230430165807.472798-1-hdegoede@redhat.com>
 <20230430165807.472798-11-hdegoede@redhat.com>
 <CAHp75VejjvfjLSsePfhRetEiWTE7ve=uZR87V9MZLET9KG6C1g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAHp75VejjvfjLSsePfhRetEiWTE7ve=uZR87V9MZLET9KG6C1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 5/1/23 11:53, Andy Shevchenko wrote:
> On Sun, Apr 30, 2023 at 7:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Split probe() and remove() into generic and WMI specific parts.
>>
>> This is a preparation patch for making lenovo-yogabook-wmi also work
>> on the Android version of the Yoga Book 1 which does not have a WMI
>> interface to deal with toggling the keyboard half between
>> touch-keyboard and wacom-digitizer mode.
> 
> ...
> 
>> Changes in v2:
>> - Use "return dev_err_probe(...);" in several places to simplify
>>   error-exits in the new yogabook_probe() function
> 
> I'm not sure you have changed previous patches where it makes sense to
> use dev_err_probe().

Actually the 2 cases you point out below are the 2 last regular dev_err()
calls in the probe() path of the driver.

> Neither it's done (in full) here (in case you
> wanted to split replacement to a separate change). See below.
> 
> ...
> 
>> +       data->kbd_adev = acpi_dev_get_first_match_dev("GDIX1001", NULL, -1);
>> +       if (!data->kbd_adev) {
>> +               dev_err(dev, "Cannot find the touchpad device in ACPI tables\n");
>> +               return -ENODEV;
> 
> Here...
> 
>> +       }
>> +
>> +       data->dig_adev = acpi_dev_get_first_match_dev("WCOM0019", NULL, -1);
>> +       if (!data->dig_adev) {
>> +               dev_err(dev, "Cannot find the digitizer device in ACPI tables\n");
>> +               r = -ENODEV;
> 
> ...and here.

Ack I've fixed these both up while merging this series.

Regards,

Hans


