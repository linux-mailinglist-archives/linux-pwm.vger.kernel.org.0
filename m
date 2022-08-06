Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1927158B4FA
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Aug 2022 12:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241828AbiHFKNL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 6 Aug 2022 06:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbiHFKNK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 6 Aug 2022 06:13:10 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644CE12A85;
        Sat,  6 Aug 2022 03:13:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l5so3608433qtv.4;
        Sat, 06 Aug 2022 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ttq6QinxlR7vBVHSYKBIHVkzo4vQSNEdnsdW+MZYFzk=;
        b=Q2lrq61/x+XePRmwi+dFaRoJHTONUwb7FRSUg2aR4SXGUD4p7Q1wrb/U4STBu8yCuO
         Hcy8HEUKBm1VC6oigCAD6KR8ThJMKKlcbNuCt6SwQKYXfub9rKqxBf0O24ycTTwvNa7l
         lpdpu4ZjPNx9KbBVQTBlt8XvndrpvzvSmk09My54DP1Tn45VcwqIoBebEPCQkcXQsl/m
         yoTgbh3m8Zybyk9LYR1MpZ6+lyj8JJamzpvMzuC0HdR2juXX5yrC31UfLApp61rgGAqB
         oqf4Yjr4C7ZhToM38m+pAbTfVfuc7h72dFFK5FD1NQM133C7S5uYhpySpWDHjBzt8CEB
         gJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ttq6QinxlR7vBVHSYKBIHVkzo4vQSNEdnsdW+MZYFzk=;
        b=p1p4hrD+IzaXzxKUblGH50//4o1vM65Dk8HUKykEj3caLPfYeaz8sJVKsnFKyQC5M2
         YCAbjZ2Y6i5E7wjbzrV2ThJ9tW0gYyKlMsjVRUputmK1QwWRDO1GuZ+b2G50JIJtCujE
         zj+J4+YJ+jb9Gp7ZFxMQMGjlki2Xxv7onMEaBNyyyfoT9BCMbKbo/9q/CKUoSTFqah4z
         vpKC/S6RyV1z1N8mOVCpGw9mrc/+pBguHUVpWlI2Y7swjnPUIfFtOo668QEbbUSv1OoL
         2JO83JJcL5gPOoDHzZyj+q0csN95cNesd3r76YbVzV0nQ9SiCb/b80A46ARvmebisYpO
         PXng==
X-Gm-Message-State: ACgBeo3sMEbDCAmsA0C/nbnvUVUtsQVz0DYCYsoV4jx+ZPN/8vAAHadr
        dtqF0HAMFwb+27q8/72h/STE0yoXv4DwSD5PwvZe96x9jWk=
X-Google-Smtp-Source: AA6agR50eTyZtmmu7iRBscv0mN2ZXzfFOaZzyF50MOpKbPo3ARwQzImzvckBILA9nk2em0XJPXptojByKxyD5tc39oM=
X-Received: by 2002:ac8:7f88:0:b0:342:e9dc:ee77 with SMTP id
 z8-20020ac87f88000000b00342e9dcee77mr3121594qtj.384.1659780788133; Sat, 06
 Aug 2022 03:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAKdJ40QqZt3MbeLNZ1fuYRgaTqSJeDaDdHkQSx1-KWCW4BcJPg@mail.gmail.com>
In-Reply-To: <CAKdJ40QqZt3MbeLNZ1fuYRgaTqSJeDaDdHkQSx1-KWCW4BcJPg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 12:12:31 +0200
Message-ID: <CAHp75Vd2dh5QDxAY-9N0xu6D0ywBcYnRL6FF5ZoKdqnnkBtAyg@mail.gmail.com>
Subject: Re: [libgpiod] How can I use PWM
To:     Robert Baumgartner <rbaumgar@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 5, 2022 at 1:17 PM Robert Baumgartner <rbaumgar@redhat.com> wrote:
>
> Hi team,
>
> I try to migrate some python scripts for my Raspberry from RPi.GPIO to
> libgpiod,

This is great and everyone should be encouraged to follow your example!

> but I miss PWM features.
> Do I miss something? Or is it not available?

No, you haven't missed anything except Unix ideology. That ideology is
telling us that one tool for one thing, and in very featurable mode.
That said, lingpiod is exclusively for GPIO ABI between kernel and
user space. For PWM you need to access the PWM ABI in a way how it's
represented by the Linux kernel. I believe there are plenty of
libraries more or less okayish for that purpose, but I never heard
about any official library and/or Python bindings for it.

Thierry, any suggestion here?

> Some details: https://www.electronicwings.com/raspberry-pi/raspberry-pi-pwm-generation-using-python-and-c
>
> Any help would be appreciated.


-- 
With Best Regards,
Andy Shevchenko
