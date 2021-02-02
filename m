Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67C630BD20
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Feb 2021 12:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBBLbM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Feb 2021 06:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhBBL2u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Feb 2021 06:28:50 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC41EC06178A
        for <linux-pwm@vger.kernel.org>; Tue,  2 Feb 2021 03:27:56 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y8so7331856ede.6
        for <linux-pwm@vger.kernel.org>; Tue, 02 Feb 2021 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWOA32QhLi/aaIbw7/tQiFcnwtGUsf/zeYi+0G0XjnQ=;
        b=gcLtq7RCac83zOJpeiOm5/H5ASWi3bsod5EFUn8KibxB5xHfa0VAilfjK+Qctqogth
         j7QaKzYhbO6ue2Iaak22Iczf4jP1j+gZyu6XpVZIruSZfLfkRrEFIFb3G1YvINN+WnK8
         RO+RrK9fV+pag2KDPsmniKxHTdF/E/f4Ibx5gAOckF2ZuD8zEbptHkr3FMIE+FpqIlxl
         H4ZHPTSn7FGxSJeHRnHCtuXBOnoOPpS5jTPvOIb3PVx/yANCl60P8plvpBTuCy2vw8+8
         mvvqkEfF7HIoN3q+Y6xMRCFbpzfu+wUb8N8OOGFAnoUzHbPOZKE3WH9W+MIQuRAiixHK
         COGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWOA32QhLi/aaIbw7/tQiFcnwtGUsf/zeYi+0G0XjnQ=;
        b=jYfS+VG9ilC5UY82fKFwh7pKGP2bG8lHOUOBzOmZX/KvB4EHkGNq+FSWt7vNi4KP05
         mXCnxcSeuMp/Sc0U3kg/KsnNq5WEE0PffVDEBfFVXAyQwQUo59NyweHl16HW5d+OUzIv
         P3hxUNvuSri/Wsv1JupZ6S6xNaMYcrZgVR7yhGVm6d3MVgy+mEKiYSkCOHxjGHfwfcs5
         MvSVagoI/23YBaxVLo5v2OGntMSjpwEfP5IfrZWUIrn/owpqMH0S0fgvckvji/42/wGE
         lcYbkoLjkzNrUTFF9tdWdWq85JMHvAMyUdOeWi9/4BfarnbBaibTWyb3BTRzh3sPUAhM
         nTog==
X-Gm-Message-State: AOAM531U6FlfJfQrLVo+pKlVLWDmP3VK2sGLNM8PrLKnISoyOOq/6efn
        OVgVvcIGMVx5ousBoFDMALqZiXRdwZpubBGSXzAsBQ==
X-Google-Smtp-Source: ABdhPJyEpBs2USy/Md7AF1xZtNppphNWkRvrACm4JRAHRBdyqh2Ms3Qc+QWjkYeV73NKLZeb84954QIUZzP9icOaTbk=
X-Received: by 2002:a05:6402:306f:: with SMTP id bs15mr882872edb.232.1612265275509;
 Tue, 02 Feb 2021 03:27:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610364681.git.baruch@tkos.co.il> <75637257694de0d4a9e432e1d8270019a4e6328b.1610364681.git.baruch@tkos.co.il>
 <CAMpxmJWjSyWkM6B-A7_eMZ38RmE4trvJ3oLaJdbkpr9Z00Ne0w@mail.gmail.com> <87tuqzspnu.fsf@BL-laptop>
In-Reply-To: <87tuqzspnu.fsf@BL-laptop>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 2 Feb 2021 12:27:44 +0100
Message-ID: <CAMpxmJUjTcVJq_q+Aiv0Lg5Z4Nxe1XRgTLnLtKErgpRSyB2kwQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] arm64: dts: armada: add pwm offsets for ap/cp gpios
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-pwm@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jan 29, 2021 at 4:56 PM Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:
>
> Hello Bartosz,
>
> > On Mon, Jan 11, 2021 at 12:47 PM Baruch Siach <baruch@tkos.co.il> wrote:
> >>
> >> The 'marvell,pwm-offset' property of both GPIO blocks (per CP component)
> >> point to the same counter registers offset. The driver will decide how
> >> to use counters A/B.
> >>
> >> This is different from the convention of pwm on earlier Armada series
> >> (370/38x). On those systems the assignment of A/B counters to GPIO
> >> blocks is coded in both DT and the driver. The actual behaviour of the
> >> current driver on Armada 8K/7K is the same as earlier systems.
> >>
> >> Add also clock properties for base pwm frequency reference.
> >>
> >> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> >> ---
> >
> > Andrew, Gregory, Sebastian,
> >
> > Can we get your Acks on this patch? Are you fine with it going through
> > the GPIO tree?
>
> I prefer applying it on our tree to avoid merge conflicts.
>
> Gregory

Ok, I applied the remaining patches from this series.

Bartosz
