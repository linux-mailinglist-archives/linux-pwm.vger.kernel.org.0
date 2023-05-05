Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC24E6F7F90
	for <lists+linux-pwm@lfdr.de>; Fri,  5 May 2023 11:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjEEJHq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 May 2023 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjEEJHq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 May 2023 05:07:46 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F390B18FFA;
        Fri,  5 May 2023 02:07:39 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-5eefa0a5561so13763466d6.1;
        Fri, 05 May 2023 02:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683277659; x=1685869659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkNtx0DFC1avEjS6Gt6czwtMdE022sLV8pwGEyLcWOA=;
        b=PJWm8XAO9lCfmbxarADvwZHpztpMk1hcy5kR4EsGm2DTk6NJhT+MaFd3/ORtSxJd5H
         ILOVx+zvicVKR081ywtV4+bkIcvgQCDoqUNE5Y+JzZoE7aW647OFtY54XiCEtfAi/s1Z
         r/5lGLqRn9ps6l9bwUyPeperebD1gCkWQoh02SqUbAdMyYZxpXNvsp66tqzTzWcQbBDr
         3gL1NXmtHXcWMBsvoruAjJ6ftVosQyXqSi6GvQJ+CU8qvRZoIi7F7UpRdNaIQ8v7vJnW
         wjheo60GnZoR+SW1xc796ronPBs7lfZccWi8tchobyB2cJOEcfYZNjuJJmrlrYzUFTII
         abVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683277659; x=1685869659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkNtx0DFC1avEjS6Gt6czwtMdE022sLV8pwGEyLcWOA=;
        b=aN232c55ewLiKo31iNi+nDis1B+kNClN1vYUbfQ+AKF0Zaik14G2VJu/y8Q6yR/v9b
         bRHqH95XipdZEbgMFgquXOyDb0BPClnubRgAxVh2BpHqqhGwgaAKFEuh2gP52DXMgHU/
         JwMKBA2ikkwbuBvaGcbOzY5WDO+giEqwDu89JdDs3dsQgJnKwyR5S4B07kERkhqGxdnQ
         LEoMVZYPeMLryMtFRtC0T3BR76Fr95K1ib0YEkezdnF3SHmJ7WnP+X6H4hnYng4V2v3a
         zfbJdwzGjqSLyMD/Gazf5BXH6yxPql9qadnrbKQNec2kkUz/iMPGdWJ3D6+xXhAu/Q8H
         /ERA==
X-Gm-Message-State: AC+VfDz1Oq8H2ELQ86enSX+l13gFRSlf4OUNUlxeOIMJ5hKbhMYXpR5/
        fSOiuEJcheTYKoZ/OsBMbiJdoGtqDBMRRvhe4zo=
X-Google-Smtp-Source: ACHHUZ7cFikwPpj4XTO9xeLhEK+lqrwE6HAz9KY20lXpekX+2VlTrg3YVrd61svAjuq7vekGm8sBusARo5JXGQ3AhqY=
X-Received: by 2002:a05:6214:20ad:b0:5f5:51c4:fca0 with SMTP id
 13-20020a05621420ad00b005f551c4fca0mr788135qvd.52.1683277659042; Fri, 05 May
 2023 02:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230430165807.472798-1-hdegoede@redhat.com> <20230430165807.472798-19-hdegoede@redhat.com>
 <20230504165307.tydqlk6sml7sp5qe@pengutronix.de>
In-Reply-To: <20230504165307.tydqlk6sml7sp5qe@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 May 2023 12:07:02 +0300
Message-ID: <CAHp75VdgFFk=q-=ZDiKwV02Tin19ZSmSS=fhwgRrE6v48s-u0w@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] platform/x86: lenovo-yogabook: Add keyboard
 backlight control to platform driver
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
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

On Thu, May 4, 2023 at 7:53=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Sun, Apr 30, 2023 at 06:58:06PM +0200, Hans de Goede wrote:

...

> I don't know much about x86, but I think the table belongs to where this
> "80862289:00" device is created.

Just for your information, it's in drivers/acpi/acpi_lpss.c.

--=20
With Best Regards,
Andy Shevchenko
