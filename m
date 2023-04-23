Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2FE6EC252
	for <lists+linux-pwm@lfdr.de>; Sun, 23 Apr 2023 22:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDWUzf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 23 Apr 2023 16:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDWUzd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 23 Apr 2023 16:55:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD6D1AB
        for <linux-pwm@vger.kernel.org>; Sun, 23 Apr 2023 13:55:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-956ff2399c9so598326266b.3
        for <linux-pwm@vger.kernel.org>; Sun, 23 Apr 2023 13:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682283331; x=1684875331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcgYo5hEprZMBHNoav25W6j8Pl8FNmsiW4q1h+BqMOg=;
        b=EqAUQeM0JQuXSYgqSJ/To+DxOQlUK6sx/O8xDPDsFp6xME8SzzX/YczB61sbgvK8kI
         hFDakjI4z+FwEb+CZkJMp6BjqhUSmJom9SllgiOOE4AuKElMDaAP3ZGD3f9kEIDy9eJj
         hcKLfWQycIpZ23PCuiCVy/5/3VPtEzcHbIQ1xqFNZLBlYEpSnV/p9VKGZPTgQPZ6q7qb
         gGjzPVdxDS5et5ASt/a07AceoEiehl9JLXKMpbhTCELg6OfENKzW2uAzut/Rrmh4jGZU
         5XH9ENAUp5OSVcBY4ujTzHhTSNsof5nUzQN4zyAuTquV4u3G1rq+mXF1zyqQxtsTgaAU
         avWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682283331; x=1684875331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YcgYo5hEprZMBHNoav25W6j8Pl8FNmsiW4q1h+BqMOg=;
        b=PrGZjgXzg+98nBcYU1V/aH43rZ3xgNfeF4oMhGUww3oKs3B5WKiqHeqI0MZr0kxmam
         MSESIq6eDHVH5rdWc/l3B55cWsVkhOqkIZH0N9vl/7qaoi+kZWqw+4FnukmtZvUNV22j
         YYgwy3xoXWjOA1qnZi7AoM/dM0b8RQuIkouKrZ41KNUgh5ttcFS7EJhw+/4CaBvbuwlO
         p5d8du4gtzL2zTngw/TbsOc6+1lBCDQEwqK3pZ4dEmIYy6Vbmd6ob1A1ilUWc/dZbjoy
         5Cjo81FKazK/jLv/y7Ux49CvBXIKVqh+QrIJlbvtxn2QYAgKD1ah/lKdJQq79DnExWHz
         db1Q==
X-Gm-Message-State: AAQBX9fxjhYXgxJEvUL3l+FUqRQRRjHCpezdIfbGn5X3MiatL2frbb3I
        eTRRYaTj07stN7uGjF5YL1nmg4NlTYuJTfTVPYY=
X-Google-Smtp-Source: AKy350aBCl5IMD8yacgRUJSjCF67IzlNv8X577NfRZKiHofEPTM2cRgkm4RyTznBIgphDn+X81O96kSv/oVxlpnVS48=
X-Received: by 2002:a17:906:a2da:b0:946:be05:ed7a with SMTP id
 by26-20020a170906a2da00b00946be05ed7amr8288089ejb.70.1682283331025; Sun, 23
 Apr 2023 13:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
 <cb79d313-c7a2-42e9-639a-63cb5366521a@gmail.com> <CAFBinCCzMdQZ4mDF7SEZKHc01MPSepxdzYa+j7G-qDXe5-kBVA@mail.gmail.com>
 <4b328dab-5f96-e5d0-3181-ce059d11b04b@gmail.com> <CAFBinCCxQvB_fY0r4jkwy7zW1F9s2vrxmcRaTs6hG5ay_Gf8mw@mail.gmail.com>
 <7601c976-3195-a35d-236c-9bd386dfe8e0@gmail.com>
In-Reply-To: <7601c976-3195-a35d-236c-9bd386dfe8e0@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 23 Apr 2023 22:55:19 +0200
Message-ID: <CAFBinCCV95Q8eCvUBH0VHgFdm7_kot5oVfPdBTppUQbw2g0+qw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] pwm: meson: make full use of common clock framework
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Heiner,

apologies for the late reply - I've been busy with offline things.

On Sun, Apr 16, 2023 at 11:34=E2=80=AFPM Heiner Kallweit <hkallweit1@gmail.=
com> wrote:
[...]
> >> With a 850MHz input clock we should see a 0.01% duty cycle with 1.2ns
> >> clock pulses. Can we rule out an issue with the measuring equipment?
> >> Is your logic analyzer able to display such short clock pulses?
> > Oh, you're right: my logic analyzer maxes out at 24MHz (~42ns).
> > So we can ignore this case.
> >
> >>> Finally I tried period =3D 12218, duty cycle =3D 12218 (typically use=
d for
> >>> the lowest CPU voltage):
> >>> before your patches / after applying your patches:
> >>> PWM: duty cycle: 99.661017% / n/a (constant low output)
> > I have to correct myself: for this case my logic analyzer sees a:
> > constant high signal
> >
> So conclusion is that the PWM output is as expected? If yes, then the
> memory corruption you saw supposedly had another root cause?
You are right:
- For this case my logic analyzer is also too slow
- In the meantime I've been able to reproduce the memory corruption
issue without your patch

> Eventually your Tested-by could be re-instantiated?
Indeed, and in addition to SM1 I have also tested it on Khadas VIM2 (GXM So=
C):
[    4.135944] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4356/2
wl0: Apr  9 2021 00:40:07 version 7.35.349.104 (775a9ab CY) FWID
01-64b609e0

Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Best regards,
Martin
