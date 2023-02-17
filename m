Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B4F69B04A
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Feb 2023 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBQQNF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Feb 2023 11:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjBQQNF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Feb 2023 11:13:05 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE41960A4F
        for <linux-pwm@vger.kernel.org>; Fri, 17 Feb 2023 08:13:03 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id bl6so1607388oib.11
        for <linux-pwm@vger.kernel.org>; Fri, 17 Feb 2023 08:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MblW2sV2loFTLuABSqdqJSNKXVRzUfuBHncz/oTZSRQ=;
        b=OznA7Efy8vo9Ucu2cOrDvM7dOO8B4nKgetAjd9129TnwOAh0dpb31fQM75KmtI3RKS
         R+40GsPEwLNmbzVET0vBBqtxVflxoe+2LRzTJCPtTIXrlawcJ4iM+G2+bgw6hM0UbgCi
         TfSjkwLeEN3PaYoLsp+WR7o/frjRMUqfqQ+cc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MblW2sV2loFTLuABSqdqJSNKXVRzUfuBHncz/oTZSRQ=;
        b=VKACV/AydQYk9pD5NZr3B90UefEByI+uK1NWey6FSh2gnx6G33ZxVu915UCEWw8IGn
         inV7iLfC5ZBHf/E/oSUlSJa/6Dnkd16HDVyjRoM4qQo/qUL6ch/ro5HbNWfg0rCfDUrW
         7b8887+vB+rVIjmeKQCUrPD5skAz/HVrdnHrli4J14QyaK6udkxJjJYa6HpPrmSWi9vI
         kT2I4M72xNppeld26lMx5i7LOjN95bwLkSM6U58F0ujtp8WUiN38J1Oc95EET/3relkV
         +vpZgv7aXa86GnbkysQDpGaeqrufjNhgrhSdWGN/accFJs0LkWSPw5ii99PpFTCDzVzD
         gBFQ==
X-Gm-Message-State: AO0yUKVCkQdT9LcxkjyZ6PFtN7omxSgmNCimlj2Eq+6bxiPT5hGblHOk
        0fsKo1LeHG+AkCzyvkLeOB6dkjMLt94+fOyOYoccSA==
X-Google-Smtp-Source: AK7set9rKqdF8/7hh+h7/TRAjjyVR9dp3jKsIZuiC6sB7XUrW2fWpsJN9H4vtRWeIcDDKS6Gyx8hhbjApK5WSiBl7lk=
X-Received: by 2002:a05:6808:1512:b0:378:9fb4:8c47 with SMTP id
 u18-20020a056808151200b003789fb48c47mr448637oiw.9.1676650383200; Fri, 17 Feb
 2023 08:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20230217145731.3018148-1-angelo@amarulasolutions.com>
 <Y++e6IMusukWJNw2@kroah.com> <CA+_SqVYMZ7MErNr-HrbHj-=Q-5u1PizHQ_6TFkTOxB5=E8+9Dg@mail.gmail.com>
 <Y++hw3QTma3BGpwB@kroah.com>
In-Reply-To: <Y++hw3QTma3BGpwB@kroah.com>
From:   Angelo Compagnucci <angelo@amarulasolutions.com>
Date:   Fri, 17 Feb 2023 17:12:26 +0100
Message-ID: <CA+_SqVY7_eNw_MnpxEAxq=0OvfMgD+V5iSaiL_uXC-3aR7o9GA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] misc: servo-pwm: driver for controlling servo
 motors via PWM
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Feb 17, 2023 at 4:48 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 17, 2023 at 04:39:01PM +0100, Angelo Compagnucci wrote:
> > On Fri, Feb 17, 2023 at 4:36 PM Greg Kroah-Hartman <
> > gregkh@linuxfoundation.org> wrote:
> >
> > > On Fri, Feb 17, 2023 at 03:57:28PM +0100, Angelo Compagnucci wrote:
> > > > This patch adds a simple driver to control servo motor position via
> > > > PWM signal.
> > > > The driver allows to set the angle from userspace, while min/max
> > > > positions duty cycle and the motor degrees aperture are defined in
> > > > the dts.
> > > >
> > > > Signed-off-by: Angelo Compagnucci <angelo@amarulasolutions.com>
> > > > ---
> > > >  MAINTAINERS              |   6 ++
> > > >  drivers/misc/Kconfig     |  11 +++
> > > >  drivers/misc/Makefile    |   1 +
> > > >  drivers/misc/servo-pwm.c | 149 +++++++++++++++++++++++++++++++++++++++
> > >
> > > You add sysfs files but do not document them in Documentation/ABI/ which
> > > is required.  Please do so in your next version of this patch.
> > >
> >
> > https://patchwork.ozlabs.org/project/linux-pwm/patch/20230217145731.3018148-2-angelo@amarulasolutions.com/
> >
> > This patch [2/3] should do what you're asking.
>
> Why was I only cc:ed on this one patch?

It looks like get_maintainers.pl only select you for some patches.

>
> confused,
>
> greg k-h



-- 

Angelo Compagnucci

Software Engineer

angelo@amarulasolutions.com
__________________________________
Amarula Solutions SRL

Via le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 (0)42 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

[`as] https://www.amarulasolutions.com|
