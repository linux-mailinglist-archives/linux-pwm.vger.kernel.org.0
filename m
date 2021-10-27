Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92AC43C9E5
	for <lists+linux-pwm@lfdr.de>; Wed, 27 Oct 2021 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbhJ0Mq0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 27 Oct 2021 08:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbhJ0MqZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 27 Oct 2021 08:46:25 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C67C061767
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 05:44:00 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id o184so3469979iof.6
        for <linux-pwm@vger.kernel.org>; Wed, 27 Oct 2021 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HDxKmOZ62FUht58FdXOSx5Qa1yp34Gywlo2BVog2d4k=;
        b=JD6O4ZfLxh8lT62FkFjA9y4GRGOql1L41J7By24XJWV1Tot3Aga8EnorZcDBx6JwSy
         O+hxUv6SYvUmpaXxk9V3Wz+Z8nmguLLjYr2Ku8u801A1YWrAI+rVZq9s/TwmOzY+KIq9
         BVOvXJqxvV+yH/84+LJjZjMhp/JilthjAJP3PdkFOsD8g3KH6vYAtMmeu9ivfGF4O9R/
         HyhVgaI0wT490I/coyp3XSy1krG376aNuw3+Rd68NGQaHc6lfja1CkHZfFxud44l1T+a
         oSjmCbivcVjG35a4p4MP1pyqdwI/JKch5MQebhpvlGrjDALa7Ir1gyAha12ZfiFkb0tq
         rzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HDxKmOZ62FUht58FdXOSx5Qa1yp34Gywlo2BVog2d4k=;
        b=bcdfIyMQLysjYLLXWMy/vHrmeL9x0vlkxqx0k6BpRMdiGi37QWVrehC9RRlHYbUz3I
         cvFALKlV6w+py6AdqCbO3mOntpnJSEywU9+gXI11gbfguQl+Kx8xS7TwCGAhSAO7lkEc
         2TiVpu29v5vLafOM4gpHVn4Ae/QSywjpP1/AVbgQxs8oXZISK65uGarUtOQp5o4Ghq/r
         5oaHE6GkHnojYA14WYCFq7IjzBtHZYmYGvOPcNCGXygX4zL3q2cQAlHrYCqflu1IFr3O
         +6rPYHxoxP4PMxPj6SMfjcN8qQqYgFoDcFg8NM9ciz/gazW/MLsy0cZnShaPo6wIAzDF
         59pg==
X-Gm-Message-State: AOAM530BnOyartoJEdzaH1kGhpZ421yxrEHZGI7OOMWAuPpk9JWX5Srl
        BW1KrZbKGwpWJD/lOVXBHVf4Xmin23DQjjNQe0qm1g==
X-Google-Smtp-Source: ABdhPJxraYfyEAPdAQGs1VHNpepQRGngxVf/3a/ovSme8ZzoFWFZBjIZBzs37dAcZqbudR76+NRe9KtzN2zrnxVmRmc=
X-Received: by 2002:a05:6602:148b:: with SMTP id a11mr20342831iow.85.1635338639393;
 Wed, 27 Oct 2021 05:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <YXU2i0FtAGDRCMSu@fedora> <202110271450.Z8JPybLg-lkp@intel.com>
 <20211027061552.bb4fczniqp6b7amh@pengutronix.de> <20211027073204.GA3978@gofer.mess.org>
 <CAH7FV3nb8K2qKgGZh-uMCk_BykWJ_sOb7K-jEhNjazYSiXdqbw@mail.gmail.com>
In-Reply-To: <CAH7FV3nb8K2qKgGZh-uMCk_BykWJ_sOb7K-jEhNjazYSiXdqbw@mail.gmail.com>
From:   =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Date:   Wed, 27 Oct 2021 09:43:47 -0300
Message-ID: <CAH7FV3=7Y7Z0y+Mq5Ak12KDMiZpHQHXGixF_pcrnQkuqCO9kvQ@mail.gmail.com>
Subject: Re: [PATCH v3] media: rc: pwm-ir-tx: Switch to atomic PWM API
To:     Sean Young <sean@mess.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        kernel test robot <lkp@intel.com>, mchehab@kernel.org,
        thierry.reding@gmail.com, Lee Jones <lee.jones@linaro.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

[resend it in Plain Text]
Thank you for the feedback! I appreciate that! I'm new at the kernel
and I got a little confused about how to send the new patch. Should I
send a v4 of this patch or just send a new patch fixing this issue?
I'm sorry about the question and thank you for your attention.

> Em qua., 27 de out. de 2021 =C3=A0s 04:32, Sean Young <sean@mess.org> esc=
reveu:
>>
>> On Wed, Oct 27, 2021 at 08:15:52AM +0200, Uwe Kleine-K=C3=B6nig wrote:
>> > On Wed, Oct 27, 2021 at 02:07:19PM +0800, kernel test robot wrote:
>> > > If you fix the issue, kindly add following tag as appropriate
>> > > Reported-by: kernel test robot <lkp@intel.com>
>> > >
>> > > All errors (new ones prefixed by >>, old ones prefixed by <<):
>> > >
>> > > >> ERROR: modpost: "__udivdi3" [drivers/media/rc/pwm-ir-tx.ko] undef=
ined!
>> >
>> > This comes from the line:
>> >
>> >       state.duty_cycle =3D DIV_ROUND_CLOSEST(pwm_ir->duty_cycle * stat=
e.period, 100);
>> >
>> > where DIV_ROUND_CLOSEST expands to a normal division but state.period =
is
>> > a u64. So this should use DIV64_U64_ROUND_CLOSEST I guess.
>>
>> DIV64_U64_ROUND_CLOSEST is for dividing a u64 with a u64. We're dividing
>> by 100 here so this is not necessary.
>>
>> It should use DIV_ROUND_CLOSEST_ULL, however it might be nicer to use:
>>
>>         pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
>>
>> Thanks
>>
>> Sean
