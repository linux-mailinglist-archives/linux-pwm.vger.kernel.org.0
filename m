Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3430141DDBF
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Sep 2021 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345129AbhI3Pl4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Sep 2021 11:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345076AbhI3Plz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Sep 2021 11:41:55 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835FC06176D
        for <linux-pwm@vger.kernel.org>; Thu, 30 Sep 2021 08:40:13 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n71so8221973iod.0
        for <linux-pwm@vger.kernel.org>; Thu, 30 Sep 2021 08:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3rSIy18tZojmsrzjfN9FHZFTJAPBKRcMqEY55dmth7w=;
        b=H/6IrwGnlqZqz+Zp8FvojRJnoTCF0J5joy+th6XZ0bLY8vA5ptPZ73KFd0zpaZOPFm
         2UdU+uTV0yCGeeqr6jasZs757aIgb2S7xNZZVJBQ9RpW69ufXMWRkQRLTdrvY3PoqoCP
         8Zcmk0EEifP+TrZ20drZqiFfCjmtAZ+ckByzn938xj+0J58xoFUlcomtD4wlKPMB6X0d
         m8zWToLc/1L+aSh8wG+DwXntZzFfiW1P4i0iCH6wDWzD6Kd4/AWqSa/pgTA+90sZGTRp
         aqlrq/x2jzWUyAPBygKkDKMxNbISBOvEagt+YgKjcD+Eql4RNSlO/vJEBdztAXKp6MvM
         RW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3rSIy18tZojmsrzjfN9FHZFTJAPBKRcMqEY55dmth7w=;
        b=Er1CUf8EeB6m74wMHqRoA6DNbQzJxanfbsRf6Uh3PhOVV5Muu3FZPtWIE2hpj+Vh8g
         AQYCXHhXuHt80Uh/aJe1TgqamcHq49/BzoUAnOysOA25qAlkV6RWrN+djK7JC4II4eXt
         2zZiF2Pac9ENe48GIzlAycjbaBXvhZs8ABt+0eZA+FsGEXsxFRPJEqqDjaZbaq2pwxf6
         ilv4dYm+coVCYURY6p7wEMTZm21No3zRdX1cmxFxzCpCwc8oGwHdj9B/We1AY0TiOLSG
         C5Ls9aKBoJRUtpfmNDC4u2GwF34I4dHjHZCullgR/9P5CEhWrStpCdqTsxmZznuMwMIw
         C1uw==
X-Gm-Message-State: AOAM5315aUnTLRNG52lb1ECn9TnUg6q8zfKcrr+ENjOdKwWCc1Etio6K
        UWGKh/KIMcJy9oYVj6owXagunzcveqLeiKNjKMs+GA==
X-Google-Smtp-Source: ABdhPJyQb/uJaGJlYxt7XHtcYu354PpX7r3E/vrRNXFvnIQvH5kFYsuh7+ZNQ0DQrpwz0sv8l9mUREABQvbBsBgcVPs=
X-Received: by 2002:a6b:f915:: with SMTP id j21mr4456834iog.98.1633016412417;
 Thu, 30 Sep 2021 08:40:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210930030557.1426-1-bjorn.andersson@linaro.org> <20210930030557.1426-2-bjorn.andersson@linaro.org>
In-Reply-To: <20210930030557.1426-2-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@google.com>
Date:   Thu, 30 Sep 2021 08:40:00 -0700
Message-ID: <CAD=FV=UY7=gr4xFOR40fWA42B2T0jFS+=bOmwSb2_=ebTN7gXw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] drm/bridge: ti-sn65dsi86: Use regmap_bulk_write API
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pwm <linux-pwm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Wed, Sep 29, 2021 at 8:06 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The multi-register u16 write operation can use regmap_bulk_write()
> instead of two separate regmap_write() calls.
>
> It's uncertain if this has any effect on the actual updates of the
> underlying registers, but this at least gives the hardware the
> opportunity and saves us one transation on the bus.

s/transation/transaction/


> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v5:
> - Extracted this hunk from patch 3.
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Looks keen. I'll plan to apply this after giving it a few days on the
list to make sure nobody is upset, though I'm not sure why they would
be. ;-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
