Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB882F7ED9
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Jan 2021 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbhAOPCO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 15 Jan 2021 10:02:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbhAOPCN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 15 Jan 2021 10:02:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00EEE23403
        for <linux-pwm@vger.kernel.org>; Fri, 15 Jan 2021 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610722893;
        bh=zNovAIdXVMXKRa8Gt9ClCMsIp6PtSdWvf9jErwz0TCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pliiLZ3dUnExDIJCnL16y0aFvn5Vr+xZJezI8pucC3jZyA5Cp+oEYL8ZzyCaJJn64
         DMlYVfg9ODL5/fJAlekCkAKFDfO4rUDMLLqGoz8CQmE94Ymcs2gsvBmwamsDYb3F5U
         8p5z4uIuwr6cp2riQT3wFotGbc9K9M7E+h7xDNJ1pCcvyp/oyF4yMVOriwe9Ek+1M/
         zUGk9sEZLogxVucxQZ14ZHXUOtMhrrjOZ4TQ9nUNCfo7RzgV5+y5apU83QqtOPRzj4
         xMAHc2UW1KPiyuEe3tsv8mSENetCtR0prwtFnkNnneUunp8uCigpDg+cqnQypmYIIk
         7mIPXfJPqj8cg==
Received: by mail-ej1-f45.google.com with SMTP id q22so13727764eja.2
        for <linux-pwm@vger.kernel.org>; Fri, 15 Jan 2021 07:01:32 -0800 (PST)
X-Gm-Message-State: AOAM531yezDookTL8bbsmOUnMihHEXDAF/WeQUXxVsF0oPmH5hB02jQC
        qj6eiMsxn9tfyhZuGfdCuL5oLsyDqh0aZ+DmyQ==
X-Google-Smtp-Source: ABdhPJwWjPOpH6f7kn2eDddhf5iE7MVvpE98o9365cDLKyEuxJF1rdllTBYK8b5o/JjdseFW8jMTSG4kFQqB2wVlC4A=
X-Received: by 2002:a17:906:958f:: with SMTP id r15mr1236760ejx.360.1610722891586;
 Fri, 15 Jan 2021 07:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20201222213325.2656124-1-angelo.compagnucci@gmail.com> <20210115081318.ig76unyfp3fqhu5z@pengutronix.de>
In-Reply-To: <20210115081318.ig76unyfp3fqhu5z@pengutronix.de>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Jan 2021 09:01:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJpm28hvXepfE499Xrdt400sGN6+ZtTboVifi+hYqB44A@mail.gmail.com>
Message-ID: <CAL_JsqJpm28hvXepfE499Xrdt400sGN6+ZtTboVifi+hYqB44A@mail.gmail.com>
Subject: Re: [PATCH] pwm: pwm-gpio: Generic GPIO bit-banged PWM driver
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Nicola Di Lieto <nicola.dilieto@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jan 15, 2021 at 2:13 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> there are currently two patches with the same goal ready for review on
> the linux-pwm list:
>
>   - https://lore.kernel.org/r/20201211170432.6113-1-nicola.dilieto@gmail.=
com
>   - https://lore.kernel.org/r/20201222213325.2656124-1-angelo.compagnucci=
@gmail.com
>     (i.e. this one)
>
> In my eyes the former is the better one, so @Angelo: Maybe you can join
> forces with Nicola and work on his patch set.

Neither one went to DT list, so they're not in my queue. Though v1 of
Nicola's did go to the list.

Rob
